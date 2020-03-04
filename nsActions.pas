unit nsActions;

interface

uses
  Windows, Messages, SysUtils, ShellAPI, ShlObj, ActiveX, Forms, Dialogs,
  Classes, Controls, nsGlobals, nsTypes, nsUtils, nsProcessFrm, DateUtils,
  IdBaseComponent, IdTCPConnection, IdSSLOpenSSL, IdSMTP, IdMessage, WinFTP;

type
  TNSOnErrorEvent = procedure(Sender: TObject; AProject: TNSItem; AItem: TNSItem) of object;
  TNSOnProgressEvent = procedure(Sender: TObject; AProject: TNSItem; AItem: TNSItem) of object;

  TNSOnVerifyEvent = procedure(Sender: TObject; AOperation: TOperation; const AName: string) of object;

  TProjectVerifier = class(TComponent)
  private
    FHandle: THandle;
    FMainProject: TNSProject;
    FProjectExists: Boolean;
    FCoProject: TNSProject;
    FOnVerifyEvent: TNSOnVerifyEvent;
    FOnDone: TNotifyEvent;
    FDirsCount: integer;
    FFilesCount: integer;
    FTempFileName: string;
    //    FKindUndefined: Boolean;
    //    FKind: TProjectKind;
    FMustClose: Boolean;
    FSizeOnMedia: integer;
  protected
    function InitMedia: Boolean;
    procedure DoVerify(AOperation: TOperation; const AName: string);
  public
    constructor Create(AOwner: TComponent); override;
    function Initialize(AInputProject: TNSProject; AExists: Boolean): Boolean;
    procedure Stop;

    property FilesCount: integer read FFilesCount;
    property DirsCount: integer read FDirsCount;
    property SizeOnMedia: integer read FSizeOnMedia;
  published
    property OnDone: TNotifyEvent read FOnDone write FOnDone;
    property OnVerifyEvent: TNSOnVerifyEvent read FOnVerifyEvent write FOnVerifyEvent;
  end;


procedure SendReport(const AProject: TNSProject);
procedure ChangeDefAction(const ARootItem: TNSItem; const ADefAction: TDefaultAction);
function MarkNormal(AItem: TNSItem): Boolean;

function g_AddFilesCallback(const ACode: longint; const AMessage: string): longint;
function g_AddFilesDummy(const ACode: longint; const AMessage: string): longint;
function g_AddFilesWizard(const ACode: longint; const AMessage: string): longint;


procedure InsertItemsToProject(const AProject: TNSProject; const AItems: TStrings;
  const ATarget: TNSCollection; const ATag: integer = 0);

procedure MarkItemForDeletion(const AProject: TNSProject; var AItem: TNSItem; var NeedRebuild: Boolean);
function ProcessProject(const AProject: TNSProject; const AOperation: TCheckState): integer;
procedure SynchronizeProject(const AProject: TNSProject; const AItems: TNSCollection;
  const AScheduled: Boolean = False);
procedure AssignVolumes(const ASource: TNSProject; const ADest: TNSProject);

implementation

uses
  nsMainFrm, nsSplashScan, abBackupWizard, cdWrapper;

var
  lpBuffer: array[0..MAX_PATH] of char;


procedure AssignVolumes(const ASource: TNSProject; const ADest: TNSProject);
var
  Index:  integer;
  SrcVol: TNSProject;
  DstVol: TNSProject;
begin
  // First we force ASource and ADest to have the same VolumeCount;
  if ASource.VolumeCount > ADest.VolumeCount then
    for Index := ADest.VolumeCount to ASource.VolumeCount - 1 do
      ADest.AddVolume
  else if ASource.VolumeCount < ADest.VolumeCount then
    for Index := ADest.VolumeCount - 1 downto ASource.VolumeCount do
      ADest.DeleteVolume(Index);

  // Now we assign media settings
  for Index := 0 to ASource.VolumeCount - 1 do
  begin
    SrcVol := ASource.Volumes[Index];
    DstVol := ADest.Volumes[Index];

    DstVol.BackupMedia := SrcVol.BackupMedia;
    DstVol.LocalFolder := SrcVol.LocalFolder;
    DstVol.HostName := SrcVol.HostName;
    DstVol.HostDirName := SrcVol.HostDirName;
    DstVol.Port := SrcVol.Port;
    DstVol.UserName := SrcVol.UserName;
    DstVol.Password := SrcVol.Password;
    DstVol.Passive := SrcVol.Passive;
    DstVol.AutoDialUp := SrcVol.AutoDialUp;
    DstVol.HangUpOnCompleted := SrcVol.HangUpOnCompleted;
    DstVol.LastRunTime := SrcVol.LastRunTime;
    DstVol.CDIndex := SrcVol.CDIndex;
    DstVol.CDErase := SrcVol.CDErase;

    DstVol.NetPath := SrcVol.NetPath;
    DstVol.NetPass := SrcVol.NetPass;
    DstVol.NetUser := SrcVol.NetUser;

  end;

  ADest.EncryptionMethod := ASource.EncryptionMethod;
  ADest.ProjPwd := ASource.ProjPwd;
  ADest.StoreArchivePwd := ASource.StoreArchivePwd;
  ADest.FileFormat := ASource.FileFormat;

end;

