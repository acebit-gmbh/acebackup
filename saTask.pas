unit saTask;

interface

uses
  Classes, ComObj, ActiveX, SysUtils, Forms, intTask;

type
  ETaskManagerError = class(Exception);

  TTaskScheduler = class;
  TTaskTriggers = class;
  TTaskItem = class;

  TTaskFlag = (tfAllowDemandStart, tfAllowHardTerminate, tfDisallowStartIfOnBatteries, tfEnabled, tfHidden,
    tfRunOnlyIfNetworkAvailable, tfRunOnlyIfIdle, tfStartWhenAvailable, tfStopIfGoingOnBatteries, tfWakeToRun);
  TTaskFlags = set of TTaskFlag;

  TTaskStatus = (tsUnknown, tsDisabled, tsQueued, tsReady, tsRunning);

  TTriggerType = (ttOnce, ttDaily, ttWeekly, ttMonthlyDate, ttMonthlyDow, ttOnIdle, ttAtStartup, ttAtLogon,
    ttOnConnect, ttOnDisconnect, ttOnLock, ttOnUnlock, ttUnknown);

  TPageType = (ptTask, ptSchedule, ptSettings);
  TPageTypes = set of TPageType;

  TTaskTrigger = class(TCollectionItem)
  private
    FTaskTrigger: TTaskTriggers;
    function GetAsString: WideString;
    function GetTriggerType: TTriggerType;
    procedure SetTriggerType(const Value: TTriggerType);
  public
    property AsString: WideString read GetAsString;
    property TaskTriggers: TTaskTriggers read FTaskTrigger write FTaskTrigger;
    property TriggerType: TTriggerType read GetTriggerType write SetTriggerType;
  end;

  TTaskTriggers = class(TCollection)
  strict private
    FTrigger: ITrigger;
    FTaskItem: TTaskItem;
    function GetItem(Index: Integer): TTaskTrigger;
  public
    constructor Create(AOwner: TTaskItem);
    function Add(const ttype: TTriggerType): TTaskTrigger;
    procedure LoadTriggers;
    procedure SaveTriggers;
    property Items[Index: Integer]: TTaskTrigger read GetItem; default;
  end;

  TTaskItem = class(TPersistent)
  strict private
    FRegTask: IRegisteredTask;
    FTaskDefinition: ITaskDefinition;
    function SetExecAction: IAction;
  private
    FCurrAction: Integer;
    FTaskName: string;
    FTriggers: TTaskTriggers;
    FTaskMan: TTaskScheduler;
    function GetAccount: string;
    function GetAppName: string;
    function GetArguments: string;
    function GetCreator: string;
    function GetFlags: TTaskFlags;
    function GetStatus: TTaskStatus;
    function GetTaskName: string;
    function GetTriggerText: string;
    function GetWorkDir: string;
    procedure SetAppName(const Value: string);
    procedure SetArguments(const Value: string);
    procedure SetCreator(const Value: string);
    procedure SetFlags(const Value: TTaskFlags);
    procedure SetTaskName(const Value: string);
    procedure SetWorkDir(const Value: string);
  public
    constructor Create(TaskManager: TTaskScheduler);
    constructor CreateByTask(TaskManager: TTaskScheduler; Task: IRegisteredTask);
    destructor Destroy; override;

    function HasSameName(const Text: String): Boolean;
    procedure InitTask;
    procedure SaveTask(const NewName: String = '');
    procedure SetAccount(const Username, Password: String);

    property Account: string read GetAccount;
    property AppName: string read GetAppName write SetAppName;
    property Arguments: string read GetArguments write SetArguments;
    property CurrAction: Integer read FCurrAction write FCurrAction;
    property Creator: string read GetCreator write SetCreator;
    property Definition: ITaskDefinition read FTaskDefinition write FTaskDefinition;
    property Flags: TTaskFlags read GetFlags write SetFlags;
    property Status: TTaskStatus read GetStatus;
    property TaskItem: IRegisteredTask read FRegTask write FRegTask;
    property TaskName: string read GetTaskName write SetTaskName;
    property TaskMan: TTaskScheduler read FTaskMan write FTaskMan;
    property Triggers: TTaskTriggers read FTriggers write FTriggers;
    property TriggerText: string read GetTriggerText;
    property WorkDir: string read GetWorkDir write SetWorkDir;
  end;

  TTaskScheduler = class(TComponent)
  strict private
    FTaskService: ITaskService;
    FTaskRoot: ITaskFolder;
    FRegTaskCollect: IRegisteredTaskCollection;
  private
    FRootFolder: string;
    FListHidden: Boolean;
    FTaskItems: TList;
    FListOwnOnly: Boolean;
    function GetHidden: Integer;
    function SameApp(Task: TTaskItem): Boolean;
    function FindItem(const TaskName: string; var Index: Integer): Boolean;
    procedure InsertItem(Index: Integer; const TaskName: string);
    procedure AddTask(Task: IRegisteredTask);
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateEx(AOwner: TComponent; AOpen, AOwn, AHidden: Boolean);
    destructor Destroy; override;

    function Active: Boolean;
    function ActivateTask(const TaskName: String): TTaskItem;
    function CreateTask(const TaskName: String): TTaskItem;
    procedure DeleteTask(const TaskName: String);

    procedure Close;
    procedure Open;
    procedure Clear;
    procedure Refresh;

    property ListHidden: Boolean read FListHidden write FListHidden;
    property ListOwnOnly: Boolean read FListOwnOnly write FListOwnOnly;
    property TaskRoot: ITaskFolder read FTaskRoot;
  end;

