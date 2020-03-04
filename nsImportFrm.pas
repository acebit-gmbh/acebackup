unit nsImportFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, nsGlobals, nsTypes, nsUtils,
  abWizardTemplate, StrUtils, WinFTP;

type
  TfrmImportWizard = class(TfrmWizardTemplate)
    ts1: TTabSheet;
    pnlWelcome: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    Panel1: TPanel;
    Label8: TLabel;
    btnConnection: TButton;
    cbMediaType: TComboBox;
    PageControl1: TPageControl;
    tsLocal: TTabSheet;
    Label10: TLabel;
    edtLocalFolder: TEdit;
    btnBrowseForLocalFolder: TButton;
    tsFTP: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtHost: TEdit;
    edtPort: TEdit;
    chkPassive: TCheckBox;
    edtHostDir: TEdit;
    edtUser: TEdit;
    edtHostPwd: TEdit;
    tsCD: TTabSheet;
    Label18: TLabel;
    cbDrives: TComboBox;
    tsNAS: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edtNetPath: TEdit;
    edtNetUser: TEdit;
    edtNetPass: TEdit;
    ts2: TTabSheet;
    pnlImporting: TPanel;
    pbxFileName: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label23: TLabel;
    aniProgress: TAnimate;
    ts3: TTabSheet;
    pnlFinish: TPanel;
    Label6: TLabel;
    lblContains: TLabel;
    Label7: TLabel;
    lblSizeOnMedia: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    btnBrowseForNetFolder: TButton;
    Label3: TLabel;
    edtCDFolder: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbMediaTypeChange(Sender: TObject);
    procedure btnBrowseForLocalFolderClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbDrivesChange(Sender: TObject);
    procedure btnBrowseForNetFolderClick(Sender: TObject);
  private
    { Private declarations }

    FOutProject: TNSProject;
    FCoProject: TNSProject;
    FFolders: integer;
    FFiles: integer;
    FSizeOnMedia: int64;
    FKindUndefined: Boolean;
    FKind: TProjectKind;
    FCurFile: string;
    FMustClose: Boolean;
    procedure GetSettings(AProject: TNSProject);
    procedure SetSettings(AProject: TNSProject);
    function VerifyArchive: Boolean;

    procedure DoScanFolder(const APath: string);
    procedure DoScanFTPDir(const APath: string);
    function DoScan: Boolean;

    procedure UpdateStep;
    procedure SetCurFile(const Value: string);
  protected
    procedure UpdateActions; override;
    property CurFile: string read FCurFile write SetCurFile;
  public
    { Public declarations }
    function GoForward: integer; override;
    function GoBack: integer; override;
  end;

function ImportExistingProject(AOwner: TForm; out AProject: TNSProject): Boolean;

implementation

uses
  nsOptionsFrm, nsProcessFrm, cdWrapper;

{$R *.dfm}

var
  lpFileRect: TRect;

function ImportExistingProject(AOwner: TForm; out AProject: TNSProject): Boolean;
begin
  with TfrmImportWizard.Create(AOwner) do
    try
      UpdateStep;
      FOutProject := TNSProject.Create(frmProcess);
      FOutProject.IncMasks.SetMask(sFileMask);
      FCoProject := nil;
      GetSettings(FCoProject);
      if ShowModal = mrOk then
      begin
        SetSettings(FOutProject);
        AProject := FOutProject;
        //      AProject.SaveToFile;
        Screen.Cursor := crHourGlass;

        try
          Application.MainForm.Update;
          Result := AProject.ReConnect;
        finally
          Screen.Cursor := crDefault;
        end;
      end
      else
      begin
        FreeAndNil(FOutProject);
        Result := False;
      end;
    finally
      if FCoProject <> nil then
        FreeAndNil(FCoProject);
      Free;
    end;
end;

procedure TfrmImportWizard.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 0;

  lpFileRect := pbxFileName.ClientRect;
  aniProgress.ResName := AVI_PROCESS;
  aniProgress.ResHandle := hInstance;
  aniProgress.Active := False;
  if DiskWriter.GetRecorderList(cbDrives.Items) then
  begin
    cbDrives.ItemIndex := 0;
    cbDrivesChange(Sender);
  end;
end;

procedure TfrmImportWizard.GetSettings(AProject: TNSProject);
var
  Media: TBackupMedia;
