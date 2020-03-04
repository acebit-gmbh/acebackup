unit abWizardFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, winftp,
  Dialogs, abWizardTemplate, nsTypes, nsGlobals, ExtCtrls, ComCtrls, StdCtrls,
  tsTaskman, tsSettings, Spin, WinInet, System.UITypes;

type
  TfrmNewProjectWizard = class(TfrmWizardTemplate)
    ts3: TTabSheet;
    Panel1: TPanel;
    ts1: TTabSheet;
    Panel3: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    ts2: TTabSheet;
    Panel5: TPanel;
    ts5: TTabSheet;
    Panel6: TPanel;
    ts4: TTabSheet;
    Panel7: TPanel;
    odExternalApp: TOpenDialog;
    Label2: TLabel;
    Label28: TLabel;
    edtTitle: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    grpSecurity: TGroupBox;
    Label4: TLabel;
    lblPassword: TLabel;
    cbEncryption: TComboBox;
    edtPassword: TEdit;
    chkMask1: TCheckBox;
    chkStoreArchivePwd: TCheckBox;
    chkAutoMangle: TCheckBox;
    Label24: TLabel;
    lvVolumes: TListView;
    cbSyncMode: TComboBox;
    btnAddVolume: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    Label22: TLabel;
    cbFileFormat: TComboBox;
    Label23: TLabel;
    rbCompression: TComboBox;
    cbDefAction: TComboBox;
    grpLog: TGroupBox;
    lblSendMail: TLabel;
    lblSendMailContent: TLabel;
    chkWriteLog: TCheckBox;
    cbSendMail: TComboBox;
    cbSendMailContent: TComboBox;
    Label1: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    lblIncluded: TLabel;
    edtInclude: TEdit;
    lblExcluded: TLabel;
    edtExclude: TEdit;
    btnEditIncluded: TButton;
    btnEditExcluded: TButton;
    Bevel9: TBevel;
    btnEditSchedule: TButton;
    Label21: TLabel;
    edExecApp1: TEdit;
    ckbWaitApp1: TCheckBox;
    Label15: TLabel;
    seTimeOutBefore: TSpinEdit;
    btBrowseApp1: TButton;
    Label32: TLabel;
    edExecApp2: TEdit;
    ckbWaitApp2: TCheckBox;
    Label20: TLabel;
    seTimeOutAfter: TSpinEdit;
    Label27: TLabel;
    Label19: TLabel;
    btBrowseApp2: TButton;
    memSettings: TRichEdit;
    Label3: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    lblSchedule: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnEditIncludedClick(Sender: TObject);
    procedure btnEditExcludedClick(Sender: TObject);
    procedure cbEncryptionChange(Sender: TObject);
    procedure chkMask1Click(Sender: TObject);
    procedure btnEditScheduleClick(Sender: TObject);
    procedure btBrowseApp1Click(Sender: TObject);
    procedure btnAddVolumeClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure chkWriteLogClick(Sender: TObject);
    procedure cbFileFormatChange(Sender: TObject);
    procedure cbDefActionSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvVolumesDblClick(Sender: TObject);
  private
    { Private declarations }
    FProject: TNSProject;
    FTask: TTaskItem;
    FPasswordSet: Boolean;
    TaskDialog: TfrmTaskSettings;
    procedure TaskDialogApply(Sender: TObject; const ATask: TTaskItem);
    procedure UpdateTask;
    procedure CheckTaskPassword;
    function CreateTask: Boolean;

    procedure GetSettings(const AProject: TNSProject);
    procedure SetSettings(const AProject: TNSProject);

    procedure FillMemo;
    procedure FillVolumes;
    procedure UpdateListItem(const AItem: TListItem);
    function VerifyArchive(const AProject: TNSProject): Boolean;
    function VerifyArchives: Boolean;

    function CheckArchive(const AProject: TNSProject): Boolean;
    function CheckArchives: Boolean;

    function GetUniqueProjName: string;

  protected
    procedure UpdateActions; override;
    function GoForward: integer; override;
    function GoBack: integer; override;
  public
    { Public declarations }
  end;

var
  frmNewProjectWizard: TfrmNewProjectWizard;