procedure HandleError(const Error: string; const Args: array of const); overload;
procedure HandleError(const Error: string); overload;

implementation

resourcestring
  res_SchedulerNotActive = 'Scheduler is not active';
  res_RootFolderNotFound = 'Rootfolder not found';
  res_TaskCollectionIsEmpty = 'Task collection is empty';
  res_NoTaskDefinitions = 'Task "%s" has no definitions';
  res_TaskAlreadyExists = 'Task "%s" already exists';
  res_TaskNotActivated = 'Task "%s" is not active';
  res_NoTriggersScheduled = 'No triggers scheduled';
  res_MultiTriggersScheduled = 'Multiple triggers scheduled';
  res_TriggerIndexOutbound = 'Trigger index (%d) out of bounds';

  res_NoActions = 'No actions';
  res_MultipleActions = 'Multiple actions';
  res_ActionCOMObject = 'Call COM object';
  res_ActionSendEmail = 'Send e-mail';
  res_ActionDisplayMessage = 'Display message';

procedure HandleError(const Error: string; const Args: array of const);
begin
  raise ETaskManagerError.CreateFmt(Error, Args);
end;

procedure HandleError(const Error: string);
begin
  HandleError(Error, []);
end;

{ TTaskItem }

constructor TTaskItem.Create(TaskManager: TTaskScheduler);
begin
  inherited Create;

  TaskMan := TaskManager;
  Triggers := TTaskTriggers.Create(Self);
end;

constructor TTaskItem.CreateByTask(TaskManager: TTaskScheduler; Task: IRegisteredTask);
begin
  Create(TaskManager);

  TaskItem := Task;
  TaskName := Task.Name;
  FTaskDefinition := Task.Definition;
end;

destructor TTaskItem.Destroy;
begin
  Triggers.Free;

  inherited;
end;

function TTaskItem.SetExecAction: IAction;
var
  i: Integer;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  Result := nil;

  for i := 1 to FTaskDefinition.Actions.Count do
  begin
    if FTaskDefinition.Actions[i].type_ = TASK_ACTION_EXEC then
    begin
      Result := FTaskDefinition.Actions[i];
      Break;
    end;
  end;

  if Result = nil then
    Result := FTaskDefinition.Actions.Create(TASK_ACTION_EXEC);
