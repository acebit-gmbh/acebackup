unit cdWrapper;

interface

uses
{$IFDEF USE_MCDB}
  mbCDBC,
  mbDrvLib,
  mbISOLib,
{$ELSE}
  cdImapi,
  cdWriter,
{$ENDIF}
  Classes,
  SysUtils;

type
{$IFDEF USE_MCDB}
  PDirEntry = mbISOLib.PDirEntry;
  PFileEntry = mbISOLib.PFileEntry;
{$ELSE}
  PDirEntry = ^TDEntry;
  TDEntry = record
  end;

  PFileEntry = ^TFEntry;
  TFEntry = record
  end;
{$ENDIF}

type
  TDiskWriter = class
  strict private
{$IFDEF USE_MCDB}
    CDClass: TMCDBurner;
{$ELSE}
    CDClass: TCDWriter;
{$ENDIF}
  private
    FOnFinish: TNotifyEvent;
    function GetSimulate: Boolean;
    procedure SetSimulate(const Value: Boolean);
  protected
{$IFDEF USE_MCDB}
    procedure CDWriteDone(Sender: TObject; Error: string);
    procedure CDEraseDone(Sender: TObject; WithError: boolean);
    procedure CDFinalizingTrack(Sender: TObject);
{$ELSE}
    procedure CDCancel(out ACancelAction: Boolean);
    procedure CDMessage(const AMessage: String);
    procedure CDCompletion(Sender: TObject; ACompletion: TCDCompletion; AStatus: HRESULT);
    procedure CDValues(AKind: TCDValueKind; ACurrent, ATotal: Integer);
{$ENDIF}
  public
    BurnerWriteDone: boolean;
    BurnerEraseDone: boolean;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    function RecorderPath(Index: Integer): String;
    function DevicePath(Index: Integer): String;
    function CheckDeviceReady: Boolean;
    function IsWriteableMedia: Boolean;
    function IsValidMedia: Boolean;
    function IsFreeSpaceAvail: Boolean;
    function CanSimulateWrite: Boolean;
    function FilesCount: Integer;
    function GetRecorderCount: Integer;
    function GetRecorderList(List: TStrings): Boolean;

    function RemoveDir(const Directory: String): Boolean;
    function RemoveFile(const Remote, Local: String): Boolean;
    function RecordDisk(Simulate, Eject, Finalize: Boolean): Boolean;
    function InsertFile(const Remote, Local: String): Integer;

{$IFDEF USE_MCDB}
    function CreateDir(const Directory: String): PDirEntry; overload;
    function CreateDir(Destination: PDirEntry; const Directory: String): PDirEntry; overload;
    function GetClass: TMCDBurner;
{$ELSE}
    function CreateDir(const Directory: String): PDirEntry;
    function GetClass: TCDWriter;
{$ENDIF}

    procedure AbortProcess;
    procedure RecorderOpen;
    procedure RecorderClose;
    procedure ReloadMedium;
    procedure SetActiveRecorder(Index: Integer);
    procedure DiscInformation;

    property Simulate: Boolean read GetSimulate write SetSimulate;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
  end;

var
  DiskWriter: TDiskWriter;

implementation

{ TDiskWriter }

uses
  nsGlobals;

constructor TDiskWriter.Create(AOwner: TComponent);
begin
  inherited Create;

{$IFDEF USE_MCDB}
  CDClass := TMCDBurner.Create(AOwner);
  CDClass.DoDebug := True;
  CDClass.OnEraseDone := CDEraseDone;
  CDClass.FinalizeDisc := False;
  CDClass.ReplaceFile := True;
  CDClass.PerformOPC := True;
  CDClass.IdApplication := 'AceBackup';
  CDClass.OnWriteDone := CDWriteDone;
  CDClass.OnFinalizingTrack := CDFinalizingTrack;
  try
    CDClass.InitializeASPI(True);
  except
  end;
{$ELSE}
  CDClass := TCDWriter.Create(AOwner);
  CDClass.OnShowMessage := CDMessage;
  CDClass.OnValueChange := CDValues;
  CDClass.OnCompletion := CDCompletion;
  CDClass.OnCancelAction := CDCancel;
{$ENDIF}
end;

