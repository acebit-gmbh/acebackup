unit nsAddToFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, nsGlobals, nsTypes, Registry,
  tsTaskman, ExtCtrls, CommCtrl, ShlObj, ShellApi, ActiveX;

type
  TfrmAddToForm = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    btnOpen: TButton;
    btnNew: TButton;
    btnSettings: TButton;
    cbProject: TComboBox;
    lblVolume: TLabel;
    lblEncryption: TLabel;
    lblSchedule: TLabel;
    lblError: TLabel;
    lblCompression: TLabel;
    OpenDialog: TOpenDialog;
    chkProcessNow: TCheckBox;
    cbVolumes: TComboBox;
    Bevel1: TBevel;
    Panel1: TPanel;
    Image1: TImage;
    lblFileName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbProjectChange(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure cbVolumesChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FProject: TNSProject;
    FFileObject: string;
    FTask: TTaskItem;
    procedure GetTaskInfo;
    procedure CloseProject(const ASaveChanges: Boolean);
    procedure OpenProject(const AFileName: string);
    procedure UpdateProjectInfo;
    procedure LoadFileOrFolder(const AFileName: string);
  protected
    FPath: string;
    procedure UpdateActions; override;
    procedure GetSettings;
    procedure SetSettings;
  public
    { Public declarations }
  end;

function AddFilesToDlg(const AFileObject: string): Boolean;

implementation

uses
  nsMainFrm, abWizardFrm, nsProjectFrm, nsScheduledThread, nsActions;

{$R *.dfm}

var
  SortOrder: integer = 1;

function AddFilesToDlg(const AFileObject: string): Boolean;
begin
  //  messageBox(GetActiveWindow, PChar(AFileObject), nil, 0);
  with TfrmAddToForm.Create(Application) do
    try
      GetSettings;
      LoadFileOrFolder(AFileObject);
      Result := ShowModal = mrOk;
      //      Windows.DeleteFile(PChar(AFileObject));
      if Result then
        SetSettings
      else
        PostMessage(frmMain.Handle, WM_CLOSE, 0, 0);
    finally
      Free;
    end;
end;

procedure TfrmAddToForm.CloseProject(const ASaveChanges: Boolean);
begin
  if FProject = nil then
    Exit;
  if FProject = CurProject then
  begin
    if ASaveChanges then
      FProject.SaveToFile(True);
    FProject := nil;
  end
  else
  begin
    if ASaveChanges then
      FProject.SaveToFile(True);
    FreeAndNil(FProject);
  end;
end;

procedure TfrmAddToForm.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  with TRegIniFile.Create(REG_FORMS) do
    try
      cbProject.Items.Text := ReadString(REG_MAIN, REG_VAL_MRU, EmptyStr);
    finally
      Free;
    end;
  lblSchedule.Caption := EmptyStr;
  if CurProject <> nil then
  begin
    cbProject.ItemIndex := cbProject.Items.IndexOf(CurProject.FileName);
  end
  else
  begin
    if cbProject.Items.Count > 0 then
      cbProject.ItemIndex := 0;
  end;
  cbProjectChange(Self);
end;

procedure TfrmAddToForm.OpenProject(const AFileName: string);
begin
  if (CurProject <> nil) and AnsiSameText(CurProject.FileName, AFileName) then
    FProject := CurProject
  else
  begin
    if AFileName = EmptyStr then
      lblError.Caption := sNoProjectFile
    else if not FileExists(AFileName) then
      lblError.Caption := Format(sProjectFileDontExists, [AFileName])
    else
    begin
      FProject := TNSProject.Create(nil);
      if not FProject.LoadFromFile(AFileName) then
      begin
        lblError.Caption := Format(sCannotOpenProject, [AFileName]);
        FreeAndNil(FProject);
      end;
    end;
  end;
end;

procedure TfrmAddToForm.UpdateProjectInfo;
var
  Index: integer;
begin
  try
    cbVolumes.Items.Clear;
    if FProject = nil then
    begin
      for Index := 0 to TabSheet1.ControlCount - 1 do
        if TabSheet1.Controls[Index] is TLabel then
          with TabSheet1.Controls[Index] do
            Visible := (Tag = 0) or (Tag = 1);
    end
    else
    begin
      //    lblMedia.Caption := BackupMediaNames[FProject.BackupMedia]^;
      lblCompression.Caption := sCompression + #32 + CompressionNames[TCompressionLevel(FProject.CompressionLevel)]^;
      lblEncryption.Caption  := sEncryption + #32 + Encryptions[FProject.EncryptionMethod]^;

      GetTaskInfo;

      for Index := 0 to TabSheet1.ControlCount - 1 do
        if TabSheet1.Controls[Index] is TLabel then
          with TabSheet1.Controls[Index] do
            Visible := (Tag = 0) or (Tag = 2);

      for Index := 0 to FProject.VolumeCount - 1 do
        cbVolumes.Items.Add(FProject.Volumes[Index].GetVolumeString);
      if FProject.ActiveVolumeIndex > FProject.VolumeCount - 1 then
        FProject.ActiveVolumeIndex := FProject.VolumeCount - 1;
      cbVolumes.ItemIndex := FProject.ActiveVolumeIndex;
    end;
  finally
    cbVolumes.Enabled := cbVolumes.Items.Count > 1;
    lblVolume.Enabled := cbVolumes.Enabled;
  end;
end;

procedure TfrmAddToForm.cbProjectChange(Sender: TObject);
begin
  CloseProject(False);
  OpenProject(cbProject.Text);
  UpdateProjectInfo;
end;

procedure TfrmAddToForm.GetTaskInfo;
begin
  if not frmMain.TaskManager.Active then
    Exit;
  try
    FTask := frmMain.TaskManager.ActivateTask(FProject.DisplayName);
    if FTask <> nil then
      lblSchedule.Caption := FTask.TriggerText
    else
      lblSchedule.Caption := sTaskNotScheduled;
  except
    on E: Exception do
      lblSchedule.Caption := E.Message;
  end;
end;

procedure TfrmAddToForm.UpdateActions;
begin
  btnOK.Enabled := FProject <> nil;
  btnSettings.Enabled := FProject <> nil;
end;

procedure TfrmAddToForm.btnOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    CloseProject(False);
    OpenProject(OpenDialog.FileName);
    UpdateProjectInfo;
    if cbProject.Items.IndexOf(OpenDialog.FileName) <> -1 then
      cbProject.ItemIndex := cbProject.Items.IndexOf(OpenDialog.FileName)
    else
    begin
      cbProject.Items.Insert(0, OpenDialog.FileName);
      cbProject.ItemIndex := 0;
      frmMain.MRUList.Add(OpenDialog.FileName);
    end;
  end;
end;

procedure TfrmAddToForm.btnSettingsClick(Sender: TObject);
begin
  if FProject = nil then
    Exit;
  if DisplayProjectPropertiesDialog(FProject) then
    UpdateProjectInfo;
end;

procedure TfrmAddToForm.btnNewClick(Sender: TObject);
var
  NewProject: TNSProject;
begin
  if not CreateNewProjectWizard(NewProject) then
    Exit;
  case NewProject.Kind of
    pkArchive:
      NewProject.FileName := IncludeTrailingPathDelimiter(g_ProjectsDir) + NewProject.DisplayName + sNsa;
    pkBackup:
      NewProject.FileName := IncludeTrailingPathDelimiter(g_ProjectsDir) + NewProject.DisplayName + sNsb;
  end;
  // Check this later
  NewProject.SaveToFile(True);
  if cbProject.Items.IndexOf(NewProject.FileName) <> -1 then
    cbProject.ItemIndex := cbProject.Items.IndexOf(NewProject.FileName)
  else
  begin
    cbProject.Items.Insert(0, NewProject.FileName);
    cbProject.ItemIndex := 0;
    frmMain.MRUList.Add(NewProject.FileName);
  end;
  CloseProject(False);
  FProject := NewProject;
  UpdateProjectInfo;
end;

procedure TfrmAddToForm.LoadFileOrFolder(const AFileName: string);
var
  FileInfo: TSHFileInfo;
begin
  FFileObject := AFileName;
  if DirectoryExists(AFileName) then
    SHGetFileInfo(PChar(AFileName), FILE_ATTRIBUTE_DIRECTORY, FileInfo, SizeOf(FileInfo),
      SHGFI_ICON {or SHGFI_USEFILEATTRIBUTES} or SHGFI_DISPLAYNAME)
  else
    SHGetFileInfo(PChar(AFileName), FILE_ATTRIBUTE_NORMAL, FileInfo, SizeOf(FileInfo),
      SHGFI_ICON or SHGFI_DISPLAYNAME);

  Image1.Picture.Icon.Handle := FileInfo.hIcon;
  lblFileName.Caption := AFileName;

end;

procedure TfrmAddToForm.GetSettings;
begin
  chkProcessNow.Checked := g_ProcessImmediately;
end;

procedure TfrmAddToForm.SetSettings;
var
  FileList: TStrings;
begin
  g_ProcessImmediately := chkProcessNow.Checked;
  FileList := TStringList.Create;
  try
    FileList.Add(FFileObject);

    try
      InsertItemsToProject(FProject, FileList, nil);
      FProject.SaveToFile(False);
    except
      PostMessage(frmMain.Handle, WM_CLOSE, 0, 0);
    end;

    if g_ProcessImmediately then
    begin
      TScheduledThread.Create(frmMain.Handle, FProject.FileName);
    end
    else
    begin
      PostMessage(frmMain.Handle, WM_CLOSE, 0, 0);
    end;
  finally
    FileList.Free;
  end;
end;

procedure TfrmAddToForm.cbVolumesChange(Sender: TObject);
begin
  FProject.ActiveVolumeIndex := cbVolumes.ItemIndex;
end;

procedure TfrmAddToForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