end;

function TTaskItem.GetAccount: string;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  Result := FTaskDefinition.Principal.UserId;
end;

function TTaskItem.GetAppName: string;
var
  fAction: IAction;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  if (FTaskDefinition.Actions.Count = 0) then
  begin
    Result := res_NoActions;
    Exit;
  end;

  if (FTaskDefinition.Actions.Count > 1) and (CurrAction = 0) then
  begin
    Result := res_MultipleActions;
    Exit;
  end;

  if (CurrAction > 0) and (FTaskDefinition.Actions.Count <= CurrAction) then
    fAction := FTaskDefinition.Actions.Item[CurrAction]
  else
    fAction := FTaskDefinition.Actions.Item[1];

  case fAction.type_ of
    TASK_ACTION_EXEC:
      Result := (fAction as IExecAction).Path;
    TASK_ACTION_COM_HANDLER:
      Result := res_ActionCOMObject;
    TASK_ACTION_SEND_EMAIL:
      Result := res_ActionSendEmail;
    TASK_ACTION_SHOW_MESSAGE:
      Result := res_ActionDisplayMessage;
  end;
end;

function TTaskItem.GetArguments: string;
var
  iIndex: Integer;
  fAction: IExecAction;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  if CurrAction > 0 then
    iIndex := CurrAction
  else
    iIndex := 1;

  if (FTaskDefinition.Actions.Count > 0) and (FTaskDefinition.Actions.Item[iIndex].type_ = TASK_ACTION_EXEC) then
  begin
    fAction := FTaskDefinition.Actions.Item[iIndex] as IExecAction;
    Result := fAction.Arguments
  end else
    Result := '';
end;

function TTaskItem.GetCreator: string;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  Result := FTaskDefinition.RegistrationInfo.Author;
end;

function TTaskItem.GetFlags: TTaskFlags;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  Result := [];
  if FTaskDefinition.Settings.AllowDemandStart then
    Include(Result, tfAllowDemandStart);
  if FTaskDefinition.Settings.AllowHardTerminate then
    Include(Result, tfAllowHardTerminate);
  if FTaskDefinition.Settings.DisallowStartIfOnBatteries then
    Include(Result, tfDisallowStartIfOnBatteries);
  if FTaskDefinition.Settings.StopIfGoingOnBatteries then
    Include(Result, tfStopIfGoingOnBatteries);
  if FTaskDefinition.Settings.Enabled then
    Include(Result, tfEnabled);
  if FTaskDefinition.Settings.Hidden then
    Include(Result, tfHidden);
  if FTaskDefinition.Settings.RunOnlyIfIdle then
    Include(Result, tfRunOnlyIfIdle);
  if FTaskDefinition.Settings.RunOnlyIfNetworkAvailable then
    Include(Result, tfRunOnlyIfNetworkAvailable);
  if FTaskDefinition.Settings.StartWhenAvailable then
    Include(Result, tfStartWhenAvailable);
  if FTaskDefinition.Settings.WakeToRun then
    Include(Result, tfWakeToRun);
end;

function TTaskItem.GetStatus: TTaskStatus;
begin
  if not Assigned(FRegTask) then
    HandleError(res_TaskNotActivated, [TaskName]);

  Result := TTaskStatus(FRegTask.State);
end;

function TTaskItem.GetTaskName: string;
begin
  // in case of *.job extension
  Result := ChangeFileExt(FTaskName, '');
end;

function TTaskItem.GetTriggerText: string;
begin
  case Triggers.Count of
    0: Result := res_NoTriggersScheduled;
    1: Result := Triggers[0].AsString;
  else
    Result := res_MultiTriggersScheduled;
  end;
end;

