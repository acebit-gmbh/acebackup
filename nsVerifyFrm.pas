unit nsVerifyFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, nsGlobals, nsTypes, nsUtils,
  abWizardTemplate, WinFTP;

type
  TfrmVerifyWizard = class(TfrmWizardTemplate)
    ts1: TTabSheet;
    pnlWelcome: TPanel;
    Label22: TLabel;
    ts2: TTabSheet;
    ts3: TTabSheet;
    pnlImporting: TPanel;
    Panel9: TPanel;
    pnlFinish: TPanel;
    Panel5: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    aniProgress: TAnimate;
    Label1: TLabel;
    pbxFileName: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    chkShowReport: TCheckBox;
    lblContains: TLabel;
    Label6: TLabel;
    lblSizeOnMedia: TLabel;
    lblConsistent: TLabel;
    lblShowReport: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FOutProject: TNSProject;
    FCoProject: TNSProject;
    FFolders: integer;
    FFiles: integer;
    FSizeOnMedia: int64;
    FMustClose: Boolean;
    FKindUndefined: Boolean;
    procedure GetSettings(AProject: TNSProject);
    procedure SetSettings(AProject: TNSProject);
    function VerifyArchive: Boolean;
    procedure DoScanFolder(const APath: string);
    procedure DoScanFTPDir(const APath: string);
    function DoScan: Boolean;
    procedure UpdateStep;
    procedure SetCurFile(const Value: string);
    procedure CompareProjects;
  protected
    function GoForward: integer; override;
    function GoBack: integer; override;
    procedure UpdateActions; override;
    property CurFile: string write SetCurFile;
  public
    { Public declarations }
  end;

function VerifyProject(AOwner: TForm; const AInpProject: TNSProject; out AOutProject: TNSProject): Boolean;

implementation

uses
  nsOptionsFrm, cdWrapper, nsLogFrm;

{$R *.dfm}

var
  ViewLog: Boolean;

function VerifyProject(AOwner: TForm; const AInpProject: TNSProject; out AOutProject: TNSProject): Boolean;
begin
  with TfrmVerifyWizard.Create(AOwner) do
    try
      FOutProject := TNSProject.Create(AInpProject.Owner);
      FCoProject  := AInpProject;
      FOutProject.Assign(FCoProject);
      GetSettings(FCoProject);
      PageControl.ActivePageIndex := 0;
      UpdateStep;
      if ShowModal = mrOk then
      begin
        SetSettings(FOutProject);
        AOutProject := FOutProject;
        try
          Screen.Cursor := crHourGlass;
          Application.MainForm.Update;
          Result := AOutProject.ReConnect;
          if chkShowReport.Checked then
            DisplayLogDlg(FOutProject);
        finally
          Screen.Cursor := crDefault;
        end;
      end
      else
      begin
        FCoProject.ReConnect;
        FreeAndNil(FOutProject);
        Result := False;
      end;
    finally
      Free;
    end;
end;

procedure TfrmVerifyWizard.FormCreate(Sender: TObject);
begin
  inherited;
  aniProgress.ResName := AVI_PROCESS;
  aniProgress.ResHandle := hInstance;
  aniProgress.Active  := False;
end;

procedure TfrmVerifyWizard.GetSettings(AProject: TNSProject);
begin
end;

function TfrmVerifyWizard.GoBack: integer;
begin
  case PageControl.ActivePageIndex of
    2: Result := 2;
    else
      Result := 1;
  end;
  UpdateStep;
end;

function TfrmVerifyWizard.GoForward: integer;
begin
  Result := 0;
  case PageControl.ActivePageIndex of
    0:
    begin
      Screen.Cursor := crHourGlass;
      try
        if not VerifyArchive then
          Exit;
      finally
        Screen.Cursor := crDefault;
      end;
      DoScan;
    end;
  end;
  UpdateStep;

end;

