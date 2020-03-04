unit nsItemFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ShellAPI, ShlObj, nsTypes, nsGlobals,
  DateUtils, System.UITypes;

type
  TfrmItemProperties = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PageControl: TPageControl;
    TS1: TTabSheet;
    Image1: TImage;
    edtName: TEdit;
    TS2: TTabSheet;
    lvVersions: TListView;
    Label2: TLabel;
    btnDelete: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblSize: TLabel;
    btnRestore: TButton;
    lblSizeOnMedia: TLabel;
    lblLocation: TLabel;
    Label6: TLabel;
    lblType: TLabel;
    Bevel1: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    lblCreated: TLabel;
    lblModified: TLabel;
    edtOriginalLocation: TEdit;
    btnChange: TButton;
    lblOriginal: TLabel;
    Label1: TLabel;
    cbDefAction: TComboBox;
    btnOpen: TButton;
    lblRemoteName: TLabel;
    edtRemoteName: TEdit;
    btnMangle: TButton;
    chkBackupItem: TCheckBox;
    Bevel4: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure btnRestoreClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvVersionsColumnClick(Sender: TObject; Column: TListColumn);
    procedure btnChangeClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnMangleClick(Sender: TObject);
    procedure cbDefActionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FItem: TNSItem;
    procedure FillVersions(AItem: TNSItem);
    procedure GetProperties(AItem: TNSItem);
    procedure SetProperties(AItem: TNSItem);
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
  end;

function DisplayItemPropertiesDialog(AOwner: TForm; AItem: TNSItem): Boolean;

implementation

uses
  nsUtils;

{$R *.dfm}

var
  SortOrder: integer = 1;

function LVSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
var
  Data1: TNSVersion;
  Data2: TNSVersion;
begin
  Data1 := TNSVersion(Item1.Data);
  Data2 := TNSVersion(Item2.Data);
  case ParamSort of
    0: Result := SortOrder * (Data2.Number - Data1.Number);
    1: Result := SortOrder * (Data2.Size - Data1.Size);
    2: Result := SortOrder * CompareDateTime(Data2.Modified, Data1.Modified);
    else
      Result := 0;
  end;
end;


function DisplayItemPropertiesDialog(AOwner: TForm; AItem: TNSItem): Boolean;
begin
  Result := False;
  with TfrmItemProperties.Create(AOwner) do
    try
      GetProperties(AItem);
      if ShowModal = mrOk then
      begin
        SetProperties(AItem);
        Result := True;
      end;
    finally
      Free;
    end;
end;

{ TItemForm }

procedure TfrmItemProperties.FillVersions(AItem: TNSItem);
var
  Index: integer;
  li: TListItem;
begin
  for Index := 0 to AItem.Versions.Count - 1 do
  begin
    if AItem.Versions[Index].Exists then
    begin
      li := lvVersions.Items.Add;
      li.Caption := IntToHex(AItem.Versions[Index].Number, 3);
      li.SubItems.Add(FormatSize(AItem.Versions[Index].Size, False));
      li.SubItems.Add(DateTimeToStr(AItem.Versions[Index].Modified));
      li.Data := AItem.Versions[Index];
    end;
  end;
end;

procedure TfrmItemProperties.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmItemProperties.GetProperties(AItem: TNSItem);
var
  VerNo: integer;
  TotSize: int64;
  FileInfo: TSHFileInfo;
  da: TDefaultAction;
begin
  PageControl.ActivePageIndex := 0;
  FItem := AItem;
  edtName.Text := AItem.DisplayName;
  Caption := Format(sProperties, [AItem.DisplayName]);
  SHGetFileInfo(PChar(AItem.DisplayName),
    FILE_ATTRIBUTE_NORMAL,
    FileInfo,
    SizeOf(FileInfo),
    SHGFI_USEFILEATTRIBUTES or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_LARGEICON or SHGFI_TYPENAME);

  Image1.Picture.Icon.Handle := FileInfo.hIcon;

  lblType.Caption := StrPas(FileInfo.szTypeName);

  FillVersions(AItem);

  lblLocation.Caption := AItem.GetLocation;
  edtOriginalLocation.Text := AItem.LocalPath;

  if AItem.RemoteName = EmptyStr then
    edtRemoteName.Text := AItem.DisplayName
  else
    edtRemoteName.Text := AItem.RemoteName;
  if CurProject.FileFormat = fmAsIs then
    btnMangle.Enabled := False
  else
    btnMangle.Enabled := not AItem.IsNameMangled and CurProject.ActiveVolume.Connected;
  lblRemoteName.Enabled := btnMangle.Enabled;
  edtRemoteName.Enabled := btnMangle.Enabled;

  TotSize := 0;
  for VerNo := 0 to AItem.Versions.Count - 1 do
    TotSize := TotSize + AItem.Versions[VerNo].SizeOnMedia;
  lblSizeOnMedia.Caption := FormatSize(TotSize, True);

  lblCreated.Caption := DateTimeToStr(AItem.Created);
  if AItem.Exists then
  begin
    lblModified.Caption := DateTimeToStr(AItem.Modified);
    lblSize.Caption := FormatSize(AItem.Size, True);
  end
  else
  begin
    lblModified.Caption := DateTimeToStr(AItem.UModified);
    lblSize.Caption := FormatSize(AItem.USize, True);
  end;

  lblOriginal.Enabled := AItem.Exists and (CurProject.Kind <> pkBackup);
  edtOriginalLocation.Enabled := lblOriginal.Enabled;
  btnChange.Enabled := lblOriginal.Enabled;

  for da := Low(TDefaultAction) to High(TDefaultAction) do
    cbDefAction.Items.Add(ActionNames[da]^);

  cbDefAction.ItemIndex := Ord(AItem.DefAction);

  if CurProject.Kind = pkBackup then
    chkBackupItem.Checked := AItem.BackupItem
  else
    chkBackupItem.Enabled := False;