function TTaskItem.GetWorkDir: string;
var
  iIndex: Integer;
  fAction: IExecAction;
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  if CurrAction > 0 then
    iIndex := CurrAction
  else
    iIndex := 1;

  if (FTaskDefinition.Actions.Count > 0) and (FTaskDefinition.Actions.Item[iIndex].type_ = TASK_ACTION_EXEC) then
  begin
    fAction := FTaskDefinition.Actions.Item[iIndex] as IExecAction;
    Result := fAction.WorkingDirectory
  end else
    Result := '';
end;

function TTaskItem.HasSameName(const Text: String): Boolean;
begin
  Result := SameText(Text, TaskName);
end;

procedure TTaskItem.InitTask;
begin
  FTriggers.LoadTriggers;
end;

procedure TTaskItem.SaveTask(const NewName: String = '');
var
  s: OleVariant;
begin
  if NewName <> '' then
  begin
    TaskMan.DeleteTask(TaskName);
    TaskName := NewName;
  end;

  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  FRegTask := FTaskMan.TaskRoot.RegisterTaskDefinition(
    TaskName, FTaskDefinition, TASK_CREATE_OR_UPDATE, s, s, FTaskDefinition.Principal.LogonType, s);
end;

procedure TTaskItem.SetAccount(const Username, Password: String);
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  FTaskDefinition.Principal.UserId := Username;
  if Trim(Password) <> EmptyStr then
    FTaskMan.TaskRoot.RegisterTaskDefinition(
      TaskName, FTaskDefinition, TASK_CREATE_OR_UPDATE, Username, Password, TASK_LOGON_PASSWORD, '');

  if (Trim(Username) = EmptyStr) and (Trim(Password) = EmptyStr) then
  begin
    FTaskDefinition.Principal.LogonType := TASK_LOGON_INTERACTIVE_TOKEN;
  end else
  begin
    FTaskDefinition.Principal.LogonType := TASK_LOGON_NONE;
  end;
end;

procedure TTaskItem.SetAppName(const Value: string);
var
  fAction: IExecAction;
begin
  fAction := SetExecAction as IExecAction;

  if Assigned(fAction) then
    fAction.Path := Value;
end;

procedure TTaskItem.SetArguments(const Value: string);
var
  fAction: IExecAction;
begin
  fAction := SetExecAction as IExecAction;

  if Assigned(fAction) then
    fAction.Arguments := Value;
end;

procedure TTaskItem.SetCreator(const Value: string);
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  FTaskDefinition.RegistrationInfo.Author := Value;
end;

procedure TTaskItem.SetFlags(const Value: TTaskFlags);
var
  tFlag: TTaskFlag;
begin
  for tFlag := Low(TTaskFlag) to High(TTaskFlag) do
  begin
    case tFlag of
      tfAllowDemandStart:
        FTaskDefinition.Settings.AllowDemandStart := tFlag in Value;
      tfDisallowStartIfOnBatteries:
        FTaskDefinition.Settings.DisallowStartIfOnBatteries := tFlag in Value;
      tfStopIfGoingOnBatteries:
        FTaskDefinition.Settings.StopIfGoingOnBatteries := tFlag in Value;
      tfEnabled:
        FTaskDefinition.Settings.Enabled := tFlag in Value;
      tfHidden:
        FTaskDefinition.Settings.Hidden := tFlag in Value;
      tfRunOnlyIfIdle:
        FTaskDefinition.Settings.RunOnlyIfIdle := tFlag in Value;
      tfRunOnlyIfNetworkAvailable:
        FTaskDefinition.Settings.RunOnlyIfNetworkAvailable := tFlag in Value;
      tfStartWhenAvailable:
        FTaskDefinition.Settings.StartWhenAvailable := tFlag in Value;
      tfWakeToRun:
        FTaskDefinition.Settings.WakeToRun := tFlag in Value;
    end;
  end;
end;

procedure TTaskItem.SetTaskName(const Value: string);
begin
  FTaskName := Value;
end;

procedure TTaskItem.SetWorkDir(const Value: string);
var
  fAction: IExecAction;
begin
  fAction := SetExecAction as IExecAction;

  if Assigned(fAction) then
    fAction.WorkingDirectory := Value;