function g_AddFilesCallback(const ACode: longint; const AMessage: string): longint;
begin
  case ACode of
    CMD_STARTSCAN:
    begin
      g_AbortScan := False;
      if frmScanner = nil then
        frmScanner := TfrmScanner.Create(Application);
      frmScanner.Show;
      frmScanner.Update;
      SetForegroundWindow(frmScanner.Handle);
      Application.MainForm.Enabled := False;
    end;
    CMD_ENDSCAN:
    begin
      Application.MainForm.Enabled := True;
      frmScanner.Hide;
      FreeAndNil(frmScanner);
    end;
    CMD_UPDATE:
    begin
      Application.MainForm.Update;
      Application.ProcessMessages;
      frmScanner.CurFile := AMessage;
    end;
  end;
  if g_AbortScan then
    Result := CMD_ABORT
  else
    Result := CMD_OK;
end;

function g_AddFilesWizard(const ACode: longint; const AMessage: string): longint;
begin
  case ACode of
    CMD_STARTSCAN:
    begin
      g_AbortScan := False;
    end;
    CMD_ENDSCAN:
    begin
    end;
    CMD_UPDATE:
    begin
      Application.ProcessMessages;
      frmBackupWizard.CurFile := AMessage;
    end;
  end;
  if g_AbortScan then
    Result := CMD_ABORT
  else
    Result := CMD_OK;
end;


function g_AddFilesDummy(const ACode: longint; const AMessage: string): longint;
begin
  if g_AbortScan then
    Result := CMD_ABORT
  else
    Result := CMD_OK;
end;



procedure ChangeDefAction(const ARootItem: TNSItem; const ADefAction: TDefaultAction);

  procedure ChangeSubItems(const ACollection: TNSCollection);
  var
    CurItem: TNSItem;
    Index: integer;
  begin
    for Index := 0 to ACollection.Count - 1 do
    begin
      CurItem := ACollection.Items[Index];
      CurItem.DefAction := ADefAction;
      if CurItem.IsFolder then
        ChangeSubItems(CurItem.SubItems);
    end;
  end;

var
  Index:  integer;
  Volume: TNSProject;
begin
  if (ARootItem <> nil) and ARootItem.IsFolder then
    ChangeSubItems(ARootItem.SubItems)
  else
  begin
    for Index := 0 to CurProject.VolumeCount - 1 do
    begin
      Volume := CurProject.Volumes[Index];
      Volume.DefaultAction := ADefAction;
      ChangeSubItems(Volume.Items);
    end;
  end;
end;


procedure MarkDelete(AItem: TNSItem);

  procedure ScanSubItems(ACollection: TNSCollection);
  var
    Index: integer;
    CItem: TNSItem;
  begin
    for Index := 0 to ACollection.Count - 1 do
    begin
      CItem := ACollection.Items[Index];
      CItem.State := isDelete;
      if CItem.IsFolder then
        ScanSubItems(CItem.SubItems);
      CItem.NotProcessed := True;
    end;
  end;

begin
  if AItem = nil then
    ScanSubItems(CurProject.Items)
  else
  begin
    if AItem.IsFolder then
      ScanSubItems(AItem.SubItems);
    AItem.State := isDelete;
    AItem.NotProcessed := True;
  end;
end;

function MarkNormal(AItem: TNSItem): Boolean;

  function ScanSubItems(ACollection: TNSCollection): Boolean;
  var
    Index: integer;
    CItem: TNSItem;
  begin
    Result := True;
    for Index := 0 to ACollection.Count - 1 do
    begin
      CItem := ACollection.Items[Index];
      if not CItem.Exists then
      begin
        Result := False;
        if CItem.State = isDelete then
          CItem.State := isBackup;
        Continue;
      end;
      CItem.State := isNormal;
      if CItem.IsFolder then
        Result := Result and ScanSubItems(CItem.SubItems);
      if Result then
        CItem.NotProcessed := False;
    end;
  end;

begin
  Result := True;
  if AItem = nil then
    Result := Result and ScanSubItems(CurProject.Items)
  else
  begin
    if AItem.Exists then
    begin
      AItem.State := isNormal;
      if AItem.IsFolder then
        Result := Result and ScanSubItems(AItem.SubItems);
      if Result then
        AItem.NotProcessed := False;
    end
    else
    begin
      if AItem.State = isDelete then
      begin
        if AItem.IsFolder then
          AItem.State := isNormal
        else
          AItem.State := isBackup;
      end;
      Result := False;
    end;
  end;
end;

function MarkRestore(AItem: TNSItem; var AFailed: integer): Boolean;

  function ScanSubItems(ACollection: TNSCollection): Boolean;
  var
    Index: integer;
    CItem: TNSItem;
  begin
    Result := True;
    for Index := 0 to ACollection.Count - 1 do
    begin
      CItem := ACollection.Items[Index];
      if not CItem.Exists then
      begin
        Inc(AFailed);
        Continue;
      end;

      if CItem.IsFolder then
        Result := Result and ScanSubItems(CItem.SubItems)
      else
      begin
        Result := Result and (CItem.LocalPath <> EmptyStr);
        CItem.State := isRestore;
      end;
      CItem.NotProcessed := True;
      CItem.DestFolder := EmptyStr;
    end;
  end;

begin
  Result := True;
  if AItem = nil then
    Result := Result and ScanSubItems(CurProject.Items)
  else
  begin
    if AItem.Exists then
    begin
      if AItem.IsFolder then
        Result := ScanSubItems(AItem.SubItems)
      else
      begin
        Result := AItem.LocalPath <> EmptyStr;
        if Result then
        begin
          AItem.State := isRestore;
          frmMain.acProcessRestore.Enabled := True;
        end;
      end;
      AItem.NotProcessed := True;
    end
    else
      Inc(AFailed);
  end;
end;

