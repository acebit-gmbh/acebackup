unit tsSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,
  tsTaskMan, Vcl.CheckLst, System.DateUtils;

type
  TTaskApplySettingEvent = procedure(Sender: TObject; const Task: TTaskItem) of object;

  TfrmTaskSettings = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnDelete: TButton;
    btnNew: TButton;
    btnOk: TButton;
    bvlSeparator: TBevel;
    cbbExecuteTask: TComboBox;
    cbbTriggers: TComboBox;
    cbbWeekdays: TComboBox;
    cbbWeekOfMonth: TComboBox;
    chkExpires: TCheckBox;
    chklstMonths: TCheckListBox;
    chklstWeekdays: TCheckListBox;
    dtpDateFirst: TDateTimePicker;
    dtpDateLast: TDateTimePicker;
    dtpTimeFirst: TDateTimePicker;
    edtDaily: TEdit;
    edtEveryMonth: TEdit;
    edtIdleTime: TEdit;
    edtWeekly: TEdit;
    lblDayOfMonth: TLabel;
    lblEndDate: TLabel;
    lblEveryDay: TLabel;
    lblEveryWeek: TLabel;
    lblExecuteDaily: TLabel;
    lblExecuteIdle: TLabel;
    lblExecuteMonthly: TLabel;
    lblExecuteTask: TLabel;
    lblExecuteWeekly: TLabel;
    lblIdleMin: TLabel;
    lblIdleTime: TLabel;
    lblMonth: TLabel;
    lblOfMonth: TLabel;
    lblOnWeek: TLabel;
    lblStartDate: TLabel;
    lblStarting: TLabel;
    lblTask: TLabel;
    lblThDay: TLabel;
    lblThWeek: TLabel;
    pgcSettings: TPageControl;
    pgcTriggers: TPageControl;
    pnlButtons: TPanel;
    rbOnFirstDay: TRadioButton;
    rbOnMonthWeekday: TRadioButton;
    tsDaily: TTabSheet;
    tsIdle: TTabSheet;
    tsMonthly: TTabSheet;
    tsSettings: TTabSheet;
    tsTimeplan: TTabSheet;
    tsWeekly: TTabSheet;
    udDaily: TUpDown;
    udDayOfMonth: TUpDown;
    udIdleTime: TUpDown;
    udWeekly: TUpDown;
    pnlBoundarys: TPanel;
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbbTriggersSelect(Sender: TObject);
    procedure cbbExecuteTaskSelect(Sender: TObject);
    procedure dtpTimeFirstChange(Sender: TObject);
    procedure dtpDateLastChange(Sender: TObject);
    procedure edtDailyChange(Sender: TObject);
    procedure edtWeeklyChange(Sender: TObject);
    procedure chklstWeekdaysClickCheck(Sender: TObject);
    procedure chklstMonthsClickCheck(Sender: TObject);
    procedure rbOnFirstDayClick(Sender: TObject);
    procedure edtEveryMonthChange(Sender: TObject);
    procedure cbbWeekOfMonthChange(Sender: TObject);
    procedure cbbWeekdaysChange(Sender: TObject);
    procedure edtIdleTimeChange(Sender: TObject);
  private
    FTaskScheduler: TTaskScheduler;
    FOnApplySettings: TTaskApplySettingEvent;
    FTaskItem: TTaskItem;
    FCounter: Integer;
    FInitTrigger: Boolean;
    FChooseTrigger: Boolean;
    FTaskTrigger: TTaskTrigger;
    function TaskComboBoxIndex: TTriggerType;
    procedure AddItem(Trigger: TTaskTrigger);
    procedure InitTriggers;
    procedure InitControls;
    procedure SetBoundarys;
    procedure SetTriggerCaption(Index: Integer);
    procedure SetTriggerDaily;
    procedure SetTriggerWeekly;
    procedure SetTriggerMonthly;
    procedure SetTriggerMonthDOW;
    procedure SetTriggerIdle;
    procedure TaskChange;
    function GetCheckListBox(ListBox: TCheckListBox): Integer;
    procedure SetCheckListBox(ListBox: TCheckListBox; Values: Integer);
    procedure EnableControls(TriggerType: TTriggerType);
  public
    function Execute: Boolean;

    property TaskItem: TTaskItem read FTaskItem write FTaskItem;
    property TaskScheduler: TTaskScheduler read FTaskScheduler write FTaskScheduler;
    property OnApplySettings: TTaskApplySettingEvent read FOnApplySettings write FOnApplySettings;
  end;

implementation

{$R *.dfm}