begin
  for Media := Low(TBackupMedia) to High(TBackupMedia) do
    cbMediaType.Items.Add(BackupMediaNames[Media]^);

  if AProject <> nil then
  begin
    cbMediaType.ItemIndex := Ord(FCoProject.BackupMedia);
    cbMediaType.OnChange(cbMediaType);
    edtHost.Text  := FCoProject.HostName;
    edtHostDir.Text := FCoProject.HostDirName;
    edtUser.Text  := FCoProject.UserName;
    edtLocalFolder.Text := IncludeTrailingPathDelimiter(FCoProject.LocalFolder) + FCoProject.DisplayName;
    edtNetPath.Text := FCoProject.NetPath;
    edtNetUser.Text := FCoProject.NetUser;
    edtNetPass.Text := FCoProject.NetPass;
  end
  else
  begin
    cbMediaType.ItemIndex := g_LastMedia;
    cbMediaType.OnChange(cbMediaType);
    edtHost.Text := g_LastServer;
    edtHostDir.Text := g_LastHostDir;
    edtUser.Text := g_LastUserName;
    edtLocalFolder.Text := g_LastLocalFolder;
    edtNetPath.Text := g_LastNetPath;
  end;
end;

function TfrmImportWizard.GoBack: integer;
begin
  case PageControl.ActivePageIndex of
    2: Result := 2;
    else
      Result := 1;
  end;
  UpdateStep;
end;

function TfrmImportWizard.GoForward: integer;
begin
  Result := 0;
  case PageControl.ActivePageIndex of
    0:
    begin
      Screen.Cursor := crHourGlass;
      try
        if not VerifyArchive then  Exit;
      finally
        Screen.Cursor := crDefault;
      end;
      aniProgress.Active := True;
      DoScan;
    end;
  end;
  UpdateStep;
end;

procedure TfrmImportWizard.SetSettings(AProject: TNSProject);
begin

  AProject.WasModified := True;
  AProject.Kind := pkBackup;
  // 15.08
  AProject.FileName := EmptyStr;
  AProject.BackupMedia := TBackupMedia(cbMediaType.ItemIndex);

  case AProject.BackupMedia of
    bmLocal: AProject.DisplayName := ExtractFileName(ExcludeTrailingPathDelimiter(edtLocalFolder.Text));
    bmFTP: AProject.DisplayName := ExtractFileName(ExcludeTrailingPathDelimiter(AnsiReplaceText(edtHostDir.Text, sSlash, sBackslash)));
    bmCD: AProject.DisplayName := ExtractFileName(ExcludeTrailingPathDelimiter(edtCDFolder.Text));
    bmNAS: AProject.DisplayName := ExtractFileName(ExcludeTrailingPathDelimiter(edtNetPath.Text));
  end;

  AProject.Port := edtPort.Text;
  AProject.UserName := edtUser.Text;
  AProject.Password := edtHostPwd.Text;
  AProject.HostName := edtHost.Text;
  AProject.HostDirName := AnsiReplaceText(ExtractFilePath(ExcludeTrailingPathDelimiter(AnsiReplaceText(edtHostDir.Text, sSlash, sBackslash))), sBackslash, sSlash);
  AProject.Passive := chkPassive.Checked;

  AProject.LocalFolder := ExtractFilePath(ExcludeTrailingPathDelimiter(edtLocalFolder.Text));
  AProject.NetPath :=  ExtractFilePath(ExcludeTrailingPathDelimiter(edtNetPath.Text));
  AProject.NetPass := edtNetPass.Text;
  AProject.NetUser := edtNetUser.Text;

  if FCoProject <> nil then
  begin
    AProject.DisplayName := FCoProject.DisplayName;
    //    AProject.Kind := FCoProject.Kind;
    //    AProject.FileName := FCoProject.FileName;
    //    AProject.BackupMedia := FCoProject.BackupMedia;
    //    AProject.LocalFolder := FCoProject.LocalFolder;
    //    AProject.Port := FCoProject.Port;
    AProject.ProjPwd := FCoProject.ProjPwd;
    AProject.EncryptionMethod := FCoProject.EncryptionMethod;
    AProject.StoreArchivePwd := FCoProject.StoreArchivePwd;
    AProject.DefaultAction := FCoProject.DefaultAction;
    AProject.IncMasks.SetMask(FCoProject.IncMasks.GetMask);
    AProject.ExcMasks.SetMask(FCoProject.ExcMasks.GetMask);
    AProject.SendLog := FCoProject.SendLog;
    //  AProject.UserName := FCoProject.UserName;
    //  AProject.Password := FCoProject.Password;
    //  AProject.HostName := FCoProject.HostName;
    //  AProject.HostDirName := FCoProject.HostDirName;
    //  AProject.Passive := FCoProject.Passive;
  end;