{$IFDEF USE_MCDB}
function TDiskWriter.CreateDir(const Directory: String): PDirEntry;
begin
  Result := CDClass.CreateDir(Directory);
end;

function TDiskWriter.CreateDir(Destination: PDirEntry; const Directory: String): PDirEntry;
begin
  Result := CDClass.CreateDir(Destination, Directory);
end;
{$ELSE}
function TDiskWriter.CreateDir(const Directory: String): PDirEntry;
begin
  Result := nil;
end;
{$ENDIF}

procedure TDiskWriter.AbortProcess;
begin
{$IFDEF USE_MCDB}
  try
    CDClass.Abort;
  except
  end;
{$ENDIF}
end;

function TDiskWriter.CanSimulateWrite: Boolean;
begin
{$IFDEF USE_MCDB}
  Result := dcWriteTest in CDClass.DeviceCapabilities;
{$ELSE}
  Result := True;
{$ENDIF}
end;

function TDiskWriter.CheckDeviceReady: Boolean;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.TestUnitReady();
{$ELSE}
  Result := CDClass.DeviceReady;
{$ENDIF}
end;

function TDiskWriter.FilesCount: Integer;
begin
  Result := CDClass.FilesCount;
end;

{$IFDEF USE_MCDB}
function TDiskWriter.GetClass: TMCDBurner;
{$ELSE}
function TDiskWriter.GetClass: TCDWriter;
{$ENDIF}
begin
  Result := CDClass;
end;

function TDiskWriter.GetRecorderCount: Integer;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.Devices.Count;
{$ELSE}
  Result := CDClass.GetRecorderCount;
{$ENDIF}
end;