resourcestring
  res_AtLeastOneWeekDay = 'You have to choose at least one weekday';
  res_AtLeastOneMonth = 'You have to choose at least one month';

{ TfrmTaskSettings }

procedure TfrmTaskSettings.AddItem(Trigger: TTaskTrigger);
begin
  Trigger.Internal := FCounter;
  cbbTriggers.ItemIndex := cbbTriggers.Items.AddObject(Format('%d. %s', [Trigger.Internal, Trigger.AsString]), Trigger);

  if FInitTrigger then
    Exit;

  cbbTriggersSelect(cbbTriggers);
end;

procedure TfrmTaskSettings.btnDeleteClick(Sender: TObject);
var
  iIndex: Integer;
begin
  iIndex := cbbTriggers.ItemIndex;
  if iIndex < 0 then
    Exit;

  TaskItem.Triggers.Delete(iIndex);
  cbbTriggers.DeleteSelected;
  cbbTriggers.ItemIndex := iIndex;
  cbbTriggersSelect(cbbTriggers);
  TaskChange;
end;

procedure TfrmTaskSettings.btnNewClick(Sender: TObject);
begin
  Inc(FCounter);
  FTaskTrigger := TaskItem.Triggers.New(ttDaily);
  FTaskTrigger.StartBoundary := Now;
  AddItem(FTaskTrigger);
end;

procedure TfrmTaskSettings.cbbExecuteTaskSelect(Sender: TObject);
var
  iIndex: Integer;
  iInternal: Integer;
begin
  iInternal := FTaskTrigger.Internal;

  iIndex := cbbTriggers.ItemIndex;
  TaskItem.Triggers.Delete(iIndex);

  FTaskTrigger := TaskItem.Triggers.New(TaskComboBoxIndex);
  FTaskTrigger.Internal := iInternal;
  if FTaskTrigger.TriggerType in [ttOnce..ttMonthlyDow] then
    FTaskTrigger.StartBoundary := Now;

  cbbTriggers.Items.Objects[iIndex] := FTaskTrigger;
  SetTriggerCaption(iIndex);

  cbbTriggersSelect(cbbTriggers);
end;

procedure TfrmTaskSettings.cbbTriggersSelect(Sender: TObject);
begin
  FTaskTrigger := nil;
  FChooseTrigger := True;
  cbbExecuteTask.ItemIndex := -1;
  if cbbTriggers.ItemIndex < 0 then
    Exit;

  FTaskTrigger := cbbTriggers.Items.Objects[cbbTriggers.ItemIndex] as TTaskTrigger;

  case FTaskTrigger.TriggerType of
    ttOnce:
      cbbExecuteTask.ItemIndex := 3;
    ttDaily:
      SetTriggerDaily;
    ttWeekly:
      SetTriggerWeekly;
    ttMonthlyDate:
      SetTriggerMonthly;
    ttMonthlyDow:
      SetTriggerMonthDOW;
    ttOnIdle:
      SetTriggerIdle;
    ttAtStartup:
      cbbExecuteTask.ItemIndex := 4;
    ttAtLogon:
      cbbExecuteTask.ItemIndex := 5;
    ttUnknown:
      cbbExecuteTask.ItemIndex := -1;
  end;
  SetBoundarys;
  TaskChange;
  FChooseTrigger := False;
end;

procedure TfrmTaskSettings.cbbWeekdaysChange(Sender: TObject);
begin
  if FChooseTrigger or (FTaskTrigger.TriggerType <> ttMonthlyDow) then
    Exit;

  FTaskTrigger.DayOfWeek := cbbWeekdays.ItemIndex + 1;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.cbbWeekOfMonthChange(Sender: TObject);
begin
  if FChooseTrigger or (FTaskTrigger.TriggerType <> ttMonthlyDow) then
    Exit;

  FTaskTrigger.WeekOfMonth := cbbWeekOfMonth.ItemIndex + 1;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.chklstMonthsClickCheck(Sender: TObject);
var
  iMonths: Integer;
begin
  if FChooseTrigger then
    Exit;

  iMonths := GetCheckListBox(chklstMonths);
  if iMonths = 0 then
  begin
    SetCheckListBox(chklstMonths, chklstMonths.Tag);
    HandleError(res_AtLeastOneMonth);
  end;
  chklstMonths.Tag := iMonths;
  if FTaskTrigger.TriggerType = ttMonthlyDate then
    FTaskTrigger.MonthsOfYear := GetCheckListBox(chklstMonths)
  else
    FTaskTrigger.MonthsOfYearDow := GetCheckListBox(chklstMonths);
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.chklstWeekdaysClickCheck(Sender: TObject);
var
  iDays: Integer;