function CreateNewProjectWizard(out AProject: TNSProject): Boolean;

implementation

uses
  abMasksDlg, nsMediaSettings, nsProcessFrm, nsMainFrm, nsUtils, nsTaskPassword, _balloonform, cdWrapper;

{$R *.dfm}

function CreateNewProjectWizard(out AProject: TNSProject): Boolean;
begin
  with TfrmNewProjectWizard.Create(Application) do
    try
      AProject := TNSProject.Create(frmProcess);

      FProject := AProject;
      FProject.SetDefaultValues;
      GetSettings(AProject);
      Result := ShowModal = mrOk;
      if Result then
      begin
        SetSettings(AProject);
      end
      else
      begin
        FreeAndNil(AProject);
      end;
    finally
      Free;
    end;
end;

{ TNewProjectWizard }

function TfrmNewProjectWizard.GoBack: integer;
begin
  Result := inherited GoBack;
  UpdateActions;
end;

function TfrmNewProjectWizard.GoForward: integer;
var
  c: char;
begin
  Result := 0;
  if PageControl.ActivePage = ts1 then
  begin
    FillVolumes;
    for c := Low(char) to High(char) do
    begin
      if CharInSet(c, IllegalSymbols) and (Pos(c, edtTitle.Text) > 0) then
      begin
        MessageBox(
          Handle,
          PChar(sIllegalSymbols),
          PChar(sError),
          $00000010
          );
        edtTitle.SetFocus;
        Exit;
      end;
    end;

    if (FTask <> nil) and not FTask.HasSameName(edtTitle.Text) then
      try
        CreateTask;
        if FTask <> nil then
          UpdateTask;
      except
        Exit;
      end;
    if not CheckArchives then
      Exit;
      
    Result := 1;
  end
  else if PageControl.ActivePage = ts3 then
  begin
    Result := 1;
  end
  else if PageControl.ActivePage = ts4 then
  begin
    FillMemo;
    Result := 1;
  end
  else if PageControl.ActivePage = ts5 then
  begin
    Screen.Cursor := crHourGlass;
    try
      FWizardReady := VerifyArchives;
    finally
      Screen.Cursor := crDefault;
    end;
  end
  else
    Result := inherited GoForward;
  UpdateActions;
end;

procedure TfrmNewProjectWizard.lvVolumesDblClick(Sender: TObject);
begin
  UpdateActions;
  if btnEdit.Enabled then
    btnEdit.Click;
end;

procedure TfrmNewProjectWizard.UpdateActions;
var
  I: integer;
  NextEnabled: Boolean;
begin
  inherited UpdateActions;
  if PageControl.ActivePage = ts1 then
  begin
    btnEdit.Enabled := lvVolumes.Selected <> nil;
    btnDelete.Enabled := (lvVolumes.Selected <> nil) and (lvVolumes.Selected.Index > 0);
    NextEnabled := True;
    for I := lvVolumes.Items.Count - 1 downto 0 do
      NextEnabled := NextEnabled and (Trim(lvVolumes.Items[I].SubItems[1]) <> EmptyStr);
    btnNext.Enabled := NextEnabled and (edtTitle.Text <> EmptyStr);
    cbSyncMode.Enabled := lvVolumes.Items.Count > 1;
  end
  else if PageControl.ActivePage = ts2 then
  begin
    btnNext.Enabled := ((cbEncryption.ItemIndex = 0) or ((cbEncryption.ItemIndex <> 0) and
      (edtPassword.Text <> EmptyStr)));
  end
  else if PageControl.ActivePage = ts4 then
  begin
    seTimeOutBefore.Enabled := ckbWaitApp1.Checked;
    seTimeOutAfter.Enabled  := ckbWaitApp2.Checked;
  end;
end;

procedure TfrmNewProjectWizard.FormCreate(Sender: TObject);
begin
  inherited;
  if frmMain.TaskManager.Active then
  begin
    frmMain.TaskManager.Refresh;
    TaskDialog := TfrmTaskSettings.Create(Self);
    TaskDialog.TaskScheduler := frmMain.TaskManager;
    TaskDialog.OnApplySettings := TaskDialogApply;
  end;
end;