end;

procedure TfrmImportWizard.UpdateActions;
begin
  inherited;
  case PageControl.ActivePageIndex of
    0:
    begin
      case cbMediaType.ItemIndex of
        0: btnNext.Enabled := DirectoryExists(edtLocalFolder.Text);
        1: btnNext.Enabled := (edtHost.Text <> EmptyStr) and
            (edtPort.Text <> EmptyStr) and (edtHostDir.Text <> EmptyStr) and (edtUser.Text <> EmptyStr);
        2: btnNext.Enabled := (cbDrives.ItemIndex <> -1);
        3: btnNext.Enabled := Trim(edtNetPath.Text) <> EmptyStr;
      end;
      btnConnection.Enabled := TBackupMedia(cbMediaType.ItemIndex) = bmFTP;
    end;
    1: begin
         btnBack.Enabled := False;
         btnNext.Enabled := False;
       end;
    else
      btnNext.Enabled := True;
  end;

(*
  if FStep = 3 then
  begin
    btnNext.Caption := sFinish;
    btnNext.ModalResult := mrOK;
  end
  else
  begin
    btnNext.Caption := sNext;
    btnNext.ModalResult := mrNone;
  end;
*)
end;

procedure TfrmImportWizard.cbMediaTypeChange(Sender: TObject);
begin
  PageControl1.ActivePageIndex := cbMediaType.ItemIndex;
end;

procedure TfrmImportWizard.btnBrowseForLocalFolderClick(Sender: TObject);
var
  sFolder: string;
begin
  if DirectoryExists(edtLocalFolder.Text) then
    sFolder := edtLocalFolder.Text;
  if SelectDir(sSelectVolumePath, sFolder) then
    edtLocalFolder.Text := sFolder;
end;