begin
  if FChooseTrigger or (FTaskTrigger.TriggerType <> ttWeekly) then
    Exit;

  iDays := GetCheckListBox(chklstWeekdays);
  if iDays = 0 then
  begin
    SetCheckListBox(chklstWeekdays, chklstWeekdays.Tag);
    HandleError(res_AtLeastOneWeekDay);
  end;
  chklstWeekdays.Tag := iDays;
  FTaskTrigger.DaysOfWeek := iDays;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.dtpDateLastChange(Sender: TObject);
begin
  if FChooseTrigger then
    Exit;

  dtpDateLast.Enabled := chkExpires.Checked;
  if chkExpires.Checked then
    FTaskTrigger.EndBoundary := TimeOf(StrToTimeDef('23:59:59', Now)) + DateOf(dtpDateLast.Date)
  else
    FTaskTrigger.EndBoundary := 0;
end;

procedure TfrmTaskSettings.dtpTimeFirstChange(Sender: TObject);
begin
  if FChooseTrigger then
    Exit;

  FTaskTrigger.StartBoundary := TimeOf(dtpTimeFirst.Time) + DateOf(dtpDateFirst.Date);
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.edtDailyChange(Sender: TObject);
begin
  if FChooseTrigger  or (FTaskTrigger.TriggerType <> ttDaily) then
    Exit;

  FTaskTrigger.DaysInterval := udDaily.Position;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.edtEveryMonthChange(Sender: TObject);
begin
  if FChooseTrigger or (FTaskTrigger.TriggerType <> ttMonthlyDate) then
    Exit;

  FTaskTrigger.DayOfMonth := udDayOfMonth.Position;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.edtIdleTimeChange(Sender: TObject);
begin
  if FChooseTrigger or (FTaskTrigger.TriggerType <> ttOnIdle) then
    Exit;

  FTaskTrigger.IdleDuration := udIdleTime.Position;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

procedure TfrmTaskSettings.edtWeeklyChange(Sender: TObject);
begin
  if FChooseTrigger or (FTaskTrigger.TriggerType <> ttWeekly) then
    Exit;

  FTaskTrigger.WeeksInterval := udWeekly.Position;
  SetTriggerCaption(cbbTriggers.ItemIndex);
end;

function TfrmTaskSettings.Execute: Boolean;
begin
  InitControls;
  InitTriggers;
  Result := ShowModal = mrOK;
end;

function TfrmTaskSettings.GetCheckListBox(ListBox: TCheckListBox): Integer;
var
  i, iInt: Integer;
begin
  iInt := 1;
  Result := 0;
  for i := 0 to ListBox.Count-1 do
  begin
    if ListBox.Checked[i] then
      Result := Result or iInt;
    iInt := iInt * 2;
  end;
end;

procedure TfrmTaskSettings.EnableControls(TriggerType: TTriggerType);
begin
  edtEveryMonth.Enabled := TriggerType = ttMonthlyDate;
  lblDayOfMonth.Enabled := TriggerType = ttMonthlyDate;
  cbbWeekOfMonth.Enabled := TriggerType = ttMonthlyDow;
  cbbWeekdays.Enabled := TriggerType = ttMonthlyDow;
  lblOfMonth.Enabled := TriggerType = ttMonthlyDow;
end;

procedure TfrmTaskSettings.InitControls;
var
  sItem: String;
begin
  chklstWeekdays.Items.Clear;
  for sItem in FormatSettings.LongDayNames do
    chklstWeekdays.Items.Add(sItem);

  chklstMonths.Items.Clear;
  for sItem in FormatSettings.LongMonthNames do
    chklstMonths.Items.Add(sItem);
end;

procedure TfrmTaskSettings.InitTriggers;
var
  i: Integer;
begin
  FCounter := 0;
  FInitTrigger := True;
  FChooseTrigger := True;
  cbbTriggers.Items.Clear;
  for i := 0 to TaskItem.Triggers.Count-1 do
  begin
    Inc(FCounter);
    AddItem(TaskItem.Triggers[i]);
  end;
  FInitTrigger := False;

  if cbbTriggers.Items.Count > 0 then
  begin
    cbbTriggers.ItemIndex := 0;
    cbbTriggersSelect(cbbTriggers);
  end else
    TaskChange;
end;

procedure TfrmTaskSettings.rbOnFirstDayClick(Sender: TObject);
begin
  if FInitTrigger or FChooseTrigger then
    Exit;

  cbbExecuteTaskSelect(cbbExecuteTask);
end;

procedure TfrmTaskSettings.SetBoundarys;
var
  pDate: TDateTime;