procedure TfrmVerifyWizard.SetSettings(AProject: TNSProject);
begin
  AProject.DisplayName := FCoProject.DisplayName;
  AProject.Kind := FCoProject.Kind;
  AProject.FileName := FCoProject.FileName;
  AProject.BackupMedia := FCoProject.BackupMedia;
  AProject.LocalFolder := FCoProject.LocalFolder;
  AProject.Port := FCoProject.Port;
  AProject.ProjPwd := FCoProject.ProjPwd;
  AProject.EncryptionMethod := FCoProject.EncryptionMethod;
  AProject.StoreArchivePwd := FCoProject.StoreArchivePwd;
  AProject.DefaultAction := FCoProject.DefaultAction;
  AProject.IncMasks.SetMask(FCoProject.IncMasks.GetMask);
  AProject.ExcMasks.SetMask(FCoProject.ExcMasks.GetMask);
  AProject.UserName := FCoProject.UserName;
  AProject.Password := FCoProject.Password;
  AProject.HostName := FCoProject.HostName;
  AProject.HostDirName := FCoProject.HostDirName;
  AProject.Passive  := FCoProject.Passive;
  AProject.SendLog  := FCoProject.SendLog;
  AProject.CDIndex  := FCoProject.CDIndex;
  AProject.NetPass  := FCoProject.NetPass;
  AProject.NetPath  := FCoProject.NetPath;
  AProject.NetUser  := FCoProject.NetUser;
end;

procedure TfrmVerifyWizard.UpdateActions;
begin
  inherited;
  btnBack.Enabled := PageControl.ActivePageIndex = 2;
  btnNext.Enabled := PageControl.ActivePageIndex <> 1;
end;

procedure TfrmVerifyWizard.DoScanFolder(const APath: string);
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
    try
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
          NewItem.Modified := FileGetModified(sr);
          NewItem.Exists := True;

          CurFile := sr.Name;
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
              NewItem.DefAction := tmpCoItem.DefAction;
            end
            else
            begin
              NewItem.Created := Now;
              FOutProject.LogMsg(Format(sFolderFound, [IncludeTrailingPathDelimiter(ADirectory) + sr.Name]));
              ViewLog := True;
            end;
          end;
          IntScan(NewItem.SubItems, tmpCoItems, IncludeTrailingPathDelimiter(ADirectory) + sr.Name);
        end
        else
        begin
          tmpName := sr.Name;

          tmpPos := AnsiPos(sNsz, tmpName);
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
                NewVersion.Size := tmpCoItem.Versions[tmpVerNo].Size;
                NewVersion.Modified := tmpCoItem.Versions[tmpVerNo].Modified;
              end
              else
              begin
                NewVersion.Size := tmpCoItem.Size;
                NewVersion.Modified := tmpCoItem.Modified;
              end;
            end
            else
            begin
              NewVersion.Size := -1;
              NewVersion.Modified := FileGetModified(sr);
            end;
          end
          else
          begin // not Folder
            Inc(FFiles);
            NewItem := AItems.Add;
            NewItem.IsFolder := False;
            NewItem.Exists := True;
            NewItem.DisplayName := tmpName;
            if tmpMangled then
              NewItem.RemoteName := MangleFileName(tmpName);

            NewItem.SizeOnMedia := FileGetSize(SR);
            NewItem.Versions[0].Number := StrToIntDef(tmpExt, 0);
            if tmpCoItem <> nil then
            begin
              NewItem.LocalPath := tmpCoItem.LocalPath;
              NewItem.Created := tmpCoItem.Created;
              NewItem.BackupItem := tmpCoItem.BackupItem;
              NewItem.DefAction := tmpCoItem.DefAction;
              tmpVerNo := tmpCoItem.IndexOfVersion(NewItem.Versions[0].Number);
              if tmpVerNo > -1 then
              begin
                NewItem.Modified := tmpCoItem.Versions[tmpVerNo].Modified;
                NewItem.Size := tmpCoItem.Versions[tmpVerNo].Size;
              end
              else
              begin
                NewItem.Modified := tmpCoItem.Modified;
                NewItem.Size := tmpCoItem.Size;
              end;
            end
            else
            begin
              NewItem.Modified := FileGetModified(sr);
              NewItem.Size := -1;
              NewItem.LocalPath := EmptyStr;
              NewItem.Created := Now;
              if FCoProject.Kind = pkArchive then
                NewItem.LocalPath := EmptyStr
              else
              begin
                if AItems.GetParentItem <> nil then
                  NewItem.LocalPath :=
                    IncludeTrailingPathDelimiter(AItems.GetParentItem.LocalPath) +
                    AItems.GetParentItem.DisplayName;
                NewItem.BackupItem := True;
                NewItem.Size := FileGetSize(includeTrailingPathDelimiter(NewItem.LocalPath) + NewItem.DisplayName);
              end;

              FOutProject.LogMsg(Format(sFileFound, [IncludeTrailingPathDelimiter(ADirectory) + sr.Name]));
              ViewLog := True;
            end;
          end;
        end;
      until FindNext(sr) <> 0;
    finally
      FindClose(sr);
    end;
  end;