procedure MarkRestoreTo(AItem: TNSItem; const ADest: string);
var
  tmpDest: string;

  procedure ScanSubItems(ACollection: TNSCollection; const ADestFolder: string);
  var
    Index: integer;
    CItem: TNSItem;
    sDest: string;
  begin
    for Index := 0 to ACollection.Count - 1 do
    begin
      CItem := ACollection.Items[Index];
      if CItem.IsFolder then
      begin
        if ExtractFileDrive(CItem.DisplayName) <> EmptyStr then
          sDest := IncludeTrailingPathDelimiter(ADestFolder)
        else
          sDest := IncludeTrailingPathDelimiter(ADestFolder) + CItem.DisplayName;
        ScanSubItems(CItem.SubItems, sDest);
      end
      else
      begin
        CItem.DestFolder := ADestFolder;
        CItem.State := isRestore;
      end;
      CItem.NotProcessed := True;
      NSChangeNotify(0,
        NSN_STATUSCHANGED,
        NSN_FLUSHNOWAIT,
        nil,
        CItem);
    end;
  end;

begin
  if AItem = nil then
  begin
    tmpDest := IncludeTrailingPathDelimiter(ADest);
    ScanSubItems(CurProject.Items, tmpDest);
  end
  else
  begin
    if AItem.IsFolder then
    begin
      if ExtractFileDrive(AItem.DisplayName) <> EmptyStr then
        tmpDest := IncludeTrailingPathDelimiter(ADest)
      else
        tmpDest := IncludeTrailingPathDelimiter(ADest) + AItem.DisplayName;
      ScanSubItems(AItem.SubItems, tmpDest);
    end
    else
    begin
      AItem.DestFolder := ADest;
      AItem.State := isRestore;
    end;
    AItem.NotProcessed := True;
    NSChangeNotify(0,
      NSN_STATUSCHANGED,
      NSN_FLUSHNOWAIT,
      nil,
      AItem);
  end;
end;

procedure SendReport(const AProject: TNSProject);
var
  SMTP: TIdSMTP;
  Msg: TIdMessage;
  IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  Index: integer;
  Volume: TNSProject;
  Strs: TStrings;
  J: integer;
  S: string;
