unit tsTaskman;

interface

uses
  Classes, ComObj, ActiveX, SysUtils, StrUtils, Forms, intTask;

type
  ETaskManagerError = class(Exception);

  TTaskScheduler = class;
  TTaskTriggers = class;
  TTaskItem = class;

  TTaskFlag = (tfAllowDemandStart, tfAllowHardTerminate, tfDisallowStartIfOnBatteries, tfEnabled, tfHidden,
    tfRunOnlyIfNetworkAvailable, tfRunOnlyIfIdle, tfStartWhenAvailable, tfStopIfGoingOnBatteries, tfWakeToRun);
  TTaskFlags = set of TTaskFlag;

  TTaskStatus = (tsUnknown, tsDisabled, tsQueued, tsReady, tsRunning);

  TTriggerType = (ttOnce, ttDaily, ttWeekly, ttMonthlyDate, ttMonthlyDow, ttOnIdle, ttAtStartup, ttAtLogon, ttUnknown);

  TWeekMonthDays = (wmDOW = 5, wmWeek = 7, wmMonth = 12, wmDays = 31);

  TTaskTrigger = class(TCollectionItem)
  strict private
    function BoundaryToDateTime(const Boundary: String): TDateTime;
    function PymdThmsToMinutes(const PymdThms: String): Integer;
    function IntArrayToString(IntArray: Integer; Mode: TWeekMonthDays; Every: Boolean): string;
    function IntArrayToInteger(IntArray: Integer; Mode: TWeekMonthDays): Integer;
  private
    FInternal: Integer;
    FTrigger: ITrigger;
    FTaskTriggers: TTaskTriggers;
    FTriggerType: TTriggerType;
    function GetDaysInterval: Integer;
    procedure SetDaysInterval(const Value: Integer);
    function GetAsString: string;
    function GetStartBoundary: TDateTime;
    function GetIdleDuration: Integer;
    procedure SetIdleDuration(const Value: Integer);
    function GetDayOfMonth: Integer;
    procedure SetDayOfMonth(const Value: Integer);
    function GetWeekOfMonth: Integer;
    procedure SetWeekOfMonth(const Value: Integer);
    function GetDayOfWeek: Integer;
    procedure SetDayOfWeek(const Value: Integer);
    function GetWeeksInterval: Integer;
    procedure SetWeeksInterval(const Value: Integer);
    function GetDaysOfWeek: Integer;
    procedure SetDaysOfWeek(const Value: Integer);
    function GetMonthsOfYear: Integer;
    function GetMonthsOfYearDow: Integer;
    procedure SetMonthsOfYear(const Value: Integer);
    procedure SetMonthsOfYearDow(const Value: Integer);
    function GetEndBoundary: TDateTime;
    function GetTriggerID: String;
    procedure SetStartBoundary(const Value: TDateTime);
    procedure SetEndBoundary(const Value: TDateTime);
  public
    property DaysInterval: Integer read GetDaysInterval write SetDaysInterval;
    property IdleDuration: Integer read GetIdleDuration write SetIdleDuration;
    property DayOfMonth: Integer read GetDayOfMonth write SetDayOfMonth;
    property DayOfWeek: Integer read GetDayOfWeek write SetDayOfWeek;
    property DaysOfWeek: Integer read GetDaysOfWeek write SetDaysOfWeek;
    property WeekOfMonth: Integer read GetWeekOfMonth write SetWeekOfMonth;
    property WeeksInterval: Integer read GetWeeksInterval write SetWeeksInterval;
    property MonthsOfYear: Integer read GetMonthsOfYear write SetMonthsOfYear;
    property MonthsOfYearDow: Integer read GetMonthsOfYearDow write SetMonthsOfYearDow;
    property StartBoundary: TDateTime read GetStartBoundary write SetStartBoundary;
    property EndBoundary: TDateTime read GetEndBoundary write SetEndBoundary;
    property Internal: Integer read FInternal write FInternal;
    property AsString: string read GetAsString;
    property Trigger: ITrigger read FTrigger write FTrigger;
    property TaskTriggers: TTaskTriggers read FTaskTriggers write FTaskTriggers;
    property TriggerType: TTriggerType read FTriggerType write FTriggerType;
    property TriggerID: String read GetTriggerID;
  end;

  TTaskTriggers = class(TCollection)
  strict private
    FTaskItem: TTaskItem;
    function GetTrigger(Index: Integer): TTaskTrigger;
  public
    constructor Create(AOwner: TTaskItem);
    function New(const TriggerType: TTriggerType): TTaskTrigger;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure InitTriggers;
    property Items[Index: Integer]: TTaskTrigger read GetTrigger; default;
    property TaskItem: TTaskItem read FTaskItem write FTaskItem;
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