begin
  pDate := FTaskTrigger.StartBoundary;
  dtpTimeFirst.Enabled := pDate > 0;
  dtpDateFirst.Enabled := pDate > 0;
  if pDate > 0 then
  begin
    dtpTimeFirst.Time := pDate;
    dtpDateFirst.Date := pDate;
  end else
  begin
    dtpTimeFirst.Time := Time;
    dtpDateFirst.Date := Date;
  end;

  pDate := FTaskTrigger.EndBoundary;
  if pDate > 0 then
    dtpDateLast.Date := pDate
  else
    dtpDateLast.Date := IncMonth(Date, 12);
  chkExpires.Checked := pDate > 0;
  dtpDateLast.Enabled := chkExpires.Checked;
end;

procedure TfrmTaskSettings.SetCheckListBox(ListBox: TCheckListBox; Values: Integer);
var
  i, iInt: Integer;
begin
  iInt := 1;
  for i := 0 to ListBox.Count-1 do
  begin
    ListBox.Checked[i] := (Values and iInt) = iInt;
    iInt := iInt * 2;
  end;
  ListBox.Tag := Values;
end;

procedure TfrmTaskSettings.SetTriggerCaption(Index: Integer);
begin
  cbbTriggers.Items[cbbTriggers.ItemIndex] := Format('%d. %s', [FTaskTrigger.Internal, FTaskTrigger.AsString]);
  cbbTriggers.ItemIndex := Index;
end;

procedure TfrmTaskSettings.SetTriggerDaily;
begin
  cbbExecuteTask.ItemIndex := 0;
  udDaily.Position := FTaskTrigger.DaysInterval;
end;

procedure TfrmTaskSettings.SetTriggerIdle;
begin
  cbbExecuteTask.ItemIndex := 6;
  udIdleTime.Position := FTaskTrigger.IdleDuration;
end;

procedure TfrmTaskSettings.SetTriggerMonthDOW;
begin
  cbbExecuteTask.ItemIndex := 2;
  rbOnMonthWeekday.Checked := True;
  cbbWeekOfMonth.ItemIndex := FTaskTrigger.WeekOfMonth - 1;
  cbbWeekdays.ItemIndex := FTaskTrigger.DayOfWeek - 1;
  SetCheckListBox(chklstMonths, FTaskTrigger.MonthsOfYearDow);
  EnableControls(FTaskTrigger.TriggerType);
end;

procedure TfrmTaskSettings.SetTriggerMonthly;
begin
  cbbExecuteTask.ItemIndex := 2;
  rbOnFirstDay.Checked := True;
  if FTaskTrigger.DayOfMonth < 1 then
    FTaskTrigger.DayOfMonth := 1;
  udDayOfMonth.Position := FTaskTrigger.DayOfMonth;
  cbbWeekOfMonth.ItemIndex := -1;
  cbbWeekdays.ItemIndex := -1;
  SetCheckListBox(chklstMonths, FTaskTrigger.MonthsOfYear);
  EnableControls(FTaskTrigger.TriggerType);
end;

procedure TfrmTaskSettings.SetTriggerWeekly;
begin
  cbbExecuteTask.ItemIndex := 1;
  udWeekly.Position := FTaskTrigger.WeeksInterval;
  if FTaskTrigger.DaysOfWeek < 1 then
    FTaskTrigger.DaysOfWeek := 1;
  SetCheckListBox(chklstWeekdays, FTaskTrigger.DaysOfWeek);
end;

procedure TfrmTaskSettings.TaskChange;
begin
  case cbbExecuteTask.ItemIndex of
    0: pgcTriggers.ActivePage := tsDaily;
    1: pgcTriggers.ActivePage := tsWeekly;
    2: pgcTriggers.ActivePage := tsMonthly;
    6: pgcTriggers.ActivePage := tsIdle;
  else
    pgcTriggers.ActivePage := nil;
  end;
  pgcTriggers.Visible := pgcTriggers.ActivePage <> nil;
  pnlBoundarys.Visible := cbbTriggers.ItemIndex >= 0;
end;

function TfrmTaskSettings.TaskComboBoxIndex: TTriggerType;
begin
  case cbbExecuteTask.ItemIndex of
    0:
      Result := ttDaily;
    1:
      Result := ttWeekly;
    2:
      begin
        if rbOnMonthWeekday.Checked then
          Result := ttMonthlyDow
        else
          Result := ttMonthlyDate;
      end;
    3:
      Result := ttOnce;
    4:
      Result := ttAtStartup;
    5:
      Result := ttAtLogon;
    6:
      Result := ttOnIdle;
  else
    Result := ttUnknown;
  end;
end;

end.
