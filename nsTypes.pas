unit nsTypes;

interface

uses
  Winapi.Windows,
  System.Classes,
  Vcl.Controls,

  nsCrypt,
  nsGlobals,
  nsProcessFrm,
  nsMasks;

type
  TWaitProgress = procedure(CurBlock, TotBlock: integer; var AClose: Boolean) of object;

  TCheckState = (csAll, csDelete, csRestore, csBackup);

  TItemState = (isNormal, isBackup, isBackupReplace, isBackupUpdate, isBackupNewVersion, isRestore, isRestoreToFolder, isDelete);

  TSendMail = (smNone, smOnFailure, smAlways);
  // 2.1
  TSendMailContent = (mcComplete, mcFailed);
  TFileFormat = (fmProprietary, fmAsIs);

  TNSItem = class;
  TNSCollection = class;

  TNSProject = class(TComponent)
  private
    FItems: TNSCollection;
    FCrypt: TWinCrypt;
    FFileName: string;
    FProjPwd: string;
    FDisplayName: string;
    FHostName: string;
    FPassive: Boolean;
    FPort: string;
    FUserName: string;
    FMaxSize: cardinal;
    FPassword: string;
    FWasModified: Boolean;
    FStoreArchivePwd: Boolean;
    FHostDirName: string;
    FOpened: Boolean;
    FBackupMedia: TBackupMedia;
    FLocalFolder: string;
    FEncryptionMethod: TEncryptionMethod;
    FConnected: Boolean;
    FDefaultAction: TDefaultAction;
    FAutoMode: Boolean;
    FWriteLog: Boolean;
    FLogFile: TStringList;
    FKind: TProjectKind;
    // FIsRunning: Boolean;
    FNeedCrypting: Boolean;
    FAutoRefresh: Boolean;
    FSendLog: TSendMail;
    FIncMasks: TMaskItems;
    FExcMasks: TMaskItems;
    FCompressionLevel: byte;
    FDialupConnection: string;
    FHangUpOnCompleted: Boolean;
    FWaitForExtAppAfter: Boolean;
    FWaitForExtAppBefore: Boolean;
    FExtAppBefore: string;
    FExtAppAfter: string;
    FActiveVolumeIndex: integer;
    FActiveVolume: TNSProject;
    FTimeOutBefore: integer;
    FTimeOutAfter: integer;
    FAutoMangle: Boolean;
    FSyncMode: TSyncMode;
    FRestoring: Boolean;
    FRestoreCDDrive: string;
    FLastRunTime: TDateTime;
    FCDIndex: integer;
    FCDDrivePath: string;
    FCDErase: Boolean;
    FSendMailContect: TSendMailContent;
    FFileFormat: TFileFormat;
    FCDWriteable: Boolean;
    FBackupSize: int64;
    FMediaSize: int64;
    FAutoDialUp: Boolean;
    FNetPass: string;
    FNetUser: string;
    FNetPath: string;
    procedure SetProjPwd(const Value: string);
    function GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
    procedure SetOpened(const Value: Boolean);
    function GetVolume(Index: integer): TNSProject;
    function GetVolumeCount: integer;
    function GetDisplayName: string;
    function GetVolumeIndex: integer;
    procedure SetActiveVolume(const Value: TNSProject);
    procedure SetActiveVolumeIndex(const Value: integer);
    procedure SetExcMasks(const Value: TMaskItems);
    procedure SetIncMasks(const Value: TMaskItems);
    procedure SetDisplayName(const Value: string);
    procedure SetKind(const Value: TProjectKind);
    procedure SetEncryptionMethod(const Value: TEncryptionMethod);
    procedure SetCompressionLevel(const Value: byte);
    procedure SetDefaultAction(const Value: TDefaultAction);
    procedure SetItems(const Value: TNSCollection);
    procedure SetAutoMangle(const Value: Boolean);
    procedure SetSyncMode(const Value: TSyncMode);
    function GetHostName: string;
    procedure SetLocalFolder(const Value: string);
    function GetIsCDMedia: Boolean;
    procedure SetFileFormat(const Value: TFileFormat);
    procedure SetNetPath(const Value: string);
    procedure SetNetUser(const Value: string);
    procedure SetHostDirName(const Value: string);
  protected
    HashValue: THashKey;
    FNasConnection: string;

    procedure ReadProjPwd(Reader: TReader);
    procedure WriteProjPwd(Writer: TWriter);
    procedure ReadPassword(Reader: TReader);
    procedure WritePassword(Writer: TWriter);
    procedure ReadNetPass(Reader: TReader);
    procedure WriteNetPass(Writer: TWriter);

    procedure DefineProperties(Filer: TFiler); override;

    function PackFile(const ANameInp: string; const ANameOut: string; var ASize: int64): Boolean;
    function UnPackFile(const ANameInp: string; const ANameOut: string; ANewHash: THashKey): Boolean;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure AssignTo(Dest: TPersistent); override;
    // 2.1
    // function InitWriting: Boolean;
    // function InitReading: Boolean;
  public
    FProgress: TfrmProcess;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function OpenProject(const APassword: string): Boolean;
    function ConnectToMedia(const AWnd: HWnd): Boolean;
    function ReConnect: Boolean;
    procedure Disconnect;
    procedure ReInitCrypting;
    procedure Reset;
    procedure Refresh;

    function CloseProject: Boolean;

    function Rename(const ANewDisplayName: string): Boolean;
    function Move(const ANewLocation: string): Boolean;

    function GetNonProcCount(var ASize: int64): integer;
    function GetDeleteCount(var ASize: int64): integer;
    function GetBackupCount(var ASize: int64): integer;
    function GetRestoreCount(var ASize: int64): integer;

    function ProcessDelete: integer;
    function ProcessRestore: integer;
    function ProcessBackup: integer;

    // 2.1
    function InitializeMedia(const AState: TCheckState): Boolean;
    function FinalizeMedia: Boolean;
    // procedure EraseCDMedia;
    function ImportCDMedia: Boolean;

    procedure KillProcessing;

    procedure StartLog;
    procedure EndLog;
    procedure TraceLog(const AOperation, AResult: string; const Rslt: Boolean);
    procedure LogMsg(const AMessage: string);

    function GetLog: TStrings;
    function CheckProject(ACheckFor: TCheckState): Boolean;
    function CheckVolumes(ACheckFor: TCheckState): Boolean;

    property Opened: Boolean read FOpened write SetOpened;
    property Connected: Boolean read GetConnected write SetConnected;

    function PathDelimiter: string;
    function IsValidExt(const AFileName: string): Boolean;
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
    function LoadFromFile(const AFileName: string): Boolean;
    procedure SaveToFile(const AFileName: string; AShowProgress: Boolean); overload;
    procedure SaveToFile(AShowProgress: Boolean); overload;

    function GetCaption: string;
    function SupportsConnect: Boolean;

    property FileName: string read FFileName write FFileName;
    property WasModified: Boolean read FWasModified write FWasModified;

    property AutoMode: Boolean read FAutoMode write FAutoMode;
    property AutoRefresh: Boolean read FAutoRefresh write FAutoRefresh;
    property Progress: TfrmProcess read FProgress write FProgress;

    property ProjPwd: string read FProjPwd write SetProjPwd;
    property Password: string read FPassword write FPassword;
    // 3.0.0
    property NetPass: string read FNetPass write FNetPass;

    // 2.0
    procedure SetDefaultValues;
    function AddVolume: TNSProject;
    procedure DeleteVolume(Index: integer);
    property VolumeCount: integer read GetVolumeCount;
    property Volumes[index: integer]: TNSProject read GetVolume;
    property VolumeIndex: integer read GetVolumeIndex;
    property ActiveVolume: TNSProject read FActiveVolume write SetActiveVolume;
    property ActiveVolumeIndex: integer read FActiveVolumeIndex write SetActiveVolumeIndex;
    function GetVolumeString(const AFull: Boolean = True): string;
    procedure ExecuteExternal(const ABefore: Boolean);

    function NormalizePath(const APath: string): string;
    function ForceCollection(const APath: string): TNSCollection;
    function FindCollection(const APath: string): TNSCollection;
    procedure CleanProject;

    // 2.1

    procedure SetProgress(const AOperation, AFileName: string; const ACurrent, ATotal: int64);

    function InitCDDrive: Boolean;
    property CDDrivePath: string read FCDDrivePath;
    property CDWriteable: Boolean read FCDWriteable;
    property BackupSize: int64 read FBackupSize write FBackupSize;
    property MediaSize: int64 read FMediaSize;

  published
    property Kind: TProjectKind read FKind write SetKind stored False;

    property DisplayName: string read GetDisplayName write SetDisplayName;
    property EncryptionMethod: TEncryptionMethod read FEncryptionMethod write SetEncryptionMethod;
    property MaxSize: cardinal read FMaxSize write FMaxSize;
    property StoreArchivePwd: Boolean read FStoreArchivePwd write FStoreArchivePwd;
    property WriteLog: Boolean read FWriteLog write FWriteLog;
    property IncMasks: TMaskItems read FIncMasks write SetIncMasks;
    property ExcMasks: TMaskItems read FExcMasks write SetExcMasks;

    property BackupMedia: TBackupMedia read FBackupMedia write FBackupMedia;
    property DefaultAction: TDefaultAction read FDefaultAction write SetDefaultAction;
    property LocalFolder: string read FLocalFolder write SetLocalFolder;
    property HostName: string read GetHostName write FHostName;
    property HostDirName: string read FHostDirName write SetHostDirName;
    property Passive: Boolean read FPassive write FPassive;
    property Port: string read FPort write FPort;
    property SendLog: TSendMail read FSendLog write FSendLog;
    property UserName: string read FUserName write FUserName;
    property Items: TNSCollection read FItems write SetItems;
    property CompressionLevel: byte read FCompressionLevel write SetCompressionLevel default ZCompressionMax;
    property DialupConnection: string read FDialupConnection write FDialupConnection stored False;

    property AutoDialUp: Boolean read FAutoDialUp write FAutoDialUp default False;
    property HangUpOnCompleted: Boolean read FHangUpOnCompleted write FHangUpOnCompleted default False;
    property ExtAppBefore: string read FExtAppBefore write FExtAppBefore;
    property WaitForExtAppBefore: Boolean read FWaitForExtAppBefore write FWaitForExtAppBefore;
    property ExtAppAfter: string read FExtAppAfter write FExtAppAfter;
    property WaitForExtAppAfter: Boolean read FWaitForExtAppAfter write FWaitForExtAppAfter;
    property TimeOutBefore: integer read FTimeOutBefore write FTimeOutBefore default 10;
    property TimeOutAfter: integer read FTimeOutAfter write FTimeOutAfter default 10;
    property AutoMangle: Boolean read FAutoMangle write SetAutoMangle default False;
    property SyncMode: TSyncMode read FSyncMode write SetSyncMode default smIndependent;

    property IsCDMedia: Boolean read GetIsCDMedia;
    property Restoring: Boolean read FRestoring;
    property RestoreCDDrive: string read FRestoreCDDrive write FRestoreCDDrive;
    // 2.1
    property LastRunTime: TDateTime read FLastRunTime write FLastRunTime;
    property CDIndex: integer read FCDIndex write FCDIndex default -1;
    property CDErase: Boolean read FCDErase write FCDErase default False;
    property SendMailContect: TSendMailContent read FSendMailContect write FSendMailContect;
    property FileFormat: TFileFormat read FFileFormat write SetFileFormat;

    // 3.0.0
    property NetPath: string read FNetPath write SetNetPath;
    property NetUser: string read FNetUser write SetNetUser;

  end;

  TNSVersion = class(TCollectionItem)
  private
    FSize: int64;
    FNumber: integer;
    FModified: TDateTime;
    FSizeOnMedia: int64;
    FExists: Boolean;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property Number: integer read FNumber write FNumber default 0;
    property Modified: TDateTime read FModified write FModified;
    property Size: int64 read FSize write FSize;
    property SizeOnMedia: int64 read FSizeOnMedia write FSizeOnMedia;
    property Exists: Boolean read FExists write FExists default True;
  end;

  TNSVersions = class(TCollection)
  private
    FOwner: TNSItem;
    function GetItem(Index: integer): TNSVersion;
    procedure SetItem(Index: integer; const Value: TNSVersion);
  protected
  public
    constructor Create(AOwner: TNSItem); overload;
    function Add: TNSVersion;
    property Items[index: integer]: TNSVersion read GetItem write SetItem; default;
  published
  end;

  TNSItem = class(TCollectionItem)
  private
    FModified: TDateTime;
    FSubItems: TNSCollection;
    FIsFolder: Boolean;
    FLocalPath: string;
    FCreated: TDateTime;
    FNotProcessed: Boolean;
    FState: TItemState;
    FVersions: TNSVersions;
    FDestFolder: string;
    FExists: Boolean;
    FBackupItem: Boolean;
    FProject: TNSProject;
    FDefAction: TDefaultAction;
    FUModified: TDateTime;
    FUSize: int64;
    FULocalPath: string;
    FRemoteName: string;
    procedure SetIsFolder(const Value: Boolean);
    function GetModified: TDateTime;
    function GetSize: int64;
    procedure SetModified(const Value: TDateTime);
    procedure SetSize(const Value: int64);
    function GetSizeOnMedia: int64;
    procedure SetSizeOnMedia(const Value: int64);
    function GetDestFolder: string;
    function GetVersion: integer;
    procedure SetExists(const Value: Boolean);
    procedure SetDefAction(const Value: TDefaultAction);
    function GetLocalPath: string;
    procedure SetLocalPath(const Value: string);
    function GetStoreFolder: Boolean;
    procedure SetNotProcessed(const Value: Boolean);
    procedure SetState(const Value: TItemState);
    procedure SetUModified(const Value: TDateTime);
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
    procedure SetBackupItem(const Value: Boolean);
    property Project: TNSProject read FProject;
  public
    FDisplayName: string;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
    function GetPathOnMedia: string;
    property Size: int64 read GetSize write SetSize;
    property SizeOnMedia: int64 read GetSizeOnMedia write SetSizeOnMedia;
    property DestFolder: string read GetDestFolder write FDestFolder;
    property versionNumber: integer read GetVersion;
    function IndexOfVersion(AVersionNumber: integer): integer;

    function Rename(const ANewName: string): Boolean;
    function Mangle: Boolean;
    function IsNameMangled: Boolean;
    function DeleteVersion(const AVersion: integer): Boolean;
    function Backup: Boolean;
    function Restore: Boolean;
    function RestoreVersion(const ADestFolder: string; const AVersion: integer): Boolean;

    function FileNameOnServer(const AVersion: integer): string;
    function AuxFileName(const AVersion: integer): string;

    function VerifyPath: Boolean;

    procedure RollBack;
    procedure Refresh;

    function GetLocation: string;
    function NS_Name(const AVersion: integer): string;
    procedure ScanBackupFolder(const AProcessAll: Boolean);

  published
    property DisplayName: string read GetDisplayName write SetDisplayName;
    property IsFolder: Boolean read FIsFolder write SetIsFolder;
    property BackupItem: Boolean read FBackupItem write SetBackupItem;
    property LocalPath: string read GetLocalPath write SetLocalPath stored GetStoreFolder;
    property DefAction: TDefaultAction read FDefAction write SetDefAction default daReplace;
    property Created: TDateTime read FCreated write FCreated;
    property Modified: TDateTime read GetModified write SetModified;
    property UModified: TDateTime read FUModified write SetUModified;
    property uSize: int64 read FUSize write FUSize default 0;
    property ULocalPath: string read FULocalPath write FULocalPath stored GetStoreFolder;
    property NotProcessed: Boolean read FNotProcessed write SetNotProcessed default False;
    property State: TItemState read FState write SetState;
    property Exists: Boolean read FExists write SetExists;
    property SubItems: TNSCollection read FSubItems write FSubItems;
    property Versions: TNSVersions read FVersions write FVersions;
    property RemoteName: string read FRemoteName write FRemoteName;
  end;

  TNSCollection = class(TCollection)
  private
    FProject: TNSProject;
    FOwner: TNSItem;
    function GetItem(Index: integer): TNSItem;
    procedure SetItem(Index: integer; const Value: TNSItem);
  protected
  public
    constructor Create(AProject: TNSProject; AOwner: TNSItem); overload;
    function GetParentItem: TNSItem;
    function Add: TNSItem;
    function DeleteItem(Index: integer): Boolean;
    function DeleteFolder(Index: integer): Boolean;
    function FindItem(const ADispName: string): TNSItem;
    // new methods
    function GetPath: string;
    property Items[index: integer]: TNSItem read GetItem write SetItem; default;
  published
  end;

  TNSProjectHeader = class(TComponent)
  private
    FDisplayName: string;
    FEncryptionMethod: TEncryptionMethod;
    FKind: TProjectKind;
    FLastRunTime: TDateTime;
    FFileName: string;
  public
    procedure AssignProperties(const AProject: TNSProject);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
    function LoadFromFile(const AFileName: string): Boolean;
  public
    property FileName: string read FFileName write FFileName;
  published
    property Kind: TProjectKind read FKind write FKind;
    property DisplayName: string read FDisplayName write FDisplayName;
    property EncryptionMethod: TEncryptionMethod read FEncryptionMethod write FEncryptionMethod;
    property LastRunTime: TDateTime read FLastRunTime write FLastRunTime;
  end;

