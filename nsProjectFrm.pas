unit nsProjectFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, nsTypes, nsGlobals, DateUtils, System.UITypes,
  tsTaskman, tsSettings, StrUtils, ImgList, Spin, System.ImageList;

type

  TfrmProjectProperties = class(TForm)
    PageControl: TPageControl;
    TS1: TTabSheet;
    TS2: TTabSheet;
    edtTitle: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    lblSize: TLabel;
    lblContains: TLabel;
    TS3: TTabSheet;
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    btnSecurity: TButton;
    grpSchedules: TGroupBox;
    grpLog: TGroupBox;
    chkWriteLog: TCheckBox;
    lblIncluded: TLabel;
    lblExcluded: TLabel;
    edtInclude: TEdit;
    edtExclude: TEdit;
    lblEncType: TLabel;
    lblEncryption: TLabel;
    btnEditSchedule: TButton;
    lblSchedule: TLabel;
    ImageList1: TImageList;
    Label16: TLabel;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    edExtApp1: TEdit;
    btBrowseExtApp1: TButton;
    ckbWaitExtApp1: TCheckBox;
    Label18: TLabel;
    edExtApp2: TEdit;
    btBrowseExtApp2: TButton;
    ckbWaitExtApp2: TCheckBox;
    odExtExecutable: TOpenDialog;
    lvVolumes: TListView;
    btnAddVolume: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    seTimeOutBefore: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    seTimeOutAfter: TSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    lblSyncMode: TLabel;
    cbSyncMode: TComboBox;
    Label9: TLabel;
    cbDefAction: TComboBox;
    cbSendMail: TComboBox;
    cbSendMailContent: TComboBox;
    lblSendMail: TLabel;
    lblSendMailContent: TLabel;
    btnEditIncluded: TButton;
    btnEditExcluded: TButton;
    lblComression: TLabel;
    cbCompression: TComboBox;
    cbFileFormat: TComboBox;
    Label33: TLabel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    Bevel5: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel6: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSecurityClick(Sender: TObject);
    procedure edtMaxSizeKeyPress(Sender: TObject; var Key: char);
    procedure btnEditScheduleClick(Sender: TObject);
    procedure cbSchedulesKeyPress(Sender: TObject; var Key: char);
    procedure btnHelpClick(Sender: TObject);
    procedure btBrowseExtApp1Click(Sender: TObject);
    procedure btnAddVolumeClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvVolumesDblClick(Sender: TObject);
    procedure chkWriteLogClick(Sender: TObject);
    procedure btnEditIncludedClick(Sender: TObject);
    procedure btnEditExcludedClick(Sender: TObject);
    procedure cbFileFormatChange(Sender: TObject);
    procedure cbDefActionChange(Sender: TObject);
  private
    { Private declarations }
    FThread: TThread;
    FProject: TNSProject;
    FTask: TTaskItem;
    TaskDialog: TfrmTaskSettings;
    FPasswordSet: Boolean;
    FDisableTask: Boolean;
    procedure CheckPassword;
    procedure GetTaskProperties(AProject: TNSProject);
    procedure SetTaskProperties(AProject: TNSProject);
    procedure UpdateTask;
    procedure GetProperties(AProject: TNSProject);
    procedure SetProperties(AProject: TNSProject);
  protected
    procedure UpdateActions; override;
    procedure FillVolumes;
    procedure UpdateListItem(const AItem: TListItem);
  public
    { Public declarations }
  end;

  TScanThread = class(TThread)
  private
    FSize: int64;
    FFolderCount: integer;
    FFileCount: integer;
    FForm: TfrmProjectProperties;
    FProject: TNSProject;
    procedure Update;
  public
    constructor Create(AForm: TfrmProjectProperties; AProject: TNSProject);
    destructor Destroy; override;
    procedure Execute; override;
  end;

function DisplayProjectPropertiesDialog(const AProject: TNSProject; DisableTask: Boolean = True): Boolean;

implementation

{$R *.dfm}

