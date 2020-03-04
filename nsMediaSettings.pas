unit nsMediaSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, nsTypes, nsGlobals, ImgList,
  System.ImageList;

type
  TfrmMediaSettings = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PageControl: TPageControl;
    Panel1: TPanel;
    Label8: TLabel;
    btnConnection: TButton;
    tsLocal: TTabSheet;
    tsFTP: TTabSheet;
    Label11: TLabel;
    edtHost: TEdit;
    Label12: TLabel;
    edtPort: TEdit;
    chkPassive: TCheckBox;
    Label15: TLabel;
    edtHostDir: TEdit;
    Label13: TLabel;
    edtUser: TEdit;
    Label14: TLabel;
    edtHostPwd: TEdit;
    ckbDialup: TCheckBox;
    ckbDialupHangup: TCheckBox;
    Label10: TLabel;
    edtLocalFolder: TEdit;
    btnBrowseForLocalFolder: TButton;
    tsCD: TTabSheet;
    cbDrives: TComboBox;
    Label3: TLabel;
    ImageList1: TImageList;
    cbMediaType: TComboBox;
    tsNAS: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    edtNetPath: TEdit;
    Label2: TLabel;
    edtNetUser: TEdit;
    Label4: TLabel;
    edtNetPass: TEdit;
    btnBrowseForNetFolder: TButton;
    procedure cbMediaTypeChange(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure btnBrowseForLocalFolderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnHelpClick(Sender: TObject);
    procedure cbDrivesChange(Sender: TObject);
    procedure cbMediaTypeDrawItem(Control: TWinControl; Index: integer; Rect: TRect; State: TOwnerDrawState);
    procedure btnBrowseForNetFolderClick(Sender: TObject);
  protected
    procedure UpdateActions; override;
  private
    { Private declarations }
    FVolume: TNSProject;
    FExisting: Boolean;

    procedure GetSettings(const AProject: TNSProject);
    procedure SetSettings(const AProject: TNSProject);
    function CheckSettings: Boolean;
  public
    { Public declarations }
  end;

function EditMediaSettingsDlg(const AVolume: TNSProject; const AExisting: Boolean = False): Boolean;

implementation

uses
  nsOptionsFrm, nsUtils, cdWrapper;

{$R *.dfm}

function EditMediaSettingsDlg(const AVolume: TNSProject; const AExisting: Boolean): Boolean;
begin
  with TfrmMediaSettings.Create(Application) do
    try
      FExisting := AExisting;
      GetSettings(AVolume);
      Result := ShowModal = mrOk;
      if Result then
        SetSettings(AVolume);
    finally
      Free;
    end;
end;

procedure TfrmMediaSettings.GetSettings(const AProject: TNSProject);
var
  Media: TBackupMedia;
begin
  FVolume := AProject;
  Caption := Format(sMediaSettings, [AProject.DisplayName]);

  for Media := Low(TBackupMedia) to High(TBackupMedia) do
    cbMediaType.Items.Add(BackupMediaNames[Media]^);
  cbMediaType.ItemIndex := Ord(AProject.BackupMedia);
  cbMediaTypeChange(cbMediaType);
  UpdateActions;

  edtHost.Enabled := not FExisting;
  edtHostDir.Enabled := not FExisting;
  edtLocalFolder.Enabled := not FExisting;
  btnBrowseForLocalFolder.Enabled := edtLocalFolder.Enabled;
  cbMediaType.Enabled := not FExisting;

  ckbDialupHangup.Checked := AProject.HangUpOnCompleted;
  ckbDialup.Checked := AProject.AutoDialUp;

  edtHost.Text := AProject.HostName;
  edtHostDir.Text := AProject.HostDirName;
  edtPort.Text := AProject.Port;
  edtUser.Text := AProject.UserName;
  edtLocalFolder.Text := AProject.LocalFolder;
  edtHostPwd.Text := AProject.Password;
  chkPassive.Checked := AProject.Passive;

  if (AProject.CDIndex >=0) and (AProject.CDIndex < cbDrives.Items.Count) then
    cbDrives.ItemIndex := AProject.CDIndex;

  // 3.0.0
  edtNetPath.Text := AProject.NetPath;
  edtNetUser.Text := AProject.NetUser;
  edtNetPass.Text := AProject.NetPass;
end;

procedure TfrmMediaSettings.SetSettings(const AProject: TNSProject);
begin
  UpdateActions;
  AProject.BackupMedia := TBackupMedia(cbMediaType.ItemIndex);
  case AProject.BackupMedia of
    bmLocal:
    begin
      AProject.LocalFolder := edtLocalFolder.Text;
      g_LastlocalFolder := AProject.LocalFolder;
    end;
    bmFTP:
    begin
      AProject.HostName := edtHost.Text;
      g_LastServer  := AProject.HostName;
      AProject.Port := edtPort.Text;
      AProject.HostDirName := edtHostDir.Text;
      g_LastHostDir := AProject.HostDirName;
      AProject.UserName := edtUser.Text;
      g_LastUserName := AProject.UserName;
      AProject.Password := edtHostPwd.Text;
      AProject.Passive := chkPassive.Checked;
    end;
    bmCD:
    begin
      AProject.CDIndex := cbDrives.ItemIndex;
    end;
    bmNAS:
    begin
      // 3.0.0
      AProject.NetPath := edtNetPath.Text;
      AProject.NetUser := edtNetUser.Text;
      AProject.NetPass := edtNetPass.Text;
      g_LastNetPath := AProject.NetPath;
    end;
  end;

  AProject.AutoDialUp := ckbDialup.Checked;
  AProject.HangUpOnCompleted := ckbDialupHangup.Checked;

end;

procedure TfrmMediaSettings.cbMediaTypeChange(Sender: TObject);
begin
  PageControl.ActivePageIndex := cbMediaType.ItemIndex;
end;

procedure TfrmMediaSettings.btnConnectionClick(Sender: TObject);
begin
  case cbMediaType.ItemIndex of
    1: DisplayOptionsDialog(Self, 1);
    2: DisplayOptionsDialog(Self, 3);
  end;
end;

procedure TfrmMediaSettings.btnBrowseForLocalFolderClick(Sender: TObject);
var
  sFolder: String;
begin
  sFolder := edtLocalFolder.Text;
  if SelectDir(sDestinationSelect, sFolder) then
    edtLocalFolder.Text := sFolder;
end;

procedure TfrmMediaSettings.FormCreate(Sender: TObject);
begin
  if DiskWriter.GetRecorderList(cbDrives.Items) then
  begin
    cbDrives.ItemIndex := 0;
    cbDrivesChange(Sender);
  end;
end;

function TfrmMediaSettings.CheckSettings: Boolean;
var
  Index: integer;
  Volume: TNSProject;
  Root: TNSProject;
  S1: string;
  S2: string;
begin
  if FVolume.Owner is TNSProject then
    Root := FVolume.Owner as TNSProject
  else
    Root := FVolume;
  Result := True;
  for Index := 0 to Root.VolumeCount - 1 do
  begin
    Volume := Root.Volumes[Index];
    if Volume = FVolume then
      Continue;
    if cbMediaType.ItemIndex <> Ord(Volume.BackupMedia) then
      Continue;
    case Volume.BackupMedia of
      bmLocal:
      begin
        S1 := IncludeTrailingPathDelimiter(edtLocalFolder.Text);
        S2 := IncludeTrailingPathDelimiter(Volume.LocalFolder);
        if AnsiSameText(S1, S2) then
        begin
          MessageDlg(Format(sDuplicateVolumes, [Volume.GetVolumeString(True)]), mtWarning, [mbOK], 0);
          Result := False;
          Exit;
        end;
      end;
      bmFtp:
      begin
        S1 := IncludeTrailingPathDelimiter(edtHost.Text) + IncludeTrailingPathDelimiter(edtHostDir.Text);
        S2 := IncludeTrailingPathDelimiter(Volume.HostName) + IncludeTrailingPathDelimiter(Volume.HostDirName);
        if AnsiSameText(S1, S2) then
        begin
          MessageDlg(Format(sDuplicateVolumes, [Volume.GetVolumeString(True)]), mtWarning, [mbOK], 0);
          Result := False;
          Exit;
        end;
      end;
      bmCD:
      begin
        if Volume.CDIndex = cbDrives.ItemIndex then
        begin
          MessageDlg(Format(sDuplicateVolumes, [Volume.GetVolumeString(True)]), mtWarning, [mbOK], 0);
          Result := False;
          Exit;
        end;
      end;
      bmNAS:
      begin
        S1 := IncludeTrailingPathDelimiter(edtNetPath.Text);
        S2 := IncludeTrailingPathDelimiter(Volume.NetPath);
        if AnsiSameText(S1, S2) then
        begin
          MessageDlg(Format(sDuplicateVolumes, [Volume.GetVolumeString(True)]), mtWarning, [mbOK], 0);
          Result := False;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmMediaSettings.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult <> mrOk then
    Exit;
  CanClose := CheckSettings;
end;

procedure TfrmMediaSettings.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(HelpContext, Application.HelpFile);
end;

procedure TfrmMediaSettings.btnBrowseForNetFolderClick(Sender: TObject);
var
  sFolder: String;
begin
  sFolder := edtNetPath.Text;
  if SelectDir(sSelectVolumePath, sFolder) then
    edtNetPath.Text := sFolder;
end;

procedure TfrmMediaSettings.UpdateActions;
begin
  btnConnection.Enabled := (cbMediaType.ItemIndex in [1, 2]);
  case cbMediaType.ItemIndex of
    0: btnOk.Enabled := Trim(edtLocalFolder.Text) <> EmptyStr;
    1:
    begin
      btnOk.Enabled := (Trim(edtHost.Text) <> EmptyStr) and (Trim(edtHostDir.Text) <> EmptyStr) and
        (Trim(edtUser.Text) <> EmptyStr);
    end;
    2: btnOK.Enabled := cbDrives.ItemIndex <> -1;
    3: btnOK.Enabled := Trim(edtNetPath.Text) <> EmptyStr;
  end;
end;

procedure TfrmMediaSettings.cbDrivesChange(Sender: TObject);
begin
  if cbDrives.ItemIndex = -1 then
    Exit;

  DiskWriter.SetActiveRecorder(cbDrives.ItemIndex);
end;

procedure TfrmMediaSettings.cbMediaTypeDrawItem(Control: TWinControl; Index: integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with (Control as TComboBox) do
  begin
    Canvas.FillRect(Rect);
    if Index <> -1 then
    begin
      ImageList1.Draw(Canvas, Rect.Left + 2, Rect.Top + 2, Index, Enabled);
      Canvas.TextOut(Rect.Left + 22, Rect.Top + 4, Items[Index]);
    end;
  end;
end;

end.