end;

{ TTaskScheduler }

constructor TTaskScheduler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FRootFolder := '\';
  FTaskItems := TList.Create;
end;

constructor TTaskScheduler.CreateEx(AOwner: TComponent; AOpen, AOwn, AHidden: Boolean);
begin
  Create(AOwner);

  ListHidden := AHidden;
  ListOwnOnly := AOwn;
  if AOpen then
    Open;
end;

destructor TTaskScheduler.Destroy;
begin
  Close;
  Clear;

  FreeAndNil(FTaskItems);

  inherited;
end;

function TTaskScheduler.FindItem(const TaskName: string; var Index: Integer): Boolean;
var
  i: Integer;
  pItem: TTaskItem;
begin
  Result := False;
  Index := 0;
  for i := 0 to FTaskItems.Count -1 do
  begin
    pItem := TTaskItem(FTaskItems[i]);
    if pItem.TaskName = TaskName then
    begin
      Index := i;
      Exit(True);
    end;
  end;
end;

procedure TTaskScheduler.InsertItem(Index: Integer; const TaskName: string);
var
  pTask: TTaskItem;
begin
  pTask := TTaskItem.Create(Self);
  pTask.FTaskName := TaskName;
  FTaskItems.Insert(Index, pTask);
end;

function TTaskScheduler.Active: Boolean;
begin
   Result := FTaskService <> nil;
end;

procedure TTaskScheduler.AddTask(Task: IRegisteredTask);
var
  pTask: TTaskItem;
  bAllow: Boolean;
begin
  if not Assigned(pTask) then
    Exit;

  pTask := TTaskItem.CreateByTask(Self, Task);

  if ListOwnOnly then
    bAllow := SameApp(pTask)
  else
    bAllow := True;

  if bAllow then
    FTaskItems.Add(pTask)
  else
    FreeAndNil(pTask);
end;

function TTaskScheduler.SameApp(Task: TTaskItem): Boolean;
begin
{$IFNDEF DEBUG}
  SameApp := SameText(Application.ExeName, Task.AppName);
{$ELSE}
  SameApp := SameText(ExtractFileName(Application.ExeName), ExtractFileName(Task.AppName));
{$ENDIF}
end;

procedure TTaskScheduler.Close;
begin
  FTaskService := nil;
end;

procedure TTaskScheduler.Open;
begin
  Close;

  OleCheck(CoCreateInstance(CLASS_TaskScheduler_, nil, CLSCTX_INPROC_SERVER, IID_ITaskService, FTaskService));
  FTaskService.Connect('', '', '', '');

  Refresh;
end;

procedure TTaskScheduler.Clear;
begin
  while FTaskItems.Count > 0 do
  begin
    TTaskItem(FTaskItems[0]).Free;
    FTaskItems.Delete(0);
  end;
end;

procedure TTaskScheduler.Refresh;
var
  i: Integer;
begin
  Clear;

  if not Active then
    HandleError(res_SchedulerNotActive);

  FTaskRoot := FTaskService.GetFolder(FRootFolder);

  if not Assigned(FTaskRoot) then
    HandleError(res_RootFolderNotFound);

  FRegTaskCollect := FTaskRoot.GetTasks(GetHidden);
  if not Assigned(FRegTaskCollect) then
    HandleError(res_TaskCollectionIsEmpty);

  for i := 1 to FRegTaskCollect.Count do
    AddTask(FRegTaskCollect.Item[i]);
end;

function TTaskScheduler.ActivateTask(const TaskName: String): TTaskItem;
var
  iIndex: Integer;
  fTask: IRegisteredTask;
begin
  Refresh;

  if FindItem(TaskName, iIndex) then
  begin
    Result := FTaskItems[iIndex]
  end else
  begin
    try
      fTask := FTaskRoot.GetTask(TaskName);
      if Assigned(fTask) then
      begin
        InsertItem(iIndex, TaskName);
        Result := FTaskItems[iIndex];
        Result.Definition := fTask.Definition;
      end else
        Result := nil;
    except
      Result := nil;
    end;
  end;
  if Assigned(Result) then
    Result.InitTask;