var
  FRestoreMR: integer = mrNone;
  BurningRequired: Boolean;
  CurProject: TNSProject = nil;
  GlobalPurchaseURL: string;

function FindFirstNew(ACollection: TNSCollection; ABaseName: string): string;

implementation

uses
  Vcl.Forms, Winapi.ShellAPI, System.SysUtils, System.StrUtils, System.DateUtils,
  WinInet, WinFTP, ziptools, abWaitDlg, cdWrapper, nsMainFrm,
  nsUtils, nsErrRestoreFrm, nsConfirmUpdateFrm, nsReplaceForm, nsActions, tsTaskman;

const
  PrivateKey1 = '@vTjmrl)89TyUrfcvzx&*5l';
  PrivateKey2 = '@vTjmrl)8#4bdrf_988uyhUTbhjbh_cvzx&*5l';

const
  PROJECT_BUF_SIZE = 1048576;

var
  RestoreSR: TSearchRec;

function CopyProgressRoutine(TotalFileSize: int64; TotalBytesTransferred: int64; StreamSize: int64; StreamBytesTransferred: int64; dwStreamNumber: DWORD;
  dwCallbackReason: DWORD; hSourceFile: THandle; hDestinationFile: THandle; lpData: Pointer): DWORD; stdcall;
var
  frm: TfrmProcess;
begin
  frm := TfrmProcess(lpData);
  if dwCallbackReason = 4 then
    frm.CopyProgressEx(TotalBytesTransferred, TotalFileSize, g_AbortProcess)
  else
    frm.CopyProgress(TotalBytesTransferred div MAXWORD, TotalFileSize div MAXWORD, g_AbortProcess);

  Application.ProcessMessages;
  if g_AbortProcess then
    Result := PROGRESS_STOP
  else
    Result := PROGRESS_CONTINUE;
end;

const
  dwHugeFile = 1024 * 1024 * 8; // file less 8 Mb we process in memory

function ErrorMsg(ACode: DWORD): string;
begin
  Result := Format(sCodeFormatted, [SysErrorMessage(ACode), ACode]);
end;

function FindFirstNew(ACollection: TNSCollection; ABaseName: string): string;
var
  I: integer;
  List: TStringList;
begin
  List := TStringList.Create;
  try
    for I := 0 to ACollection.Count - 1 do
      List.Add(ACollection.Items[I].DisplayName);
    List.Sorted := True;
    if List.IndexOf(ABaseName) = -1 then
      Result := ABaseName
    else
    begin
      I := 2;
      repeat
        Result := Format('%s (%d)', [ABaseName, I]);
        Inc(I);
      until List.IndexOf(Result) = -1;
    end;
  finally
    List.Free;
  end;
end;

{ TNSCollection }

function TNSCollection.Add: TNSItem;
begin
  Result := TNSItem(inherited Add);
  if FOwner <> nil then
  begin
    Result.FDefAction := FOwner.FDefAction;
  end
  else
  begin
    Result.FDefAction := FProject.FDefaultAction;
  end;
end;

constructor TNSCollection.Create(AProject: TNSProject; AOwner: TNSItem);
begin
  inherited Create(TNSItem);
  FProject := AProject;
  FOwner := AOwner;
end;

function TNSCollection.DeleteFolder(Index: integer): Boolean;
var
  Item: TNSItem;
  DirName: string;
  sLog: string;
begin
  Result := False;
  if g_AbortProcess then
    Exit;

  Item := Items[index];

  if Item.Exists then
  begin
    DirName := Item.FileNameOnServer(-1);
    case FProject.BackupMedia of
      bmLocal, bmNAS:
        begin
          if Length(DirName) > MAX_PATH then
          begin
            Result := False;
            FProject.TraceLog(Format(sFolderDeletion, [DirName]), ErrorMsg(3), Result);
          end
          else
          begin
            RemoveDirectory(PChar(DirName));
            FProject.TraceLog(Format(sFolderDeletion, [DirName]), ErrorMsg(GetLastError), Result);
            Result := not DirectoryExists(DirName);
          end;
        end;
      bmFTP:
        begin
          Result := DeleteFTPFolder(PChar(DirName)) = 0;
          FProject.TraceLog(Format(sFolderDeletion, [DirName]), StrPas(GetLastFTPResponse), Result);
        end;
      bmCD:
        begin
          Result := DiskWriter.RemoveDir(DirName);
          if Result then
            sLog := ErrorMsg(NO_ERROR)
          else
            sLog := ErrorMsg(ERROR_PATH_NOT_FOUND);
          FProject.TraceLog(Format(sFolderDeletion, [DirName]), sLog, Result);
        end;
    else
      Result := False;
    end;
  end
  else
    Result := True;

  if Result then
  begin
    if FProject.FProgress <> nil then
      NSChangeNotify(0, NSN_REMOVEFOLDER, NSN_FLUSH, Item.SubItems, Item)
    else
      Delete(index);
  end;
end;

function TNSCollection.DeleteItem(Index: integer): Boolean;
var
  Ver: integer;
  RemoteFileName: string;
  sRealName: string;
  Item: TNSItem;
  tmpResult: Boolean;
  sLog: string;
begin
  Result := False;
  if g_AbortProcess then
    Exit;
  Item := Items[index];

  if FProject.Progress <> nil then
    with FProject.Progress do
    begin
      CurAction := sDeleting;
      CurItemSize := Item.SizeOnMedia;
      CurFile := Item.DisplayName;
      ProgressBar1.Position := 0;
      ProgressBar1.Max := Item.Versions.Count;
      Application.ProcessMessages;
    end;

{$B+}
  if Item.Exists then
  begin
    RemoteFileName := Item.FileNameOnServer(-1);
    case FProject.BackupMedia of
      bmLocal, bmNAS:
        begin
          for Ver := 0 to Item.Versions.Count - 1 do
          begin
            sRealName := Item.FileNameOnServer(Item.Versions[Ver].Number);
            if Length(sRealName) > MAX_PATH then
            begin
              FProject.TraceLog(Format(sFileDeletion, [sRealName]), ErrorMsg(3), False);
              Result := False;
            end
            else
            begin
              tmpResult := DeleteFile(PChar(sRealName));
              FProject.TraceLog(Format(sFileDeletion, [sRealName]), ErrorMsg(GetLastError), tmpResult);
              Result := Result or tmpResult;
            end;

            if FProject.Progress <> nil then
              with FProject.Progress do
              begin
                ProgressBar1.Position := ProgressBar1.Position + 1;
                Application.ProcessMessages;
              end;
          end;
        end;
      bmFTP:
        begin
          for Ver := 0 to Item.Versions.Count - 1 do
          begin
            sRealName := Item.FileNameOnServer(Item.Versions[Ver].Number);
            // sRealName := RemoteFileName + IntToHex(Item.Versions[Ver].Number, 3);
            tmpResult := DeleteFTPFile(PChar(sRealName)) = 0;
            FProject.TraceLog(Format(sFileDeletion, [sRealName]), StrPas(GetLastFTPResponse), tmpResult);
            Result := Result or tmpResult;
            if FProject.Progress <> nil then
              with FProject.Progress do
              begin
                ProgressBar1.Position := ProgressBar1.Position + 1;
                Application.ProcessMessages;
              end;

          end;
        end;
      bmCD:
        begin
          for Ver := 0 to Item.Versions.Count - 1 do
          begin
            sRealName := Item.FileNameOnServer(Item.Versions[Ver].Number);
            tmpResult := DiskWriter.RemoveFile(ExtractFilePath(RemoteFileName), ExtractFileName(sRealName));
            if tmpResult then
            begin
              BurningRequired := True;
              sLog := ErrorMsg(NO_ERROR);
            end
            else
              sLog := ErrorMsg(ERROR_FILE_NOT_FOUND);
            FProject.TraceLog(Format(sFileDeletion, [sRealName]), sLog, tmpResult);
            Result := Result or tmpResult;
            if FProject.Progress <> nil then
              with FProject.Progress do
              begin
                ProgressBar1.Position := ProgressBar1.Position + 1;
                Application.ProcessMessages;
              end;
          end;
        end;

    end;
  end
  else
    Result := True;
{$B-}
  if FProject.Progress <> nil then
    FProject.Progress.UpdateProgress;

  if Result then
  begin
    if FProject.Progress <> nil then
      NSChangeNotify(0, NSN_REMOVEITEM, NSN_FLUSH, Self, Item)
    else
      Self.Delete(index);
  end;
end;

function TNSCollection.FindItem(const ADispName: string): TNSItem;
var
  I: integer;
begin
  Result := nil;
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      if AnsiSameText(Items[I].FDisplayName, ADispName) then
      begin
        Result := Items[I];
        Break;
      end;
  finally
    EndUpdate;
  end;
end;

function TNSCollection.GetItem(Index: integer): TNSItem;
begin
  Result := TNSItem(inherited GetItem(index));
end;

function TNSCollection.GetParentItem: TNSItem;
begin
  Result := FOwner;
end;

function TNSCollection.GetPath: string;
var
  ParItem: TNSItem;
begin
  if FOwner = nil then
    Result := FProject.PathDelimiter
  else
  begin
    ParItem := GetParentItem;
    Result := EmptyStr;
    while ParItem <> nil do
    begin
      Result := ParItem.FDisplayName + FProject.PathDelimiter + Result;
      ParItem := TNSCollection(ParItem.Collection).GetParentItem;
    end;
  end;
end;

procedure TNSCollection.SetItem(Index: integer; const Value: TNSItem);
begin
  inherited SetItem(index, Value);
end;

{ TNSProject }

constructor TNSProject.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TfrmProcess then
  begin
    FProgress := TfrmProcess(AOwner);
    FAutoRefresh := g_AutoRefresh;
  end
  else
  begin
    if AOwner is TNSProject then
      FProgress := (AOwner as TNSProject).FProgress;
    FAutoRefresh := True;
  end;

  FCrypt := TWinCrypt.Create;
  FItems := TNSCollection.Create(Self, nil);
  FDisplayName := FormatDateTime('"AceBackup Project ("dd"_"mm"_"yyyy"_"hh"_"nn")', Now);
  FLogFile := TStringList.Create;
  FWriteLog := True;
  FIncMasks := TMaskItems.Create;
  FExcMasks := TMaskItems.Create;

  FCompressionLevel := ZCompressionDefault;

  FWaitForExtAppAfter := False;
  FWaitForExtAppBefore := False;

  FActiveVolume := Self;
  FActiveVolumeIndex := 0;
  FTimeOutBefore := 10;
  FTimeOutAfter := 10;
  // 11/6/2003
  FDefaultAction := daUpdate;

  FRestoring := False;
  // 2.1
  FCDIndex := -1;
  FKind := pkBackup;
end;

destructor TNSProject.Destroy;
begin
  FLogFile.Free;
  FIncMasks.Free;
  FExcMasks.Free;
  FreeAndNil(FCrypt);
  if FItems <> nil then
    FItems.Free;
  inherited Destroy;
end;

{ function TNSProject.GetCRC32(ADataStream: TStream): LongInt;
  var
  crc, checked, buffersize, fsize, count: LongInt;
  BufferArray: array[0..10239] of Byte;
  OriginalPos: LongInt;
  begin
  OriginalPos := ADataStream.Position;
  ADataStream.Seek(0, soFromBeginning);
  crc := LongInt($FFFFFFFF);
  fsize := ADataStream.Size;
  while True do
  begin
  if fsize <= 0 then break;
  if fsize >= 10240 then
  buffersize := 10240
  else
  buffersize := fsize;
  Count := ADataStream.Read(BufferArray, BufferSize);
  checked := 0;
  while checked < Count do
  begin
  crc := ((crc shr 8) and $FFFFFF) xor FCRC32Table[(crc xor bufferArray[checked]) and $FF];
  Inc(checked);
  end;
  Dec(fsize, buffersize);
  end;
  Result := crc xor LongInt($FFFFFFFF);
  ADataStream.Seek(OriginalPos, soFromBeginning);
  end;
}

{ procedure TNSProject.InitCRC32;
  var
  crc, poly: LongInt;
  i, j: LongInt;
  begin
  poly := LongInt($FF726390);
  for i := 0 to 255 do
  begin
  crc := i;
  for j := 8 downto 1 do
  begin
  if (crc and 1) = 1 then
  crc := (crc shr 1) xor poly
  else
  crc := crc shr 1;
  end;
  FCRC32Table[i] := crc;
  end;
  end;

}

function TNSProject.LoadFromFile(const AFileName: string): Boolean;
var
  FS: TFileStream;
  MS: TMemoryStream;
  // 2.1
  Header: TNSProjectHeader;
  Reader: TReader;

begin
  Result := False;
  if not FileExists(AFileName) then
    Exit;
  FFileName := AFileName;
  MS := TMemoryStream.Create;
  FS := TFileStream.Create(AFileName, fmOpenRead);

  if FProgress <> nil then
  begin
    frmWaitDlg := TfrmWaitDlg.Create(Application);
    frmWaitDlg.Show;
    frmWaitDlg.Update;
    Application.MainForm.Enabled := False;
  end;

  // 2.1
  Header := TNSProjectHeader.Create(nil);
  try
    try
      // 2.1
      try
        Header.LoadFromStream(FS);
      except
        FS.Position := 0;
      end;

      if FProgress <> nil then
        DecompressStream(FS, MS, frmWaitDlg.WaitProgress)
      else
        DecompressStream(FS, MS, nil);

      MS.Position := 0;

      Reader := TReader.Create(MS, PROJECT_BUF_SIZE);
      try
        Reader.ReadRootComponent(Self);
      finally
        Reader.Free;
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    FS.Free;
    MS.Free;
    if FProgress <> nil then
    begin
      Application.MainForm.Enabled := True;
      frmWaitDlg.Free;
    end;
    Header.Free;
  end;
end;

procedure TNSProject.LoadFromStream(AStream: TStream);
begin
  if FItems.Count > 0 then
    FItems.Clear;
  if AStream.Size <> 0 then
    AStream.ReadComponent(Self);
end;

procedure TNSProject.SaveToFile(const AFileName: string; AShowProgress: Boolean);
var
  FS: TFileStream;
  MS: TMemoryStream;
  Task: TTaskItem;
  Header: TNSProjectHeader;
  Writer: TWriter;
begin
  if AFileName = EmptyStr then
    Exit;
  if not ForceDirectories(ExtractFilePath(AFileName)) then
    Exit;
  FileName := AFileName;
  if AShowProgress then
  begin
    frmWaitDlg := TfrmWaitDlg.Create(Application);
    frmWaitDlg.Show;
    frmWaitDlg.Update;
    Application.MainForm.Enabled := False;
  end;
  try

    MS := TMemoryStream.Create;
    FS := TFileStream.Create(AFileName, fmCreate);
    // 2.1
    Header := TNSProjectHeader.Create(nil);
    try
      // 2.1
      try
        Header.AssignProperties(Self);
        Header.SaveToStream(FS);
      except
        FS.Position := 0;
      end;

      Writer := TWriter.Create(MS, PROJECT_BUF_SIZE);
      try
        Writer.WriteDescendent(Self, nil);
      finally
        Writer.Free;
      end;

      MS.Position := 0;
      if AShowProgress then
        CompressStream(MS, FS, frmWaitDlg.WaitProgress, ZCompressionFastest)
      else
        CompressStream(MS, FS, nil, ZCompressionFastest);
    finally
      FS.Free;
      MS.Free;
      // 2.1
      Header.Free;
    end;
    if frmMain.TaskManager.Active then
    begin
      Task := frmMain.TaskManager.ActivateTask(DisplayName);
      if Assigned(Task) then
      begin
        Task.Arguments := sUpdate + #34 + AFileName + #34;
        Task.SaveTask;
      end;
    end;
  finally
    if AShowProgress then
    begin
      Application.MainForm.Enabled := True;
      frmWaitDlg.Free;
    end;
  end;
end;

procedure TNSProject.SaveToFile(AShowProgress: Boolean);
begin
  if FFileName <> EmptyStr then
    SaveToFile(FileName, AShowProgress);
end;

procedure TNSProject.SaveToStream(AStream: TStream);
begin
  AStream.WriteComponent(Self);
end;

procedure TNSProject.SetProjPwd(const Value: string);
var
  Index: integer;
begin
  for index := 0 to VolumeCount - 1 do
    Volumes[index].FProjPwd := Value;
end;

function TNSProject.GetConnected: Boolean;
begin
  Result := FConnected;
end;

procedure TNSProject.SetConnected(const Value: Boolean);
begin
  FConnected := Value;
end;

procedure TNSProject.SetOpened(const Value: Boolean);
begin
  if Value then
    FOpened := OpenProject(FProjPwd)
  else
  begin
    CloseProject;
    FOpened := False;
  end;
end;

function TNSProject.CloseProject: Boolean;
var
  RemoteFolder: string;
  RemoteFileName: string;
  NeedPwdClean: Boolean;