uses
  nsSecSettingsFrm, nsUtils, nsActions, nsTaskPassword, nsMediaSettings, abMasksDlg, nsMainFrm;

function DisplayProjectPropertiesDialog(const AProject: TNSProject; DisableTask: Boolean = True): Boolean;
var
  dlg: TfrmProjectProperties;
begin
  dlg := TfrmProjectProperties.Create(nil);
  try
    dlg.FDisableTask := DisableTask;
    dlg.GetTaskProperties(AProject);
    dlg.GetProperties(AProject);
    Result := dlg.ShowModal = mrOk;
    if Result then
      dlg.SetProperties(AProject);
    if Result then
      dlg.SetTaskProperties(AProject);
  finally
    FreeAndNil(dlg);
  end;
end;

{ TProjectForm }

procedure TfrmProjectProperties.GetProperties(AProject: TNSProject);
var
  da: TDefaultAction;
  sm: TSyncMode;
begin
  PageControl.ActivePageIndex := 0;
  //  FProject := AProject;
  FProject := TNSProject.Create(nil);

  AssignVolumes(AProject, FProject);

  FThread := TScanThread.Create(Self, AProject);
  Caption := Format(sProperties, [AProject.DisplayName]);

  edtTitle.Text := AProject.DisplayName;

  lblEncryption.Caption := Encryptions[AProject.EncryptionMethod]^;

  chkWriteLog.Checked := AProject.WriteLog;


  edtInclude.Text := AProject.IncMasks.GetMask;
  edtExclude.Text := AProject.ExcMasks.GetMask;

  for da := Low(TDefaultAction) to High(TDefaultAction) do
    cbDefAction.Items.Add(ActionNames[da]^);
  cbDefAction.ItemIndex := Ord(AProject.DefaultAction);

  for sm := Low(TSyncMode) to High(TSyncMode) do
    cbSyncMode.Items.Add(SyncModeNames[sm]^);
  cbSyncMode.ItemIndex := Ord(AProject.SyncMode);


  cbSendMail.ItemIndex := Ord(AProject.SendLog);
  cbSendMailContent.ItemIndex := Ord(AProject.SendMailContect);
  chkWriteLogClick(Self);

  cbFileFormat.ItemIndex  := Ord(AProject.FileFormat);
  cbCompression.ItemIndex := AProject.CompressionLevel;
  cbFileFormatChange(Self);

  edExtApp1.Text := AProject.ExtAppBefore;
  ckbWaitExtApp1.Checked := AProject.WaitForExtAppBefore;
  edExtApp2.Text := AProject.ExtAppAfter;
  ckbWaitExtApp2.Checked := AProject.WaitForExtAppAfter;
  seTimeOutBefore.Value := AProject.TimeOutBefore;
  seTimeOutAfter.Value := AProject.TimeOutAfter;

  FillVolumes;
end;