uses
  Math;

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

  res_TriggerTime = 'At %s on %s';
  res_TriggerDaily = 'At %s every day';
  res_TriggerDays = 'At %s every %d days';
  res_TriggerWeekly = 'At %s %s of every week, starting %s';
  res_TriggerWeeks = 'At %s %s of every %d weeks, starting %s';
  res_TriggerMonthly = 'At %s on %s of %s, starting %s';
  res_TriggerMonthDOW = 'Runs at %s on the %s %s of %s, starting %s';
  res_EachWeekDay = 'each weekday';
  res_EachMonth = 'each month';
  res_EachDay = 'each day';
  res_Every = 'every ';
  res_DOWFirst = 'first';
  res_DOWSecond = 'second';
  res_DOWThird = 'third';
  res_DOWFourth = 'fourth';
  res_DOWLast = 'last';
  res_TriggerIdle = 'When computer is idle';
  res_TriggerStartup = 'On system startup';
  res_TriggerLogon = 'At user logon';
  res_VeryShortDateLocale = 'mmm dd';

procedure HandleError(const Error: string; const Args: array of const);
begin
  raise ETaskManagerError.CreateFmt(Error, Args);
end;

procedure HandleError(const Error: string);
begin
  HandleError(Error, []);
end;

{ TTaskTriggers }

constructor TTaskTriggers.Create(AOwner: TTaskItem);
begin
  inherited Create(TTaskTrigger);

  FTaskItem := AOwner;
end;

function TTaskTriggers.New(const TriggerType: TTriggerType): TTaskTrigger;
var
  fTrigger: ITrigger;
  iTriggerType: Integer;
begin
  case TriggerType of
    ttOnce:
      iTriggerType := TASK_TRIGGER_TIME;
    ttDaily:
      iTriggerType := TASK_TRIGGER_DAILY;
    ttWeekly:
      iTriggerType := TASK_TRIGGER_WEEKLY;
    ttMonthlyDate:
      iTriggerType := TASK_TRIGGER_MONTHLY;
    ttMonthlyDow:
      iTriggerType := TASK_TRIGGER_MONTHLYDOW;
    ttOnIdle:
      iTriggerType := TASK_TRIGGER_IDLE;
    ttAtStartup:
      iTriggerType := TASK_TRIGGER_BOOT;
    ttAtLogon:
      iTriggerType := TASK_TRIGGER_LOGON;
  else
    iTriggerType := -1;
  end;

  if (iTriggerType > 0) then
  begin
    fTrigger := FTaskItem.Definition.Triggers.Create(iTriggerType);
    Result := TTaskTrigger(Add);
    Result.Trigger := fTrigger;
    Result.TaskTriggers := FTaskItem.FTriggers;
    Result.TriggerType := TriggerType;
  end else
    Result := nil;
end;

procedure TTaskTriggers.Clear;
begin
  FTaskItem.Definition.Triggers.Clear;

  inherited Clear;
end;

procedure TTaskTriggers.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= Count) then
    HandleError(res_TriggerIndexOutbound, [Index]);

  FTaskItem.Definition.Triggers.Remove(Succ(Index));
  Items[Index].Free;
end;

function TTaskTriggers.GetTrigger(Index: Integer): TTaskTrigger;
begin
  if (Index < 0) or (Index >= Count) then
    HandleError(res_TriggerIndexOutbound, [Index]);

  Result := TTaskTrigger(GetItem(Index));
end;

procedure TTaskTriggers.InitTriggers;
var
  i: Integer;
  iCount: Integer;
  pTrigger: TTaskTrigger;