begin
  NeedPwdClean := (Self.EncryptionMethod <> tmNone) and Self.StoreArchivePwd;
  if NeedPwdClean then
    Self.StoreArchivePwd := False;
  try
    try
      if FFileName = EmptyStr then
        case FKind of
          pkArchive: FFileName := IncludeTrailingPathDelimiter(g_ProjectsDir) + DisplayName + sNsa;
          pkBackup: FFileName := IncludeTrailingPathDelimiter(g_ProjectsDir) + DisplayName + sNsb;
        end;
      SaveToFile(FileName, FProgress <> nil);
      Result := True;
    except
      Result := False;
      Exit;
    end;

    if not FConnected then
    begin
      if (FProgress = nil) and FHangUpOnCompleted then
        try
          InternetAutodialHangup(0);
        except
        end;
      if FProgress <> nil then
        PlaySoundEvent(SProjectClosedSound);
      Exit;
    end;
    case FBackupMedia of
      bmLocal:
        begin
          RemoteFolder := IncludeTrailingPathDelimiter(FLocalFolder) + DisplayName;
          Result := ForceDirectories(RemoteFolder);
          if not Result then
            Exit;
          RemoteFileName := IncludeTrailingPathDelimiter(RemoteFolder) + sRemoteFileName;
          Result := CopyFile(PChar(FFileName), PChar(RemoteFileName), False);
        end;
      bmFTP:
        begin
          RemoteFolder := IncludeTrailingPathDelimiter(FHostDirName) + FDisplayName;
          CreateFTPFolder(PChar(RemoteFolder));
          CreateFTPFolder(PChar(IncludeTrailingPathDelimiter(RemoteFolder) + sArchives));
          RemoteFileName := IncludeTrailingPathDelimiter(RemoteFolder) + sRemoteFileName;
          Result := UploadFTPFile(PChar(FFileName), PChar(RemoteFileName), nil) = 0;
          FinalizeFTPSession;
          if (FProgress = nil) and FHangUpOnCompleted then
            try
              InternetAutodialHangup(0);
            except
            end;
        end;
      bmNAS:
        begin
          RemoteFolder := IncludeTrailingPathDelimiter(FNasConnection) + DisplayName;
          Result := ForceDirectories(RemoteFolder);

          if Result then
          begin
            RemoteFileName := IncludeTrailingPathDelimiter(RemoteFolder) + sRemoteFileName;
            Result := CopyFile(PChar(FFileName), PChar(RemoteFileName), False);
          end;

          WNetCancelConnection2(PChar(FNasConnection), 0, True);
          FNasConnection := EmptyStr;
        end;
    else
      Result := False;
    end;
    FConnected := False;
    if FProgress <> nil then
      PlaySoundEvent(SProjectClosedSound);
  finally
    if NeedPwdClean then
    begin
      Self.StoreArchivePwd := True;
      try
        SaveToFile(FileName, FProgress <> nil);
      except
      end;
    end;
  end;
end;

procedure TNSProject.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Password', ReadPassword, WritePassword, True);
  Filer.DefineProperty('ProjPwd', ReadProjPwd, WriteProjPwd, True);
  Filer.DefineProperty('NetPass', ReadNetPass, WriteNetPass, True);
end;

function TNSProject.PathDelimiter: string;
begin
  if FBackupMedia = bmFTP then
    Result := sSlash
  else
    Result := sBackslash;
end;

procedure TNSProject.ReadNetPass(Reader: TReader);
begin
  FNetPass := TWinCrypt.CryptText(Reader.ReadString, PrivateKey1, False);
end;

procedure TNSProject.ReadPassword(Reader: TReader);
begin
  FPassword := TWinCrypt.CryptText(Reader.ReadString, PrivateKey1, False);
end;

procedure TNSProject.WriteNetPass(Writer: TWriter);
var
  Hash: string;
begin
  Hash := TWinCrypt.CryptText(FNetPass, PrivateKey1, True);
  Writer.WriteString(Hash);
end;

procedure TNSProject.WritePassword(Writer: TWriter);
var
  Hash: string;
begin
  Hash := TWinCrypt.CryptText(FPassword, PrivateKey1, True);
  Writer.WriteString(Hash);
end;

procedure TNSProject.ReadProjPwd(Reader: TReader);
begin
  FProjPwd := TWinCrypt.CryptText(Reader.ReadString, PrivateKey2, False);
end;

procedure TNSProject.WriteProjPwd(Writer: TWriter);
var
  Hash: string;
begin
  Hash := TWinCrypt.CryptText(FProjPwd, PrivateKey2, True);
  Writer.WriteString(Hash);
end;

procedure TNSProject.EndLog;
var
  FN: string;
  FS: TStringList;
begin
  if FWriteLog then
  begin
    ForceDirectories(g_LogDir);
    if not DirectoryExists(g_LogDir) then
      Exit;
    FN := IncludeTrailingPathDelimiter(g_LogDir) + DisplayName + sLog;
    FS := TStringList.Create;
    try
      if FileExists(FN) then
        FS.LoadFromFile(FN);
      FLogFile.Add(EmptyStr);
      FLogFile.Add(Format(sLogEnded, [DisplayName, GetVolumeString(True), DateTimeToStr(Now)]));
      FS.AddStrings(FLogFile);
      FS.SaveToFile(FN);
    finally
      FS.Free;
    end;
  end;
end;

procedure TNSProject.StartLog;
var
  FS: TFileStream;
  FN: string;
begin
  if FWriteLog then
  begin
    if not ForceDirectories(g_LogDir) then
      Exit;
    FN := IncludeTrailingPathDelimiter(g_LogDir) + DisplayName + sLog;
    if FileExists(FN) then
    begin
      FS := TFileStream.Create(FN, fmOpenRead or fmShareExclusive);
      try
        if FS.Size > MAXWORD then
        begin
          CopyFile(PChar(FN), PChar(ChangeFileExt(FN, sBak)), False);
          DeleteFile(PChar(FN));
        end;
      finally
        FS.Free;
      end;
    end;
  end;
  FLogFile.Clear;
  FLogFile.Add(Format(sLogStarted, [DisplayName, GetVolumeString(True), DateTimeToStr(Now)]));
end;

function TNSProject.SupportsConnect: Boolean;
begin
  case FBackupMedia of
    bmLocal: Result := GetDriveType(PChar(ExtractFileDrive(FLocalFolder))) <> DRIVE_FIXED;
  else
    Result := True;
  end;
end;

function TNSProject.ReConnect: Boolean;
var
  RemoteFolder: string;
begin
  Result := False;
  try
    case FBackupMedia of
      bmLocal:
        begin
          RemoteFolder := IncludeTrailingPathDelimiter(FLocalFolder) + DisplayName;
          Result := DirectoryExists(RemoteFolder);
        end;
      bmFTP:
        begin
          FinalizeFTPSession;
          if FDialupConnection <> EmptyStr then
            try
              Result := InternetAutodial(INTERNET_AUTODIAL_FORCE_UNATTENDED, Application.MainFormHandle);
            except
              Result := False;
              Exit;
            end;
          Result := InitializeFTPSession(g_ConnectType, (HostName), (UserName), (Password), (Port), (g_ProxyName), (g_ProxyPort), EmptyStr, EmptyStr,
            Passive) = 0;
        end;
      bmCD:
        begin
          Result := DiskWriter.CheckDeviceReady;
        end;
      bmNAS:
        begin
          Result := ConnectToNAS(0, NetPath, NetUser, NetPass, FNasConnection);
        end;
    end;
  finally
    FConnected := Result;
  end;
end;

function TNSProject.OpenProject(const APassword: string): Boolean;
begin
  if Self.StoreArchivePwd or (Self.EncryptionMethod = tmNone) or (Self.ProjPwd = EmptyStr) then
    Result := True
  else
    Result := AnsiSameStr(Self.ProjPwd, APassword);
  FOpened := Result;
end;

function TNSProject.ConnectToMedia(const AWnd: HWnd): Boolean;
var
  RemoteFolder: string;
  ArchiveFolder: string;
begin
  Result := False;
  try
    case FBackupMedia of
      bmLocal:
        begin
          Result := FolderExists(FLocalFolder);
          if not Result then
          begin
            TraceLog(Format(sVerifyFolder, [FLocalFolder]), GetLastLocalResponse, Result);
            if AWnd <> 0 then
              MessageBox(AWnd, PChar(GetLastLocalResponse), PChar(sError), $00000030);
            Exit;
          end;

          RemoteFolder := IncludeTrailingPathDelimiter(FLocalFolder) + DisplayName;
          ArchiveFolder := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;

          Result := FolderExists(ArchiveFolder);

          if AWnd = 0 then
            Exit;
          if not Result then
          begin
            case MessageBox(GetActiveWindow, PChar(Format(sCreateDirConfirm, [ArchiveFolder])), PChar(sConfirm), $00000024) of
              idYes:
                begin
                  Result := ForceDirectories(ArchiveFolder);
                  g_dwLastError := GetLastError;
                  if not Result then
                    MessageBox(GetActiveWindow, PChar(Format(sErrorCreatingDir, [ArchiveFolder, GetLastLocalResponse])), PChar(sError), $00000030);
                end;
              idNo:
                begin
                  Result := False;
                end;
            end;
          end;
        end;
      bmFTP:
        begin
          FinalizeFTPSession;
          if FAutoDialUp then
            try
              Result := InternetAutodial(INTERNET_AUTODIAL_FORCE_UNATTENDED, Application.MainFormHandle);
            except
              Result := False;
              Exit;
            end;

          Result := InitializeFTPSession(g_ConnectType, (HostName), (UserName), (Password), (Port), (g_ProxyName), (g_ProxyPort), EmptyStr, EmptyStr,
            Passive) = 0;

          TraceLog(Format(sConnectingTo, [HostName]), StrPas(GetLastFTPResponse), Result);
          if not Result then
          begin
            if AWnd <> 0 then
              MessageBox(AWnd, PChar(Format(sCouldNotConnect, [StrPas(GetLastFTPResponse)])), PChar(sError), $00000030);
            FinalizeFTPSession;
            Exit;
          end;
          RemoteFolder := IncludeTrailingPathDelimiter(HostDirName) + FDisplayName;
          CreateFTPFolder(PChar(RemoteFolder));
          ArchiveFolder := IncludeTrailingPathDelimiter(RemoteFolder) + sArchives;
          CreateFTPFolder(PChar(ArchiveFolder));
          Result := { FTPDirectoryExists(PChar(RemoteFolder)) and } FTPDirectoryExists(PChar(ArchiveFolder));

          TraceLog(Format(sVerifiyng, [ArchiveFolder]), StrPas(GetLastFTPResponse), Result);
          if not Result then
          begin
            if AWnd <> 0 then
              case MessageBox(AWnd, PChar(Format(sCreateDirConfirm, [ArchiveFolder])), PChar(sConfirm), $00000024) of
                idYes:
                  begin
                    CreateFTPFolder(PChar(RemoteFolder));
                    CreateFTPFolder(PChar(ArchiveFolder));
                    Result := FTPDirectoryExists(PChar(RemoteFolder)) and FTPDirectoryExists(PChar(ArchiveFolder));
                    if not Result then
                      MessageBox(0, PChar(Format(SCannotCreateDir, [ArchiveFolder]) + Format(sResponse, [StrPas(GetLastFTPResponse)])), PChar(sError),
                        $00000030);
                  end;
                idNo:
                  begin
                    Result := False;
                  end;
              end;
            if not Result then
            begin
              FinalizeFTPSession;
              Exit;
            end;
          end;
          TraceLog(Format(sConnectingTo, [HostName]), StrPas(GetLastFTPResponse), Result);
          if not Result then
          begin
            if AWnd <> 0 then
              MessageBox(AWnd, PChar(Format(sCouldNotConnect, [StrPas(GetLastFTPResponse)])), PChar(sError), $00000030);
            FinalizeFTPSession;
            Exit;
          end;
        end;
      bmCD:
        begin
          Result := InitCDDrive;
          if not Result then
          begin
            TraceLog(SVerifyCD, SCDNotAvailable, Result);
            if AWnd <> 0 then
              MessageBox(AWnd, PChar(SCDNotAvailable), PChar(sError), $00000030);
            Exit;
          end;
          Result := DiskWriter.CheckDeviceReady;
          if not Result then
          begin
            TraceLog(SVerifyCD, SCDNotAvailable, Result);
            if AWnd <> 0 then
              MessageBox(AWnd, PChar(SCDNotAvailable), PChar(sError), $00000030);
            Exit;
          end;
        end;
      bmNAS:
        begin
          Result := ConnectToNAS(AWnd, NetPath, NetUser, NetPass, FNasConnection);
        end;
    end;
  finally
    FConnected := Result;
  end;
  if Result and (FProgress <> nil) then
    PlaySoundEvent(SConnectedSound);
end;

procedure TNSProject.Disconnect;
begin
  case FBackupMedia of
    bmFTP: FinalizeFTPSession;
    bmNAS: WNetCancelConnection2(PChar(FNasConnection), 0, True);
  end;
  FConnected := False;
end;

function TNSProject.Rename(const ANewDisplayName: string): Boolean;
var
  OldName: string;
  NewName: string;
  Task: TTaskItem;
begin
  try
    case CurProject.BackupMedia of
      bmLocal:
        begin
          OldName := IncludeTrailingPathDelimiter(LocalFolder) + DisplayName;
          NewName := IncludeTrailingPathDelimiter(LocalFolder) + ANewDisplayName;
          Result := MoveFile(PChar(OldName), PChar(NewName));
        end;
      bmFTP:
        begin
          OldName := IncludeTrailingPathDelimiter(HostDirName) + DisplayName;
          NewName := IncludeTrailingPathDelimiter(HostDirName) + ANewDisplayName;
          Result := RenameFTPFile(PChar(OldName), PChar(NewName)) = 0;
        end;
      bmCD:
        begin
          Result := False;
        end;
      bmNAS:
        begin
          OldName := IncludeTrailingPathDelimiter(FNetPath) + DisplayName;
          NewName := IncludeTrailingPathDelimiter(FNetPath) + ANewDisplayName;
          Result := MoveFile(PChar(OldName), PChar(NewName));
        end;
    else
      Result := False;
    end;
  except
    Result := False;
  end;
  if not Result then
    Exit;
  if frmMain.TaskManager.Active then
  begin
    Task := frmMain.TaskManager.ActivateTask(FDisplayName);
    if Assigned(Task) then
    begin
      Task.SaveTask(ANewDisplayName);
    end;
  end;
  if Result then
  begin
    FDisplayName := ANewDisplayName;
    FWasModified := True;
  end;
end;

function TNSProject.Move(const ANewLocation: string): Boolean;
var
  OldPath: string;
  NewPath: string;
  lpFileOp: TSHFileOpStruct;