begin
  try
    Screen.Cursor := crAppStart;
    FOutProject.Items.Clear;
    FOutProject.Items.BeginUpdate;
    CoItems := FCoProject.Items;
    IntScan(FOutProject.Items, CoItems, IncludeTrailingPathDelimiter(APath) + sArchives);
  finally
    FOutProject.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

function TfrmVerifyWizard.DoScan: Boolean;
var
  sFolderToScan:  string;
  sNASConnection: string;
begin

  Result := False;
  FFolders := 0;
  FFiles := 0;
  FSizeOnMedia := 0;
  FKindUndefined := True;

  PageControl.ActivePageIndex := 1;
  UpdateActions;

  Update;
  Self.Update;

  ViewLog := False;

  try
    FMustClose := False;

  FOutProject.StartLog;

  Application.ProcessMessages;
  AniProgress.Active := True;
  Self.Update;
  Application.ProcessMessages;
  try

    case FCoProject.BackupMedia of
      bmLocal:
      begin
        sFolderToScan := IncludeTrailingPathDelimiter(FCoProject.LocalFolder) + FCoProject.DisplayName;
        DoScanFolder(sFolderToScan);
      end;
      bmCD:
      begin
        sFolderToScan := IncludeTrailingPathDelimiter(FCoProject.CDDrivePath) + FCoProject.DisplayName;
        DoScanFolder(sFolderToScan);
      end;
      bmFTP:
        try

          InitializeFTPSession(g_ConnectType, FCoProject.HostName,
            FCoProject.UserName, FCoProject.Password, FCoProject.Port,
            g_ProxyName, g_ProxyPort, EmptyStr, EmptyStr, FCoProject.Passive);

          DoScanFTPDir(IncludeTrailingPathDelimiter(FCoProject.HostDirName) + FCoProject.DisplayName);
        finally
          FinalizeFTPSession;
        end;
      bmNAS:
        try
          ConnectToNAS(Handle, FCoProject.NetPath, FCoProject.NetUser, FCoProject.NetPass, sNASConnection);
          sFolderToScan := IncludeTrailingPathDelimiter(sNASConnection) + FCoProject.DisplayName;
          DoScanFolder(sFolderToScan);
        finally
          DisconnectNAS(sNASConnection);
        end;
    end;
  finally
    Self.Update;
    Application.ProcessMessages;
    AniProgress.Active := False;
  end;

  CompareProjects;
  FOutProject.EndLog;

  PageControl.ActivePageIndex := 2;
  UpdateActions;

  lblShowReport.Visible := ViewLog;
  chkShowReport.Visible := ViewLog;
  chkShowReport.Checked := ViewLog;
  lblConsistent.Visible := not lblShowReport.Visible;
  UpdateActions;
  except
    PageControl.ActivePageIndex := 0;
    UpdateActions;
  end;
end;