procedure TfrmProjectProperties.SetProperties(AProject: TNSProject);
begin

  AssignVolumes(FProject, AProject);


  AProject.DisplayName := edtTitle.Text;
  AProject.Kind := AProject.Kind;
  AProject.WriteLog := chkWriteLog.Checked;
  AProject.IncMasks.SetMask(edtInclude.Text);
  AProject.IncMasks := AProject.IncMasks;
  AProject.ExcMasks.SetMask(edtExclude.Text);
  AProject.ExcMasks := AProject.ExcMasks;

  AProject.ReInitCrypting;
  //  AProject.ProjPwd := AProject.ProjPwd;
  //  AProject.EncryptionMethod := FProject.EncryptionMethod;

  if AProject.Items.Count = 0 then
    AProject.DefaultAction := TDefaultAction(cbDefAction.ItemIndex)
  else if AProject.DefaultAction <> TDefaultAction(cbDefAction.ItemIndex) then
  begin
    if MessageDlg(Format(sConfirmApplyDefAction, [ActionNames[TDefaultAction(cbDefAction.ItemIndex)]^]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      AProject.DefaultAction := TDefaultAction(cbDefAction.ItemIndex);
      ChangeDefAction(nil, AProject.DefaultAction);
    end;
  end;

  AProject.SendLog := TSendMail(cbSendMail.ItemIndex);
  AProject.SendMailContect := TSendMailContent(cbSendMailContent.ItemIndex);
  AProject.CompressionLevel := cbCompression.ItemIndex;

  AProject.ExtAppBefore := edExtApp1.Text;
  AProject.WaitForExtAppBefore := ckbWaitExtApp1.Checked;
  AProject.ExtAppAfter  := edExtApp2.Text;
  AProject.WaitForExtAppAfter := ckbWaitExtApp2.Checked;
  AProject.TimeOutBefore := seTimeOutBefore.Value;
  AProject.TimeOutAfter := seTimeOutAfter.Value;
  if AProject.VolumeCount > 1 then
    AProject.SyncMode := TSyncMode(cbSyncMode.ItemIndex)
  else
    AProject.SyncMode := smIndependent;
  //  AProject.FileFormat := TFileFormat(cbFileFormat.ItemIndex);

end;

procedure TfrmProjectProperties.UpdateTask;
begin
  try
    lblSchedule.Caption := FTask.TriggerText;
  except
    on E: Exception do
      lblSchedule.Caption := E.Message;
  end;
end;

procedure TfrmProjectProperties.GetTaskProperties(AProject: TNSProject);
var
  sTaskAccount: string;
begin
  if not frmMain.TaskManager.Active then
    Exit;
  FTask := frmMain.TaskManager.ActivateTask(AProject.DisplayName);
  if FTask <> nil then
  begin
    FPasswordSet := True;
    try
      sTaskAccount := FTask.Account;
    except
      FPasswordSet := False;
    end;
  end
  else
    try
      FTask := frmMain.TaskManager.CreateTask(AProject.DisplayName);
      FTask.AppName := Application.ExeName;
    except
      FPasswordSet := False;
    end;
  UpdateTask;
end;

procedure TfrmProjectProperties.SetTaskProperties(AProject: TNSProject);
begin
  if (FTask <> nil) then
  begin
    if FTask.Triggers.Count > 0 then
    begin
      FTask.AppName := Application.ExeName;
      FTask.WorkDir := g_ProjectsDir;
      FTask.Creator := Application.Title;
      if FDisableTask then
        FTask.Flags := FTask.Flags - [tfEnabled];
      FTask.Arguments := sUpdate + #34 + AProject.FileName + #34;
      FTask.SaveTask;
    end
    else
    begin
      FTask.SaveTask;
      FTask := nil;
    end;
  end;
end;

procedure TfrmProjectProperties.CheckPassword;
var
  Accnt: WideString;
  Pwd: WideString;
begin
  if SysUtils.Win32Platform <> VER_PLATFORM_WIN32_NT then
    Exit;
  if not FPasswordSet and (FTask.Triggers.Count > 0) then
  begin
    FPasswordSet := SetTaskPassword(Accnt, Pwd);
    if FPasswordSet then
    begin
      FTask.SetAccount(Accnt, Pwd);
    end;
  end;
end;

procedure TfrmProjectProperties.FillVolumes;
var
  Project: TNSProject;
  Index: integer;
  Item:  TListItem;
begin
  lvVolumes.Items.Clear;
  for Index := 0 to FProject.VolumeCount - 1 do
  begin
    Project := FProject.Volumes[Index];
    Item := lvVolumes.Items.Add;
    Item.Data := Project;
    UpdateListItem(Item);
  end;
  if lvVolumes.CanFocus then
    lvVolumes.SetFocus;
  Self.Update;
end;

procedure TfrmProjectProperties.UpdateListItem(const AItem: TListItem);
var
  Project: TNSProject;
begin
  Project := TNSProject(AItem.Data);
  AItem.Caption := Format(sVolume, [Project.VolumeIndex]);
  AItem.SubItems.Text := #13#10#13#10;
  AItem.SubItems[0] := BackupMediaNames[Project.BackupMedia]^;
  AItem.SubItems[1] := Project.GetVolumeString(False);
end;

procedure TfrmProjectProperties.UpdateActions;
begin
  inherited UpdateActions;
  btnEdit.Enabled := lvVolumes.Selected <> nil;
  btnDelete.Enabled := (lvVolumes.Selected <> nil) and (lvVolumes.Selected.Index > 0);
  seTimeOutBefore.Enabled := ckbWaitExtApp1.Checked;
  seTimeOutAfter.Enabled := ckbWaitExtApp2.Checked;
  cbSyncMode.Enabled := lvVolumes.Items.Count > 1;
  lblSyncMode.Enabled := cbSyncMode.Enabled;
  btnEditSchedule.Enabled := FTask <> nil;
end;

{ TScanThread }

constructor TScanThread.Create(AForm: TfrmProjectProperties; AProject: TNSProject);
begin
  inherited Create(True);
  FForm := AForm;
  FProject := AProject;
  Priority := tpLower;
  FreeOnTerminate := True;
  Execute; // FIX // Resume;
end;

destructor TScanThread.Destroy;
begin
  FForm.FThread := nil;
  inherited Destroy;
end;

procedure TScanThread.Execute;
var
  Index:  integer;
  Volume: TNSProject;

  procedure ScanSubItems(const AItem: TPersistent);
  var
    Index: integer;
    CurItem: TNSItem;
    Collection: TNSCollection;
  begin
    if AItem is TNSProject then
      Collection := TNSProject(AItem).Items
    else
      Collection := TNSItem(AItem).SubItems;
    Synchronize(Update);
    for Index := 0 to Collection.Count - 1 do
    begin
      CurItem := Collection[Index];
      if CurItem.IsFolder then
      begin
        Inc(FFolderCount);
        ScanSubItems(CurItem);
      end
      else
      begin
        Inc(FFileCount);
        FSize := FSize + CurItem.SizeOnMedia;
      end;
    end;
  end;

begin
  FSize := 0;
  for Index := 0 to FProject.VolumeCount - 1 do
  begin
    Volume := FProject.Volumes[Index];
    ScanSubItems(Volume);
    Synchronize(Update);
  end;
end;

procedure TScanThread.Update;
begin
  with FForm do
  begin
    lblSize.Caption := FormatSize(FSize, True);
    lblContains.Caption := Format(sFFInfo, [FFileCount, FFolderCount]);
  end;
end;

procedure TfrmProjectProperties.FormDestroy(Sender: TObject);
begin
  if Assigned(FProject) then
    FreeAndNil(FProject);
  if Assigned(FThread) then
    FThread.Terminate;
end;

procedure TfrmProjectProperties.btnSecurityClick(Sender: TObject);
begin
  if DisplaySecSettingsDialog(Self, FProject) then
    lblEncryption.Caption := Encryptions[FProject.EncryptionMethod]^;
  //    lblKind.Caption := ProjectKindNames[FProject.Kind]^;
end;

procedure TfrmProjectProperties.edtMaxSizeKeyPress(Sender: TObject; var Key: char);
begin
  if not CharInSet(Key, [Chr(VK_BACK), '0'..'9']) then
    Key := #0;
end;

procedure TfrmProjectProperties.btnEditScheduleClick(Sender: TObject);
begin
  if FTask = nil then
    Exit;
  try
    TaskDialog.TaskItem := FTask;
    if TaskDialog.Execute then
    begin
      UpdateTask;
      CheckPassword;
    end;
  except
  end;
end;

procedure TfrmProjectProperties.FormCreate(Sender: TObject);
begin
  TaskDialog := TfrmTaskSettings.Create(Self);
  TaskDialog.TaskScheduler := frmMain.TaskManager;
  grpSchedules.Visible := True;
end;

procedure TfrmProjectProperties.cbSchedulesKeyPress(Sender: TObject; var Key: char);
begin
  Key := #0;
end;

procedure TfrmProjectProperties.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(PageControl.ActivePage.HelpContext, Application.HelpFile);
end;

procedure TfrmProjectProperties.btBrowseExtApp1Click(Sender: TObject);
begin
  Self.Enabled := False;
  try
    if TComponent(Sender).Tag = 0 then
      odExtExecutable.FileName := edExtApp1.Text
    else
      odExtExecutable.FileName := edExtApp2.Text;
    if not FileExists(odExtExecutable.FileName) then
      odExtExecutable.FileName := EmptyStr;
    if not odExtExecutable.Execute then
      Exit;
    if TComponent(Sender).Tag = 0 then
      edExtApp1.Text := odExtExecutable.FileName
    else
      edExtApp2.Text := odExtExecutable.FileName;
  finally
    Self.Enabled := True;
  end;
end;

procedure TfrmProjectProperties.btnAddVolumeClick(Sender: TObject);
var
  NewProject: TNSProject;
  Item: TListItem;
begin
  NewProject := FProject.AddVolume;
  if EditMediaSettingsDlg(NewProject) then
  begin
    Item := lvVolumes.Items.Add;
    Item.Data := NewProject;
    UpdateListItem(Item);
  end
  else
  begin
    NewProject.Free;
  end;
end;

procedure TfrmProjectProperties.btnEditClick(Sender: TObject);
var
  Project: TNSProject;
begin
  if (lvVolumes.Selected = nil) or (lvVolumes.Selected.Data = nil) then
    Exit;
  Project := TNSProject(lvVolumes.Selected.Data);
  if EditMediaSettingsDlg(Project, True) then
    UpdateListItem(lvVolumes.Selected);
end;

procedure TfrmProjectProperties.btnDeleteClick(Sender: TObject);
var
  Item: TListItem;
  Project: TNSProject;
begin
  Item := lvVolumes.Selected;
  if (Item = nil) or (Item.Data = nil) or (Item.Index = 0) then
    Exit;
  Project := TNSProject(Item.Data);
  if MessageDlg(Format(sConfirmDeleteVolume, [Project.GetVolumeString]),
    mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    Project.Free;
    FillVolumes;
  end;
  //  lvVolumes.Items.Delete(Item.Index);
end;

procedure TfrmProjectProperties.lvVolumesDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TfrmProjectProperties.chkWriteLogClick(Sender: TObject);
begin
  if chkWriteLog.Checked then
  begin
    lblSendMail.Enabled := True;
    cbSendMail.Enabled  := True;
    lblSendMailContent.Enabled := True;
    cbSendMailContent.Enabled := True;
  end
  else
  begin
    lblSendMail.Enabled := False;
    cbSendMail.Enabled  := False;
    lblSendMailContent.Enabled := False;
    cbSendMailContent.Enabled := False;
  end;
end;

procedure TfrmProjectProperties.btnEditIncludedClick(Sender: TObject);
var
  S: string;
begin
  S := edtInclude.Text;
  if EditMasksDlg(lblIncluded.Caption, S) then
    edtInclude.Text := S;
end;

procedure TfrmProjectProperties.btnEditExcludedClick(Sender: TObject);
var
  S: string;
begin
  S := edtExclude.Text;
  if EditMasksDlg(lblExcluded.Caption, S) then
    edtExclude.Text := S;
end;

procedure TfrmProjectProperties.cbFileFormatChange(Sender: TObject);
begin
  lblEncType.Enabled  := cbFileFormat.ItemIndex = 0;
  lblEncryption.Enabled := cbFileFormat.ItemIndex = 0;
  btnSecurity.Enabled := cbFileFormat.ItemIndex = 0;
  lblComression.Enabled := cbFileFormat.ItemIndex = 0;
  cbCompression.Enabled := cbFileFormat.ItemIndex = 0;
end;

procedure TfrmProjectProperties.cbDefActionChange(Sender: TObject);
begin
  if cbFileFormat.ItemIndex = 1 then // As Is
    if cbDefAction.ItemIndex = 2 then
      cbDefAction.ItemIndex := 1;
end;

end.