begin
  Result := False;
  try
    case CurProject.BackupMedia of
      bmLocal, bmNAS:
        begin
          if ANewLocation <> EmptyStr then
            Result := ForceDirectories(ANewLocation);
          if not Result then
            Exit;
          if CurProject.BackupMedia = bmLocal then
            OldPath := IncludeTrailingPathDelimiter(FLocalFolder) + DisplayName
          else
            OldPath := IncludeTrailingPathDelimiter(FNasConnection) + DisplayName;

          NewPath := IncludeTrailingPathDelimiter(ANewLocation) + DisplayName;
          FillChar(lpFileOp, SizeOf(TSHFileOpStruct), 0);
          with lpFileOp do
          begin
            wFunc := FO_MOVE;
            fFlags := FOF_SILENT or FOF_NOERRORUI;
            pFrom := PChar(OldPath + #0);
            pTo := PChar(NewPath + #0);
          end;
          Result := SHFileOperation(lpFileOp) = 0;
          if lpFileOp.fAnyOperationsAborted then
            Result := False;

          if Result then
            FLocalFolder := ANewLocation;
        end;
      bmFTP:
        begin
          CreateFTPFolder(PChar(ANewLocation));
          OldPath := IncludeTrailingPathDelimiter(FHostDirName) + FDisplayName;
          NewPath := IncludeTrailingPathDelimiter(ANewLocation) + FDisplayName;
          Result := RenameFTPFile(PChar(OldPath), PChar(NewPath)) = 0;
          if Result then
            FHostDirName := ANewLocation;
        end;
    else
      Result := False;
    end;
  except
    Result := False;
  end;
end;

(*
  function TNSProject.AddBackupFolder(const AFolderName: string): TNSItem;
  var
  S: string;
  iPos: Integer;
  function iFindItem(const ACollection: TNSCollection): TNSItem;
  var
  Index: Integer;
  intPos: Integer;
  sDisplayName: string;
  CurItem: TNSItem;
  begin
  Result := nil;
  intPos := AnsiPos(sBackslash, S);
  if intPos > 0 then
  begin
  sDisplayName := Copy(S, 1, intPos - 1);
  Delete(S, 1, intPos);
  end
  else
  begin
  sDisplayName := S;
  S := EmptyStr;
  if sDisplayName = EmptyStr then Exit;
  end;
  for Index := 0 to ACollection.Count - 1 do
  begin
  CurItem := ACollection.Items[Index];
  if not CurItem.IsFolder then Continue;
  if AnsiSameText(sDisplayName, CurItem.FDisplayName) then
  begin
  Result := CurItem;
  Result.UModified := Now;
  Result.NotProcessed := True;
  //        Result.State := isBackup;
  Break;
  end;
  end;
  if Result <> nil then Exit;
  Result := ACollection.Add;
  Result.IsFolder := True;
  Result.FDisplayName := sDisplayName;
  Result.Created := Now;
  Result.UModified := Now;
  Result.NotProcessed := True;
  end;
  begin
  S := ExcludeTrailingPathDelimiter(AFolderName);
  iPos := AnsiPos(sColon, S);
  if iPos > 0 then
  begin
  Delete(S, iPos, 1);
  S := nsdPrefix + S;
  end;
  iPos := AnsiPos(sMachine, S);
  if iPos > 0 then
  begin
  Delete(S, iPos, 2);
  S := nscPrefix + S;
  end;
  Result := iFindItem(FItems);
  while (Result <> nil) and (S <> EmptyStr) do
  Result := iFindItem(Result.FSubItems);

  Result.BackupItem := True;
  Result.State := isBackup;
  end;
*)

function TNSProject.ProcessDelete: integer;

  function ProcessCollection(const ACollection: TNSCollection): integer;
  var
    Index: integer;
    CurItem: TNSItem;
    tmpResult: integer;
  begin
    Result := 0;
    ACollection.BeginUpdate;
    try
      for index := ACollection.Count - 1 downto 0 do
      begin
        if g_AbortProcess then
          Exit;
        CurItem := ACollection.Items[index];
        if CurItem.IsFolder then
        begin
          if CurItem.State = isDelete then
          begin
            tmpResult := ProcessCollection(CurItem.SubItems);
            Result := Result + tmpResult;
            if tmpResult = 0 then
              if not ACollection.DeleteFolder(index) then
                Inc(Result);
          end
          else
          begin
            tmpResult := ProcessCollection(CurItem.SubItems);
            Result := Result + tmpResult;
          end;
        end
        else
        begin
          if CurItem.NotProcessed and (CurItem.State = isDelete) then
          begin
            if not ACollection.DeleteItem(index) then
              Inc(Result);
          end;
        end;
      end;
    finally
      ACollection.EndUpdate;
    end;
  end;

begin
  LastRunTime := Now;
  Result := ProcessCollection(FItems);
end;

(*
  procedure TNSProject.ProcessAll(const AProcessAll: Boolean);
  var
  Count: Integer;
  OldSounds: Boolean;
  begin
  OldSounds := g_PlaySounds;
  if FProgress <> nil then
  begin
  PlaySoundEvent(SProcessStartSound);
  g_PlaySounds := False;
  end;
  StartLog;
  //  ExecuteExternal(True);
  try
  FNeedClose := False;
  FIsRunning := True;
  if FProgress <> nil then
  begin
  Count := GetNonProcCount;
  FProgress.CurProgress := 0;
  FProgress.ProgressBar.Max := Count;
  FProgress.Caption := Format(sProcessing, [DisplayName]);
  FProgress.CurAction := sPrep;
  Application.MainForm.Enabled := False;
  FProgress.Show;
  end;
  ProcessDelete;
  if FKind = pkArchive then
  ProcessBackups(AProcessAll)
  else
  ProcessRegularBackups(AProcessAll);
  ProcessRestore;
  finally
  if FProgress <> nil then
  begin
  Application.MainForm.Enabled := True;
  FProgress.Hide;
  Application.MainForm.Update;
  end;
  //    ExecuteExternal(False);
  EndLog;
  WasModified := True;
  FIsRunning := False;
  g_PlaySounds := OldSounds;
  if FProgress <> nil then
  PlaySoundEvent(SProcessCompletedSound);
  end;
  end;
*)

function TNSProject.PackFile(const ANameInp: string; const ANameOut: string; var ASize: int64): Boolean;
var
  FStreamInp: TFileStream;
  AuxStream: TStream;
  FStreamOut: TFileStream;
  dwSignature: DWORD;
  sAuxName: string;
  pCancel: Bool;
  sSrcFile: string;
  hTmp: THandle;
  errCode: DWORD;
begin
  Result := False;
  if g_AbortProcess then
  begin
    Exit;
  end;
  pCancel := False;

  hTmp := CreateFile(PChar(ANameInp), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  errCode := GetLastError;
  if hTmp <> INVALID_HANDLE_VALUE then
    CloseHandle(hTmp);

  if FileFormat = fmAsIs then
  begin
    if errCode in [ERROR_ACCESS_DENIED, ERROR_SHARING_VIOLATION] then
    begin
      Result := CopyFileRaw(PChar(ANameInp), PChar(ANameOut), @CopyProgressRoutine, FProgress, @pCancel, 0);
    end
    else
    begin
      if (Win32Platform = VER_PLATFORM_WIN32_NT) and (FProgress <> nil) then
        Result := CopyFileEx(PChar(ANameInp), PChar(ANameOut), @CopyProgressRoutine, FProgress, @pCancel, 0)
      else
        Result := CopyFile(PChar(ANameInp), PChar(ANameOut), False);
    end;
    ASize := FileGetSize(ANameOut);
    Exit;
  end;

  FStreamInp := nil;
  FStreamOut := nil;
  try
    try

      if errCode in [ERROR_ACCESS_DENIED, ERROR_SHARING_VIOLATION] then
      begin
        if not Result then
          Exit;
        sSrcFile := IncludeTrailingPathDelimiter(g_TempDir) + ExtractFileName(ANameInp);
        Result := CopyFileRaw(PChar(ANameInp), PChar(sSrcFile), @CopyProgressRoutine, FProgress, @pCancel, 0);
        if not Result then
          raise Exception.Create(SysErrorMessage(GetLastError));
        FStreamInp := TFileStream.Create(sSrcFile, fmOpenRead or fmShareDenyWrite);
      end
      else
        FStreamInp := TFileStream.Create(ANameInp, fmOpenRead or fmShareDenyWrite);
      FStreamOut := TFileStream.Create(ANameOut, fmCreate or fmShareDenyWrite);
      Result := Assigned(FStreamInp) and Assigned(FStreamOut);
    except
      Result := False;
    end;
    if not Result then
      Exit;

    // new realisation
    // if FNeedCrypting and (CompressionLevel > 0) then
    begin
      dwSignature := SID_FACE;
      FStreamOut.WriteBuffer(dwSignature, SizeOf(DWORD));
      FStreamOut.WriteBuffer(CompressionLevel, SizeOf(byte));
      FStreamOut.WriteBuffer(byte(EncryptionMethod), SizeOf(byte));
      FStreamOut.WriteBuffer(HashValue, SizeOf(HashValue));
    end;

    if FNeedCrypting then
    begin

      if FProgress <> nil then
        with FProgress do
        begin
          CurAction := sCompressing;
          Application.ProcessMessages;
        end;

      sAuxName := ChangeFileExt(ANameOut, sCmp);
      if FStreamInp.Size > dwHugeFile then
        AuxStream := TFileStream.Create(sAuxName, fmCreate or fmShareDenyWrite)
      else
        AuxStream := TMemoryStream.Create;
      try
        try
          if FProgress <> nil then
          begin
            CompressStream(FStreamInp, AuxStream, FProgress.ZipProgress, CompressionLevel);
            with FProgress do
            begin
              CurAction := sEncrypting;
              Application.ProcessMessages;
            end;
            FCrypt.OnProgress := FProgress.HashProgress;
          end
          else
          begin
            CompressStream(FStreamInp, AuxStream, nil, CompressionLevel);
          end;
          AuxStream.Position := 0;
          FCrypt.EncryptFile(AuxStream, FStreamOut);
          ASize := FStreamOut.Size;
          Result := True;
        except
          Result := False;
        end;
      finally
        AuxStream.Free;
        DeleteFile(PChar(sAuxName));
      end;
    end
    else
      try
        if FProgress <> nil then
          CompressStream(FStreamInp, FStreamOut, FProgress.ZipProgress, CompressionLevel)
        else
          CompressStream(FStreamInp, FStreamOut, nil, CompressionLevel);
        ASize := FStreamOut.Size;
        Result := True;
      except
        Result := False;
      end;

    if FileExists(sSrcFile) then
      DeleteFile(PChar(sSrcFile));
  finally
    if Assigned(FStreamInp) then
      FStreamInp.Free;
    if Assigned(FStreamOut) then
      FStreamOut.Free;
  end;
end;

function TNSProject.UnPackFile(const ANameInp, ANameOut: string; ANewHash: THashKey): Boolean;
var
  FStreamInp: TFileStream;
  AuxStream: TStream;
  // AuxStream: TMemoryStream;
  FStreamOut: TFileStream;
  dwSignature: DWORD;
  bBuffer: byte;
  // Commpression: Byte;
  sHash: THashKey;
  sEmpty: THashKey;
  sAuxName: string;
  sOldver: array [1 .. 8] of Char;
begin
  if g_AbortProcess then
  begin
    Result := False;
    Exit;
  end;

  if FileFormat = fmAsIs then
  begin
    Result := CopyFile(PChar(ANameInp), PChar(ANameOut), False);
    Exit;
  end;

  FStreamInp := nil;
  FStreamOut := nil;

  try
    DeleteFile(PChar(ANameOut));

    try
      FStreamInp := TFileStream.Create(ANameInp, fmOpenRead or fmShareDenyWrite);
      FStreamOut := TFileStream.Create(ANameOut, fmCreate or fmShareDenyWrite);
      Result := Assigned(FStreamInp) and Assigned(FStreamOut);
    except
      Result := False;
    end;

    if not Result then
      Exit;

    // new realisation
    FStreamInp.ReadBuffer(dwSignature, SizeOf(DWORD));
    if (dwSignature = SID_FACE) or (dwSignature = SID_FACE_AB3) then
    begin // new format
      FStreamInp.ReadBuffer(bBuffer, SizeOf(byte));
      FStreamInp.ReadBuffer(bBuffer, SizeOf(byte));
      g_Encryption := TEncryptionMethod(bBuffer);
      // old version AB3
      if (dwSignature = SID_FACE_AB3) then
      begin
        FStreamInp.ReadBuffer(sOldver, 8);
        Result := g_Encryption = tmNone;
      end
      else
      begin
        FStreamInp.ReadBuffer(sHash, SizeOf(sHash));
        sEmpty := FCrypt.HashEmpty;
        if CompareMem(@ANewHash, @sEmpty, SizeOf(THashKey)) then
          Result := CompareMem(@sHash, @HashValue, SizeOf(THashKey))
        else
          Result := CompareMem(@sHash, @ANewHash, SizeOf(THashKey));
      end;

      sAuxName := ChangeFileExt(ANameOut, sCmp);

      if not Result then
        Exit;
      if g_Encryption <> tmNone then
      begin // Decryption needed
        if FStreamInp.Size > dwHugeFile then
          AuxStream := TFileStream.Create(sAuxName, fmCreate or fmShareDenyWrite)
        else
          AuxStream := TMemoryStream.Create;
        try
          if FProgress <> nil then
            with FProgress do
            begin
              CurAction := sDecrypt;
              Application.ProcessMessages;
            end;

          try
            if FProgress <> nil then
              FCrypt.OnProgress := FProgress.HashProgress
            else
              FCrypt.OnProgress := nil;
            FCrypt.DecryptFile(FStreamInp, AuxStream);
            AuxStream.Position := 0;

            if FProgress <> nil then
              with FProgress do
              begin
                CurAction := sDecompress;
                Application.ProcessMessages;
              end;

            if FProgress <> nil then
              DecompressStream(AuxStream, FStreamOut, FProgress.ZipProgress)
            else
              DecompressStream(AuxStream, FStreamOut, nil);
            Result := True;
          except
            Result := False;
          end;
        finally
          AuxStream.Free;
          DeleteFile(PChar(sAuxName));
        end;
      end // Decryption needed
      else
      begin // No Decryption
        try
          if FProgress <> nil then
            DecompressStream(FStreamInp, FStreamOut, FProgress.ZipProgress)
          else
            DecompressStream(FStreamInp, FStreamOut, nil);
          Result := True;
        except
          Result := False;
        end;
      end; // No Decryption
    end // new format
    else
    begin // old format
      FStreamInp.Position := 0;

      if FNeedCrypting then
      begin
        if FStreamInp.Size > dwHugeFile then
          AuxStream := TFileStream.Create(sAuxName, fmCreate or fmShareDenyWrite)
        else
          AuxStream := TMemoryStream.Create;
        try
          try
            if FProgress <> nil then
              FCrypt.OnProgress := FProgress.HashProgress
            else
              FCrypt.OnProgress := nil;

            FCrypt.DecryptFile(FStreamInp, AuxStream);
            AuxStream.Position := 0;

            if FProgress <> nil then
            begin
              DecompressStream(AuxStream, FStreamOut, FProgress.ZipProgress);
            end
            else
            begin
              DecompressStream(AuxStream, FStreamOut, nil);
            end;
            Result := True;
          except
            Result := False;
          end;
        finally
          AuxStream.Free;
          DeleteFile(PChar(sAuxName));
        end;
      end
      else
        try
          if FProgress <> nil then
            DecompressStream(FStreamInp, FStreamOut, FProgress.ZipProgress)
          else
            DecompressStream(FStreamInp, FStreamOut, nil);
          Result := True;
        except
          Result := False;
        end;
    end;
  finally
    if FStreamInp <> nil then
      FStreamInp.Free;
    if FStreamOut <> nil then
      FStreamOut.Free;
  end;
end;

function TNSProject.ProcessRestore: integer;

  function ProcessCollection(const ACollection: TNSCollection): integer;
  var
    Index: integer;
    CurItem: TNSItem;
    tmpResult: integer;
  begin
    Result := 0;
    ACollection.BeginUpdate;
    try
      for index := ACollection.Count - 1 downto 0 do
      begin
        if g_AbortProcess or (FRestoreMR = mrCancel) then
          Abort;
        Application.ProcessMessages;
        CurItem := ACollection.Items[index];
        if CurItem.IsFolder then
        begin
          if CurItem.NotProcessed then
          begin
            tmpResult := ProcessCollection(CurItem.SubItems);
            Result := Result + tmpResult;
          end;
        end
        else
        begin
          if CurItem.NotProcessed and (CurItem.State = isRestore) and CurItem.Exists then
            if not CurItem.Restore then
              Inc(Result);
        end;
      end;
    finally
      ACollection.EndUpdate;
    end;
  end;

begin
  LastRunTime := Now;

  FRestoreMR := mrNone;
  FillChar(RestoreSR, SizeOf(TSearchRec), #0);

  ReInitCrypting;
  FRestoring := True;
  Result := ProcessCollection(FItems);
  FRestoring := False;
  if FProgress <> nil then
    NSChangeNotify(0, NSN_STATUSCHANGED, NSN_FLUSHNOWAIT, nil, nil);
end;

function TNSProject.GetNonProcCount(var ASize: int64): integer;

  procedure ScanSubItems(const AItems: TNSCollection);
  var
    Index: integer;
  begin
    AItems.BeginUpdate;
    try
      for index := 0 to AItems.Count - 1 do
        with AItems[index] do
        begin
          if NotProcessed then
          begin
            if IsFolder then
              ScanSubItems(SubItems)
            else if (State <> isNormal) then
            begin
              Inc(Result);
              case State of
                isBackup, isBackupReplace, isBackupUpdate, isBackupNewVersion: ASize := ASize + uSize;
                isRestore, isRestoreToFolder: ASize := ASize + Size;
                isDelete: ASize := ASize + SizeOnMedia;
              end;
            end;
          end;
        end;
    finally
      AItems.EndUpdate;
    end;
  end;

begin
  Result := 0;
  ASize := 0;
  ScanSubItems(FItems);
  Result := Result * 2;
end;

function TNSProject.CheckProject(ACheckFor: TCheckState): Boolean;
var
  gResult: Boolean;
  iResult: integer;

  function ScanSubItems(ASubItems: TNSCollection): integer;
  var
    Index: integer;
    CurItem: TNSItem;
    tmpResult: integer;
  begin
    Result := 0;
    ASubItems.BeginUpdate;
    try
      for index := 0 to ASubItems.Count - 1 do
      begin
        CurItem := ASubItems.Items[index];
        if CurItem.IsFolder then
        begin
          tmpResult := ScanSubItems(CurItem.SubItems);
          if tmpResult = 0 then
          begin
            if CurItem.Exists and (CurItem.State = isNormal) then
              CurItem.NotProcessed := False;
          end
          else
            CurItem.NotProcessed := True;
          Result := Result + tmpResult;
        end
        else if CurItem.NotProcessed then
        begin
          Inc(Result);
          case ACheckFor of
            csDelete:
              if CurItem.State = isDelete then
                gResult := False;
            csRestore:
              if CurItem.State in [isRestore, isRestoreToFolder] then
                gResult := False;
            csBackup:
              if (CurItem.State in [isBackup .. isBackupNewVersion]) then
                gResult := False;
          end;
        end;
      end;
    finally
      ASubItems.EndUpdate;
    end;
  end;

begin
  gResult := True;
  iResult := ScanSubItems(FItems);
  if ACheckFor = csAll then
    Result := iResult = 0
  else
    Result := gResult;
end;

procedure TNSProject.ReInitCrypting;
begin
  FNeedCrypting := EncryptionMethod <> tmNone;
  FCrypt.Password := ProjPwd;
  HashValue := FCrypt.HashKey;
end;

procedure TNSProject.KillProcessing;
begin
  g_AbortProcess := True;
end;

procedure TNSProject.Reset;

  procedure ScanSubItems(ACollection: TNSCollection);
  var
    Index: integer;
    CurItem: TNSItem;
  begin
    ACollection.BeginUpdate;
    try
      for index := ACollection.Count - 1 downto 0 do
      begin
        CurItem := ACollection.Items[index];
        if not CurItem.Exists then
          ACollection.Delete(CurItem.Index)
        else
        begin
          if CurItem.IsFolder then
            ScanSubItems(CurItem.SubItems)
          else
            CurItem.RollBack;
          CurItem.State := isNormal;
          CurItem.NotProcessed := False;
        end;
      end;
    finally
      ACollection.EndUpdate;
    end;
  end;

begin
  ScanSubItems(FItems);
end;

procedure TNSProject.Refresh;
var
  cIndex: integer;
  cItem: TNSItem;
begin
  g_AutoRefresh := False;
  g_AbortRefresh := False;
  FItems.BeginUpdate;
  try
    for cIndex := 0 to FItems.Count - 1 do
    begin
      if g_AbortRefresh then
        Abort;
      cItem := FItems[cIndex];
      cItem.Refresh;
    end;
  finally
    FItems.EndUpdate;
  end;
end;

function TNSProject.IsValidExt(const AFileName: string): Boolean;
var
  IncRslt: Boolean;
  ExcRslt: Boolean;
begin
  if FIncMasks.Count = 0 then
    IncRslt := True
  else
    IncRslt := FIncMasks.Matches(AFileName);

  if FExcMasks.Count = 0 then
    ExcRslt := True
  else
    ExcRslt := not FExcMasks.Matches(AFileName);
  Result := IncRslt and ExcRslt;
end;

procedure TNSProject.TraceLog(const AOperation, AResult: string; const Rslt: Boolean);
const
  Markers: array [Boolean] of Char = (#3, #1);
begin
  FLogFile.Add(Markers[Rslt]);
  FLogFile.Add(Markers[Rslt] + sOperation + #9 + AOperation);
  FLogFile.Add(Markers[Rslt] + sResult + #9#9 + AResult);
end;

function TNSProject.GetLog: TStrings;
begin
  Result := FLogFile;
end;

function TNSProject.GetCaption: string;
begin
  case FBackupMedia of
    bmLocal, bmNAS: Result := Format(sCaption, [DisplayName, GetVolumeString(False)]);
    bmFTP:
      begin
        Result := Format(sCaption, [FDisplayName, GetVolumeString(False)]);
      end;
    bmCD: Result := Format(sCaption, [DisplayName, GetVolumeString(False)]);
  end;
end;

function TNSProject.GetDeleteCount(var ASize: int64): integer;

  procedure ScanSubItems(const AItems: TNSCollection);
  var
    Index: integer;
  begin
    AItems.BeginUpdate;
    try
      for index := 0 to AItems.Count - 1 do
        with AItems[index] do
        begin
          if NotProcessed then
          begin
            if IsFolder then
              ScanSubItems(SubItems)
            else if (State = isDelete) then
            begin
              Inc(Result);
              ASize := ASize + SizeOnMedia;
            end;
          end;
        end;
    finally
      AItems.EndUpdate;
    end;
  end;

begin
  Result := 0;
  ASize := 0;
  ScanSubItems(FItems);
  Result := Result * 2;
end;

function TNSProject.GetBackupCount(var ASize: int64): integer;

  procedure ScanSubItems(const AItems: TNSCollection);
  var
    Index: integer;
  begin
    AItems.BeginUpdate;
    try
      for index := 0 to AItems.Count - 1 do
        with AItems[index] do
        begin
          if NotProcessed then
          begin
            if IsFolder then
              ScanSubItems(SubItems)
            else if (State in [isBackup .. isBackupNewVersion]) then
            begin
              Inc(Result);
              ASize := ASize + uSize;
            end;
          end;
        end;
    finally
      AItems.EndUpdate;
    end;
  end;

begin
  Result := 0;
  ASize := 0;
  ScanSubItems(FItems);
  Result := Result * 2;
end;

function TNSProject.GetRestoreCount(var ASize: int64): integer;

  procedure ScanSubItems(const AItems: TNSCollection);
  var
    Index: integer;
  begin
    AItems.BeginUpdate;
    try
      for index := 0 to AItems.Count - 1 do
        with AItems[index] do
        begin
          if NotProcessed then
          begin
            if IsFolder then
              ScanSubItems(SubItems)
            else if (State in [isRestore, isRestoreToFolder]) then
            begin
              Inc(Result);
              ASize := ASize + Size;
            end;
          end;
        end;
    finally
      AItems.EndUpdate;
    end;
  end;

begin
  Result := 0;
  ASize := 0;
  ScanSubItems(FItems);
  Result := Result * 2;
end;

procedure TNSProject.LogMsg(const AMessage: string);
begin
  FLogFile.Add(#1);
  FLogFile.Add(#1 + AMessage);
end;

procedure TNSProject.ExecuteExternal(const ABefore: Boolean);
var
  ExecRes: integer;
  ExeCmd: string;
  DoWait: Boolean;
begin
  if ABefore then
  begin
    ExeCmd := FExtAppBefore;
    DoWait := FWaitForExtAppBefore;
  end
  else
  begin
    ExeCmd := FExtAppAfter;
    DoWait := FWaitForExtAppAfter;
  end;
  if ExeCmd <> EmptyStr then
  begin
    if DoWait then
    begin
      // TraceLog(Format(sExecutingExternalApp, [ExeCmd]), '');
      if ABefore then
        ExecRes := ExecWait(ExeCmd, FTimeOutBefore)
      else
        ExecRes := ExecWait(ExeCmd, FTimeOutAfter);
      // if ExecRes <> 0 then
      TraceLog(Format(sExecutingExternalApp, [ExeCmd]), ErrorMsg(ExecRes), ExecRes = 0);
      // else
      // TraceLog(Format(sErrorExecute, [ExeCmd]), ErrorMsg(ExecRes))
    end
    else
    begin
      // TraceLog(Format(sExecutingExternalApp, [ExeCmd]), ErrorMsg(GetLastError));
      ExecuteApp(ExeCmd);
      TraceLog(Format(sExecutingExternalApp, [ExeCmd]), ErrorMsg(GetLastError), Boolean(GetLastError));
    end;
  end;
end;

procedure TNSProject.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  Index: integer;
  comp: TComponent;
begin
  for index := 0 to ComponentCount - 1 do
  begin
    comp := Components[index];
    if comp.Owner = Root then
      Proc(comp);
  end;
end;

function TNSProject.GetVolume(Index: integer): TNSProject;
begin
  if index = 0 then
    Result := Self
  else
    Result := TNSProject(Components[index - 1]);
end;

function TNSProject.GetVolumeCount: integer;
begin
  Result := ComponentCount + 1;
end;

function TNSProject.AddVolume: TNSProject;
begin
  Result := TNSProject.Create(Self);
end;

procedure TNSProject.DeleteVolume(Index: integer);
var
  Volume: TNSProject;
begin
  Volume := Volumes[index];
  RemoveComponent(Volume);
  Volume.Free;
end;

function TNSProject.GetDisplayName: string;
begin
  if (Owner = nil) or not(Owner is TNSProject) then
    Result := FDisplayName
  else
    Result := (Owner as TNSProject).DisplayName;
end;

function TNSProject.GetVolumeIndex: integer;
begin
  if (Owner = nil) or not(Owner is TNSProject) then
    Result := 0
  else
    Result := ComponentIndex + 1;
end;

procedure TNSProject.SetActiveVolume(const Value: TNSProject);
begin
  FActiveVolume := Value;
  FActiveVolumeIndex := FActiveVolume.VolumeIndex;
end;

procedure TNSProject.SetActiveVolumeIndex(const Value: integer);
begin
  FActiveVolumeIndex := Value;
  FActiveVolume := Volumes[FActiveVolumeIndex];
end;

function TNSProject.GetVolumeString(const AFull: Boolean): string;
var
  S: string;
begin
  case FBackupMedia of
    bmLocal: S := FLocalFolder;
    bmFTP:
      begin
        S := 'ftp://' + '/' + HostName + '/' + FHostDirName;
        S := StringReplace(S, '//', '/', [rfReplaceAll]);
      end;
    bmCD:
      begin
        S := DiskWriter.RecorderPath(CDIndex);
      end;
    bmNAS: S := NetPath;
  end;
  if AFull then
    Result := Format(sVolume + ' (%s)', [VolumeIndex, S])
  else
    Result := S;
end;

procedure TNSProject.SetDefaultValues;
begin
  if g_DefaultBackupDefined then
  begin
    FBackupMedia := TBackupMedia(g_DefaultBackupMedia);
    FLocalFolder := g_DefaultLocalFolder;
    FHostName := g_DefaultHostName;
    FPort := g_DefaultPort;
    FUserName := g_DefaultUserName;
    FPassword := g_DefaultPassword;
    FHostDirName := g_DefaultHostDirName;
    FPassive := g_DefaultUsePassive;
    FAutoDialUp := g_DefaultAutoDial;
    FHangUpOnCompleted := g_DefaultHangUpOnCompleted;
  end
  else
  begin
    FBackupMedia := TBackupMedia(g_LastMedia);
    LocalFolder := g_LastlocalFolder;
    NetPath := g_LastNetPath;
    FHostName := g_LastServer;
    FHostDirName := g_LastHostDir;
    FPort := g_DefaultPort;
    FUserName := g_LastUserName;
    FPassive := g_DefaultUsePassive;
  end;
end;

procedure TNSProject.AssignTo(Dest: TPersistent);
begin
  if Dest is TNSProject then
    with Dest as TNSProject do
    begin
      FProjPwd := Self.FProjPwd;
      FDisplayName := Self.FDisplayName;
      FHostName := Self.FHostName;
      FPassive := Self.FPassive;
      FPort := Self.FPort;
      FUserName := Self.FUserName;
      FPassword := Self.FPassword;
      FStoreArchivePwd := Self.StoreArchivePwd;
      FHostDirName := Self.FHostDirName;
      FBackupMedia := Self.FBackupMedia;
      FLocalFolder := Self.FLocalFolder;
      FEncryptionMethod := Self.FEncryptionMethod;
      FDefaultAction := Self.FDefaultAction;
      FWriteLog := Self.FWriteLog;
      FKind := Self.FKind;
      FSendLog := Self.FSendLog;
      FIncMasks.SetMask(Self.FIncMasks.GetMask);
      FExcMasks.SetMask(Self.FExcMasks.GetMask);
      FCompressionLevel := Self.FCompressionLevel;
      FAutoDialUp := Self.FAutoDialUp;
      FHangUpOnCompleted := Self.FHangUpOnCompleted;
      FWaitForExtAppAfter := Self.FWaitForExtAppAfter;
      FWaitForExtAppBefore := Self.FWaitForExtAppBefore;
      FExtAppBefore := Self.FExtAppBefore;
      FExtAppAfter := Self.FExtAppAfter;
      FCDIndex := Self.FCDIndex;
      FCDErase := Self.FCDErase;
      FFileFormat := Self.FFileFormat;

    end;
end;

function TNSProject.CheckVolumes(ACheckFor: TCheckState): Boolean;
var
  Index: integer;
  Volume: TNSProject;
  Rslt: Boolean;
begin
  Result := True;
  for index := 0 to VolumeCount - 1 do
  begin
    Volume := Volumes[index];
    Rslt := Volume.CheckProject(ACheckFor);
{$B+}
    Result := Result and Rslt;
{$B-}
  end;
  if SendLog = smAlways then
    SendReport(Self)
  else if (SendLog = smOnFailure) and not Result then
    SendReport(Self);
end;

procedure TNSProject.SetExcMasks(const Value: TMaskItems);
var
  Index: integer;
  S: string;
begin
  if csLoading in ComponentState then
    FExcMasks := Value
  else
  begin
    S := Value.GetMask;
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FExcMasks.SetMask(S);
  end;
end;

procedure TNSProject.SetIncMasks(const Value: TMaskItems);
var
  Index: integer;
  S: string;
begin
  if csLoading in ComponentState then
    FIncMasks := Value
  else
  begin
    S := Value.GetMask;
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FIncMasks.SetMask(S);
  end;
end;

procedure TNSProject.SetDisplayName(const Value: string);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FDisplayName := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FDisplayName := Value;
end;

procedure TNSProject.SetKind(const Value: TProjectKind);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FKind := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FKind := Value;
end;

procedure TNSProject.SetEncryptionMethod(const Value: TEncryptionMethod);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FEncryptionMethod := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FEncryptionMethod := Value;
end;

procedure TNSProject.SetCompressionLevel(const Value: byte);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FCompressionLevel := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FCompressionLevel := Value;
end;

procedure TNSProject.SetDefaultAction(const Value: TDefaultAction);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FDefaultAction := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FDefaultAction := Value;
end;

procedure TNSProject.SetItems(const Value: TNSCollection);
begin
  if FItems <> nil then
    FItems.Free;
  FItems := Value;
  FItems.FProject := Self;
end;

procedure TNSProject.SetAutoMangle(const Value: Boolean);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FAutoMangle := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FAutoMangle := Value;
end;

procedure TNSProject.SetSyncMode(const Value: TSyncMode);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FSyncMode := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FSyncMode := Value;
end;

function TNSProject.ForceCollection(const APath: string): TNSCollection;
var
  nPos: integer;
  sBuffer: string;
  sItemName: string;
  xItem: TNSItem;
begin
  sBuffer := AnsiReplaceStr(APath, sSlash, sBackslash);
  Result := FItems;
  if (APath = EmptyStr) or (APath = sBackslash) then
    Exit
  else
  begin
    while sBuffer <> EmptyStr do
    begin
      nPos := AnsiPos(sBackslash, sBuffer);
      if nPos > 0 then
      begin
        sItemName := Copy(sBuffer, 1, nPos - 1);
        Delete(sBuffer, 1, nPos);
      end
      else
      begin
        sItemName := sBuffer;
        sBuffer := EmptyStr;
      end;
      if (sItemName = EmptyStr) or (sItemName = sBackslash) then
        Exit;
      xItem := Result.FindItem(sItemName);
      if (xItem <> nil) and xItem.IsFolder then
      begin
        Result := xItem.FSubItems;
      end
      else
      begin
        xItem := Result.Add;
        xItem.IsFolder := True;
        xItem.DisplayName := sItemName;
        xItem.Created := Now;
        Result := xItem.FSubItems;
      end;
    end;
  end;
end;

function TNSProject.NormalizePath(const APath: string): string;
var
  nPos: integer;
begin
  Result := APath;
  nPos := AnsiPos(sColon, Result);
  if nPos > 0 then
  begin
    Delete(Result, nPos, 1);
    Result := nsdPrefix + Result;
  end
  else
  begin
    nPos := AnsiPos(sMachine, Result);
    if nPos > 0 then
    begin
      Delete(Result, nPos, 2);
      Result := nscPrefix + Result;
    end;
  end;
  Result := ExcludeTrailingPathDelimiter(Result);
  // SetLength(Result, Length(Result) - 1);
  if FBackupMedia = bmFTP then
    Result := AnsiReplaceStr(Result, sBackslash, sSlash);
end;

function TNSProject.FindCollection(const APath: string): TNSCollection;
var
  nPos: integer;
  sBuffer: string;
  sItemName: string;
  xItem: TNSItem;
begin
  sBuffer := AnsiReplaceStr(APath, sSlash, sBackslash);
  Result := FItems;
  if (APath = EmptyStr) or (APath = sBackslash) then
    Exit
  else
  begin
    while sBuffer <> EmptyStr do
    begin
      nPos := AnsiPos(sBackslash, sBuffer);
      if nPos > 0 then
      begin
        sItemName := Copy(sBuffer, 1, nPos - 1);
        Delete(sBuffer, 1, nPos);
      end
      else
      begin
        sItemName := sBuffer;
        sBuffer := EmptyStr;
      end;
      if (sItemName = EmptyStr) or (sItemName = sBackslash) then
        Exit;
      xItem := Result.FindItem(sItemName);
      if (xItem <> nil) and xItem.IsFolder then
      begin
        Result := xItem.FSubItems;
      end
      else
      begin
        Result := nil;
        Exit;
      end;
    end;
  end;
end;

function TNSProject.GetHostName: string;
begin
  if Pos('ftp://', FHostName) = 1 then
    Result := Copy(FHostName, 7, MaxInt)
  else
    Result := FHostName;
end;

function TNSProject.ProcessBackup: integer;

  function ProcessCollection(const ACollection: TNSCollection): integer;
  var
    Index: integer;
    CurItem: TNSItem;
    tmpResult: integer;
    S: string;
  begin
    Result := 0;
    ACollection.BeginUpdate;
    try
      for index := ACollection.Count - 1 downto 0 do
      begin
        if g_AbortProcess then
          Break;
        Application.ProcessMessages;
        CurItem := ACollection.Items[index];
        if CurItem.IsFolder then
        begin
          if CurItem.State <> isDelete then
          begin
            if CurItem.VerifyPath then
            begin
              CurItem.Exists := True;
              tmpResult := ProcessCollection(CurItem.SubItems);
              Result := Result + tmpResult;
              if CurItem.SubItems.Count = 0 then
              begin
                CurItem.State := isNormal;
                CurItem.NotProcessed := False;
              end;
            end
            else
            begin
              Inc(Result);
              CurItem.NotProcessed := True;
              S := IncludeTrailingPathDelimiter(CurItem.Project.LocalFolder) + CurItem.GetPathOnMedia + CurItem.DisplayName;
              TraceLog(Format(sCreateDir, [S]), ErrorMsg(GetLastError), False);
            end;
          end;
        end
        else
        begin
          if CurItem.NotProcessed and (CurItem.State in [isBackup .. isBackupNewVersion]) then
          begin
            if (FMediaSize > 0) and (FBackupSize > FMediaSize) then
            begin
              TraceLog(sAddingToCD, ErrorMsg(ERROR_HANDLE_DISK_FULL), False);
              CurItem.NotProcessed := True;
              Exit;
            end;
            if IsValidExt(CurItem.DisplayName) then
            begin
              if not CurItem.Backup then
                Inc(Result);
            end
            else
              Inc(Result);
          end;
        end;
      end;
    finally
      ACollection.EndUpdate;
    end;
  end;

// var
// lpFileOp: TSHFileOpStruct;
// SRealFileName: string;
begin
  LastRunTime := Now;
  FBackupSize := 0;

  // 2.1
  Result := ProcessCollection(FItems);
  if FProgress <> nil then
    NSChangeNotify(0, NSN_STATUSCHANGED, NSN_FLUSHNOWAIT, nil, nil);

end;

procedure TNSProject.SetLocalFolder(const Value: string);
begin
  FLocalFolder := Value;
end;

procedure TNSProject.SetNetPath(const Value: string);
begin
  FNetPath := Value;
end;

procedure TNSProject.SetNetUser(const Value: string);
begin
  FNetUser := Value;
end;

function TNSProject.GetIsCDMedia: Boolean;
begin
  Result := False;
  // Result := GetDriveType(PChar(ExtractFileDrive(FLocalFolder))) = DRIVE_CDROM;
end;

procedure TNSProject.CleanProject;
var
  Index: integer;
  Volume: TNSProject;
  RemoteFolder: string;
begin
  if frmMain.TaskManager.Active then
    try
      if frmMain.TaskManager.ActivateTask(DisplayName) <> nil then
        frmMain.TaskManager.DeleteTask(DisplayName);
    except
    end;
  for index := 0 to VolumeCount - 1 do
    try
      Volume := Volumes[index];
      case Volume.BackupMedia of
        bmLocal:
          begin
            RemoteFolder := IncludeTrailingPathDelimiter(Volume.LocalFolder) + DisplayName;
            RemoveDirectory(PChar(IncludeTrailingPathDelimiter(RemoteFolder) + sArchives));
            RemoveDirectory(PChar(RemoteFolder));
          end;
        bmFTP:
          begin
            if Volume.ConnectToMedia(Application.MainForm.Handle) then
            begin
              RemoteFolder := IncludeTrailingPathDelimiter(Volume.HostDirName) + DisplayName;
              DeleteFTPFolder(PChar(IncludeTrailingPathDelimiter(RemoteFolder) + sArchives));
              DeleteFTPFolder(PChar(RemoteFolder));
            end;
          end;
        bmNAS:
          begin
            RemoteFolder := IncludeTrailingPathDelimiter(Volume.FNasConnection) + DisplayName;
            RemoveDirectory(PChar(IncludeTrailingPathDelimiter(RemoteFolder) + sArchives));
            RemoveDirectory(PChar(RemoteFolder));
          end;
      end;
    except
      Continue;
    end;
end;

function TNSProject.InitCDDrive: Boolean;
begin
  FCDDrivePath := EmptyStr;
  try
    Result := (CDIndex <> -1) and (CDIndex < DiskWriter.GetRecorderCount);
    if not Result then
      Exit;
    DiskWriter.SetActiveRecorder(CDIndex);
    FCDDrivePath := DiskWriter.DevicePath(CDIndex);
  except
    Result := False;
  end;
end;

function TNSProject.ImportCDMedia: Boolean;

  procedure ScanSubItems(const ACollection: TNSCollection);
  var
    I: integer;
    VerNo: integer;
    Item: TNSItem;
    sRemoteName: string;
    sLocalName: string;
  begin
    for I := 0 to ACollection.Count - 1 do
    begin
      if g_AbortProcess then
        Exit;
      Application.ProcessMessages;
      Item := ACollection[I];
      if Item.IsFolder then
      begin
        sRemoteName := CDDrivePath + Item.GetPathOnMedia;
        if DirectoryExists(sRemoteName) then
        begin
          Item.VerifyPath;
          ScanSubItems(Item.SubItems);
        end;
      end
      else
        try
          for VerNo := 0 to Item.Versions.Count - 1 do
          begin
            if g_AbortProcess then
              Exit;
            Application.ProcessMessages;
            sRemoteName := CDDrivePath + Item.FileNameOnServer(Item.Versions[VerNo].FNumber);
            if FileExists(sRemoteName) then
            begin
              sLocalName := Item.AuxFileName(Item.Versions[VerNo].FNumber);
              if CopyFile(PChar(sRemoteName), PChar(sLocalName), True) then
              begin
                Result := True;
                sRemoteName := Item.GetPathOnMedia;
                DiskWriter.InsertFile(sRemoteName, sLocalName);
              end;
            end;
          end;
        except
          Continue;
        end;
    end;
  end;

begin
  Result := False;
  ScanSubItems(FItems);
end;

procedure TNSProject.SetProgress(const AOperation, AFileName: string; const ACurrent, ATotal: int64);
begin
  if FProgress = nil then
    Exit;
  FProgress.SetProgress(AOperation, AFileName, ACurrent, ATotal);
end;

function TNSProject.FinalizeMedia: Boolean;
var
  lpFileOp: TSHFileOpStruct;
  sProjectFile: string;
  sOldProjectFile: string;
begin
  Result := True;
  case BackupMedia of
    bmCD:
      begin
        DiskWriter.BurnerWriteDone := False;
        DiskWriter.BurnerEraseDone := False;
        if BurningRequired then
        begin
          DiskWriter.RecorderOpen;
          try
            SetProgress(EmptyStr, sInitCD, 0, 0);

            if DiskWriter.FilesCount = 0 then
              Exit;

            sOldProjectFile := Self.FileName;
            sProjectFile := IncludeTrailingPathDelimiter(g_TempDir + STmpFolder) + sRemoteFileName;
            Self.SaveToFile(sProjectFile, False);
            DiskWriter.InsertFile(sBackslash + Self.DisplayName + sBackslash, sProjectFile);
            Self.FileName := sOldProjectFile;
            if not DiskWriter.RecordDisk(True, False, True) then
              Exit;
            SetProgress(EmptyStr, sWriteToCD, 0, DiskWriter.GetClass.ImageSize);
            if FProgress <> nil then
              FProgress.ProgressBar2.Position := FProgress.ProgressBar2.Max div 2;

            repeat
              if g_AbortProcess then
              begin
                DiskWriter.AbortProcess;
                Break;
              end;
              Application.ProcessMessages;
              SetProgress(EmptyStr, sWriteToCD, DiskWriter.GetClass.BytesWritten div 2048, DiskWriter.GetClass.ImageSize);
            until DiskWriter.BurnerWriteDone or g_AbortProcess;
          finally
            DiskWriter.RecorderClose;
            DiskWriter.ReloadMedium;

            if DirectoryExists(g_TempDir + STmpFolder) then
            begin
              FillChar(lpFileOp, SizeOf(TSHFileOpStruct), #0);
              with lpFileOp do
              begin
                wFunc := FO_DELETE;
                fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
                pFrom := PChar(g_TempDir + STmpFolder + #0);
              end;
              SHFileOperation(lpFileOp);
            end;
          end;
        end;
      end
  end;
end;

function TNSProject.InitializeMedia(const AState: TCheckState): Boolean;
{$IFDEF USE_MCDB}
var
  DirEntry: PDirEntry;
{$ENDIF}
begin
  BurningRequired := False;
  case BackupMedia of
    bmCD:
      try
        Result := DiskWriter.CheckDeviceReady;
        if not Result then
        begin
          TraceLog(Format(sVerifyFolder, [FCDDrivePath]), SCDNotAvailable, False);
          Exit;
        end;

        // CDWriter.WriteSpeed here?

        Result := DiskWriter.IsWriteableMedia;
        FCDWriteable := Result;
        if not Result then
        begin
          TraceLog(Format(sVerifyFolder, [FCDDrivePath]), SDiskClosed, False);
          Exit;
        end;

        // FMediaSize := int64(frmMain.CDWriter.GetMediaInfo.FreeBlocks) - 2048;
        if FMediaSize < 0 then
          FMediaSize := 0;
        FMediaSize := FMediaSize * 2048;
{$IFDEF USE_MCDB}
        if ([AState] * [csAll, csBackup] <> []) then
        begin
          DirEntry := DiskWriter.CreateDir(DisplayName);
          Result := DirEntry <> nil;
          if not Result then
            Exit;
          DirEntry := DiskWriter.CreateDir(DirEntry, sArchives);
          Result := DirEntry <> nil;
        end;
{$ENDIF}
      except
        Result := False;
      end;
  else
    begin
      Result := True;
      FMediaSize := -1;
    end;
  end;
end;

procedure TNSProject.SetFileFormat(const Value: TFileFormat);
var
  Index: integer;
begin
  if csLoading in ComponentState then
    FFileFormat := Value
  else
    for index := 0 to VolumeCount - 1 do
      Volumes[index].FFileFormat := Value;
end;

procedure TNSProject.SetHostDirName(const Value: string);
begin
  FHostDirName := AnsiReplaceStr(Value, sBackslash, sSlash);
end;

{ TNSItem }

function TNSItem.Backup: Boolean;
var
  LocalFileName: string;
  tmpSize: int64;
  RemoteFileName: string;
  TempFilename: string;
  sLog: string;
  SR: TSearchRec;
  xSize: int64;
  xSizeOnMedia: int64;
  xModified: TDateTime;
  pCancel: Bool;
begin
  Result := False;
  LocalFileName := IncludeTrailingPathDelimiter(LocalPath) + Self.DisplayName;
  with FProject do
    try
      if g_AbortProcess then
        Exit;

      if FProgress <> nil then
        with FProgress do
        begin
          CurItemSize := uSize;
          CurFile := LocalFileName;
          CurAction := sCompressing;
          Application.ProcessMessages;
          if g_AbortProcess then
            Exit;
        end;

      if FindFirst(LocalFileName, faAnyFile, SR) <> 0 then
      begin
        FProject.TraceLog(Format(sBackupItem, [LocalFileName]), ErrorMsg(ERROR_FILE_NOT_FOUND), False);
        Exit;
      end;

      xSize := FileGetSize(SR);
      xModified := FileGetModified(SR);

      FindClose(SR);

      if FDefAction = daNewVersion then
      begin
        RemoteFileName := FileNameOnServer(Self.versionNumber + 1);
        TempFilename := AuxFileName(Self.versionNumber + 1);
      end
      else
      begin
        RemoteFileName := FileNameOnServer(Self.versionNumber);
        TempFilename := AuxFileName(Self.versionNumber);
      end;

      if FileFormat = fmAsIs then
      begin
        tmpSize := FileGetSize(LocalFileName);
        TempFilename := LocalFileName;
        Result := tmpSize <> -1;
      end
      else
      begin
        Result := PackFile(LocalFileName, TempFilename, tmpSize);
      end;

      if Result then
      begin
        xSizeOnMedia := tmpSize;
        tmpSize := (tmpSize div 2048 + 1) * 2048;
        FProject.BackupSize := FProject.BackupSize + tmpSize;
      end
      else
      begin
        sLog := ErrorMsg(GetLastError);
        FProject.TraceLog(Format(sBackupItem, [LocalFileName]), sLog, False);
        Exit;
      end;

      if FProgress <> nil then
        with FProgress do
        begin
          CurAction := sTransfer;
          if g_AbortProcess then
            Exit;
        end;

      case FProject.BackupMedia of
        bmLocal, bmNAS:
          begin
            Result := ForceDirectories(ExtractFilePath(RemoteFileName));
            if not Result then
            begin
              sLog := ErrorMsg(ERROR_CANNOT_MAKE);
            end
            else
            begin
              pCancel := False;
              if (Win32Platform = VER_PLATFORM_WIN32_NT) and (FProgress <> nil) then
                Result := CopyFileEx(PChar(TempFilename), PChar(RemoteFileName), @CopyProgressRoutine, FProgress, @pCancel, 0)
              else
                Result := CopyFile(PChar(TempFilename), PChar(RemoteFileName), False);

              sLog := ErrorMsg(GetLastError);
              if FileFormat <> fmAsIs then
                DeleteFile(PChar(TempFilename));
            end;
            if Result then
            begin
              State := isNormal;
              NotProcessed := False;
              Result := True;
            end;
          end;
        bmFTP:
          begin
            if FProgress <> nil then
              Result := UploadFTPFile(PChar(TempFilename), PChar(RemoteFileName), FProgress.FTPProgress) = 0
            else
              Result := UploadFTPFile(PChar(TempFilename), PChar(RemoteFileName), nil) = 0;

            if not Result then
              if FProject.ReConnect then
              begin
                if FProgress <> nil then
                  Result := UploadFTPFile(PChar(TempFilename), PChar(RemoteFileName), FProgress.FTPProgress) = 0
                else
                  Result := UploadFTPFile(PChar(TempFilename), PChar(RemoteFileName), nil) = 0;
              end;

            sLog := StrPas(GetLastFTPResponse);

            if Result then
            begin
              State := isNormal;
              NotProcessed := False;
              Result := True;
            end;
            if FileFormat <> fmAsIs then
              DeleteFile(PChar(TempFilename));
          end;
        bmCD:
          begin
            RemoteFileName := ExtractFilePath(RemoteFileName);
            Result := DiskWriter.InsertFile(RemoteFileName, TempFilename) = 1;
            if Result then
            begin
              BurningRequired := True;
              State := isNormal;
              NotProcessed := False;
              Result := True;
              sLog := ErrorMsg(NO_ERROR);
            end
            else
              sLog := ErrorMsg(ERROR_PATH_NOT_FOUND);
          end;
      end;

      if Result then
      begin
        if FDefAction = daNewVersion then
          Self.Versions.Add;
        Self.Size := xSize;
        Self.FUSize := 0;
        Self.SizeOnMedia := xSizeOnMedia;
        Self.Modified := xModified;
        Self.FUModified := 0;
        Self.FULocalPath := EmptyStr;
        Self.Exists := True;
        State := isNormal;
      end;

    finally
      if FProgress <> nil then
        FProgress.UpdateProgress;
      FProject.TraceLog(Format(sBackupItem, [LocalFileName]), sLog, Result);
    end;
end;

constructor TNSItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FProject := TNSCollection(ACollection).FProject;
  FSubItems := nil;
  FVersions := nil;
end;

function TNSItem.DeleteVersion(const AVersion: integer): Boolean;
var
  RemoteFileName: string;
  sLog: string;
  // sSourceDir: string;
  // sSourceFile: string;
begin
  Result := False;
  RemoteFileName := FileNameOnServer(AVersion);
  case FProject.BackupMedia of
    bmLocal, bmNAS:
      begin
        Result := DeleteFile(PChar(RemoteFileName));
        sLog := ErrorMsg(GetLastError);
      end;
    bmFTP:
      begin
        Result := DeleteFTPFile(PChar(RemoteFileName)) = 0;
        if not Result then
          if FProject.ReConnect then
            Result := DeleteFTPFile(PChar(RemoteFileName)) = 0;
        sLog := StrPas(GetLastFTPResponse);
      end;
    bmCD:
      begin
        Result := False;
        {
          sSourceDir := GetPathOnMedia;
          sSourceFile := NS_Name(AVersion);
          Result := NSMainForm.CDBurner.RemoveFile(sSourceDir, sSourceFile);
          if Result then
          sLog := ErrorMsg(NO_ERROR)
          else
          sLog := ErrorMsg(ERROR_FILE_NOT_FOUND);
        }
      end;
  end;
  FProject.TraceLog(Format(sFileDeletion, [RemoteFileName]), sLog, Result);
end;

destructor TNSItem.Destroy;
begin
  if FSubItems <> nil then
    FSubItems.Free;
  if FVersions <> nil then
    FVersions.Free;
  inherited Destroy;
end;

function TNSItem.FileNameOnServer(const AVersion: integer): string;
begin
  Result := NS_Name(AVersion);
  with FProject do
    case BackupMedia of
      bmLocal: Result := IncludeTrailingPathDelimiter(FLocalFolder) + GetPathOnMedia + Result;
      bmFTP: Result := IncludeTrailingPathDelimiter(FHostDirName) + GetPathOnMedia + Result;
      bmCD: Result := GetPathOnMedia + Result;
      bmNAS: Result := IncludeTrailingPathDelimiter(FNasConnection) + GetPathOnMedia + Result;
    end;
end;

function TNSItem.GetDestFolder: string;
begin
  if FDestFolder <> EmptyStr then
    Result := FDestFolder
  else
    Result := FLocalPath;
end;

function TNSItem.GetDisplayName: string;
var
  iPos: integer;
begin
  iPos := AnsiPos(nsdPrefix, FDisplayName);
  if iPos > 0 then
  begin
    Result := Copy(FDisplayName, 6, 1) + sDrive;
    Exit;
  end;
  iPos := AnsiPos(nscPrefix, FDisplayName);
  if iPos > 0 then
  begin
    Result := FDisplayName;
    Delete(Result, 1, 5);
    Result := sMachine + Result;
    Exit;
  end;
  Result := FDisplayName;
end;

function TNSItem.GetModified: TDateTime;
begin
  if IsFolder then
    Result := FModified
  else if (FVersions <> nil) and (FVersions.Count > 0) then
    Result := FVersions.Items[FVersions.Count - 1].FModified
  else
    Result := 0;
end;

function TNSItem.GetPathOnMedia: string;
var
  lOwner: TNSItem;
begin
  Result := EmptyStr;
  lOwner := TNSCollection(Self.Collection).GetParentItem;
  with TNSCollection(Self.Collection).FProject do
  begin
    while lOwner <> nil do
    begin
      // Here must be FDisplayName
      Result := lOwner.FDisplayName + PathDelimiter + Result;
      lOwner := TNSCollection(lOwner.Collection).GetParentItem;
    end;
    case FBackupMedia of
      bmLocal: Result := DisplayName + #92 + sArchives + #92 + Result;
      bmFTP: Result := DisplayName + #47 + sArchives + #47 + Result;
      bmCD: Result := #92 + DisplayName + #92 + sArchives + #92 + Result;
      bmNAS: Result := DisplayName + #92 + sArchives + #92 + Result;
    end;
  end;
end;

function TNSItem.GetSize: int64;
begin
  if (FVersions <> nil) and (FVersions.Count > 0) then
    Result := FVersions.Items[FVersions.Count - 1].FSize
  else
    Result := 0;
end;

function TNSItem.GetSizeOnMedia: int64;
var
  Index: integer;
begin
  Result := 0;
  if FVersions = nil then
    Exit;
  for index := 0 to FVersions.Count - 1 do
    if FVersions[index].Exists then
      Result := Result + FVersions[index].FSizeOnMedia;
end;

function TNSItem.GetVersion: integer;
begin
  if (FVersions <> nil) and (FVersions.Count > 0) then
    Result := FVersions.Items[FVersions.Count - 1].FNumber
  else
    Result := 0;
end;

function TNSItem.IndexOfVersion(AVersionNumber: integer): integer;
var
  Index: integer;
begin
  Result := -1;
  if FVersions = nil then
    Exit;
  for index := 0 to FVersions.Count - 1 do
    if FVersions[index].FNumber = AVersionNumber then
    begin
      Result := index;
      Break;
    end;
end;

function TNSItem.NS_Name(const AVersion: integer): string;
var
  tmpExt: string;
  nsz: string;
  tmpName: string;
begin
  if FIsFolder or (FProject.FileFormat = fmAsIs) then
    Result := FDisplayName
  else
  begin
    tmpExt := ExtractFileExt(FDisplayName);

    if IsNameMangled then
    begin
      tmpName := FRemoteName;
      nsz := sMsz;
    end
    else
    begin
      tmpName := FDisplayName;
      nsz := sNsz;
    end;

    if AVersion >= 0 then
      nsz := nsz + IntToHex(AVersion, 3);
    if tmpExt <> EmptyStr then
      Result := ChangeFileExt(tmpName, tmpExt + nsz)
    else
      Result := ChangeFileExt(tmpName, nsz);
  end;
end;

function TNSItem.Rename(const ANewName: string): Boolean;
var
  Path: string;
  OldName: string;
  NewName: string;
  Proj: TNSProject;
  nsz: string;
  VerNo: integer;
begin
  Result := False;
  Proj := TNSCollection(Self.Collection).FProject;
  case Proj.BackupMedia of
    bmLocal: Path := IncludeTrailingPathDelimiter(Proj.LocalFolder) + GetPathOnMedia;
    bmFTP: Path := IncludeTrailingPathDelimiter(Proj.HostDirName) + GetPathOnMedia;
    bmNAS: Path := IncludeTrailingPathDelimiter(Proj.NetPath) + GetPathOnMedia;
  end;
  if IsNameMangled then
  begin
    OldName := Path + FRemoteName;
    NewName := Path + MangleFileName(ANewName);
  end
  else
  begin
    OldName := Path + FDisplayName;
    NewName := Path + ANewName;
  end;
  if Self.IsFolder then
    try
      case Proj.BackupMedia of
        bmLocal, bmNAS: Result := MoveFile(PChar(OldName), PChar(NewName));
        bmFTP: Result := RenameFTPFile(PChar(OldName), PChar(NewName)) = 0
      else
        Result := False;
      end;
    except
      Result := False;
    end
  else
    try
{$B+}
      Result := False;
      for VerNo := 0 to Versions.Count - 1 do
      begin
        if FProject.FileFormat = fmAsIs then
          nsz := EmptyStr
        else
        begin
          if IsNameMangled then
            nsz := sMsz
          else
            nsz := sNsz;
          nsz := nsz + IntToHex(Versions[VerNo].Number, 3);
        end;
        case Proj.BackupMedia of
          bmLocal, bmNAS: Result := Result or MoveFile(PChar(OldName + nsz), PChar(NewName + nsz));
          bmFTP: Result := Result or (RenameFTPFile(PChar(OldName + nsz), PChar(NewName + nsz)) = 0);
        end;
      end;
    except
      // Result := False;
    end;
{$B-}
  if Result then
  begin
    FDisplayName := ANewName;
    if IsNameMangled then
      FRemoteName := MangleFileName(ANewName);
  end;
end;

function TNSItem.Restore: Boolean;
var
  Method: TEncryptionMethod;
  pwd: string;
  RemoteFileName: string;
  TempFileName1: string;
  TempFileName2: string;
  DestFileName: string;
  sLog: string;
  tmpDate: TDateTime;
  mrResult: integer;
  sNewHash: THashKey;
{$IFDEF USE_MCDB}
  sDirEntry: string;
  DirEntry: PDirEntry;
  sFileEntry: string;
  FileEntry: PFileEntry;
{$ENDIF}
  pCancel: Bool;
begin
  DestFileName := IncludeTrailingPathDelimiter(DestFolder) + Self.DisplayName;
  // Result := False;
  with FProject do
    try

      if FProgress <> nil then
        with FProgress do
        begin
          CurItemSize := Size;
          CurFile := DestFileName;
          CurAction := sTransfer;
          Application.ProcessMessages;
          if g_AbortProcess then
          begin
            Result := False;
            Exit;
          end;
        end;

      // if g_AbortProcess then Abort;
      if DestFolder <> EmptyStr then
        Result := ForceDirectories(DestFolder)
      else
        Result := False;
      if not Result then
      begin
        sLog := ErrorMsg(ERROR_CANNOT_MAKE);
        FProject.TraceLog(Format(sCreateDir, [DestFolder]), sLog, False);
        Exit;
      end;

      if g_AbortProcess then
      begin
        sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
        TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
        Result := False;
        Exit;
      end;

      if FProgress <> nil then
      begin
        if (FRestoreMR <> mrYesToAll) and (FindFirst(DestFileName, faAnyFile, RestoreSR) = 0) then
        begin
          tmpDate := FileGetModified(RestoreSR);

          FRestoreMR := ReplaceLocalDlg(Self.DisplayName, DestFolder, Size, Modified, FileGetSize(RestoreSR), tmpDate);
          if FRestoreMR = mrNo then
          begin
            sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
            TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
            Exit;
          end
          else if FRestoreMR = mrCancel then
          begin
            sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
            TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
            Result := False;
            Exit;
          end;
          FindClose(RestoreSR);
        end;
      end;

      RemoteFileName := FileNameOnServer(versionNumber);

      if g_AbortProcess then
      begin
        sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
        TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
        Result := False;
        Exit;
      end;

      case BackupMedia of
        bmLocal, bmNAS:
          begin
            TempFileName1 := RemoteFileName;
            Result := FileExists(TempFileName1);
            if not Result then
              sLog := ErrorMsg(ERROR_FILE_NOT_FOUND);
          end;
        bmFTP:
          begin
            TempFileName1 := AuxFileName(versionNumber);
            if FileExists(TempFileName1) then
            begin
              if not DeleteFile(PChar(TempFileName1)) then
              begin
                sLog := ErrorMsg(GetLastError);
                TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
                Exit;
              end;
            end;
            if FProgress <> nil then
              Result := DownloadFTPFile(PChar(TempFileName1), PChar(RemoteFileName), FProgress.FTPProgress) = 0
            else
              Result := DownloadFTPFile(PChar(TempFileName1), PChar(RemoteFileName), nil) = 0;

            if g_AbortProcess then
            begin
              sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
              TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
              Result := False;
              Exit;
            end;

            if not Result then
              if FProject.ReConnect then
              begin
                if FProgress <> nil then
                  Result := DownloadFTPFile(PChar(TempFileName1), PChar(RemoteFileName), FProgress.FTPProgress) = 0
                else
                  Result := DownloadFTPFile(PChar(TempFileName1), PChar(RemoteFileName), nil) = 0;
              end;
            if not Result then
              sLog := StrPas(GetLastFTPResponse);
          end;
        bmCD:
          begin
            if FProject.CDWriteable then
            begin
{$IFDEF USE_MCDB}
              sDirEntry := GetPathOnMedia;
              DirEntry := DiskWriter.GetClass.FindDir(sDirEntry);
              Result := DirEntry <> nil;
              if not Result then
                sLog := ErrorMsg(ERROR_PATH_NOT_FOUND)
              else
              begin
                sFileEntry := NS_Name(versionNumber);
                FileEntry := DiskWriter.GetClass.FindFile(DirEntry, sFileEntry);
                Result := FileEntry <> nil;
                if not Result then
                  sLog := ErrorMsg(ERROR_FILE_NOT_FOUND)
                else
                begin
                  TempFileName1 := AuxFileName(versionNumber);
                  if FileExists(TempFileName1) then
                  begin
                    if not DeleteFile(PChar(TempFileName1)) then
                    begin
                      sLog := ErrorMsg(GetLastError);
                      TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
                    end;
                  end;
                  Result := DiskWriter.GetClass.ExtractFile(FileEntry, TempFileName1);
                  if not Result then
                    sLog := DiskWriter.GetClass.ErrorString;
                end;
              end;
{$ENDIF}
            end
            else
            begin
              TempFileName1 := FProject.CDDrivePath + RemoteFileName;
              Result := FileExists(TempFileName1);
              if not Result then
                sLog := ErrorMsg(ERROR_FILE_NOT_FOUND);
            end;
          end;
      end;

      if not Result then
      begin
        TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
        Exit;
      end;

      TempFileName2 := IncludeTrailingPathDelimiter(g_TempDir) + Self.FDisplayName;

      if FileExists(TempFileName2) then
      begin
        if not DeleteFile(PChar(TempFileName2)) then
        begin
          sLog := ErrorMsg(GetLastError);
          TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
          Exit;
        end;
      end;

      if (FileFormat = fmAsIs) then
      begin
        Result := True;
        TempFileName2 := TempFileName1;
      end
      else
      begin
        Result := UnPackFile(TempFileName1, TempFileName2, FCrypt.HashEmpty);
      end;

      if g_AbortProcess then
      begin
        sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
        TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
        Result := False;
        Exit;
      end;

      if not Result then
      begin
        if FProgress = nil then
        begin
          Result := False;
          sLog := ErrorMsg(ERROR_INVALID_DATA);
          TraceLog(Format(sDecryption, [GetPathOnMedia + Self.FDisplayName]), sLog, False);
          Exit;
        end
        else
        begin
          repeat
            if g_AbortProcess then
            begin
              sLog := ErrorMsg(ERROR_REQUEST_ABORTED);
              TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, False);
              Result := False;
              Exit;
            end;

            DeleteFile(PChar(TempFileName2));
            mrResult := ErrorRestoreDialog(FProgress, FProject, Self, Method, pwd);
            case mrResult of
              mrYes:
                begin
                  FCrypt.Password := pwd;
                  sNewHash := FCrypt.HashKey;
                  Result := UnPackFile(TempFileName1, TempFileName2, sNewHash);
                  ReInitCrypting;
                end;
              mrYesToAll:
                begin
                  FCrypt.Password := pwd;
                  sNewHash := FCrypt.HashKey;
                  Result := UnPackFile(TempFileName1, TempFileName2, sNewHash);
                  HashValue := sNewHash;
                end;
              mrIgnore:
                begin
                  Result := False;
                  sLog := ErrorMsg(ERROR_INVALID_DATA);
                  TraceLog(Format(sDecryption, [GetPathOnMedia + Self.FDisplayName]), sLog, False);
                  Exit;
                end
            else
              begin
                g_AbortProcess := True;
                Result := False;
                sLog := ErrorMsg(ERROR_INVALID_DATA);
                TraceLog(Format(sDecryption, [GetPathOnMedia + Self.FDisplayName]), sLog, False);
                Exit;
              end;
            end;
          until Result;
        end;
      end;

      pCancel := False;
      if (Win32Platform = VER_PLATFORM_WIN32_NT) and (FProgress <> nil) then
        Result := CopyFileEx(PChar(TempFileName2), PChar(DestFileName), @CopyProgressRoutine, FProgress, @pCancel, 0)
      else
        Result := CopyFile(PChar(TempFileName2), PChar(DestFileName), False);

      sLog := ErrorMsg(GetLastError);

      if FileFormat <> fmAsIs then
        DeleteFile(PChar(TempFileName2));
      if BackupMedia = bmFTP then
        DeleteFile(PChar(TempFileName1));

      // Restore original create and modified datetime
      if Modified > 1 then
        SetFileModifiedTime(DestFileName, Modified);

      if Result then
      begin
        State := isNormal;
        NotProcessed := False;
        DestFolder := EmptyStr;
      end;

      TraceLog(Format(sRestoreFile, [GetPathOnMedia + Self.DisplayName]), sLog, Result);
    finally
      if FProgress <> nil then
        with FProgress do
        begin
          UpdateProgress;
          Application.ProcessMessages;
        end;
    end;
end;

function TNSItem.RestoreVersion(const ADestFolder: string; const AVersion: integer): Boolean;
var
  Method: TEncryptionMethod;
  pwd: string;
  RemoteFileName: string;
  TempFileName1: string;
  TempFileName2: string;
  DestFileName: string;
  mrResult: integer;
  I: integer;
  sNewHash: THashKey;
  sDestination: string;
begin
  Result := False;
  sDestination := ADestFolder;
  with FProject do
  begin
    RemoteFileName := FileNameOnServer(AVersion);
    DestFileName := IncludeTrailingPathDelimiter(sDestination) + Self.DisplayName;
    case BackupMedia of
      bmLocal, bmNAS:
        begin
          TempFileName1 := RemoteFileName;
          Result := FileExists(TempFileName1);
        end;
      bmFTP:
        begin
          TempFileName1 := AuxFileName(AVersion);
          if FileExists(TempFileName1) then
          begin
            Result := DeleteFile(PChar(TempFileName1));
            if not Result then
              Exit;
          end;
          Result := DownloadFTPFile(PChar(TempFileName1), PChar(RemoteFileName), nil) = 0;
        end;
      bmCD:
        begin
          TempFileName1 := FProject.CDDrivePath + RemoteFileName;
          Result := FileExists(TempFileName1);
        end;
    end;

    if not Result then
      Exit;

    TempFileName2 := IncludeTrailingPathDelimiter(g_TempDir) + Self.DisplayName;

    Result := UnPackFile(TempFileName1, TempFileName2, FCrypt.HashEmpty);

    if not Result then
      repeat
        mrResult := ErrorRestoreDialog(nil, FProject, Self, Method, pwd);
        case mrResult of
          mrYes:
            begin
              FCrypt.Password := pwd;
              sNewHash := FCrypt.HashKey;
              Result := UnPackFile(TempFileName1, TempFileName2, sNewHash);
              ReInitCrypting;
            end;
          mrYesToAll:
            begin
              FCrypt.Password := pwd;
              sNewHash := FCrypt.HashKey;
              Result := UnPackFile(TempFileName1, TempFileName2, sNewHash);
              HashValue := sNewHash;
            end
        else
          begin
            Result := False;
            Exit;
          end;
        end;
      until Result;

    if AnsiSameText(DestFileName, TempFileName2) then
      Result := True
    else
    begin
      Result := CopyFile(PChar(TempFileName2), PChar(DestFileName), False);
      DeleteFile(PChar(TempFileName2));
    end;

    // Restore original create and modified datetime
    try
      for I := 0 to FVersions.Count - 1 do
        if FVersions.Items[I].Number = AVersion then
        begin
          if Versions.Items[I].Modified > 1 then
            SetFileModifiedTime(DestFileName, Versions[I].Modified);
          Break;
        end;
    except
    end;

    if BackupMedia = bmFTP then
      DeleteFile(PChar(TempFileName1));
  end;
end;

procedure TNSItem.SetBackupItem(const Value: Boolean);
begin
  FBackupItem := Value;
end;

procedure TNSItem.SetDisplayName(const Value: string);
var
  iPos: integer;
begin
  if not(csLoading in FProject.ComponentState) then
    if FProject.AutoMangle then
      FRemoteName := MangleFileName(Value);
  iPos := AnsiPos(sDrive, Value);
  if iPos > 0 then
  begin
    FDisplayName := nsdPrefix + Copy(Value, 1, 1);
    Exit;
  end;
  iPos := AnsiPos(sMachine, Value);
  if iPos > 0 then
  begin
    FDisplayName := nscPrefix + Copy(Value, 3, Length(Value));
    Exit;
  end;
  FDisplayName := Value;
end;

procedure TNSItem.SetExists(const Value: Boolean);
begin
  FExists := Value;
  if (FVersions <> nil) and (FVersions.Count > 0) then
    FVersions.Items[FVersions.Count - 1].FExists := Value;
end;

procedure TNSItem.SetIsFolder(const Value: Boolean);
begin
  FIsFolder := Value;
  if FIsFolder then
    FSubItems := TNSCollection.Create(TNSCollection(Collection).FProject, Self)
  else
  begin
    FVersions := TNSVersions.Create(Self);
    if not(csLoading in FProject.ComponentState) then
      FVersions.Add;
  end;
end;

procedure TNSItem.SetModified(const Value: TDateTime);
var
  Parent: TNSItem;
begin
  if IsFolder then
    FModified := Value
  else if (FVersions <> nil) and (FVersions.Count > 0) then
    FVersions.Items[FVersions.Count - 1].FModified := Value;
  Parent := TNSCollection(Self.Collection).GetParentItem;
  if Parent <> nil then
    Parent.Modified := Now;
end;

procedure TNSItem.SetNotProcessed(const Value: Boolean);
var
  Parent: TNSItem;
begin
  FNotProcessed := Value;
  if Value then
  begin
    Parent := TNSCollection(Self.Collection).GetParentItem;
    if Parent <> nil then
      Parent.NotProcessed := Value;
  end;
end;

procedure TNSItem.SetSize(const Value: int64);
begin
  if (FVersions <> nil) and (FVersions.Count > 0) then
    FVersions.Items[FVersions.Count - 1].FSize := Value;
end;

procedure TNSItem.SetSizeOnMedia(const Value: int64);
begin
  if (FVersions <> nil) and (FVersions.Count > 0) then
    FVersions[FVersions.Count - 1].FSizeOnMedia := Value;
end;

function TNSItem.AuxFileName(const AVersion: integer): string;
var
  // S: string;
  lOwner: TNSItem;
begin
  case FProject.BackupMedia of
    bmCD:
      begin
        Result := EmptyStr;
        lOwner := TNSCollection(Self.Collection).GetParentItem;
        while lOwner <> nil do
        begin
          Result := IntToStr(lOwner.Index) + sBackslash + Result;
          lOwner := TNSCollection(lOwner.Collection).GetParentItem;
        end;
        Result := IncludeTrailingPathDelimiter(g_TempDir) + STmpFolder + sBackslash + Result;
        if ForceDirectories(Result) then
          Result := IncludeTrailingPathDelimiter(Result) + NS_Name(AVersion)
        else
          Result := IncludeTrailingPathDelimiter(g_TempDir) + NS_Name(AVersion);
      end;
  else
    Result := IncludeTrailingPathDelimiter(g_TempDir) + NS_Name(AVersion);
  end;
end;

function TNSItem.VerifyPath: Boolean;
var
  RemoteFolder: string;
  DirEntry: PDirEntry;
begin
  Result := False;
  if not IsFolder then
    Exit;
  case TNSCollection(Collection).FProject.BackupMedia of
    bmLocal:
      begin
        RemoteFolder := IncludeTrailingPathDelimiter(TNSCollection(Collection).FProject.LocalFolder) + GetPathOnMedia + FDisplayName;
        Result := ForceDirectories(RemoteFolder);
      end;
    bmFTP:
      begin
        RemoteFolder := IncludeTrailingPathDelimiter(TNSCollection(Collection).FProject.HostDirName) + GetPathOnMedia + FDisplayName;
        try
          CreateFTPFolder(PChar(RemoteFolder));
          Result := True;
        except
          Result := False;
        end;
      end;
    bmCD:
      begin
        try
          RemoteFolder := GetPathOnMedia + FDisplayName;
          Result := RemoteFolder <> EmptyStr;
          if Result then
          begin
            DirEntry := DiskWriter.CreateDir(RemoteFolder);
            Result := DirEntry <> nil;
          end;
        except
          Result := False;
        end;
      end;
    bmNAS:
      begin
        RemoteFolder := IncludeTrailingPathDelimiter(TNSCollection(Collection).FProject.FNasConnection) + GetPathOnMedia + FDisplayName;
        Result := ForceDirectories(RemoteFolder);
      end;
  else
    Result := False;
  end;
end;

procedure TNSItem.SetLocalPath(const Value: string);
begin
  if FIsFolder then
    Exit;
  { if FLocalPath <> EmptyStr then
    FOldLocalPath := FLocalPath
    else
    FOldLocalPath := Value;
  }
  FLocalPath := Value;
end;

procedure TNSItem.RollBack;
begin
  FUSize := 0;
  FUModified := 0;
  FULocalPath := EmptyStr;
  {
    if FOldLocalPath <> EmptyStr then
    FLocalPath := FOldLocalPath;
    if FOldSize <> 0 then
    FVersions.Items[FVersions.Count - 1].FSize := FOldSize;
    if FOldModified > 1 then
    FVersions.Items[FVersions.Count - 1].FModified := FOldModified;
  }
end;

procedure TNSItem.SetDefAction(const Value: TDefaultAction);
begin
  FDefAction := Value;
end;

function TNSItem.GetLocalPath: string;
var
  Par: TNSItem;
begin
  if not FIsFolder then
    Result := FLocalPath
  else
  begin
    Result := EmptyStr;
    Par := TNSCollection(Self.Collection).FOwner;
    while Par <> nil do
    begin
      Result := IncludeTrailingPathDelimiter(Par.DisplayName) + Result;
      Par := TNSCollection(Par.Collection).FOwner;
    end;
  end;
end;

function TNSItem.GetStoreFolder: Boolean;
begin
  Result := not FIsFolder;
end;

function TNSItem.GetLocation: string;
begin
  Result := GetPathOnMedia;
  if AnsiPos(sArchives, Result) > 0 then
    Delete(Result, 1, AnsiPos(sArchives, Result) + Length(sArchives));
  if Result = EmptyStr then
    Result := sRoot;
  if AnsiPos(nsdPrefix, Result) > 0 then
  begin
    Delete(Result, 1, Length(nsdPrefix));
    Insert(sColon, Result, 2);
  end
  else if AnsiPos(nscPrefix, Result) > 0 then
  begin
    Delete(Result, 1, Length(nscPrefix));
    Result := sMachine + Result;
  end;
end;

procedure TNSItem.ScanBackupFolder(const AProcessAll: Boolean);
var
  SR: TSearchRec;
  xItem: TNSItem;
  xPath: string;
  xTime: TDateTime;
begin
  if FSubItems = nil then
    Exit;
  xPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Self.LocalPath) + Self.DisplayName) + sFileMask;
  if FindFirst(xPath, faAnyFile, SR) <> 0 then
    Exit;
  repeat
    if (SR.Name = sDot) or (SR.Name = sDoubleDot) then
      Continue;
    if (SR.Attr and faDirectory <> faDirectory) then
      if not FProject.IsValidExt(SR.Name) then
        Continue;

    xTime := FileGetModified(SR);
    xItem := FSubItems.FindItem(SR.Name);
    if xItem = nil then
    begin // new item
      xItem := FSubItems.Add;
      xItem.IsFolder := (SR.Attr and faDirectory = faDirectory);
      xItem.DisplayName := SR.Name;
      if not xItem.IsFolder then
      begin
        xItem.LocalPath := IncludeTrailingPathDelimiter(Self.LocalPath) + Self.DisplayName;
      end;
      xItem.State := isBackup;
      xItem.Created := Now;
      xItem.UModified := xTime;
      xItem.uSize := FileGetSize(SR);
      xItem.NotProcessed := True;
      xItem.Exists := False;
    end // new item
    else
    begin // existing item
      if AProcessAll then
        case xItem.DefAction of
          daReplace:
            begin
              xItem.State := isBackupReplace;
              xItem.NotProcessed := True;
              xItem.UModified := xTime;
              xItem.uSize := FileGetSize(SR);
            end;
          daUpdate:
            begin
              if CompareDateTime(xItem.Modified, xTime) < 0 then
              begin
                xItem.State := isBackupUpdate;
                xItem.NotProcessed := True;
                xItem.UModified := xTime;
                xItem.uSize := FileGetSize(SR);
              end;
            end;
          daNewVersion:
            begin
              if CompareDateTime(xItem.Modified, xTime) < 0 then
              begin
                xItem.State := isBackupNewVersion;
                xItem.NotProcessed := True;
                xItem.UModified := xTime;
                xItem.uSize := FileGetSize(SR);
              end;
            end;
        end;
    end; // existing item
    xItem.BackupItem := True;
  until FindNext(SR) <> 0;
  FindClose(SR);
end;

procedure TNSItem.Refresh;
var
  SR: TSearchRec;
  tmpDate: TDateTime;

  procedure ScanBackupItems;
  var
    xPath: string;
    rec: TSearchRec;
    xItem: TNSItem;
  begin
    if FSubItems = nil then
      Exit;
    xPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(LocalPath) + DisplayName) + sFileMask;
    if FindFirst(xPath, faAnyFile, rec) <> 0 then
      Exit;
    repeat
      if (rec.Name = sDot) or (rec.Name = sDoubleDot) then
        Continue;

      if (rec.Attr and faDirectory <> faDirectory) then
        if not FProject.IsValidExt(rec.Name) then
          Continue;

      xItem := FSubItems.FindItem(rec.Name);
      if xItem = nil then
      begin // new item
        xItem := FSubItems.Add;
        xItem.IsFolder := (rec.Attr and faDirectory = faDirectory);
        xItem.DisplayName := rec.Name;
        if not xItem.IsFolder then
        begin
          xItem.LocalPath := IncludeTrailingPathDelimiter(Self.LocalPath) + Self.DisplayName;
        end;
        xItem.State := isBackup;
        xItem.Exists := False;
        xItem.FCreated := Now;
        xItem.NotProcessed := True;
        xItem.Modified := FileGetModified(rec);
        xItem.Size := FileGetSize(rec);

        xItem.BackupItem := True;
        if xItem.IsFolder then
          xItem.Refresh;
      end // new item
      else
      begin // existing item
        xItem.Refresh;
      end; // existing item
    until FindNext(rec) <> 0;
    FindClose(rec);
  end;

  procedure ScanArchiveItems;
  var
    cIndex: integer;
    cItem: TNSItem;
  begin
    if FSubItems = nil then
      Exit;
    for cIndex := 0 to FSubItems.Count - 1 do
    begin
      if g_AbortRefresh then
        Abort;
      cItem := FSubItems[cIndex];
      cItem.Refresh;
    end; // for cIndex
  end;

begin

  if FIsFolder then
  begin
    if FBackupItem then
      ScanBackupItems
    else
      ScanArchiveItems;
  end
  else
  begin
    if FNotProcessed or g_AbortRefresh then
      Exit;
    if FindFirst(IncludeTrailingPathDelimiter(FLocalPath) + FDisplayName, faAnyFile, SR) <> 0 then
      Exit;

    tmpDate := FileGetModified(SR);
    if CompareDateTime(Modified, tmpDate) < 0 then
    begin
      if g_AutoRefresh or (ConfirmUpdateDlg(FProject, Self, SR) in [mrYes, mrYesToAll]) then
      begin
        State := isBackupUpdate;
        Modified := tmpDate;
        Size := FileGetSize(SR);
        NotProcessed := True;
      end;
    end;
    FindClose(SR);
    if g_AbortRefresh then
      Abort;
  end;
end;

procedure TNSItem.SetState(const Value: TItemState);
var
  Parent: TNSItem;
begin
  FState := Value;
  Parent := TNSCollection(Self.Collection).GetParentItem;
  if (Parent <> nil) and (Parent.State <> Self.State) then
    Parent.State := isNormal;
end;

procedure TNSItem.SetUModified(const Value: TDateTime);
var
  Parent: TNSItem;
begin
  FUModified := Value;
  Parent := TNSCollection(Self.Collection).GetParentItem;
  if Parent <> nil then
    Parent.UModified := Now;
end;

function TNSItem.Mangle: Boolean;
var
  Path: string;
  OldName: string;
  NewName: string;
  Proj: TNSProject;
  nsz: string;
  VerNo: integer;
begin
  if not Exists then
  begin
    RemoteName := MangleFileName(DisplayName);
    Result := True;
  end
  else
  begin
    Result := False;
    Proj := TNSCollection(Self.Collection).FProject;
    case Proj.BackupMedia of
      bmLocal: Path := IncludeTrailingPathDelimiter(Proj.LocalFolder) + GetPathOnMedia;
      bmFTP: Path := IncludeTrailingPathDelimiter(Proj.HostDirName) + GetPathOnMedia;
      bmNAS: Path := IncludeTrailingPathDelimiter(Proj.FNasConnection) + GetPathOnMedia;
    end;
    OldName := Path + DisplayName + sNsz;
    NewName := Path + MangleFileName(DisplayName) + sMsz;
    try
{$B+}
      Result := False;
      for VerNo := 0 to Versions.Count - 1 do
      begin
        nsz := IntToHex(Versions[VerNo].Number, 3);
        case Proj.BackupMedia of
          bmLocal, bmNAS: Result := Result or MoveFile(PChar(OldName + nsz), PChar(NewName + nsz));
          bmFTP: Result := Result or (RenameFTPFile(PChar(OldName + nsz), PChar(NewName + nsz)) = 0);
        end;
      end;
    except
      // Result := False;
    end;
{$B-}
  end;
  if Result then
    RemoteName := MangleFileName(DisplayName);
end;

function TNSItem.IsNameMangled: Boolean;
begin
  Result := (FRemoteName <> EmptyStr) and not AnsiSameText(FDisplayName, FRemoteName);
end;

{ TNSVersions }

function TNSVersions.Add: TNSVersion;
var
  LastVersion: integer;
begin
  if Count > 0 then
    LastVersion := Items[Count - 1].FNumber
  else
    LastVersion := -1;
  Result := TNSVersion(inherited Add);
  Result.FNumber := LastVersion + 1;
end;

constructor TNSVersions.Create(AOwner: TNSItem);
begin
  inherited Create(TNSVersion);
  FOwner := AOwner;
end;

function TNSVersions.GetItem(Index: integer): TNSVersion;
begin
  Result := TNSVersion(inherited GetItem(index));
end;

procedure TNSVersions.SetItem(Index: integer; const Value: TNSVersion);
begin
  inherited SetItem(index, Value);
end;

{ TNSProjectHeader }

procedure TNSProjectHeader.AssignProperties(const AProject: TNSProject);
begin
  if AProject <> nil then
  begin
    Self.DisplayName := AProject.DisplayName;
    Self.Kind := AProject.Kind;
    Self.EncryptionMethod := AProject.EncryptionMethod;
    Self.LastRunTime := AProject.LastRunTime;
  end;
end;

function TNSProjectHeader.LoadFromFile(const AFileName: string): Boolean;
var
  FS: TFileStream;
begin
  Result := False;
  if not FileExists(AFileName) then
    Exit;
  FFileName := AFileName;
  FS := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(FS);
    Result := True;
  finally
    FS.Free;
  end;
end;

procedure TNSProjectHeader.LoadFromStream(AStream: TStream);
begin
  if AStream.Size <> 0 then
    AStream.ReadComponent(Self);
end;

procedure TNSProjectHeader.SaveToStream(AStream: TStream);
begin
  AStream.WriteComponent(Self);
end;

{ TNSVersion }

constructor TNSVersion.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FExists := True;
end;

initialization

if GetClass('TNSProject') = nil then
  RegisterClass(TNSProject);
if GetClass('TNSProjectHeader') = nil then
  RegisterClass(TNSProjectHeader);

end.