end;

procedure TfrmItemProperties.SetProperties(AItem: TNSItem);
begin
  if AItem.Exists then
  begin
    AItem.LocalPath := edtOriginalLocation.Text;
  end;


  AItem.DefAction := TDefaultAction(cbDefAction.ItemIndex);
  if (AItem.DisplayName <> edtRemoteName.Text) and (AItem.RemoteName <> edtRemoteName.Text) then
  begin
    if not AItem.Mangle then
      MessageDlg(sCannotMangleFile, mtWarning, [mbOK], 0);
  end;

  if CurProject.Kind = pkBackup then
    AItem.BackupItem := chkBackupItem.Checked;
end;

procedure TfrmItemProperties.UpdateActions;
begin
  if FItem.Exists then
  begin
    btnRestore.Enabled := lvVersions.Selected <> nil;
    btnOpen.Enabled := lvVersions.Selected <> nil;
    btnDelete.Enabled := (lvVersions.Items.Count > 1) and (lvVersions.Selected <> nil);
  end
  else
  begin
    btnRestore.Enabled := False;
    btnOpen.Enabled := False;
    btnDelete.Enabled := False;
  end;
end;

procedure TfrmItemProperties.btnRestoreClick(Sender: TObject);
var
  Version: TNSVersion;
  sFolder: String;
begin
  Version := TNSVersion(lvVersions.Selected.Data);
  sFolder := FItem.LocalPath;
  if SelectDir(Format(sDestinationFolder, [FItem.DisplayName]), sFolder) and DirectoryExists(sFolder) then
    with CurProject.ActiveVolume do
      try
        Screen.Cursor := crHourGlass;
        ReInitCrypting;
        if FItem.RestoreVersion(sFolder, Version.Number) then
          MessageBox(
            Handle,
            PChar(Format(sRestoreSucceeded, [FItem.DisplayName, sFolder])),
            PChar(sInformation),
            $00000040)
        else
          MessageBox(
            Handle,
            PChar(Format(sRestoreVerFailed, [FItem.DisplayName, Version.Number, sFolder])),
            PChar(sError),
            $00000030);
      finally
        Screen.Cursor := crDefault;
      end;
end;

procedure TfrmItemProperties.btnDeleteClick(Sender: TObject);
var
  Version: TNSVersion;
begin
  Version := TNSVersion(lvVersions.Selected.Data);
  if FItem.DeleteVersion(Version.Number) then
  begin
    FItem.Versions.Delete(Version.Index);
    lvVersions.Items.Delete(lvVersions.Selected.Index);
  end
  else
    MessageBox(
      Handle,
      PChar(Format(sDeleteVerFailed, [FItem.DisplayName, Version.Number])),
      PChar(sError),
      $00000030);
end;

procedure TfrmItemProperties.lvVersionsColumnClick(Sender: TObject; Column: TListColumn);
begin
  SortOrder := -SortOrder;
  lvVersions.CustomSort(@LVSortProc, Column.Index);
end;

procedure TfrmItemProperties.btnChangeClick(Sender: TObject);
var
  sFolder: String;
begin
  sFolder := edtOriginalLocation.Text;
  if SelectDir(sSelectDefaultLocItem, sFolder) then
    edtOriginalLocation.Text := sFolder;
end;

procedure TfrmItemProperties.btnOpenClick(Sender: TObject);
var
  Version: TNSVersion;
  tmpName: string;
  dwError: DWORD;
begin
  Version := TNSVersion(lvVersions.Selected.Data);
  with CurProject.ActiveVolume do
  begin
    try
      ReInitCrypting;
      Screen.Cursor := crHourGlass;
      tmpName := IncludeTrailingPathDelimiter(g_TempDir) + FItem.DisplayName;
      if FileExists(tmpName) then
      begin
        if not Windows.DeleteFile(PChar(tmpName)) then
        begin
          dwError := GetLastError;
          MessageBox(
            Handle,
            PChar(Format(sCannotOpenFile + #13#10 + '"%s"', [FItem.DisplayName, SysErrorMessage(dwError)])),
            PChar(sErrorOpening),
            $00000030);
          Exit;
        end;
      end;
      if FItem.RestoreVersion(g_TempDir, Version.Number) then
        ShellExecute(Handle, pOpen, PChar(tmpName), nil, nil, SW_SHOWNORMAL)
      else
      begin
        MessageBox(
          Handle,
          PChar(Format(sRestoreVerFailed, [FItem.DisplayName, Version.Number, g_TempDir])),
          PChar(sError),
          $00000030);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmItemProperties.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(HelpContext, Application.HelpFile);
end;

procedure TfrmItemProperties.btnMangleClick(Sender: TObject);
begin
  edtRemoteName.Text := MangleFileName(edtRemoteName.Text);
  btnMangle.Enabled  := False;
  edtRemoteName.Enabled := False;
end;

procedure TfrmItemProperties.cbDefActionChange(Sender: TObject);
begin
  if CurProject.FileFormat = fmAsIs then // As Is
    if cbDefAction.ItemIndex = 2 then
      cbDefAction.ItemIndex := 1;
end;

end.