begin
  try
    SMTP := TIdSMTP.Create(Application.MainForm);
    IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application.MainForm);
    try
      IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := g_SSLVersion;

      Msg := TIdMessage.Create(SMTP);
      with Msg do
      begin
        Subject := Format(sReportFrom, [AProject.DisplayName, DateTimeToStr(Now)]);
        Recipients.EMailAddresses := g_RecipEMail;

        From.Name := g_SenderName;
        From.Address := g_SenderEMail;

        for Index := 0 to AProject.VolumeCount - 1 do
        begin
          Volume := AProject.Volumes[Index];
          Strs := Volume.GetLog;

          for J := 0 to Strs.Count - 1 do
          begin
            S := Strs[J];
            if AProject.SendMailContect = mcFailed then
              if (S = EmptyStr) or (S[1] = #1) then
                Continue;
            Body.Add(Trim(S));
          end;

        end;
      end;
      with SMTP do
      begin

        if g_UseSSL then
        begin
          IOHandler := IdSSLIOHandlerSocketOpenSSL;
          UseTLS := g_UseTLS;
        end;

        Host := g_SMTPServer;
        Port := g_SMTPPort;

        if (g_AuthenticationType <> satNone) then
        begin
          UserName := g_SMTPAccount;
          Password := g_SMTPPassword;
          AuthType := g_AuthenticationType;
        end;


        Connect;
        try
          Send(Msg);
        finally
          Disconnect;
        end;
      end;
    finally
      SMTP.Free;
      IdSSLIOHandlerSocketOpenSSL.Free;
    end;
  except
    on E: Exception do
      if Application.ShowMainForm then
        MessageBox(GetActiveWindow, PChar(sErrorSendingEmail + #32 + E.Message), PChar(Application.Title),
          MB_ICONWARNING or MB_OK);
  end;
end;

procedure InsertItemToVolume(const AVolume: TNSProject; const ASearchRec: TSearchRec;
  const ADestPath: string; const ALocalPath: string; const ACallBack: TAddFilesCallback);
var
  Root: TNSCollection;
  sDestPath: string;

  procedure InternalInsertFile(const ASR: TSearchRec; const ADestinationItems: TNSCollection;
  const AOriginalPath: string);
  var
    xTime: TDateTime;
    xItem: TNSItem;
    xPath: string;
  begin
    if not AVolume.IsValidExt(ASR.Name) then
      Exit;

    xTime := FileGetModified(ASR);
    xPath := IncludeTrailingPathDelimiter(AOriginalPath) + ASR.Name;
    if AnsiPos(sDestPath, xPath) = 1 then
      Exit;
    if ACallBack(CMD_UPDATE, xPath) = CMD_Abort then
      Abort;
    xItem := ADestinationItems.FindItem(ASR.Name);
    if xItem <> nil then
    begin // the item exists already
      case xItem.DefAction of
        daReplace:
        begin
          xItem.State := isBackupReplace;
          xItem.NotProcessed := True;
          xItem.UModified := xTime;
          xItem.USize := FileGetSize(ASR);
        end;
        daUpdate:
        begin
          if CompareDateTime(xItem.Modified, xTime) < 0 then
          begin
            xItem.State := isBackupUpdate;
            xItem.NotProcessed := True;
            xItem.UModified := xTime;
            xItem.USize := FileGetSize(ASR);
          end;
        end;
        daNewVersion:
        begin
          // See http://www.acebit-bugtracker.com/view_bug_page.php?f_id=0000255
          if CompareDateTime(xItem.Modified, xTime) < 0 then
          begin
            xItem.State := isBackupNewVersion;
            xItem.NotProcessed := True;
            xItem.UModified := xTime;
            xItem.USize := FileGetSize(ASR);
          end;
        end;
      end;
    end
    else
    begin // no such item
      xItem := ADestinationItems.Add;
      xItem.IsFolder := False;
      xItem.DisplayName := ASR.Name;
      xItem.LocalPath := AOriginalPath;
      xItem.BackupItem := True;
      xItem.State := isBackup;
      xItem.Created := Now;
      xItem.UModified := xTime;
      xItem.USize := FileGetSize(ASR);
      xItem.NotProcessed := True;
      xItem.Exists := False;
    end;
  end;

  procedure InternalInsertFolder(const ASR: TSearchRec; const ADestinationItems: TNSCollection;
  const AOriginalPath: string);
  var
    xItem: TNSItem;
    FoundRec: TSearchRec;
    xPath: string;
  begin
    xPath := IncludeTrailingPathDelimiter(AOriginalPath) + ASR.Name;
    if AnsiPos(sDestPath, xPath) = 1 then
      Exit;
    if ACallBack(CMD_UPDATE, xPath) = CMD_Abort then
      Abort;

    xItem := ADestinationItems.FindItem(ASR.Name);
    if xItem = nil then
    begin // no such item
      xItem := ADestinationItems.Add;
      xItem.IsFolder := True;
      xItem.DisplayName := ASR.Name;
      xItem.BackupItem := True;
      xItem.Created := Now;
      xItem.UModified := Now;
      xItem.NotProcessed := True;
      xItem.Exists := False;
    end; // no such item

    // Now scan the folder
    if FindFirst(IncludeTrailingPathDelimiter(xPath) + sFileMask, faAnyFile, FoundRec) <> 0 then
      Exit;
    repeat
      if (FoundRec.Name = sDot) or (FoundRec.Name = sDoubleDot) then
        Continue;
      if (FoundRec.Attr and faDirectory = faDirectory) then
      begin // Directory found
        InternalInsertFolder(FoundRec, xItem.SubItems, xPath);
      end
      else
      begin // File found
        InternalInsertFile(FoundRec, xItem.SubItems, xPath);
      end;
    until FindNext(FoundRec) <> 0;
    FindClose(FoundRec);
  end;

begin

  sDestPath := IncludeTrailingPathDelimiter(AVolume.LocalFolder) + AVolume.DisplayName;
  if AnsiPos(sDestPath, IncludeTrailingPathDelimiter(ALocalPath) + ASearchRec.Name) = 1 then
    Exit;
  Root := AVolume.ForceCollection(ADestPath);
  Root.BeginUpdate;
  try
    if ASearchRec.Attr and faDirectory = faDirectory then
    begin // AItemName is directory
      InternalInsertFolder(ASearchRec, Root, ALocalPath);
    end // AItemName is directory
    else
    begin // AItemName is file
      InternalInsertFile(ASearchRec, Root, ALocalPath);
    end; // AItemName is file
  finally
    Root.EndUpdate;
  end;
end;

function CheckDestination(const AProject: TNSProject; const ASourceItem: string): Boolean;
var
  sPath:  string;
  Index:  integer;
  Volume: TNSProject;
begin
  Result := False;
  for Index := 0 to AProject.VolumeCount - 1 do
  begin
    Volume := AProject.Volumes[Index];
    if Volume.BackupMedia = bmLocal then
    begin
      sPath := IncludeTrailingPathDelimiter(Volume.LocalFolder) + AProject.DisplayName;
      if AnsiPos(sPath, ASourceItem) = 1 then
        Exit;
    end;
  end;
  Result := True;
end;

procedure InsertItemsToProject(const AProject: TNSProject; const AItems: TStrings;
  const ATarget: TNSCollection; const ATag: integer = 0);
var
  SR: TSearchRec;
  sPath: string;
  Index: integer;
  sItemName: string;
  MainVolume: TNSProject;
  VolNo: integer;
  SyncVolume: TNSProject;
  IsDiskOrMachine: Boolean;
  CallBack: TAddFilesCallback;
begin
  case ATag of
    1: CallBack := g_AddFilesDummy;
    2: CallBack := g_AddFilesWizard;
    else
      CallBack := g_AddFilesCallback;
  end;

  CallBack(CMD_STARTSCAN, EmptyStr);
  try
    MainVolume := AProject.ActiveVolume;
    AItems.BeginUpdate;
    try
      for Index := 0 to AItems.Count - 1 do
      begin
        sItemName := ExcludeTrailingPathDelimiter(AItems[Index]);
        if not CheckDestination(AProject, sItemName) then
        begin
          case MessageDlg(Format(SCannotAddToProject, [sItemName]), mtError, [mbAbort, mbIgnore], 0) of
            mrAbort: Abort;
            mrIgnore: Continue;
          end;
        end;

        IsDiskOrMachine := ExtractFileDrive(sItemName) = sItemName;

        FillChar(SR, SizeOf(TSearchRec), #0);

        if IsDiskOrMachine then
        begin
          if FindFirst(IncludeTrailingPathDelimiter(sItemName) + sFileMask, faAnyFile, SR) <> 0 then
            Continue;
        end
        else
        begin
          if FindFirst(sItemName, faAnyFile, SR) <> 0 then
            Continue;
        end;

        try
          if (AProject.Kind = pkArchive) and (ATarget <> nil) then
            sPath := ATarget.GetPath
          else
            sPath := MainVolume.NormalizePath(ExtractFilePath(sItemName));

          if CallBack(CMD_UPDATE, sItemName) = CMD_Abort then
            Abort;

          if IsDiskOrMachine then
            repeat
              if (SR.Name = sDot) or (SR.Name = sDoubleDot) then
                Continue;
              InsertItemToVolume(MainVolume, SR, sPath, sItemName, CallBack);
              if AProject.SyncMode = smSynchronized then
                for VolNo := 0 to AProject.VolumeCount - 1 do
                begin
                  SyncVolume := AProject.Volumes[VolNo];
                  if SyncVolume <> MainVolume then
                    InsertItemToVolume(SyncVolume, SR, sPath, ExtractFilePath(ExtractFilePath(sItemName)),
                      g_AddFilesDummy);
                end;
            until FindNext(SR) <> 0
          else
          begin
            InsertItemToVolume(MainVolume, SR, sPath, ExtractFilePath(ExtractFilePath(sItemName)), CallBack);
            if AProject.SyncMode = smSynchronized then
              for VolNo := 0 to AProject.VolumeCount - 1 do
              begin
                SyncVolume := AProject.Volumes[VolNo];
                if SyncVolume <> MainVolume then
                  InsertItemToVolume(SyncVolume, SR, sPath, ExtractFilePath(ExtractFilePath(sItemName)),
                    g_AddFilesDummy);
              end;
          end;
        finally
          FindClose(SR);
        end;
      end;
    finally
      AItems.EndUpdate;
    end;
  finally
    AProject.WasModified := True;
    CallBack(CMD_ENDSCAN, EmptyStr);
  end;
end;

procedure MarkItemForDeletion(const AProject: TNSProject; var AItem: TNSItem; var NeedRebuild: Boolean);
var
  MainVolume: TNSProject;
  VolNo: integer;
  SyncVolume: TNSProject;
  sPath: string;
  xCollection: TNSCollection;
  xItem: TNSItem;
  xDisplayName: string;

  procedure InternalScanFolder(const ACollection: TNSCollection);
  var
    Index: integer;
    ColItem: TNSItem;
  begin
    ACollection.BeginUpdate;
    try
      for Index := ACollection.Count - 1 downto 0 do
      begin
        ColItem := ACollection.Items[Index];
        if ColItem.Exists then
        begin
          ColItem.NotProcessed := True;
          ColItem.State := isDelete;
          if ColItem.IsFolder then
            InternalScanFolder(ColItem.SubItems);
        end
        else
        begin
          FreeAndNil(ColItem);
          NeedRebuild := True;
        end;
      end;
    finally
      ACollection.EndUpdate;
    end;
  end;

begin
  MainVolume := AProject.ActiveVolume;
  if AItem <> nil then
  begin
    sPath := TNSCollection(AItem.Collection).GetPath;
    xDisplayName := AItem.FDisplayName;
    if AItem.Exists then
    begin
      AItem.State := isDelete;
      AItem.NotProcessed := True;
      if AItem.IsFolder then
        InternalScanFolder(AItem.SubItems);
    end
    else
    begin
      FreeAndNil(AItem);
      NeedRebuild := True;
    end;
  end
  else
  begin
    InternalScanFolder(MainVolume.Items);
  end;

  if AProject.SyncMode = smSynchronized then
  begin
    for VolNo := 0 to AProject.VolumeCount - 1 do
    begin
      SyncVolume := AProject.Volumes[VolNo];
      if SyncVolume <> MainVolume then
      begin
        if sPath <> EmptyStr then
        begin
          xCollection := SyncVolume.FindCollection(sPath);
          if xCollection = nil then
            Continue;
          xItem := xCollection.FindItem(xDisplayName);
          if xItem <> nil then
          begin
            if xItem.Exists then
            begin
              xItem.State := isDelete;
              xItem.NotProcessed := True;
              if xItem.IsFolder then
                InternalScanFolder(xItem.SubItems);
            end
            else
            begin
              FreeAndNil(xItem);
              NeedRebuild := True;
            end;
          end;
        end
        else
        begin
          InternalScanFolder(SyncVolume.Items);
        end;
      end;
    end;
  end;
end;

//  TCheckState = (csAll, csDelete, csRestore, csBackup);

function ProcessProject(const AProject: TNSProject; const AOperation: TCheckState): integer;
var
  MainVolume: TNSProject;
  VolNo: integer;
  SyncVolume: TNSProject;
  ProcessCount: integer;
  VolCount: integer;
  InitMedia: Boolean;
  ProcessSize: int64;
  tmpSize: int64;
begin
  g_AbortProcess := False;

  MainVolume := AProject.ActiveVolume;
  if AProject.SyncMode = smSynchronized then
  begin
    ProcessCount := 0;
    ProcessSize  := 0;
    for VolNo := 0 to AProject.VolumeCount - 1 do
    begin
      case AOperation of
        csDelete: ProcessCount  := ProcessCount + AProject.Volumes[VolNo].GetDeleteCount(tmpSize);
        csRestore: ProcessCount := ProcessCount + AProject.Volumes[VolNo].GetRestoreCount(tmpSize);
        csBackup: ProcessCount  := ProcessCount + AProject.Volumes[VolNo].GetBackupCount(tmpSize);
        else
          ProcessCount := ProcessCount + AProject.Volumes[VolNo].GetNonProcCount(tmpSize);
      end;
      ProcessSize := ProcessSize + tmpSize;
    end;
  end
  else
  begin
    case AOperation of
      csDelete: ProcessCount  := MainVolume.GetDeleteCount(ProcessSize);
      csRestore: ProcessCount := MainVolume.GetRestoreCount(ProcessSize);
      csBackup: ProcessCount  := MainVolume.GetBackupCount(ProcessSize);
      else
        ProcessCount := MainVolume.GetNonProcCount(ProcessSize);
    end;
  end;

  Result := ProcessCount div 2;

  if MainVolume.FProgress <> nil then
    with MainVolume.FProgress do
    begin
      Initialize(ProcessSize);
      Caption := Format(sProcessing, [MainVolume.DisplayName]);
      CurAction := sPrep;
      Application.MainForm.Enabled := False;
      Show;
    end;

  try
    if MainVolume.FProgress <> nil then
      PlaySoundEvent(SProcessStartSound);

    if AProject.SyncMode = smSynchronized then
    begin // Synchronized
      for VolNo := 0 to AProject.VolumeCount - 1 do
      begin
        SyncVolume := AProject.Volumes[VolNo];
        SyncVolume.StartLog;
        case AOperation of
          csDelete:
          begin
            VolCount := SyncVolume.GetDeleteCount(tmpSize);
            if VolCount > 0 then
              try
                if SyncVolume.ConnectToMedia(GetActiveWindow) then
                begin
                  InitMedia := SyncVolume.InitializeMedia(csDelete);
                  if InitMedia then
                  begin
                    SyncVolume.ProcessDelete;
                    SyncVolume.FinalizeMedia;
                  end;
                end;
              except
                SyncVolume.EndLog;
                Continue;
              end;
          end;
          csRestore:
          begin
            if (SyncVolume = MainVolume) and (SyncVolume.GetRestoreCount(tmpSize) > 0) then
              try
                if SyncVolume.ConnectToMedia(GetActiveWindow) then
                begin
                  SyncVolume.ReInitCrypting;
                  InitMedia := SyncVolume.InitializeMedia(csRestore);
                  if InitMedia then
                  begin
                    SyncVolume.ProcessRestore;
                    SyncVolume.FinalizeMedia;
                  end;
                end;
              except
                SyncVolume.EndLog;
                Continue;
              end;
          end;
          csBackup:
          begin
            VolCount := SyncVolume.GetBackupCount(tmpSize);
            if VolCount > 0 then
              try
                if SyncVolume.ConnectToMedia(GetActiveWindow) then
                begin
                  SyncVolume.ReInitCrypting;
                  InitMedia := SyncVolume.InitializeMedia(csBackup);
                  if InitMedia then
                  begin
                    SyncVolume.ProcessBackup;
                    SyncVolume.FinalizeMedia;
                  end;
                end;
              except
                SyncVolume.EndLog;
                Continue;
              end;
          end;
          csAll:
          begin
            VolCount := SyncVolume.GetNonProcCount(tmpSize);
            if VolCount > 0 then
              try
                if SyncVolume.ConnectToMedia(GetActiveWindow) then
                begin
                  SyncVolume.ReInitCrypting;
                  InitMedia := SyncVolume.InitializeMedia(csAll);
                  if InitMedia then
                  begin
                    SyncVolume.ProcessBackup;
                    SyncVolume.ProcessDelete;
                  end;
                  SyncVolume.ProcessRestore;
                  if InitMedia then
                    SyncVolume.FinalizeMedia;
                end;
              except
                SyncVolume.EndLog;
                Continue;
              end;
          end;
        end;
        SyncVolume.EndLog;
      end;
    end // Synchronized
    else
    begin // Independent
      MainVolume.StartLog;
      case AOperation of
        csDelete:
        begin
          InitMedia := MainVolume.InitializeMedia(csDelete);
          if InitMedia then
          begin
            MainVolume.ProcessDelete;
            MainVolume.FinalizeMedia;
          end;
        end;
        csRestore:
        begin
          MainVolume.ReInitCrypting;
          InitMedia := MainVolume.InitializeMedia(csRestore);
          if InitMedia then
          begin
            MainVolume.ProcessRestore;
            MainVolume.FinalizeMedia;
          end;
        end;
        csBackup:
        begin
          MainVolume.ReInitCrypting;
          InitMedia := MainVolume.InitializeMedia(csBackup);
          if InitMedia then
          begin
            MainVolume.ProcessBackup;
            MainVolume.FinalizeMedia;
          end;
        end;
        csAll:
        begin
          MainVolume.ReInitCrypting;
          InitMedia := MainVolume.InitializeMedia(csAll);
          if InitMedia then
          begin
            MainVolume.ProcessBackup;
            MainVolume.ProcessDelete;
          end;
          MainVolume.ProcessRestore;
          if InitMedia then
            MainVolume.FinalizeMedia;
        end;
      end;
      MainVolume.EndLog;
    end;

    AProject.WasModified := True;
    if MainVolume.FProgress <> nil then
      PlaySoundEvent(SProcessCompletedSound);
  finally
    if MainVolume.FProgress <> nil then
    begin
      Application.MainForm.Enabled := True;
      MainVolume.FProgress.Hide;
    end;
  end;
end;

procedure SynchronizeProject(const AProject: TNSProject; const AItems: TNSCollection;
  const AScheduled: Boolean = False);
var
  MainVolume: TNSProject;
  VolNo:  integer;
  SyncVolume: TNSProject;
  xItems: TNSCollection;
  xPath:  string;

  procedure SynchronizeItem(const AItem: TNSItem);
  var
    xItem: TNSItem;
    SR: TSearchRec;
    sPath: string;
    xTime: TDateTime;
  begin
    if AItem.IsFolder then
    begin // Backup Folder
      if AItem.LocalPath <> EmptyStr then
        sPath := IncludeTrailingPathDelimiter(AItem.LocalPath)
      else
        sPath := EmptyStr;

      sPath := IncludeTrailingPathDelimiter(sPath + AItem.DisplayName) + sFileMask;
      if FindFirst(sPath, faAnyFile, SR) <> 0 then
      begin
        AItem.Free;
        Exit;
      end;
      repeat
        if (SR.Name = sDot) or (SR.Name = sDoubleDot) then
          Continue;
        if (SR.Attr and faDirectory <> faDirectory) then
          if not AProject.IsValidExt(SR.Name) then
            Continue;


        xTime := FileGetModified(SR);
        xItem := AItem.SubItems.FindItem(SR.Name);
        if xItem = nil then
        begin // new item
          xItem := AItem.SubItems.Add;
          xItem.IsFolder := (SR.Attr and faDirectory = faDirectory);
          xItem.DisplayName := SR.Name;
          if not xItem.IsFolder then
          begin
            xItem.LocalPath := IncludeTrailingPathDelimiter(AItem.LocalPath) + AItem.DisplayName;
          end;
          xItem.State  := isBackup;
          xItem.Created := Now;
          xItem.UModified := xTime;
          xItem.USize  := FileGetSize(SR);
          xItem.NotProcessed := True;
          xItem.Exists := False;
        end // new item
        else
        begin // existing item
          // See http://www.acebit-bugtracker.com/view_bug_page.php?f_id=0000255
          if ((xItem.DefAction in [daUpdate, daNewVersion]) and
            (CompareDateTime(xItem.Modified, xTime) < 0)) or (xItem.DefAction = daReplace) then
          begin
            xItem.State := isBackup;
            xItem.NotProcessed := True;
            xItem.UModified := xTime;
            xItem.USize := FileGetSize(SR);
          end;
        end; // existing item
        xItem.BackupItem := True;

        if xItem.IsFolder then
          SynchronizeItem(xItem);

      until FindNext(SR) <> 0;
      FindClose(SR);
    end
    else
    begin // Backup File
      if AItem.NotProcessed then
        Exit;

      sPath := IncludeTrailingPathDelimiter(AItem.LocalPath) + AItem.DisplayName;
      if FindFirst(sPath, faAnyFile, SR) <> 0 then
      begin
        if (AProject.Kind = pkBackup) and AScheduled then
        begin
          AItem.State := isBackup;
          AItem.NotProcessed := True;
        end;
        Exit;
      end;

      xTime := FileGetModified(SR);
      // See http://www.acebit-bugtracker.com/view_bug_page.php?f_id=0000255
      if ((AItem.DefAction in [daUpdate, daNewVersion]) and (CompareDateTime(AItem.Modified, xTime) < 0)) or
        (AItem.DefAction = daReplace) then
      begin
        AItem.State := isBackup;
        AItem.NotProcessed := True;
        AItem.UModified := xTime;
        AItem.USize := FileGetSize(SR);
      end;
      FindClose(SR);
    end; // Backup File
  end; // SyncBackupItem


  procedure ScanCollection(const ACollection: TNSCollection);
  var
    Index: integer;
    CurItem: TNSitem;
    ParItem: TNSitem;
  begin
    ACollection.BeginUpdate;
    try
      ParItem := ACollection.GetParentItem;
      if (ParItem = nil) or not ParItem.BackupItem then
      begin
        for Index := ACollection.Count - 1 downto 0 do
        begin
          CurItem := ACollection.Items[Index];
          if CurItem.IsFolder then
          begin
            if CurItem.BackupItem then
              SynchronizeItem(CurItem)
            else
              ScanCollection(CurItem.SubItems);
          end
          else
          begin
            SynchronizeItem(CurItem);
          end;
        end;
      end
      else
        SynchronizeItem(ParItem);
    finally
      ACollection.EndUpdate;
    end;
  end;

begin
  g_AbortRefresh := False;

  MainVolume := AProject.ActiveVolume;
  if AItems <> nil then
    xItems := AItems
  else
    xItems := MainVolume.Items;
  xPath := xItems.GetPath;

  ScanCollection(xItems);

  if AProject.SyncMode = smSynchronized then
    for VolNo := 0 to AProject.VolumeCount - 1 do
    begin
      SyncVolume := AProject.Volumes[VolNo];
      if SyncVolume <> MainVolume then
      begin
        xItems := SyncVolume.ForceCollection(xPath);
        if xItems <> nil then
          ScanCollection(xItems);
      end;
    end;
end;



{ TProjectVerifier }

constructor TProjectVerifier.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TCustomForm then
    FHandle := (AOwner as TCustomForm).Handle;
  GetTempFileName(PChar(g_TempDir), sTempPre, 0, @lpBuffer);
  FTempFileName := StrPas(lpBuffer);
  if FileExists(FTempFileName) then
    Windows.DeleteFile(PChar(FTempFileName));
end;

procedure TProjectVerifier.DoVerify(AOperation: TOperation; const AName: string);
begin
  if Assigned(FOnVerifyEvent) then
    FOnVerifyEvent(Self, AOperation, AName);
end;

function TProjectVerifier.Initialize(AInputProject: TNSProject; AExists: Boolean): Boolean;
var
  RemoteFolder:  string;
  RemoteArchive: string;
begin
  Result := False;
  FMainProject := AInputProject;
  FProjectExists := AExists;
  case FMainProject.BackupMedia of
    bmLocal, bmNAS:
    begin
      if FMainProject.BackupMedia = bmLocal then
        RemoteFolder := FMainProject.LocalFolder
      else
        RemoteFolder := FMainProject.NetPath;

      Result := DirectoryExists(RemoteFolder);
      if not Result then
      begin
        MessageBox(FHandle,
          PChar(Format(sCannotFindDir, [RemoteFolder])),
          PChar(sError), $00000030);
        Exit;
      end;
      RemoteFolder := IncludeTrailingPathDelimiter(RemoteFolder) + FMainProject.DisplayName;

      Result := DirectoryExists(RemoteFolder);
      if not Result then
      begin
        MessageBox(FHandle,
          PChar(Format(sCannotFindDir, [RemoteFolder])),
          PChar(sError), $00000030);
        Exit;
      end;
      RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
      Result := DirectoryExists(RemoteArchive);
      if not Result then
      begin
        MessageBox(FHandle,
          PChar(Format(sCannotFindDir, [RemoteArchive])),
          PChar(sError), $00000030);
        Exit;
      end;
    end;
    bmFTP:
      try
        Result := InitializeFTPSession(g_ConnectType, FMainProject.HostName, FMainProject.UserName,
          FMainProject.Password, FMainProject.Port, g_ProxyName, g_ProxyPort, EmptyStr,
          EmptyStr, FMainProject.Passive) = 0;
        if not Result then
        begin
          MessageBox(
            FHandle,
            GetLastFTPResponse,
            PChar(sError),
            $00000030);
          Exit;
        end;
        RemoteFolder := FMainProject.HostDirName;
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(FHandle,
            PChar(Format(sCannotFindDir, [RemoteFolder])),
            PChar(sError), $00000030);
          Exit;
        end;
        RemoteFolder := IncludeTrailingPathDelimiter(FMainProject.HostDirName) + FMainProject.DisplayName;
        Result := FTPDirectoryExists(PChar(RemoteFolder));
        if not Result then
        begin
          MessageBox(FHandle,
            PChar(Format(sCannotFindDir, [RemoteFolder])),
            PChar(sError), $00000030);
          Exit;
        end;
        RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
        Result := FTPDirectoryExists(PChar(RemoteArchive));
        if not Result then
        begin
          MessageBox(FHandle,
            PChar(Format(sCannotFindDir, [RemoteArchive])),
            PChar(sError), $00000030);
          Exit;
        end;
      finally
        FinalizeFTPSession;
      end;
    bmCD:
      try
        Result := FMainProject.InitCDDrive;
        if not Result then
        begin
          MessageBox(
            FHandle,
            PChar(SCDNotAvailable),
            PChar(sError),
            $00000030);
          Exit;
        end;
        Result := DiskWriter.CheckDeviceReady;
        if not Result then
        begin
          MessageBox(
            FHandle,
            PChar(SCDNotAvailable),
            PChar(sError),
            $00000030);
          Exit;
        end;

        RemoteFolder := IncludeTrailingPathDelimiter(FMainProject.CDDrivePath) + FMainProject.DisplayName;
        Result := DirectoryExists(RemoteFolder);
        if not Result then
        begin
          MessageBox(FHandle,
            PChar(Format(sCannotFindDir, [RemoteFolder])),
            PChar(sError), $00000030);
          Exit;
        end;
        RemoteArchive := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
        Result := DirectoryExists(RemoteArchive);
        if not Result then
        begin
          MessageBox(FHandle,
            PChar(Format(sCannotFindDir, [RemoteArchive])),
            PChar(sError), $00000030);
          Exit;
        end;
      except
        Result := False;
      end;
  end;
  FDirsCount  := 0;
  FFilesCount := 0;
  FSizeOnMedia := 0;

  if FCoProject <> nil then
    FreeAndNil(FCoProject);

  FCoProject := TNSProject.Create(frmProcess);

end;

function TProjectVerifier.InitMedia: Boolean;
var
  RemoteProjectName: string;
begin
  Result := False;
  case FMainProject.BackupMedia of
    bmLocal, bmNAS:
    begin
      if FMainProject.BackupMedia = bmLocal then
        RemoteProjectName := IncludeTrailingPathDelimiter(FMainProject.LocalFolder) +
          IncludeTrailingPathDelimiter(FMainProject.DisplayName) + sRemoteFileName
      else
        RemoteProjectName := IncludeTrailingPathDelimiter(FMainProject.NetPath) +
          IncludeTrailingPathDelimiter(FMainProject.DisplayName) + sRemoteFileName;
      Result := FileExists(RemoteProjectName);
      if not Result then
        Exit;
      Result := Windows.CopyFile(PChar(RemoteProjectName), PChar(FTempFileName), False);
    end;
    bmFTP:
    begin
      Result := InitializeFTPSession(g_ConnectType, FMainProject.HostName, FMainProject.UserName,
        FMainProject.Password, FMainProject.Port, g_ProxyName, g_ProxyPort, EmptyStr,
        EmptyStr, FMainProject.Passive) = 0;
      if not Result then
        Exit;
      RemoteProjectName := IncludeTrailingPathDelimiter(FMainProject.HostDirName) +
        IncludeTrailingPathDelimiter(FMainProject.DisplayName) + sRemoteFileName;
      Result := DownloadFTPFile(PChar(FTempFileName), PChar(RemoteProjectName), nil) = 0;
      if not Result then
        Exit;
    end;
    bmCD:
    begin
      Result := FMainProject.InitCDDrive;
      if not Result then
        Exit;
      RemoteProjectName := IncludeTrailingPathDelimiter(FMainProject.CDDrivePath) +
        IncludeTrailingPathDelimiter(FMainProject.DisplayName) + sRemoteFileName;
      Result := FileExists(RemoteProjectName);
      if not Result then
        Exit;
      Result := Windows.CopyFile(PChar(RemoteProjectName), PChar(FTempFileName), False);
    end;
  end;
end;

procedure TProjectVerifier.Stop;
begin
  FMustClose := True;
end;

end.