begin
  iCount := FTaskItem.Definition.Triggers.Count;
  for i := 1 to iCount do
  begin
    pTrigger := TTaskTrigger(Add);
    pTrigger.Trigger := FTaskItem.Definition.Triggers.Item[i];
    pTrigger.TaskTriggers := Self;
    case pTrigger.Trigger.type_ of
      TASK_TRIGGER_TIME:
        pTrigger.TriggerType := ttOnce;
      TASK_TRIGGER_DAILY:
        pTrigger.TriggerType := ttDaily;
      TASK_TRIGGER_WEEKLY:
        pTrigger.TriggerType := ttWeekly;
      TASK_TRIGGER_MONTHLY:
        pTrigger.TriggerType := ttMonthlyDate;
      TASK_TRIGGER_MONTHLYDOW:
        pTrigger.TriggerType := ttMonthlyDow;
      TASK_TRIGGER_IDLE:
        pTrigger.TriggerType := ttOnIdle;
      TASK_TRIGGER_BOOT:
        pTrigger.TriggerType := ttAtStartup;
      TASK_TRIGGER_LOGON:
        pTrigger.TriggerType := ttAtLogon;
    else
      pTrigger.TriggerType := ttUnknown;
    end;
  end;
end;

{ TTaskTrigger }

function TTaskTrigger.GetAsString: string;
var
  rFormat: TFormatSettings;
  fDaily: IDailyTrigger;
  fWeekly: IWeeklyTrigger;
  fMonthly: IMonthlyTrigger;
  fMonthDOW: IMonthlyDOWTrigger;
  rStart: TDateTime;
  sDate: string;
  sTime: string;
  sHelp: string;
  sDays: string;
  sWeek: string;
begin
  rFormat := TFormatSettings.Create;
  rFormat.LongTimeFormat := rFormat.ShortTimeFormat;
  rFormat.ShortDateFormat := res_VeryShortDateLocale;
  rStart := StartBoundary;
  sDate := DateToStr(rStart, rFormat);
  sTime := TimeToStr(rStart, rFormat);
  case FTrigger.type_ of
    TASK_TRIGGER_TIME:
      begin
        Result := Format(res_TriggerTime, [sTime, sDate]);
      end;
    TASK_TRIGGER_DAILY:
      begin
        fDaily := FTrigger as IDailyTrigger;
        if (fDaily.DaysInterval > 1) then
          Result := Format(res_TriggerDays, [sTime, fDaily.DaysInterval])
        else
          Result := Format(res_TriggerDaily, [sTime]);
      end;
    TASK_TRIGGER_WEEKLY:
      begin
        fWeekly := FTrigger as IWeeklyTrigger;
        sHelp := IntArrayToString(fWeekly.DaysOfWeek, wmWeek, True);
        if (fWeekly.WeeksInterval > 1) then
          Result := Format(res_TriggerWeeks, [sTime, sHelp, fWeekly.WeeksInterval, sDate])
        else
          Result := Format(res_TriggerWeekly, [sTime, sHelp, sDate]);
      end;
    TASK_TRIGGER_MONTHLY:
      begin
        fMonthly := FTrigger as IMonthlyTrigger;
        sHelp := IntArrayToString(fMonthly.MonthsOfYear, wmMonth, True);
        sDays := IntArrayToString(fMonthly.DaysOfMonth, wmDays, True);
        Result := Format(res_TriggerMonthly, [sTime, sDays, sHelp, sDate])
      end;
    TASK_TRIGGER_MONTHLYDOW:
      begin
        fMonthDOW := FTrigger as IMonthlyDOWTrigger;
        sDays := IntArrayToString(fMonthDOW.WeeksOfMonth, wmDOW, False);
        sWeek := IntArrayToString(fMonthDOW.DaysOfWeek, wmWeek, False);
        sHelp := IntArrayToString(fMonthDOW.MonthsOfYear, wmMonth, True);
        Result := Format(res_TriggerMonthDOW, [sTime, sDays, sWeek, sHelp, sDate]);
      end;
    TASK_TRIGGER_IDLE:
      begin
        Result := res_TriggerIdle;
      end;
    TASK_TRIGGER_BOOT:
      begin
        Result := res_TriggerStartup;
      end;
    TASK_TRIGGER_LOGON:
      begin
        Result := res_TriggerLogon;
      end;
  end;
end;

function TTaskTrigger.GetStartBoundary: TDateTime;
begin
  Result := BoundaryToDateTime(FTrigger.StartBoundary);
end;

function TTaskTrigger.GetTriggerID: String;
begin
  Result := FTrigger.Id;
end;

function TTaskTrigger.GetWeekOfMonth: Integer;
begin
  Result := IntArrayToInteger((FTrigger as IMonthlyDOWTrigger).WeeksOfMonth, wmDOW);
end;

function TTaskTrigger.GetWeeksInterval: Integer;
begin
  Result := (FTrigger as IWeeklyTrigger).WeeksInterval;
end;