procedure TfrmNewProjectWizard.FormShow(Sender: TObject);
begin
  inherited;
  if lvVolumes.CanFocus then
    lvVolumes.SetFocus;
  lvVolumes.Invalidate;
end;

procedure TfrmNewProjectWizard.GetSettings(const AProject: TNSProject);
var
  Method: TEncryptionMethod;
  sm: TSyncMode;
  da: TDefaultAction;
begin
  for Method := Low(TEncryptionMethod) to High(TEncryptionMethod) do
    cbEncryption.Items.Add(Encryptions[Method]^);
  cbEncryption.ItemIndex := Ord(AProject.EncryptionMethod);
  cbEncryption.OnChange(Self);

  for da := Low(TDefaultAction) to High(TDefaultAction) do
    cbDefAction.Items.Add(ActionNames[da]^);
  cbDefAction.ItemIndex := Ord(AProject.DefaultAction);

  edtInclude.Text := AProject.IncMasks.GetMask;
  edtExclude.Text := AProject.ExcMasks.GetMask;

  for sm := Low(TSyncMode) to High(TSyncMode) do
    cbSyncMode.Items.Add(SyncModeNames[sm]^);
  cbSyncMode.ItemIndex := 0;

  edExecApp1.Text := g_LastExe1;
  edExecApp2.Text := g_LastExe2;
  ckbWaitApp1.Checked := g_WaitExe1;
  ckbWaitApp2.Checked := g_WaitExe2;

  FillVolumes;
  if Trim(edtTitle.Text) = EmptyStr then
    edtTitle.Text := GetUniqueProjName;
end;

procedure TfrmNewProjectWizard.SetSettings(const AProject: TNSProject);
begin
  AProject.Kind := pkBackup;

  AProject.DisplayName := edtTitle.Text;
  AProject.FileName := EmptyStr;
  AProject.WasModified := True;
  AProject.EncryptionMethod := TEncryptionMethod(cbEncryption.ItemIndex);
  if cbEncryption.ItemIndex <> 0 then
  begin
    AProject.ProjPwd := edtPassword.Text;
    AProject.StoreArchivePwd := chkStoreArchivePwd.Checked;
  end;

  AProject.DefaultAction := TDefaultAction(cbDefAction.ItemIndex);
  AProject.IncMasks.SetMask(edtInclude.Text);
  AProject.IncMasks := AProject.IncMasks;
  AProject.ExcMasks.SetMask(edtExclude.Text);
  AProject.ExcMasks := AProject.ExcMasks;
  AProject.CompressionLevel := rbCompression.ItemIndex;

  AProject.AutoMangle := chkAutoMangle.Checked;
  if lvVolumes.Items.Count > 1 then
    AProject.SyncMode := TSyncMode(cbSyncMode.ItemIndex)
  else
    AProject.SyncMode := smIndependent;

  g_LastMedia := Ord(AProject.BackupMedia);

  //  g_LastKind := pkBackup;
  if (FTask <> nil) and (FTask.Triggers.Count > 0) then
  begin
      FTask.AppName := Application.ExeName;
      FTask.WorkDir := g_ProjectsDir;
      FTask.Creator := Application.Title;
      FTask.Arguments := sUpdate + #34 + AProject.FileName + #34;
      FTask.Flags := FTask.Flags - [tfEnabled];
      FTask.SaveTask;
  end else
  if FTask <> nil then
    frmMain.TaskManager.DeleteTask(FTask.TaskName);

  AProject.ExtAppBefore := edExecApp1.Text;
  AProject.WaitForExtAppBefore := ckbWaitApp1.Checked;
  AProject.ExtAppAfter  := edExecApp2.Text;
  AProject.WaitForExtAppAfter := ckbWaitApp2.Checked;
  AProject.TimeOutBefore := seTimeOutBefore.Value;
  AProject.TimeOutAfter := seTimeOutAfter.Value;

  g_LastExe1 := edExecApp1.Text;
  g_WaitExe1 := ckbWaitApp1.Checked;
  g_LastExe2 := edExecApp2.Text;
  g_WaitExe2 := ckbWaitApp2.Checked;

  AProject.SendLog := TSendMail(cbSendMail.ItemIndex);
  AProject.SendMailContect := TSendMailContent(cbSendMailContent.ItemIndex);
  AProject.FileFormat := TFileFormat(cbFileFormat.ItemIndex);