end;

function TTaskScheduler.CreateTask(const TaskName: String): TTaskItem;
var
  iIndex: Integer;
  fTaskDef: ITaskDefinition;
begin
  Refresh;
  Result := nil;

  if FindItem(TaskName, iIndex) then
  begin
    HandleError(res_TaskAlreadyExists, [TaskName]);
  end else
  begin
    fTaskDef := FTaskService.NewTask(0);
    fTaskDef.Settings.Enabled := True;
    fTaskDef.Settings.Hidden := False;
    fTaskDef.Principal.LogonType := TASK_LOGON_INTERACTIVE_TOKEN;
    fTaskDef.Principal.UserId := '';
    InsertItem(iIndex, TaskName);
    Result := FTaskItems[iIndex];
    Result.Definition := fTaskDef;
    Result.TaskMan := Self;
  end;
end;

procedure TTaskScheduler.DeleteTask(const TaskName: String);
var
  i: Integer;
begin
  if FindItem(TaskName, i) then
  begin
    TTaskItem(FTaskItems[i]).Free;
    FTaskItems.Delete(i);
  end;

  FTaskRoot.DeleteTask(TaskName, 0);
end;

function TTaskScheduler.GetHidden: Integer;
begin
  if ListHidden then
    Result := TASK_ENUM_HIDDEN
  else
    Result := 0;
end;

{ TTaskTriggers }

function TTaskTriggers.Add(const ttype: TTriggerType): TTaskTrigger;
begin
  //
end;

constructor TTaskTriggers.Create(AOwner: TTaskItem);
begin
  inherited Create(TTaskTrigger);

  FTaskItem := AOwner;
end;

function TTaskTriggers.GetItem(Index: Integer): TTaskTrigger;
begin
  if (Index < 0) or (Index >= Count) then
    HandleError(res_TriggerIndexOutbound, [Index]);

  Result := TTaskTrigger(inherited GetItem(Index));
end;

procedure TTaskTriggers.LoadTriggers;
var
  iCount: Integer;
  iIndex: Integer;
  pTrigger: TTaskTrigger;
  fTrigger: ITrigger;
begin
  iCount := FTaskItem.Definition.Triggers.Count;
  for iIndex := 1 to iCount do
  begin
    pTrigger := TTaskTrigger(inherited Add);
    fTrigger := FTaskItem.Definition.Triggers.Item[iIndex];
    pTrigger.TaskTriggers := Self;
    case fTrigger.type_ of
      TASK_TRIGGER_TIME: pTrigger.TriggerType := ttOnce;
      TASK_TRIGGER_DAILY: pTrigger.TriggerType := ttDaily;
      TASK_TRIGGER_WEEKLY: pTrigger.TriggerType := ttWeekly;
      TASK_TRIGGER_MONTHLY: pTrigger.TriggerType := ttMonthlyDate;
      TASK_TRIGGER_MONTHLYDOW: pTrigger.TriggerType := ttMonthlyDow;
      TASK_TRIGGER_IDLE: pTrigger.TriggerType := ttOnIdle;
      TASK_TRIGGER_BOOT: pTrigger.TriggerType := ttAtStartup;
      TASK_TRIGGER_LOGON: pTrigger.TriggerType := ttAtLogon;
    else
      pTrigger.TriggerType := ttUnknown;
    end;
  end;
end;

procedure TTaskTriggers.SaveTriggers;
begin

end;

{ TTaskTrigger }

function TTaskTrigger.GetAsString: WideString;
begin
  Result := 'do be defined';
end;

function TTaskTrigger.GetTriggerType: TTriggerType;
begin

end;

procedure TTaskTrigger.SetTriggerType(const Value: TTriggerType);
begin

end;

end.