function TDiskWriter.GetRecorderList(List: TStrings): Boolean;
{$IFDEF USE_MCDB}
var
  i, nPos: Integer;
{$ENDIF}
begin
{$IFDEF USE_MCDB}
  Result := False;
  if not Assigned(List) then
    Exit;

  if (CDClass.Devices <> nil) and (CDClass.Devices.Count > 0) then
  begin
    for I := 0 to CDClass.Devices.Count - 1 do
    begin
      nPos := Pos(#44, CDClass.Devices[I]);
      if nPos > 0 then
        List.Add(Copy(CDClass.Devices[I], nPos + 1, MaxInt))
      else
        List.Add(CDClass.Devices[I]);
    end;
    Result := List.Count > 0;
  end;
{$ELSE}
  Result := False; // currently no support! CDClass.GetRecorderList(List)
{$ENDIF}
end;

function TDiskWriter.GetSimulate: Boolean;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.TestWrite;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TDiskWriter.InsertFile(const Remote, Local: String): Integer;
begin
{$IFDEF USE_MCDB}
  Result:= CDClass.InsertFile(Remote, Local, False);
{$ELSE}
  Result:= Integer(CDClass.AddFile(Remote, Local, False));
{$ENDIF}
end;

function TDiskWriter.IsFreeSpaceAvail: Boolean;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.DiscStatus <> dsCompleteDisc;
{$ELSE}
  Result := CDClass.GetMediaInfo.FreeBlocks > 0
{$ENDIF}
end;

function TDiskWriter.IsValidMedia: Boolean;
{$IFDEF USE_MCDB}
begin
  Result := CDClass.Disc.Valid;
{$ELSE}
var
  GUID: TGUID;
begin
  CDClass.DiscMaster.GetActiveDiscMasterFormat(GUID);
  Result := GUID = IID_IRedbookDiscMaster;
{$ENDIF}
end;

function TDiskWriter.IsWriteableMedia: Boolean;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.DeviceCapabilities * [dcWriteCDR, dcWriteCDRW, dcWriteDVDR,
    dcWriteDVDRW, dcWriteDVDRAM, dcWriteDVDPLUSR, dcWriteDVDPLUSRW] <> [];
{$ELSE}
  Result := CDClass.IsWriteableMedia
{$ENDIF}
end;

function TDiskWriter.RecordDisk(Simulate, Eject, Finalize: Boolean): Boolean;
begin
{$IFDEF USE_MCDB}
  CDClass.FinalizeTrack := Finalize;
  Result := CDClass.PrepareCD and CDClass.BurnCD;
{$ELSE}
  Result := CDClass.RecordDisk(Simulate, Eject);
{$ENDIF}
end;

procedure TDiskWriter.RecorderClose;
begin
{$IFDEF USE_MCDB}
  CDClass.LockMedium(True);
{$ELSE}
{$ENDIF}
end;

procedure TDiskWriter.RecorderOpen;
begin
{$IFDEF USE_MCDB}
  CDClass.LockMedium(False);
{$ELSE}
{$ENDIF}
end;

destructor TDiskWriter.Destroy;
begin
  FreeAndNil(CDClass);

  inherited;
end;

function TDiskWriter.DevicePath(Index: Integer): String;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.DeviceByDriveLetter + sColon;
{$ELSE}
  Result := EmptyStr;
{$ENDIF}
end;

procedure TDiskWriter.DiscInformation;
begin
{$IFDEF USE_MCDB}
  CDClass.GetDiscInformation;
{$ELSE}
{$ENDIF}
end;

function TDiskWriter.RecorderPath(Index: Integer): String;
{$IFDEF USE_MCDB}
var
  nPos: Integer;
{$ENDIF}
begin
{$IFDEF USE_MCDB}
  if (Index <> -1) and (Index < CDClass.Devices.Count) then
  begin
    Result := CDClass.Devices[Index];
    nPos := Pos(#44, Result);
    if nPos > 0 then
      Result := Copy(Result, nPos + 1, MaxInt);
  end
  else
    Result := EmptyStr;
{$ELSE}
  Result := EmptyStr;
{$ENDIF}
end;

procedure TDiskWriter.ReloadMedium;
begin
{$IFDEF USE_MCDB}
  CDClass.LoadMedium(True);
  CDClass.LoadMedium(False);
{$ELSE}
  CDClass.DiscMaster.Open;
  CDClass.DiscMaster.Close;
{$ENDIF}
end;

function TDiskWriter.RemoveDir(const Directory: String): Boolean;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.RemoveDir(Directory);
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TDiskWriter.RemoveFile(const Remote, Local: String): Boolean;
begin
{$IFDEF USE_MCDB}
  Result := CDClass.RemoveFile(Remote, Local);
{$ELSE}
  Result := False;
{$ENDIF}
end;

procedure TDiskWriter.SetActiveRecorder(Index: Integer);
begin
{$IFDEF USE_MCDB}
  CDClass.Device := CDClass.Devices[Index];
{$ELSE}
{$ENDIF}
end;

procedure TDiskWriter.SetSimulate(const Value: Boolean);
begin
{$IFDEF USE_MCDB}
  CDClass.TestWrite := Value;
{$ELSE}
  //
{$ENDIF}
end;

{$IFDEF USE_MCDB}
procedure TDiskWriter.CDWriteDone(Sender: TObject; Error: string);
begin
  BurnerWriteDone := True;
end;

procedure TDiskWriter.CDEraseDone(Sender: TObject; WithError: boolean);
begin
  BurnerEraseDone := True;
end;

procedure TDiskWriter.CDFinalizingTrack(Sender: TObject);
begin
  if Assigned(OnFinish) then
    OnFinish(Sender);
end;

{$ELSE}

procedure TDiskWriter.CDCompletion(Sender: TObject; ACompletion: TCDCompletion; AStatus: HRESULT);
begin
  case ACompletion of
    cdcoBurning: BurnerWriteDone := True;
    cdcoErasing: BurnerEraseDone := True;
  end;
  if Assigned(OnFinish) then
    OnFinish(Sender);
end;

procedure TDiskWriter.CDCancel(out ACancelAction: Boolean);
begin
  ACancelAction := g_AbortProcess;
end;

procedure TDiskWriter.CDMessage(const AMessage: String);
begin
  // Ausgabe der Meldungen vom CD-Writer
end;

procedure TDiskWriter.CDValues(AKind: TCDValueKind; ACurrent, ATotal: Integer);
begin
  // Ausgabe der Werte vom CD-Writer
end;

{$ENDIF}

end.