end;

procedure TfrmNewProjectWizard.btnEditIncludedClick(Sender: TObject);
var
  S: string;
begin
  S := edtInclude.Text;
  if EditMasksDlg(lblIncluded.Caption, S) then
    edtInclude.Text := S;
end;

procedure TfrmNewProjectWizard.btnEditExcludedClick(Sender: TObject);
var
  S: string;
begin
  S := edtExclude.Text;
  if EditMasksDlg(lblExcluded.Caption, S) then
    edtExclude.Text := S;
end;

function TfrmNewProjectWizard.CheckArchive(const AProject: TNSProject): Boolean;
var
  RemoteFolder: string;
begin
  case AProject.BackupMedia of
    bmLocal:
    begin
      RemoteFolder := AProject.LocalFolder;
      Result := DirectoryExists(RemoteFolder);
      if not Result then
        Result := MessageBox(Handle, PChar(Format(sCannotFindDir + #13#10 + sConfirmContinue, [RemoteFolder])), PChar(AProject.GetVolumeString(True)), $00000034) = idYes;
    end;
    bmFTP:
      begin
        Result := (AProject.UserName <> EmptyStr) and (AProject.Password <> EmptyStr);
        if not Result then
          Result := MessageBox(Handle, PChar(sUserOrPassIsEmpty + #13#10 + sConfirmContinue), PChar(AProject.GetVolumeString(True)), $00000034) = idYes;
      end;
    bmCD:
    begin
      Result := AProject.InitCDDrive;
      if not Result then
        Result := MessageBox(Handle, PChar(SCDNotAvailable + #13#10 + sConfirmContinue), PChar(AProject.GetVolumeString(True)), $00000034) = idYes;
    end;
    bmNAS:
    begin
       Result := DirectoryExists(AProject.NetPath);
       if not Result then
       begin
         Result := (AProject.NetPass <> EmptyStr) and (AProject.NetUser <> EmptyStr);
         if not Result then
            Result := MessageBox(Handle, PChar(sUserOrPassIsEmpty + #13#10 + sConfirmContinue), PChar(AProject.GetVolumeString(True)), $00000034) = idYes;
       end;
    end;
    else
      Result := False;
  end;
end;

function TfrmNewProjectWizard.CheckArchives: Boolean;
var
  Profile: TNSProject;
  tmpRslt: Boolean;
  Index: integer;
begin
  Result := True;
  for Index := 0 to FProject.VolumeCount - 1 do
  begin
    Profile := FProject.Volumes[Index];
    tmpRslt := CheckArchive(Profile);
    Result  := Result and tmpRslt;
    if not Result then Exit;
  end;
end;

procedure TfrmNewProjectWizard.CheckTaskPassword;
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

function TfrmNewProjectWizard.CreateTask: Boolean;
begin
  if not frmMain.TaskManager.Active then
  begin
    Result := False;
    Exit;
  end;
  FTask := nil;
  if frmMain.TaskManager.ActivateTask(edtTitle.Text) <> nil then
  begin
    MessageBox(
      Handle,
      PChar(sAnotherTaskRunning),
      PChar(sErrorNewTask),
      $00000030);
    FTask := nil;
  end
  else
    try
      FTask := frmMain.TaskManager.CreateTask(edtTitle.Text);
      FTask.AppName := Application.ExeName;
    except
      MessageBox(
        Handle,
        PChar(sAnotherTaskRunning),
        PChar(sErrorNewTask),
        $00000030);
      FTask := nil;
    end;
  Result := FTask <> nil;
end;

procedure TfrmNewProjectWizard.TaskDialogApply(Sender: TObject; const ATask: TTaskItem);
begin
  try
    if ATask.Triggers.Count > 0 then
      lblSchedule.Caption := ATask.TriggerText
    else
      lblSchedule.Caption := sTaskIsNotScheduled;
  except
    on E: Exception do
      lblSchedule.Caption := E.Message;
  end;
end;

procedure TfrmNewProjectWizard.UpdateTask;
begin
  try
    if FTask.Triggers.Count > 0 then
      lblSchedule.Caption := FTask.TriggerText
    else
      lblSchedule.Caption := sTaskIsNotScheduled;
  except
    on E: Exception do
      lblSchedule.Caption := E.Message;
  end;
end;

procedure TfrmNewProjectWizard.cbEncryptionChange(Sender: TObject);
begin
  lblPassword.Enabled := cbEncryption.ItemIndex <> 0;
  edtPassword.Enabled := lblPassword.Enabled;
  //  edVerifyPW.Enabled := lblPassword.Enabled;
  //  lblVerifyPW.Enabled := lblPassword.Enabled;
  chkMask1.Enabled := lblPassword.Enabled;
  chkStoreArchivePwd.Enabled := lblPassword.Enabled;
end;

procedure TfrmNewProjectWizard.chkMask1Click(Sender: TObject);
begin
  if chkMask1.Checked then
    edtPassword.PasswordChar := #42
  else
    edtPassword.PasswordChar := #0;
end;

procedure TfrmNewProjectWizard.btnEditScheduleClick(Sender: TObject);
begin
  UpdateActions;
  if FTask = nil then
    CreateTask;
  if FTask = nil then
    Exit;
  TaskDialog.TaskItem := FTask;
  if TaskDialog.Execute then
  begin
    UpdateTask;
    CheckTaskPassword;
  end;
  UpdateActions;
end;

procedure TfrmNewProjectWizard.btBrowseApp1Click(Sender: TObject);
begin
  UpdateActions;
  if TComponent(Sender).Tag = 0 then
    odExternalApp.FileName := edExecApp1.Text
  else
    odExternalApp.FileName := edExecApp2.Text;
  if not FileExists(odExternalApp.FileName) then
    odExternalApp.FileName := EmptyStr;
  if not odExternalApp.Execute then
    Exit;
  if TComponent(Sender).Tag = 0 then
    edExecApp1.Text := odExternalApp.FileName
  else
    edExecApp2.Text := odExternalApp.FileName;
  UpdateActions;
end;

procedure TfrmNewProjectWizard.btnAddVolumeClick(Sender: TObject);
var
  NewProject: TNSProject;
  Item: TListItem;
begin
  UpdateActions;
  NewProject := FProject.AddVolume;
  NewProject.SetDefaultValues;
  if EditMediaSettingsDlg(NewProject) then
    try
      lvVolumes.Items.BeginUpdate;
      Item := lvVolumes.Items.Add;
      Item.Data := NewProject;
      UpdateListItem(Item);
    finally
      lvVolumes.Items.EndUpdate;
    end
  else
  begin
    NewProject.Free;
  end;
  UpdateActions;
end;

procedure TfrmNewProjectWizard.btnEditClick(Sender: TObject);
var
  Project: TNSProject;
  Item: TListItem;
begin
  UpdateActions;
  Item := lvVolumes.Selected;
  if (Item = nil) or (Item.Data = nil) then
    Exit;
  Project := TNSProject(Item.Data);
  if EditMediaSettingsDlg(Project) then
    UpdateListItem(Item);
  UpdateActions;
end;

procedure TfrmNewProjectWizard.btnDeleteClick(Sender: TObject);
var
  Item: TListItem;
  Project: TNSProject;
begin
  UpdateActions;
  Item := lvVolumes.Selected;
  if (Item = nil) or (Item.Data = nil) or (Item.Index = 0) then
    Exit;
  Project := TNSProject(Item.Data);
  Project.Free;
  FillVolumes;
  UpdateActions;
end;

procedure TfrmNewProjectWizard.FillMemo;
const
  sFormatStr = #13#10#9 + '%s' + #13#10;
var
  S: string;
  Index: integer;
  Volume: TNSProject;
begin
  with memSettings do
  begin
    Lines.Clear;
    Lines.Add(Format(sProjectTitle + sFormatStr, [edtTitle.Text]));
    Lines.Add(Format(sEncryption + sFormatStr, [Encryptions[TEncryptionMethod(cbEncryption.ItemIndex)]^]));
    if cbEncryption.ItemIndex <> 0 then
      Lines.Add(Format(sStorePasswort + sFormatStr, [YesNoNames[chkStoreArchivePwd.Checked]^]));
    Lines.Add(sMediaSettings + sColon);
    for Index := 0 to FProject.VolumeCount - 1 do
    begin
      Volume := FProject.Volumes[Index];
      Lines.Add(#9 + Volume.GetVolumeString(True));
    end;
    Lines.Add(EmptyStr);
    if edExecApp1.Text <> EmptyStr then
    begin
      if ckbWaitApp1.Checked then
        S := sExecuteBeforeProcessAndWait
      else
        S := sExecuteBeforeProcessDontWait;
      Lines.Add(Format(S, [edExecApp1.Text]));
    end;
    if edExecApp2.Text <> EmptyStr then
    begin
      if ckbWaitApp2.Checked then
        S := sExecuteAfterProcessAndWait
      else
        S := sExecuteAfterProcessDontWait;
      Lines.Add(Format(S, [edExecApp2.Text]));
    end;
    SelLength := 0;
    SelStart  := 0;
  end;
end;

procedure TfrmNewProjectWizard.FillVolumes;
var
  Project: TNSProject;
  Index: integer;
  Item:  TListItem;
begin
  lvVolumes.Items.Clear;
  try
    lvVolumes.Items.BeginUpdate;
    for Index := 0 to FProject.VolumeCount - 1 do
    begin
      Project := FProject.Volumes[Index];
      Item := lvVolumes.Items.Add;
      Item.Data := Project;
      UpdateListItem(Item);
    end;
  finally
    lvVolumes.Items.EndUpdate;
    UpdateActions;
  end;
end;

procedure TfrmNewProjectWizard.UpdateListItem(const AItem: TListItem);
var
  Project: TNSProject;
begin
  Project := TNSProject(AItem.Data);
  AItem.Caption := Format(sVolume, [Project.VolumeIndex]);
  AItem.SubItems.Text := #13#10#13#10;
  AItem.SubItems[0] := BackupMediaNames[Project.BackupMedia]^;
  AItem.SubItems[1] := Project.GetVolumeString(False);
end;

function TfrmNewProjectWizard.VerifyArchive(const AProject: TNSProject): Boolean;
var
  RemoteFolder: string;
  RemoteFileName: string;
  dwError: DWORD;
  NASConnection: string;
begin
  Result := False;
  case AProject.BackupMedia of
    bmLocal:
    begin
      RemoteFolder := AProject.LocalFolder;
      Result := DirectoryExists(RemoteFolder) or AProject.IsCDMedia;
      if not Result then
      begin
        if MessageBox(Handle, PChar(Format(sCreateDirConfirm, [RemoteFolder])),
          PChar(AProject.GetVolumeString(True)), $00000034) = idYes then
        begin
          Result := ForceDirectories(RemoteFolder);
          if not Result then
          begin
            MessageBox(
              Handle,
              PChar(Format(sCannotCreateDir, [RemoteFolder])),
              PChar(AProject.GetVolumeString(True)),
              $00000030);
            Exit;
          end;
        end
        else
        begin
          Result := False;
          Exit;
        end;
      end;
      RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + edtTitle.Text;
      Result := ForceDirectories(RemoteFolder) or AProject.IsCDMedia;
      if not Result then
      begin
        MessageBox(
          Handle,
          PChar(Format(sCannotCreateDir, [RemoteFolder])),
          PChar(AProject.GetVolumeString(True)),
          $00000030);
        Exit;
      end;
      GetTempFileName(PChar(RemoteFolder), sINS, 0, @lpBuffer);
      dwError := GetLastError;
      Result  := (dwError = S_OK) or AProject.IsCDMedia;
      if not Result then
      begin
        MessageBox(
          Handle,
          PChar(Format(sCannotWriteToDir, [RemoteFolder])),
          PChar(AProject.GetVolumeString(True)),
          $00000030);
        Exit;
      end;
      if not AProject.IsCDMedia then
        Windows.DeleteFile(PChar(@lpBuffer));
      RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
      Result := ForceDirectories(RemoteFolder) or AProject.IsCDMedia;
      if not Result then
      begin
        MessageBox(
          Handle,
          PChar(Format(sCannotCreateDir, [RemoteFolder])),
          PChar(AProject.GetVolumeString(True)),
          $00000030);
        Exit;
      end;
    end;
    bmFTP:
      try

        if (AProject.DialupConnection <> EmptyStr) then
          Result := InternetAutodial(INTERNET_AUTODIAL_FORCE_UNATTENDED, Application.MainFormHandle);

        Result := InitializeFTPSession(g_ConnectType, AProject.HostName, AProject.UserName,
          AProject.Password, AProject.Port, g_ProxyName, g_ProxyPort, EmptyStr, EmptyStr, AProject.Passive) = 0;

        if not Result then
        begin
          MessageBox(
            Handle,
            GetLastFTPResponse,
            PChar(AProject.GetVolumeString(True)),
            $00000030);
          Exit;
        end;
        RemoteFolder := AProject.HostDirName;
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          if MessageBox(Handle, PChar(Format(sCreateDirConfirm, [RemoteFolder])),
            PChar(AProject.GetVolumeString(True)), $00000034) = idYes then
          begin
            CreateFTPFolder(PChar(RemoteFolder));
            Result := FTPDirectoryExists(PChar(RemoteFolder));
            if not Result then
            begin
              MessageBox(
                Handle,
                PChar(Format(sCannotCreateDir, [RemoteFolder]) + Format(sResponse,
                [StrPas(GetLastFTPResponse)])),
                PChar(AProject.GetVolumeString(True)),
                $00000030);
              Exit;
            end;
          end
          else
          begin
            Result := False;
            Exit;
          end;
        end;

        RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + edtTitle.Text;
        CreateFTPFolder(PChar(RemoteFolder));

        GetTempFileName(PChar(g_TempDir), sINS, 723, @lpBuffer);
        RemoteFileName := IncludeTrailingPathDelimiter(RemoteFolder) + ExtractFileName(String(@lpBuffer));

        Result := TestWriteToFTP(PChar(RemoteFileName));

        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotWriteToDir, [RemoteFolder]) + Format(sResponse,
            [StrPas(GetLastFTPResponse)])),
            PChar(AProject.GetVolumeString(True)),
            $00000030);
          Exit;
        end;
        RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
        CreateFTPFolder(PChar(RemoteFolder));
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotCreateDir, [RemoteFolder]) + Format(sResponse,
            [StrPas(GetLastFTPResponse)])),
            PChar(AProject.GetVolumeString(True)),
            $00000030);
          Exit;
        end;
      finally
        FinalizeFTPSession;
      end;
    bmCD:
    begin
      Result := AProject.InitCDDrive;
      if not Result then
      begin
        MessageBox(
          Handle,
          PChar(SCDNotAvailable),
          PChar(sError),
          $00000030);
        Exit;
      end;
      Result := DiskWriter.IsWriteableMedia;

      if not Result then
      begin
        MessageBox(
          Handle,
          PChar(SCDNotWriteable),
          PChar(sError),
          $00000030);
        Exit;
      end;

      if DiskWriter.CanSimulateWrite then
      begin
        try
          if MessageDlg(Format(STestWrite, [AProject.CDDrivePath]), mtCustom, [mbOK, mbCancel], 0) <> mrOk then
            Exit;
          DiskWriter.Simulate := True;
          Result := DiskWriter.CheckDeviceReady;
          if not Result then
          begin
            MessageBox(Handle,
              PChar(SCDNotAvailable),
              PChar(sError),
              $00000030);
            Exit;
          end;
          DiskWriter.DiscInformation;
          Result := DiskWriter.IsValidMedia;
          if not Result then
          begin
            MessageBox(Handle,
              PChar(SInvalidCD),
              PChar(sError),
              $00000030);
            Exit;
          end;
          Result := DiskWriter.IsFreeSpaceAvail;
          if not Result then
          begin
            MessageBox(Handle,
              PChar(SDiskClosed),
              PChar(sError),
              $00000030);
            Exit;
          end;

          RemoteFolder := edtTitle.Text;
          DiskWriter.BurnerWriteDone := False;
{$IFDEF USE_MCDB}
          DiskWriter.GetClass.Initialize;
          DiskWriter.GetClass.CreateDir(RemoteFolder);
          DiskWriter.GetClass.SessionToImport := -1;
{$ENDIF}
          Result := DiskWriter.RecordDisk(True, False, False);
          if not Result then
            Exit;
          repeat
            Application.ProcessMessages;
          until DiskWriter.BurnerWriteDone;
        finally
          DiskWriter.Simulate := False;
        end;
      end;
    end;
    bmNAS:
    begin
      RemoteFolder := AProject.NetPath;

      Result := ConnectToNAS(Handle, RemoteFolder, AProject.NetUser, AProject.NetPass, NASConnection);
      if Result then
        try
          Result := DirectoryExists(NASConnection);
          if not Result then
          begin
            MessageBox(Handle, PChar(Format(sCannotFindDir, [RemoteFolder])), PChar(sError), $00000030);
            Exit;
          end;
          RemoteFolder := IncludeTrailingPathDelimiter(NASConnection) + edtTitle.Text;
          Result := DirectoryExists(RemoteFolder);

          if not Result then
          begin
            if MessageBox(Handle, PChar(Format(sCreateDirConfirm, [RemoteFolder])),
              PChar(AProject.GetVolumeString(True)), $00000034) = idYes then
            begin
              Result := ForceDirectories(RemoteFolder);
              if not Result then
              begin
                MessageBox(
                  Handle,
                  PChar(Format(sCannotCreateDir, [RemoteFolder])),
                  PChar(AProject.GetVolumeString(True)),
                  $00000030);
                Exit;
              end;
            end
            else
            begin
              Result := False;
              Exit;
            end;
          end;

          GetTempFileName(PChar(RemoteFolder), sINS, 0, @lpBuffer);
          dwError := GetLastError;
          Result  := (dwError = S_OK);
          if not Result then
          begin
            MessageBox(
              Handle,
              PChar(Format(sCannotWriteToDir, [RemoteFolder])),
              PChar(AProject.GetVolumeString(True)),
              $00000030);
            Exit;
          end;
          Windows.DeleteFile(PChar(@lpBuffer));
          RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
          Result := ForceDirectories(RemoteFolder);
          if not Result then
          begin
            MessageBox(
              Handle,
              PChar(Format(sCannotCreateDir, [RemoteFolder])),
              PChar(AProject.GetVolumeString(True)),
              $00000030);
            Exit;
          end;
        finally
          DisconnectNAS(NASConnection);
        end;
    end;

  end;
end;

function TfrmNewProjectWizard.VerifyArchives: Boolean;
var
  Profile: TNSProject;
  tmpRslt: Boolean;
  Index: integer;
begin
  Result := True;
  for Index := 0 to FProject.VolumeCount - 1 do
  begin
    Profile := FProject.Volumes[Index];
    tmpRslt := VerifyArchive(Profile);
    Result  := Result and tmpRslt;
    if not Result then
      Exit;
  end;
end;

procedure TfrmNewProjectWizard.chkWriteLogClick(Sender: TObject);
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

var
  BalloonShown: Boolean = False;

procedure TfrmNewProjectWizard.cbFileFormatChange(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to grpSecurity.ControlCount - 1 do
    grpSecurity.Controls[I].Enabled := cbFileFormat.ItemIndex = 0;
  rbCompression.Enabled := cbFileFormat.ItemIndex = 0;
  if (cbFileFormat.ItemIndex = 1) and not BalloonShown then
  begin
    CreateBalloon(ii_Warning, sWarningBIG, sFileFormatASIS, cbFileFormat, nil,
      0, False, 0, 0, False, EmptyStr, EmptyStr);
    BalloonShown := True;
  end;
end;

procedure TfrmNewProjectWizard.cbDefActionSelect(Sender: TObject);
begin
  if cbFileFormat.ItemIndex = 1 then // As Is
    if cbDefAction.ItemIndex = 2 then
      cbDefAction.ItemIndex := 1;
end;

function TfrmNewProjectWizard.GetUniqueProjName: string;
var
  N:  integer;
  SE: string;
begin
  SE := sNsb;
  N  := 1;
  repeat
    Result := Format(PROJECT_SUFFIX, [N]);
    Inc(N);
  until not FileExists(IncludeTrailingPathDelimiter(g_ProjectsDir) + Result + SE);
end;

end.