procedure TfrmImportWizard.DoScanFolder(const APath: string);
var
  CoItems: TNSCollection;

  function FindItem(const AItems: TNSCollection; AName: string): TNSItem;
  var
    Index: integer;
  begin
    Result := nil;
    for Index := 0 to AItems.Count - 1 do
      if AnsiSameText(AItems[Index].DisplayName, AName) then
      begin
        Result := AItems[Index];
        Break;
      end;
  end;

  procedure IntScan(const AItems: TNSCollection; const ACoItems: TNSCollection; const ADirectory: string);
  var
    NewItem: TNSItem;
    NewVersion: TNSVersion;
    sr: TSearchRec;
    fAttr: integer;
    IsDir: Boolean;
    tmpName: string;
    tmpPos: integer;
    tmpExt: string;
    tmpCoItem: TNSItem;
    tmpCoItems: TNSCollection;
    tmpVerNo: integer;
    tmpMangled: Boolean;
  begin
    if FMustClose then
      Abort;
    fAttr := faAnyFile;
    FillChar(sr, SizeOf(TSearchRec), #0);
    if FindFirst(IncludeTrailingPathDelimiter(ADirectory) + sFileMask, fAttr, sr) <> 0 then
      Exit;
    repeat
      if FMustClose then
        Abort;
      if (sr.Name = sDot) or (sr.Name = sDoubleDot) then
        Continue;
      IsDir := (sr.Attr and faDirectory = faDirectory);
      if IsDir then
      begin
        Inc(FFolders);
        NewItem := AItems.Add;
        NewItem.IsFolder := True;
        NewItem.DisplayName := sr.Name;
        NewItem.Created := Now;
        NewItem.Modified := FileGetModified(sr);

        NewItem.Exists := True;
        Application.ProcessMessages;
        tmpCoItems := nil;
        if ACoItems <> nil then
        begin
          tmpCoItem := FindItem(ACoItems, NewItem.DisplayName);
          if tmpCoItem <> nil then
          begin
            tmpCoItems := tmpCoItem.SubItems;
            NewItem.Created := tmpCoItem.Created;
            NewItem.BackupItem := tmpCoItem.BackupItem;
          end
          else
            NewItem.Created := Now;
        end;
        if FKindUndefined then
        begin
          if (AnsiPos(nscPrefix, sr.Name) > 0) or (AnsiPos(nsdPrefix, sr.Name) > 0) then
          begin
            FKind := pkBackup;
            FKindUndefined := False;
          end;
        end;
        IntScan(NewItem.SubItems, tmpCoItems, IncludeTrailingPathDelimiter(ADirectory) + sr.Name);
      end
      else
      begin
        tmpName := sr.Name;
        tmpPos  := AnsiPos(sNsz, tmpName);
        if tmpPos > 0 then
          System.Delete(tmpName, tmpPos, 128);

        tmpPos := AnsiPos(sMsz, tmpName);
        if tmpPos > 0 then
          System.Delete(tmpName, tmpPos, 128);

        tmpMangled := tmpPos > 0;
        if tmpMangled then
          tmpName := MangleFileName(tmpName);

        CurFile := tmpName;
        FSizeOnMedia := FSizeOnMedia + FileGetSize(SR);
        Application.ProcessMessages;
        tmpExt := ExtractFileExt(sr.Name);
        if (tmpExt <> EmptyStr) and (tmpExt[1] = #46) then
          tmpExt[1] := #36;
        tmpCoItem := nil;
        if ACoItems <> nil then
          tmpCoItem := FindItem(ACoItems, tmpName);
        NewItem := FindItem(AItems, tmpName);
        if NewItem <> nil then
        begin
          NewVersion := NewItem.Versions.Add;
          NewVersion.Exists := True;
          NewVersion.Number := StrToIntDef(tmpExt, 0);
          NewVersion.SizeOnMedia := FileGetSize(SR);
          if tmpCoItem <> nil then
          begin
            tmpVerNo := tmpCoItem.IndexOfVersion(NewVersion.Number);
            if tmpVerNo > 0 then
            begin
              NewItem.Size := tmpCoItem.Versions[tmpVerNo].Size;
              NewItem.Modified := tmpCoItem.Versions[tmpVerNo].Modified;
            end
            else
            begin
              NewItem.Size := -1;
              NewItem.Modified := FileGetModified(sr);
            end;
          end
          else
          begin
            NewVersion.Size := -1;
            NewVersion.Modified := FileGetModified(sr);
          end;
        end
        else
        begin
          Inc(FFiles);
          NewItem := AItems.Add;
          NewItem.IsFolder := False;
          NewItem.Exists := True;
          //          NewItem.Versions.Add;
          NewItem.DisplayName := tmpName;
          if tmpMangled then
            NewItem.RemoteName := MangleFileName(tmpName);

          NewItem.SizeOnMedia := FileGetSize(SR);
          NewItem.Versions[0].Number := StrToIntDef(tmpExt, 0);
          if tmpCoItem <> nil then
          begin
            NewItem.LocalPath := tmpCoItem.LocalPath;
            NewItem.Size := tmpCoItem.Size;
            tmpVerNo := tmpCoItem.IndexOfVersion(NewItem.Versions[0].Number);
            if tmpVerNo > -1 then
              NewItem.Modified := tmpCoItem.Versions[tmpVerNo].Modified
            else
              NewItem.Modified := tmpCoItem.Versions[0].Modified;

            NewItem.Created := tmpCoItem.Created;
            NewItem.BackupItem := tmpCoItem.BackupItem;
            NewItem.DefAction := tmpCoItem.DefAction;
          end
          else
          begin
            NewItem.Size := -1;
            NewItem.Created := Now;
            NewItem.Modified := FileGetModified(sr);
            if FKind = pkArchive then
              NewItem.LocalPath := EmptyStr
            else
            begin
              if AItems.GetParentItem <> nil then
                NewItem.LocalPath :=
                  IncludeTrailingPathDelimiter(AItems.GetParentItem.LocalPath) +
                  AItems.GetParentItem.DisplayName;
              NewItem.BackupItem := True;
              NewItem.Size := FileGetSize(IncludeTrailingPathDelimiter(NewItem.LocalPath) + NewItem.DisplayName);
            end;
          end;
        end;
      end;
      if FMustClose then
        Abort;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

begin
  try
    Screen.Cursor := crAppStart;
    if FileExists(IncludeTrailingPathDelimiter(APath) + sRemoteFileName) then
    begin
      FCoProject := TNSProject.Create(Self);
      if not FCoProject.LoadFromFile(IncludeTrailingPathDelimiter(APath) + sRemoteFileName) then
        FreeAndNil(FCoProject);
      if not FOutProject.LoadFromFile(IncludeTrailingPathDelimiter(APath) + sRemoteFileName) then
      begin
        FreeAndNil(FOutProject);
        FOutProject := TNSProject.Create(nil);
      end;
    end;

    FOutProject.Items.Clear;
    FOutProject.Items.BeginUpdate;

    if FCoProject <> nil then
    begin
      FCoProject.StoreArchivePwd := False;
      CoItems := FCoProject.Items;
      FKind := FCoProject.Kind;
      FKindUndefined := False;
    end
    else
      CoItems := nil;
    IntScan(FOutProject.Items, CoItems, IncludeTrailingPathDelimiter(APath) + sArchives);
  finally
    FOutProject.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

function TfrmImportWizard.DoScan: Boolean;
var
  sFolderToScan:  string;
  sNASConnection: string;
begin
  PageControl.ActivePageIndex := 1;
  Update;

  Result := False;
  FFolders := 0;
  FFiles := 0;
  FSizeOnMedia := 0;
  FKindUndefined := True;
  Self.Update;
  Application.ProcessMessages;
  if FCoProject <> nil then
    FreeAndNil(FCoProject);

  try
    FMustClose := False;
    AniProgress.Active := True;
    Self.Update;
    Application.ProcessMessages;
    try

      UpdateActions;
      case TBackupMedia(cbMediaType.ItemIndex) of
        bmLocal, bmCD:
        begin
          if TBackupMedia(cbMediaType.ItemIndex) = bmLocal then
            sFolderToScan := IncludeTrailingPathDelimiter(edtLocalFolder.Text)
          else
            sFolderToScan := IncludeTrailingPathDelimiter(FOutProject.CDDrivePath + edtCDFolder.Text);
          DoScanFolder(sFolderToScan);
        end;
        bmFTP:
          try

            InitializeFTPSession(g_ConnectType, edtHost.Text,
              edtUser.Text, edtHostPwd.Text, edtPort.Text,
              g_ProxyName, g_ProxyPort, EmptyStr, EmptyStr, chkPassive.Checked);

            DoScanFTPDir(IncludeTrailingPathDelimiter(edtHostDir.Text));
          finally
            FinalizeFTPSession;
          end;
        bmNAS:
          try
            ConnectToNAS(Handle, IncludeTrailingPathDelimiter(edtNetPath.Text), edtNetUser.Text,
              edtNetPass.Text, sNASConnection);
            sFolderToScan := IncludeTrailingPathDelimiter(sNASConnection);
            DoScanFolder(sFolderToScan);
          finally
            DisconnectNAS(sNASConnection);
          end;
      end;
    finally
      AniProgress.Active := False;
      Self.Update;
      Application.ProcessMessages;
    end;

    UpdateStep;
    PageControl.ActivePageIndex := 2;
    UpdateActions;

  except
    PageControl.ActivePageIndex := 0;
    UpdateStep;
    UpdateActions;
  end;
end;

procedure TfrmImportWizard.DoScanFTPDir(const APath: string);
var
  CoItems: TNSCollection;
  CoFileName: string;

  function FindItem(const AItems: TNSCollection; AName: string): TNSItem;
  var
    Index: integer;
  begin
    Result := nil;
    for Index := 0 to AItems.Count - 1 do
      if AnsiSameText(AItems[Index].DisplayName, AName) then
      begin
        Result := AItems[Index];
        Break;
      end;
  end;

  procedure IntScan(const AItems: TNSCollection; const ACoItems: TNSCollection; const ADirectory: string);
  var
    NewItem: TNSItem;
    NewVersion: TNSVersion;
    sr: TFTPSearchRec;
    fAttr: integer;
    IsDir: Boolean;
    tmpName: string;
    tmpPos: integer;
    tmpExt: string;
    Index: integer;
    tmpCoItem: TNSItem;
    tmpCoItems: TNSCollection;
    tmpVerNo: integer;
    tmpMangled: Boolean;
  begin
    if FMustClose then
      Abort;
    fAttr := faAnyFile;
    FillChar(sr, SizeOf(TSearchRec), #0);
    //17
    if FTPFindFirst(PChar(IncludeTrailingPathDelimiter(ADirectory) { + sFileMask}), fAttr, sr) <> 0 then
      Exit;
    repeat
      if FMustClose then
        Abort;
      if (sr.Name = sDot) or (sr.Name = sDoubleDot) then
        Continue;
      IsDir := (sr.Attr and faDirectory = faDirectory);
      if not IsDir then
      begin
        tmpName := sr.Name;
        tmpPos  := AnsiPos(sNsz, tmpName);
        if tmpPos > 0 then
          System.Delete(tmpName, tmpPos, 128);

        tmpPos := AnsiPos(sMsz, tmpName);
        if tmpPos > 0 then
          System.Delete(tmpName, tmpPos, 128);

        tmpMangled := tmpPos > 0;
        if tmpMangled then
          tmpName := MangleFileName(tmpName);

        FSizeOnMedia := FSizeOnMedia + int64(SR.FindData.nFileSizeHigh) shl int64(32) +
          int64(SR.FindData.nFileSizeLow);
        //        System.Delete(tmpName, tmpPos, 128);

        CurFile := sr.Name;
        Application.ProcessMessages;
        tmpExt := ExtractFileExt(sr.Name);
        if (tmpExt <> EmptyStr) and (tmpExt[1] = #46) then
          tmpExt[1] := #36;

        tmpCoItem := nil;
        if ACoItems <> nil then
          tmpCoItem := FindItem(ACoItems, tmpName);

        NewItem := FindItem(AItems, tmpName);
        if NewItem <> nil then
        begin
          NewVersion := NewItem.Versions.Add;
          NewVersion.Exists := True;
          NewVersion.Number := StrToIntDef(tmpExt, 0);
          NewVersion.SizeOnMedia := int64(SR.FindData.nFileSizeHigh) shl int64(32) + int64(SR.FindData.nFileSizeLow);
          if tmpCoItem <> nil then
          begin
            tmpVerNo := tmpCoItem.IndexOfVersion(NewVersion.Number);
            if tmpVerNo > 0 then
            begin
              NewVersion.Size := tmpCoItem.Versions[tmpVerNo].Size;
              NewVersion.Modified := tmpCoItem.Versions[tmpVerNo].Modified;
            end
            else
            begin
              NewVersion.Size := -1;
              NewVersion.Modified := FileGetModified(sr);
            end;
          end
          else
          begin
            NewVersion.Size := -1;
            NewVersion.Modified := FileGetModified(sr);
          end;
        end
        else
        begin
          Inc(FFiles);
          NewItem := AItems.Add;
          NewItem.IsFolder := False;
          NewItem.Exists := True;
          //            NewItem.Versions.Add;
          NewItem.DisplayName := tmpName;
          if tmpMangled then
            NewItem.RemoteName := MangleFileName(tmpName);
          NewItem.SizeOnMedia := FileGetSize(sr);
          NewItem.Versions[0].Number := StrToIntDef(tmpExt, 0);
          NewItem.Modified := FileGetModified(sr);
          //          CurFile := sr.Name;
          Application.ProcessMessages;

          if tmpCoItem <> nil then
          begin
            NewItem.Size := tmpCoItem.Size;
            NewItem.LocalPath := tmpCoItem.LocalPath;
            NewItem.Created := tmpCoItem.Created;
            tmpVerNo := tmpCoItem.IndexOfVersion(NewItem.Versions[0].Number);
            if tmpVerNo > -1 then
              NewItem.Modified := tmpCoItem.Versions[tmpVerNo].Modified
            else
              NewItem.Modified := tmpCoItem.Versions[0].Modified;
            NewItem.BackupItem := tmpCoItem.BackupItem;
            NewItem.DefAction := tmpCoItem.DefAction;
          end
          else
          begin
            NewItem.Size := -1;
            NewItem.Created := Now;
            if FKind = pkArchive then
              NewItem.LocalPath := EmptyStr
            else
            begin
              if AItems.GetParentItem <> nil then
                NewItem.LocalPath :=
                  IncludeTrailingPathDelimiter(AItems.GetParentItem.LocalPath) +
                  AItems.GetParentItem.DisplayName;
              NewItem.BackupItem := True;
              NewItem.Size := FileGetSize(IncludeTrailingPathDelimiter(NewItem.LocalPath) + NewItem.DisplayName);
            end;
          end;
        end;
      end
      else
      begin
        Inc(FFolders);
        NewItem := AItems.Add;
        NewItem.IsFolder := True;
        NewItem.Exists := True;
        NewItem.Created := Now;
        NewItem.DisplayName := sr.Name;
        NewItem.Modified := FileGetModified(sr);
        CurFile := sr.Name;
        Application.ProcessMessages;

        if FKindUndefined then
        begin
          if (AnsiPos(nscPrefix, sr.Name) > 0) or (AnsiPos(nsdPrefix, sr.Name) > 0) then
          begin
            FKind := pkBackup;
            FKindUndefined := False;
          end;
        end;
      end;
      if FMustClose then
        Abort;
    until FTPFindNext(sr) <> 0;
    FTPFindClose(sr);
    for Index := AItems.Count - 1 downto 0 do
      if AItems[Index].IsFolder then
      begin
        if FMustClose then
          Abort;
        tmpCoItems := nil;
        if ACoItems <> nil then
        begin
          tmpCoItem := FindItem(ACoItems, AItems[Index].DisplayName);
          if tmpCoItem <> nil then
          begin
            AItems[Index].Created := tmpCoItem.Created;
            tmpCoItems := tmpCoItem.SubItems;
            AItems[Index].BackupItem := tmpCoItem.BackupItem;
            AItems[Index].DefAction := tmpCoItem.DefAction;
          end;
        end;
        IntScan(AItems[Index].SubItems, tmpCoItems, IncludeTrailingPathDelimiter(ADirectory) + AItems[Index].NS_Name(0));
      end;
  end;

begin
  try
    Screen.Cursor := crAppStart;
    GetTempFileName(PChar(g_TempDir), sTempPre, 0, @lpBuffer);
    CoFileName := StrPas(lpBuffer);
    if DownloadFTPFile(PChar(CoFileName), PChar(IncludeTrailingPathDelimiter(APath) + sRemoteFileName), nil) = 0 then
    begin
      FCoProject := TNSProject.Create(Self);
      if not FCoProject.LoadFromFile(CoFileName) then
        FreeAndNil(FCoProject);
      if not FOutProject.LoadFromFile(CoFileName) then
      begin
        FreeAndNil(FOutProject);
        FOutProject := TNSProject.Create(nil);
      end;
    end;

    FOutProject.Items.Clear;
    FOutProject.Items.BeginUpdate;

    if FCoProject <> nil then
    begin
      CoItems := FCoProject.Items;
      FKind := FCoProject.Kind;
      FKindUndefined := False;
    end
    else
    begin
      CoItems := nil;
    end;
    IntScan(FOutProject.Items, CoItems, IncludeTrailingPathDelimiter(APath) + sArchives);
  finally
    FOutProject.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmImportWizard.btnConnectionClick(Sender: TObject);
begin
  case cbMediaType.ItemIndex of
    1: DisplayOptionsDialog(Self, 1);
    2: DisplayOptionsDialog(Self, 3);
  end;
end;

procedure TfrmImportWizard.btnBrowseForNetFolderClick(Sender: TObject);
var
  sFolder: String;
begin
  if DirectoryExists(edtNetPath.Text) then
    sFolder := edtNetPath.Text;
  if SelectDir(sSelectVolumePath, sFolder, rfNetwork) then
    edtNetPath.Text := sFolder;
end;

procedure TfrmImportWizard.UpdateStep;
begin
  btnConnection.Enabled := (cbMediaType.ItemIndex in [1, 2]);

  lblContains.Caption := Format(sFFInfo, [FFiles, FFolders]);
  lblSizeOnMedia.Caption := FormatSize(FSizeOnMedia, True);
  Self.Update;
  Application.ProcessMessages;
end;


function TfrmImportWizard.VerifyArchive: Boolean;
var
  RemoteFolder:  string;
  RemoteArchive: string;
  NASConnection: string;
begin
  Result := False;
  case TBackupMedia(cbMediaType.ItemIndex) of
    bmLocal:
    begin
      RemoteFolder := edtLocalFolder.Text;
      Result := DirectoryExists(RemoteFolder);
      if not Result then
      begin
        MessageBox(Handle,
          PChar(Format(sCannotFindDir, [RemoteFolder])),
          PChar(sError), $00000030);
        Exit;
      end;
      RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder);
      Result := DirectoryExists(RemoteFolder);
      if not Result then
      begin
        MessageBox(Handle,
          PChar(Format(sCannotFindDir, [RemoteFolder])),
          PChar(sError), $00000030);
        Exit;
      end;
      RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
      Result := DirectoryExists(RemoteArchive);
      if not Result then
      begin
        MessageBox(Handle,
          PChar(Format(sCannotFindDir, [RemoteArchive])),
          PChar(sError), $00000030);
        Exit;
      end;
    end;

    bmFTP:
      try
        Result := InitializeFTPSession(g_ConnectType, edtHost.Text, edtUser.Text,
          edtHostPwd.Text, edtPort.Text, g_ProxyName, g_ProxyPort, EmptyStr, EmptyStr, chkPassive.Checked) = 0;
        if not Result then
        begin
          MessageBox(
            Handle,
            GetLastFTPResponse,
            PChar(sError),
            $00000030);
          Exit;
        end;

        RemoteFolder := edtHostDir.Text;
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotFindDir, [RemoteFolder])),
            PChar(sError), $00000030);
          Exit;
        end;

        RemoteFolder := IncludeTrailingPathDelimiter(edtHostDir.Text);
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotFindDir, [RemoteFolder])),
            PChar(sError), $00000030);
          Exit;
        end;
        RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
        Result := FTPDirectoryExists(PChar(RemoteArchive));

        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotFindDir, [RemoteArchive])),
            PChar(sError), $00000030);
          Exit;
        end;
      finally
        FinalizeFTPSession;
      end;
    bmCD:
      try
        FOutProject.CDIndex := cbDrives.ItemIndex;
        Result := FOutProject.InitCDDrive;
        if not Result then
        begin
          MessageBox(
            Handle,
            PChar(SCDNotAvailable),
            PChar(sError),
            $00000030);
          Exit;
        end;
        Result := DiskWriter.CheckDeviceReady;
        if not Result then
        begin
          MessageBox(
            Handle,
            PChar(SCDNotAvailable),
            PChar(sError),
            $00000030);
          Exit;
        end;

        RemoteFolder := IncludeTrailingPathDelimiter(FOutProject.CDDrivePath) + edtCDFolder.Text;
        Result := DirectoryExists(RemoteFolder);
        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotFindDir, [RemoteFolder])),
            PChar(sError), $00000030);
          Exit;
        end;
        RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
        Result := DirectoryExists(RemoteArchive);
        if not Result then
        begin
          MessageBox(Handle,
            PChar(Format(sCannotFindDir, [RemoteArchive])),
            PChar(sError), $00000030);
          Exit;
        end;
      except
        Result := False;
      end;

    bmNAS:
    begin
      RemoteFolder := edtNetPath.Text;
      Result := ConnectToNAS(Handle, RemoteFolder, edtNetUser.Text, edtNetPass.Text, NASConnection);
      if Result then
        try
          Result := DirectoryExists(NASConnection);
          if not Result then
          begin
            MessageBox(Handle, PChar(Format(sCannotFindDir, [RemoteFolder])), PChar(sError), $00000030);
            Exit;
          end;
          RemoteFolder := IncludeTrailingPathDelimiter(NASConnection);
          Result := DirectoryExists(RemoteFolder);
          if not Result then
          begin
            MessageBox(Handle,
              PChar(Format(sCannotFindDir, [RemoteFolder])),
              PChar(sError), $00000030);
            Exit;
          end;
          RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
          Result := DirectoryExists(RemoteArchive);
          if not Result then
          begin
            MessageBox(Handle,
              PChar(Format(sCannotFindDir, [RemoteArchive])),
              PChar(sError), $00000030);
            Exit;
          end;
        finally
          DisconnectNAS(NASConnection);
        end;
    end;

  end;
end;

procedure TfrmImportWizard.SetCurFile(const Value: string);
begin
  pbxFileName.Caption := Value;
end;

procedure TfrmImportWizard.btnCancelClick(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1 then
  begin
    FMustClose  := True;
    ModalResult := mrNone;
  end
  else
    ModalResult := mrCancel;
end;

procedure TfrmImportWizard.cbDrivesChange(Sender: TObject);
begin
  if cbDrives.ItemIndex = -1 then
    Exit;
  DiskWriter.SetActiveRecorder(cbDrives.ItemIndex);
end;

end.