function TTaskTrigger.GetDayOfMonth: Integer;
begin
  Result := IntArrayToInteger((FTrigger as IMonthlyTrigger).DaysOfMonth, wmDays);
end;

function TTaskTrigger.GetDayOfWeek: Integer;
begin
  Result := IntArrayToInteger((FTrigger as IMonthlyDOWTrigger).DaysOfWeek, wmWeek);
end;

function TTaskTrigger.GetDaysInterval: Integer;
begin
  Result := (FTrigger as IDailyTrigger).DaysInterval;
end;

function TTaskTrigger.GetDaysOfWeek: Integer;
begin
  Result := (FTrigger as IWeeklyTrigger).DaysOfWeek;
end;

function TTaskTrigger.GetEndBoundary: TDateTime;
begin
  Result := BoundaryToDateTime(FTrigger.EndBoundary);
end;

function TTaskTrigger.GetIdleDuration: Integer;
begin
  Result := PymdThmsToMinutes(TaskTriggers.TaskItem.Definition.Settings.IdleSettings.IdleDuration);
end;

function TTaskTrigger.GetMonthsOfYear: Integer;
begin
  Result := (FTrigger as IMonthlyTrigger).MonthsOfYear;
end;

function TTaskTrigger.GetMonthsOfYearDow: Integer;
begin
  Result := (FTrigger as IMonthlyDOWTrigger).MonthsOfYear;
end;

procedure TTaskTrigger.SetDayOfMonth(const Value: Integer);
begin
  (FTrigger as IMonthlyTrigger).DaysOfMonth := Value;
end;

procedure TTaskTrigger.SetDayOfWeek(const Value: Integer);
begin
  (FTrigger as IMonthlyDOWTrigger).DaysOfWeek := Value;
end;

procedure TTaskTrigger.SetDaysInterval(const Value: Integer);
begin
  (FTrigger as IDailyTrigger).DaysInterval := Value;
end;

procedure TTaskTrigger.SetDaysOfWeek(const Value: Integer);
begin
  (FTrigger as IWeeklyTrigger).DaysOfWeek := Value;
end;

procedure TTaskTrigger.SetEndBoundary(const Value: TDateTime);
var
  BoundaryFormat: TFormatSettings;
begin
  if Value <> 0 then
  begin
    BoundaryFormat.ShortDateFormat := 'yyyy-mm-dd';
    BoundaryFormat.DateSeparator := '-';
    BoundaryFormat.LongTimeFormat := 'hh:nn:ss';
    BoundaryFormat.TimeSeparator := ':';

    FTrigger.EndBoundary := Trim(DateToStr(Value, BoundaryFormat) + 'T' + TimeToStr(Value, BoundaryFormat));
  end else
    FTrigger.EndBoundary := '';
end;

procedure TTaskTrigger.SetIdleDuration(const Value: Integer);
begin
  TaskTriggers.TaskItem.Definition.Settings.IdleSettings.IdleDuration := Format('PT%dM', [Value]);
end;

procedure TTaskTrigger.SetMonthsOfYear(const Value: Integer);
begin
  (FTrigger as IMonthlyTrigger).MonthsOfYear := Value;
end;

procedure TTaskTrigger.SetMonthsOfYearDow(const Value: Integer);
begin
  (FTrigger as IMonthlyDOWTrigger).MonthsOfYear := Value;
end;

procedure TTaskTrigger.SetStartBoundary(const Value: TDateTime);
var
  BoundaryFormat: TFormatSettings;
begin
  if Value <> 0 then
  begin
    BoundaryFormat.ShortDateFormat := 'yyyy-mm-dd';
    BoundaryFormat.DateSeparator := '-';
    BoundaryFormat.LongTimeFormat := 'hh:nn:ss';
    BoundaryFormat.TimeSeparator := ':';

    FTrigger.StartBoundary := Trim(DateToStr(Value, BoundaryFormat) + 'T' + TimeToStr(Value, BoundaryFormat));
  end else
    FTrigger.StartBoundary := '';
end;

procedure TTaskTrigger.SetWeekOfMonth(const Value: Integer);
begin
  (FTrigger as IMonthlyDOWTrigger).WeeksOfMonth := Value;
end;

procedure TTaskTrigger.SetWeeksInterval(const Value: Integer);
begin
  (FTrigger as IWeeklyTrigger).WeeksInterval := Value;
end;

function TTaskTrigger.BoundaryToDateTime(const Boundary: String): TDateTime;
var
  BoundaryFormat: TFormatSettings;