procedure TfrmVerifyWizard.DoScanFTPDir(const APath: string);
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
    if FTPFindFirst(PChar(IncludeTrailingPathDelimiter(ADirectory) { + sFileMask}), fAttr, sr) <> 0 then
      Exit;
    try
      repeat
        if FMustClose then
          Abort;
        if (sr.Name = sDot) or (sr.Name = sDoubleDot) then
          Continue;
        IsDir := (sr.Attr and faDirectory = faDirectory);
        if not IsDir then
        begin
          tmpName := sr.Name;

          tmpPos := AnsiPos(sNsz, tmpName);
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
          System.Delete(tmpName, tmpPos, 128);

          CurFile := tmpName;
          Application.ProcessMessages;

          if FMustClose then
            Abort;
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
            NewVersion.SizeOnMedia := int64(SR.FindData.nFileSizeHigh) shl int64(32) +
              int64(SR.FindData.nFileSizeLow);
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
                NewVersion.Size := tmpCoItem.Size;
                NewVersion.Modified := tmpCoItem.Modified;
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
            //              NewItem.Versions.Add;
            NewItem.DisplayName := tmpName;
            if tmpMangled then
              NewItem.RemoteName := MangleFileName(tmpName);
            NewItem.SizeOnMedia := int64(SR.FindData.nFileSizeHigh) shl int64(32) + int64(SR.FindData.nFileSizeLow);
            NewItem.Versions[0].Number := StrToIntDef(tmpExt, 0);
            if tmpCoItem <> nil then
            begin
              NewItem.LocalPath := tmpCoItem.LocalPath;
              NewItem.Created := tmpCoItem.Created;
              NewItem.BackupItem := tmpCoItem.BackupItem;
              NewItem.DefAction := tmpCoItem.DefAction;
              tmpVerNo := tmpCoItem.IndexOfVersion(NewItem.Versions[0].Number);
              if tmpVerNo > -1 then
              begin
                NewItem.Modified := tmpCoItem.Versions[tmpVerNo].Modified;
                NewItem.Size := tmpCoItem.Versions[tmpVerNo].Size;
              end
              else
              begin
                NewItem.Modified := tmpCoItem.Modified;
                NewItem.Size := tmpCoItem.Size;
              end;

            end
            else
            begin
              NewItem.Size := -1;
              NewItem.Modified := FileGetModified(sr);
              NewItem.Created := Now;
              FOutProject.LogMsg(Format(sFileFound, [IncludeTrailingPathDelimiter(ADirectory) + sr.Name]));
              ViewLog := True;
              if FCoProject.Kind = pkArchive then
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
          NewItem.Created := Now;
          NewItem.Exists := True;
          NewItem.DisplayName := sr.Name;
          NewItem.Modified := FileGetModified(sr);
          CurFile := sr.Name;
          Application.ProcessMessages;
        end;
      until FTPFindNext(sr) <> 0;
    finally
      FTPFindClose(sr);
    end;
    if FMustClose then
      Abort;
    for Index := AItems.Count - 1 downto 0 do
      if AItems[Index].IsFolder then
      begin
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
          end
          else
          begin
            AItems[Index].Created := Now;
            FOutProject.LogMsg(Format(sFolderFound, [IncludeTrailingPathDelimiter(ADirectory) + sr.Name]));
            ViewLog := True;
          end;
        end;
        IntScan(AItems[Index].SubItems, tmpCoItems, IncludeTrailingPathDelimiter(ADirectory) + AItems[Index].NS_Name(0));
      end;
  end;

begin
  try
    Screen.Cursor := crAppStart;
    FOutProject.Items.Clear;
    FOutProject.Items.BeginUpdate;
    GetTempFileName(PChar(g_TempDir), sTempPre, 0, @lpBuffer);
    CoFileName := StrPas(lpBuffer);
    CoItems := FCoProject.Items;
    IntScan(FOutProject.Items, CoItems, IncludeTrailingPathDelimiter(APath) + sArchives);
  finally
    FOutProject.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmVerifyWizard.btnConnectionClick(Sender: TObject);
begin
  DisplayOptionsDialog(Self, 1);
end;

procedure TfrmVerifyWizard.UpdateStep;
begin
  lblContains.Caption := sContent + #32 + Format(sFFInfo, [FFiles, FFolders]);
  lblSizeOnMedia.Caption := sSizeOnVolume + #32 + FormatSize(FSizeOnMedia, True);
  Application.ProcessMessages;