begin
  if Boundary = EmptyStr then
  begin
    Result := 0;
  end else
  begin
    BoundaryFormat.ShortDateFormat := 'yyyy-mm-dd';
    BoundaryFormat.DateSeparator := '-';
    BoundaryFormat.ShortTimeFormat := 'hh:nn:ss';
    BoundaryFormat.TimeSeparator := ':';
    Result := StrToDateTimeDef(Boundary, 0, BoundaryFormat);
  end;
end;

function TTaskTrigger.PymdThmsToMinutes(const PymdThms: String): Integer;
const
  SecsPerMonth = SecsPerDay * 30;
  SecsPerYear = SecsPerMonth * 12;
  Mult: array[1..7] of Integer = (SecsPerYear, SecsPerMonth, SecsPerDay, 0, SecsPerHour, SecsPerMin, 1);
  Mask = 'YMDTHMS';
var
  cId: Char;
  iPos, iId: Byte;
  iSecs: Integer;

  procedure NextPart;
  var
    sPart: String;
  begin
    iId := PosEx(cId, PymdThms, iPos);
    sPart := Copy(PymdThms, iPos + 1, iId - iPos - 1);
    iPos := Max(iId, iPos);
    iSecs := iSecs + (StrToIntDef(sPart, 0) * Mult[Pos(cId, Mask)]);
  end;

begin
  iPos := PosEx('P', PymdThms, 1);
  if (iPos = 1) then
  begin
    iSecs := 0;
    for cId in Mask do
      NextPart;
  end;
  Result := iSecs div SecsPerMin;
end;

function TTaskTrigger.IntArrayToInteger(IntArray: Integer; Mode: TWeekMonthDays): Integer;
var
  i, iInt: Integer;
begin
  Result := 0;
  iInt := 1;
  for i := 1 to Integer(Mode) do
  begin
    if (IntArray and iInt) = iInt then
    begin
      Result := i;
      Break;
    end;
    iInt := iInt * 2;
  end;
end;

function TTaskTrigger.IntArrayToString(IntArray: Integer; Mode: TWeekMonthDays; Every: Boolean): string;
const
  DOW: array[1..Integer(wmDOW)] of String =
    (res_DOWFirst, res_DOWSecond, res_DOWThird, res_DOWFourth, res_DOWLast);
var
  i, iInt: Integer;
begin
  Result := '';
  iInt := 1;
  if IntArray = Pred(iInt shl Integer(Mode)) then
  begin
    case Mode of
      wmWeek: Result := res_EachWeekDay;
      wmMonth: Result := res_EachMonth;
      wmDays: Result := res_EachDay;
    end;
    Exit;
  end;

  for i := 1 to Integer(Mode) do
  begin
    if (IntArray and iInt) = iInt then
    begin
      if (Result = '') and (Every) then
        Result := res_Every
      else
      if Result <> '' then
        Result := Result + ', ';

      case Mode of
        wmDOW: Result := Result + DOW[i];
        wmWeek: Result := Result + FormatSettings.ShortDayNames[i];
        wmMonth: Result := Result + FormatSettings.ShortMonthNames[i];
        wmDays: Result := Result + Format('%d.', [i]);
      end;
    end;
    iInt := iInt * 2;
  end;
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
  FTriggers.InitTriggers;
end;

procedure TTaskItem.SaveTask(const NewName: String = '');
var
  s: OleVariant;
  sOldName: String;
begin
  if NewName <> '' then
  begin
    sOldName := TaskName;
    TaskName := NewName;
  end;

  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  FRegTask := FTaskMan.TaskRoot.RegisterTaskDefinition(
    TaskName, FTaskDefinition, TASK_CREATE_OR_UPDATE, s, s, FTaskDefinition.Principal.LogonType, s);

  if NewName <> '' then
  begin
    TaskMan.AddTask(FRegTask);
    TaskMan.DeleteTask(sOldName);
  end;
end;

procedure TTaskItem.SetAccount(const Username, Password: String);
begin
  if not Assigned(FTaskDefinition) then
    HandleError(res_NoTaskDefinitions, [TaskName]);

  FTaskDefinition.Principal.UserId := Username;

  if Trim(Password) <> EmptyStr then
    FTaskMan.TaskRoot.RegisterTaskDefinition(
      TaskName, FTaskDefinition, TASK_CREATE_OR_UPDATE, Username, Password, TASK_LOGON_PASSWORD, '');
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

end.