end;

function TfrmVerifyWizard.VerifyArchive: Boolean;
var
  RemoteFolder:  string;
  RemoteArchive: string;
  NASConnection: string;
begin
  Result := False;
  case FCoProject.BackupMedia of
    bmLocal:
    begin
      RemoteFolder := FCoProject.LocalFolder;

      Result := DirectoryExists(RemoteFolder);
      if not Result then
      begin
        MessageBox(Handle,
          PChar(Format(sCannotFindDir, [RemoteFolder])),
          PChar(sError), $00000030);
        Exit;
      end;
      RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + FCoProject.DisplayName;
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
        FinalizeFTPSession;
        Result := InitializeFTPSession(g_ConnectType, FCoProject.HostName, FCoProject.UserName,
          FCoProject.Password, FCoProject.Port, g_ProxyName, g_ProxyPort, EmptyStr, EmptyStr, FCoProject.Passive) = 0;

        RemoteFolder := FCoProject.HostDirName;
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(Handle, PChar(Format(sCouldNotFindDir, [RemoteFolder])), PChar(sError), $00000030);
          Exit;
        end;

        RemoteFolder := IncludeTrailingPathDelimiter(FCoProject.HostDirName) + FCoProject.DisplayName;
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(Handle, PChar(Format(sCouldNotFindDir, [RemoteFolder])), PChar(sError), $00000030);
          Exit;
        end;
        RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
        Result := FTPDirectoryExists(PChar(RemoteArchive));

        if not Result then
        begin
          MessageBox(Handle, PChar(Format(sCouldNotFindDir, [RemoteArchive])), PChar(sError), $00000030);
          Exit;
        end;
      finally
        FinalizeFTPSession;
      end;
    bmCD:
      try
        Result := FCoProject.InitCDDrive;
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

        RemoteFolder := IncludeTrailingPathDelimiter(FCoProject.CDDrivePath) + FCoProject.DisplayName;
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
      RemoteFolder := FCoProject.NetPath;
      Result := ConnectToNAS(Handle, RemoteFolder, FCoProject.NetUser, FCoProject.NetPass, NASConnection);

      if Result then
        try
          Result := DirectoryExists(NASConnection);
          if not Result then
          begin
            MessageBox(Handle, PChar(Format(sCannotFindDir, [RemoteFolder])), PChar(sError), $00000030);
            Exit;
          end;
          RemoteFolder := IncludeTrailingPathDelimiter(NASConnection) + FCoProject.DisplayName;
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

procedure TfrmVerifyWizard.btnCancelClick(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1 then
  begin
    FMustClose := True;
    ModalResult := mrNone;
  end
  else
    ModalResult := mrCancel;
end;

procedure TfrmVerifyWizard.SetCurFile(const Value: string);
begin
  pbxFileName.Caption := Value;
end;

procedure TfrmVerifyWizard.CompareProjects;

  procedure IntCompare(const AItems1, AItems2: TNSCollection);
  var
    Index:  integer;
    CurItem: TNSItem;
    CoItem: TNSItem;
  begin
    for Index := 0 to AItems1.Count - 1 do
    begin
      CurItem := AItems1.Items[Index];
      CoItem  := AItems2.FindItem(CurItem.FDisplayName);
      if CoItem = nil then
      begin
        ViewLog := True;
        if CurItem.IsFolder then
          FOutProject.LogMsg(Format(sNotFoundOnBackUpFolder, [CurItem.GetPathOnMedia + CurItem.DisplayName]))
        else
          FOutProject.LogMsg(Format(sNotFoundOnBackUpFile, [CurItem.GetPathOnMedia + CurItem.DisplayName]));
      end
      else
      begin
        if CurItem.IsFolder then
          IntCompare(CurItem.SubItems, CoItem.SubItems);
      end;
    end;
  end;

begin
  IntCompare(FCoProject.Items, FOutProject.Items);
end;

end.
