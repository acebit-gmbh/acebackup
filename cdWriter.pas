unit cdWriter;

interface

uses
  Classes, Windows, ShlObj, SysUtils, ComObj, ActiveX, cdImapi;

type
  TCDWriter = class;

  TCallBackObj = class(TInterfacedObject,IDiscMasterProgressEvents)
  private
    FOwner: TCDWriter;
  public
    constructor Create(AOwner: TCDWriter);
    function NotifyAddProgress(nCompletedSteps: Integer;
      nTotalSteps: Integer): HRESULT; stdcall;
    function NotifyBurnComplete(status: HRESULT): HRESULT; stdcall;
    function NotifyBlockProgress(nCompleted: Integer; nTotal: Integer): HRESULT; stdcall;
    function NotifyClosingDisc(nEstimatedSeconds: Integer): HRESULT; stdcall;
    function NotifyEraseComplete(status: HRESULT): HRESULT; stdcall;
    function NotifyPnPActivity: HRESULT; stdcall;
    function NotifyPreparingBurn(nEstimatedSeconds: Integer): HRESULT; stdcall;
    function NotifyTrackProgress(nCurrentTrack: Integer;
      nTotalTracks: Integer): HRESULT; stdcall;
    function QueryCancel(out pbCancel: LongBool): HRESULT; stdcall;
  end;

  TCDValueKind = (cdvkData, cdvkBlock, cdvkTrack);
  TCDCompletion = (cdcoBurning, cdcoErasing);
  TCDRecorderState = (cdrsUnknown, cdrsIdle, cdrsOpen, cdrsBurning);
  TCDDrive = record
    Device : String;
    Volume : String;
    Path : String;
  end;
  TCDMediaInfo = record
    SessionCount: Byte;
    LastTrack: Byte;
    StartAddress: Cardinal;
    NextWriteable: Cardinal;
    FreeBlocks: Cardinal;
  end;

  TNotifyCancel = procedure(out ACancelAction: Boolean) of object;
  TNotifyMessage = procedure(const AMessage: String) of object;
  TNotifyValues = procedure(AKind: TCDValueKind; ACurrent, ATotal: Integer) of object;
  TNotifyCompletion = procedure(Sender: TObject; ACompletion: TCDCompletion; AStatus: HRESULT) of object;

  TCDWriter = class(TObject)
  private
    FCookie: Cardinal;
    FJolietDiscMaster: IJolietDiscMaster;
    FRedBookDiscMaster: IRedbookDiscMaster;
    FHelper: IDiscMasterProgressEvents;
    FDiscMaster: IDiscMaster;
    FDiscRecorder: IDiscRecorder;
    FRecorders: TInterfaceList;
    FOnShowMessage: TNotifyMessage;
    FOnValueChange: TNotifyValues;
    FOnCompletion: TNotifyCompletion;
    FOnCancelAction: TNotifyCancel;
    FImageSize: Cardinal;
    FBytesWritten: Cardinal;
    function GetDiscMaster: IDiscMaster;
    function GetRecorderState: TCDRecorderState;
    function GetFirstRecorder(out aRecorder: IDiscRecorder): Boolean;
    procedure ListRecorders(AIntfList: TInterfaceList; ADisplay: TStrings);
    procedure GetDiskFormats;
    procedure SetLastMessage(const Value: String);
    function GetDiscRecorder: IDiscRecorder;
    function GetDeviceReady: Boolean;
    function GetRecorderPath: String;
    procedure GetVolumeNames(AVolume: array of Char; var ADrive: TCDDrive);
    procedure DoJolietAddFiles(AFiles: TStrings; AOverwrite: Boolean);
    procedure DoJolietAddFileToStorage(AFile: String; AStorage: IStorage;
      ANewFileName: String);
    property LastMessage: String write SetLastMessage;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure RecorderOpen;
    procedure RecorderClose;
    procedure SetActiveRecorder(AIndex: Integer);

    function AddData(AContent: IStorage; AOverwrite: Boolean): Boolean;
    function AddFolder(const AFolderOnHDD, AFolderOnDisc: String;
      AOverwrite: Boolean): Boolean;
    function AddFile(const AFile, AFolderOnDisc: String;
      AOverwrite: Boolean): Boolean;
    function AddFiles(AFileList: TStrings; AOverwrite: Boolean): Boolean;

    function FilesCount: Integer;
    function RecordDisk(Simulate, EjectAfterBurn: Boolean): Boolean;
    function IsWriteableMedia: Boolean;
    function GetMediaInfo: TCDMediaInfo;
    function GetRecorderCount: Integer;
    function GetRecorderList(ARecorders: TStrings): Boolean;
    property OnCompletion: TNotifyCompletion read FOnCompletion write FOnCompletion;
    property OnShowMessage: TNotifyMessage read FOnShowMessage write FOnShowMessage;
    property OnValueChange: TNotifyValues read FOnValueChange write FOnValueChange;
    property OnCancelAction: TNotifyCancel read FOnCancelAction write FOnCancelAction;
    property DiscMaster: IDiscMaster read GetDiscMaster;
    property DiscRecorder: IDiscRecorder read GetDiscRecorder;
    property RecorderState: TCDRecorderState read GetRecorderState;
    property DeviceReady: Boolean read GetDeviceReady;
    property RecorderPath: String read GetRecorderPath;
    property ImageSize: Cardinal read FImageSize write FImageSize;
    property BytesWritten: Cardinal read FBytesWritten write FBytesWritten;
  end;

implementation

uses
  nsGlobals;

resourcestring
  res_ImapiAlreadyOpen = 'Imapi interface is already opened.';
  res_ImapiObjectNotAvail = 'Imapi-Object is not available.';
  res_DeviceWasRemoved = 'Device has been removed from the system.';
  res_CDfullOrReadOnlyOrAudio = 'Disc is full or read only or has audio format.';
  res_NoMediaInserted = 'No media inserted.';
  res_ImapiNoInit = 'Imapi has not been initialized.';
  res_NoFormatChoosen = 'No format has been choosen.';
  res_AnotherRecorderChoosen = 'Another recorder has been choosen already.';
  res_WritingComplete = 'CD-Writing complete.';
  res_FinalizeStartsInSeconds = 'Finalizing starts in %d seconds';
  res_CDErasingComplete = 'CD-Erasing complete.';
  res_RecorderListChanged = 'List of recorders has been changed.';
  res_WritingBeginsInSeconds = 'Writing begins in %d seconds.';

constructor TCDWriter.Create(AOwner: TComponent);
begin
  FHelper := TCallBackObj.Create(Self);
  FDiscMaster := CreateComObject(MSDiscMasterObj) as IDiscMaster;
  if FDiscMaster.Open = IMAPI_E_ALREADYOPEN then
    LastMessage := res_ImapiAlreadyOpen;

  GetDiskFormats;

  FRecorders := TInterfaceList.Create;
  FDiscMaster.ProgressAdvise(FHelper,FCookie);
  GetFirstRecorder(FDiscRecorder);
end;

destructor TCDWriter.Destroy;
begin
  if Assigned(FDiscMaster) then
  begin
    FDiscMaster.ProgressUnadvise(FCookie);
    FDiscMaster.Close;
    FDiscMaster := nil;
  end;
  FreeAndNil(FRecorders);
end;

procedure TCDWriter.DoJolietAddFiles(AFiles: TStrings; AOverwrite: Boolean);
{ List has to be in this format:
\Folder\On\Disc\file1.txt=c:\test.txt
\Sub\Folder\On\Disc\file2.exe=c:\app.exe
}
var
  idxFile : Integer;
  Folders : TInterfaceList;
  FolderNames : TStringList;

  PathSplitter : TStringList;
  RootFolder,
  CurrentFolder : IStorage;

  function FirstNParts(N : Integer) : String;
  var
    idx : Integer;
  begin
    Result := EmptyStr;

    for idx := 0 to N do
    begin
      if idx > 0 then
        Result := Result + PathSplitter.Delimiter;
      Result := Result + PathSplitter[idx];
    end;
  end;

  procedure GetCurrentFolder(AFolderName : String);
  var
    idxFolderName,
    idxFolderPart,
    idxFolder,
    idx : Integer;
    temp : IStorage;
  begin
    AFolderName := Trim(ExcludeTrailingPathDelimiter(AFolderName));

    if AFolderName = EmptyStr then
    begin
      CurrentFolder := RootFolder;
      exit;
    end;

    idxFolderName := FolderNames.IndexOf(AFolderName);
    if idxFolderName > -1 then
    begin
      idxFolder := Integer(FolderNames.Objects[idxFolderName]);
      CurrentFolder := Folders[idxFolder] as IStorage;
      exit;
    end;

    PathSplitter.DelimitedText := AFolderName;

    idx := 1;

    CurrentFolder := nil;

    for idxFolderPart := PathSplitter.Count - 1 downto 1 do
    begin
      PathSplitter.Delete(idxFolderPart);

      idxFolderName := FolderNames.IndexOf(PathSplitter.DelimitedText);
      if idxFolderName > -1 then
      begin
        idx := idxFolderPart;
        idxFolder := Integer(FolderNames.Objects[idxFolderName]);
        CurrentFolder := Folders[idxFolder] as IStorage;
        break;
      end;
    end;

    if CurrentFolder = nil then
      CurrentFolder := RootFolder;

    PathSplitter.DelimitedText := AFolderName;

    for idxFolderPart := idx to PathSplitter.Count - 1 do
    begin
      temp := CurrentFolder;
      temp.CreateStorage(PWideChar(WideString(PathSplitter[idxFolderPart])),
                         STGM_CREATE or STGM_READWRITE or STGM_DIRECT or
                         STGM_SHARE_EXCLUSIVE, 0, 0, CurrentFolder);

      FolderNames.AddObject(FirstNParts(idxFolderPart), TObject(Folders.Add(CurrentFolder)));
    end;
  end;

begin
  OleCheck(StgCreateDocFile(nil,
                            STGM_CREATE or STGM_READWRITE or STGM_DIRECT or
                            STGM_SHARE_EXCLUSIVE or STGM_DELETEONRELEASE,
                            0,
                            ActiveX.IStorage(RootFolder)));

  Folders := TInterfaceList.Create;

  FolderNames := TStringList.Create;
  FolderNames.Sorted := true;

  PathSplitter := TStringList.Create;
  PathSplitter.Delimiter := PathDelim;
  PathSplitter.StrictDelimiter := true;
  try

    for idxFile := 0 to AFiles.Count - 1 do
    begin
      GetCurrentFolder(ExtractFilePath(AFiles.Names[idxFile]));
      DoJolietAddFileToStorage(AFiles.ValueFromIndex[idxFile],
                       CurrentFolder,
                       ExtractFileName(AFiles.Names[idxFile]));
    end;

  finally
    CurrentFolder := nil;
    Folders.Free;
    FolderNames.Free;
    PathSplitter.Free;
  end;

  AddData(RootFolder, AOverwrite);
end;

procedure TCDWriter.DoJolietAddFileToStorage(AFile: String; AStorage: IStorage;
  ANewFileName : String);
var
  FileName : String;
  FS : TFileStream;
  Buffer : Pointer;
  DataInBuffer : Integer;
  Written : Longint;
  Stream : IStream;
const
  DEFAULT_BUFFER_SIZE = 4096;
begin
  if not FileExists(AFile) then
    exit;

  FileName := ExtractFileName(AFile);

  if ANewFileName = EmptyStr then
    ANewFileName := ExtractFileName(AFile);

  OleCheck(AStorage.CreateStream(PWideChar(WideString(ANewFileName)),
                                 STGM_CREATE or STGM_READWRITE or STGM_DIRECT or
                                 STGM_SHARE_EXCLUSIVE, 0, 0, Stream));

  FS := TFileStream.Create(AFile, fmOpenRead);
  GetMem(Buffer, DEFAULT_BUFFER_SIZE);
  try
    repeat
      DataInBuffer := FS.Read(Buffer^, DEFAULT_BUFFER_SIZE);
      Stream.Write(Buffer, DataInBuffer, @Written);
    until DataInBuffer = 0;

  finally
    fs.Free;

    Stream := nil;

    if Assigned(Buffer) then
      FreeMem(Buffer, DEFAULT_BUFFER_SIZE);
  end;
end;

function TCDWriter.AddData(AContent: IStorage; AOverwrite: Boolean): Boolean;
begin
  Result := Assigned(FJolietDiscMaster);
  if not Result then
    Exit;

  try
    OleCheck(FJolietDiscMaster.AddData(AContent, Integer(AOverwrite)));
  except
    Result := False;
  end;
end;

function TCDWriter.AddFile(const AFile, AFolderOnDisc: String;
  AOverwrite: Boolean): Boolean;
var
  slList : TStringList;
begin
  Result := Assigned(FJolietDiscMaster);
  if not Result then
    Exit;

  slList := TStringList.Create;
  try
    slList.Values[IncludeTrailingPathDelimiter(AFolderOnDisc) + ExtractFileName(AFile)] := AFile;
    DoJolietAddFiles(slList, AOverwrite);
  finally
    slList.Free;
  end;
end;

function TCDWriter.AddFiles(AFileList: TStrings; AOverwrite: Boolean): Boolean;
begin
  Result := Assigned(FJolietDiscMaster);
  if not Result then
    Exit;

  DoJolietAddFiles(AFileList, AOverwrite);
end;

function TCDWriter.AddFolder(const AFolderOnHDD, AFolderOnDisc: String;
  AOverwrite: Boolean): Boolean;
var
  slList : TStringList;

  procedure AddFilesToList(AFolderHDD, AFolderDisc : String);
  var
    sr : TSearchRec;
  begin
    AFolderHDD := IncludeTrailingPathDelimiter(AFolderHDD);
    AFolderDisc := IncludeTrailingPathDelimiter(AFolderDisc);

    if FindFirst(AFolderHDD + sFileMask, faAnyFile, sr) = 0 then
    begin
      repeat
        if (sr.Name <> sDot) and (sr.Name <> sDoubleDot) then
        begin
          if ((sr.Attr and faDirectory) <> 0) then
          begin
            AddFilesToList(AFolderHDD + sr.Name, AFolderDisc + sr.Name)
          end
          else
            slList.Values[AFolderDisc + sr.Name] := AFolderHDD + sr.Name;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  end;
begin
  Result := Assigned(FJolietDiscMaster);
  if not Result then
    Exit;

  slList := TStringList.Create;
  try
    AddFilesToList(AFolderOnHDD, AFolderOnDisc);
    AddFiles(slList, AOverwrite);
  finally
    slList.Free;
  end;
end;

function TCDWriter.FilesCount: Integer;
begin
  Result := 1; //TODO
end;

function TCDWriter.GetDeviceReady: Boolean;
begin
  Result := GetRecorderState = cdrsIdle;
end;

function TCDWriter.GetDiscMaster: IDiscMaster;
begin
  if Assigned(FDiscMaster) then
    Result := FDiscMaster
  else
    raise Exception.Create(res_ImapiObjectNotAvail);
end;

function TCDWriter.GetDiscRecorder: IDiscRecorder;
begin
  if Assigned(FDiscRecorder) then
    Result := FDiscRecorder
  else
    raise Exception.Create(res_ImapiObjectNotAvail);
end;

function TCDWriter.GetFirstRecorder(out ARecorder: IDiscRecorder): Boolean;
var
  lEnumRecorders : IEnumDiscRecorders;
  pfetched : Cardinal;
begin
  ARecorder := nil;
  OleCheck(DiscMaster.EnumDiscRecorders(lEnumRecorders));
  pFetched := 0;
  lEnumRecorders.Next(1,ARecorder,pFetched);
  Result := pFetched > 0;
end;

function TCDWriter.GetMediaInfo: TCDMediaInfo;
begin
  RecorderOpen;
  try
    OleCheck(FDiscRecorder.QueryMediaInfo(
      Result.SessionCount,
      Result.LastTrack,
      Result.StartAddress,
      Result.NextWriteable,
      Result.FreeBlocks));
  finally
    RecorderClose;
  end;
end;

function TCDWriter.GetRecorderList(ARecorders: TStrings): Boolean;
var
  iUnk : IUnknown;
begin
  OleCheck(DiscMaster.SetActiveDiscMasterFormat(IID_IJolietDiscMaster, iUnk));
  ListRecorders(FRecorders, ARecorders);
  Result := ARecorders.Count > 0;
end;

function TCDWriter.GetRecorderCount: Integer;
var
  list: TStringList;
begin
  list := TStringList.Create;
  try
    GetRecorderList(list);
    Result := list.Count;
  finally
    FreeAndNil(list);
  end;
end;

procedure TCDWriter.GetVolumeNames(AVolume: Array of Char; var ADrive: TCDDrive);
var
  dBufferLen: DWORD;
  dReturnLen: DWORD;
  pVolumePath: PChar;
begin
  dBufferLen := MAX_PATH + 1;

  ADrive.Volume := Copy(AVolume, 1, dBufferLen);
  pVolumePath := StrAlloc(dBufferLen);
  if GetVolumePathNamesForVolumeName(PChar(ADrive.Volume), pVolumePath, dBufferLen, dReturnLen) then
    ADrive.Path := ExcludeTrailingPathDelimiter(pVolumePath);
  StrDispose(pVolumePath);

  pVolumePath := StrAlloc(dBufferLen);
  if (QueryDosDevice(PChar(ADrive.Path), pVolumePath, dBufferLen) > 0) then
    ADrive.Device := pVolumePath;
  StrDispose(pVolumePath);
  ADrive.Path := IncludeTrailingPathDelimiter(ADrive.Path);
end;

function TCDWriter.IsWriteableMedia: Boolean;
var
  mt, mf : Integer;
begin
  RecorderOpen;
  try
    OleCheck(FDiscRecorder.QueryMediaType(mt, mf));
    Result := (MEDIA_FORMAT_UNUSABLE_BY_IMAPI and mf = 0)
      and ((MEDIA_BLANK and mf = MEDIA_BLANK)
      or (MEDIA_RW and mf = MEDIA_RW)
      or (MEDIA_WRITABLE and mf = MEDIA_WRITABLE));
  finally
    RecorderClose;
  end;
end;

function TCDWriter.GetRecorderPath: String;
var
  hVolume: THandle;
  cVolume: Array[0..MAX_PATH] of Char;
  pPath: PWideChar;
  rDrive: TCDDrive;
begin
  Result := EmptyStr;
  DiscRecorder.GetPath(pPath);
  hVolume := FindFirstVolume(cVolume, SizeOf(cVolume));
  if hVolume <> INVALID_HANDLE_VALUE then
  repeat
    GetVolumeNames(cVolume, rDrive);
    if rDrive.Device = pPath then
      Result := rDrive.Path;
  until (Result <> EmptyStr) or (not FindNextVolume(hVolume, cVolume, SizeOf(cVolume)));
  FindVolumeClose(hVolume);
end;

function TCDWriter.GetRecorderState: TCDRecorderState;
var
  iState: Cardinal;
begin
  OleCheck(FDiscRecorder.GetRecorderState(iState));

  case iState of
    RECORDER_DOING_NOTHING: Result := cdrsIdle;
    RECORDER_OPENED: Result := cdrsOpen;
    RECORDER_BURNING: Result := cdrsBurning;
    else
      Result := cdrsUnknown;
  end;
end;

procedure TCDWriter.GetDiskFormats;
var
  lFormats: IEnumDiscMasterFormats;
  gFmtID: TGUID;
  iFetched: Cardinal;
begin
  OleCheck(FDiscMaster.EnumDiscMasterFormats(lFormats));

  FRedBookDiscMaster := nil;
  FJolietDiscMaster := nil;

  iFetched := 1;
  lFormats.Next(1, gFmtID, iFetched);

  while iFetched > 0 do
  begin
    if IsEqualGUID(gFmtID, IID_IRedbookDiscMaster) then
      FRedBookDiscMaster := FDiscMaster as IRedbookDiscMaster
    else
    if IsEqualGUID(gFmtID, IID_IJolietDiscMaster) then
      FJolietDiscMaster := FDiscMaster as IJolietDiscMaster;

    lFormats.Next(1, gFmtID, iFetched);
  end;
end;

procedure TCDWriter.ListRecorders(AIntfList: TInterfaceList; ADisplay: TStrings);
var
  lEnumRecorders: IEnumDiscRecorders;
  lRecIntf: IDiscRecorder;
  iFetched: Cardinal;
  pPath: PWideChar;
  pVendorStr: PWideChar;
  pProductId: PWideChar;
  pRevision: PWideChar;
begin
  AIntfList.Clear;
  ADisplay.Clear;
  OleCheck(DiscMaster.EnumDiscRecorders(lEnumRecorders));
  iFetched := 1;
  lEnumRecorders.Next(1,lRecIntf,iFetched);
  while iFetched > 0 do
    begin
      AIntfList.Add(lRecIntf);
      OleCheck(lRecIntf.GetDisplayNames(pVendorStr, pProductId, pRevision));
      OleCheck(lRecIntf.GetPath(pPath));
      ADisplay.Add(Format('%s (%s %s %s %s)', [GetRecorderPath,
                   WideCharToString(pPath),
                   WideCharToString(pVendorStr),
                   WideCharToString(pProductId),
                   WideCharToString(pRevision)]));
      lEnumRecorders.Next(1,lRecIntf,iFetched);
    end;
end;

procedure TCDWriter.RecorderOpen;
begin
  OleCheck(FDiscRecorder.OpenExclusive);
end;

procedure TCDWriter.RecorderClose;
begin
  OleCheck(FDiscRecorder.Close);
end;

function TCDWriter.RecordDisk(Simulate, EjectAfterBurn: Boolean): Boolean;
begin
  try
    OleCheck(DiscMaster.RecordDisc(Simulate, EjectAfterBurn));
    Result := True;
  except
    Result := False;
  end;
end;

procedure TCDWriter.SetActiveRecorder(AIndex: Integer);
begin
  case DiscMaster.SetActiveDiscRecorder(FRecorders.Items[AIndex] as IDiscRecorder) of
    IMAPI_E_DEVICE_NOTPRESENT : LastMessage := res_DeviceWasRemoved;
    IMAPI_E_DISCFULL          : LastMessage := res_CDfullOrReadOnlyOrAudio;
    IMAPI_E_MEDIUM_NOTPRESENT : LastMessage := res_NoMediaInserted;
    IMAPI_E_NOTOPENED         : LastMessage := res_ImapiNoInit;
    IMAPI_E_NOACTIVEFORMAT    : LastMessage := res_NoFormatChoosen;
    IMAPI_E_STASHINUSE        : LastMessage := res_AnotherRecorderChoosen;
  end;
end;

procedure TCDWriter.SetLastMessage(const Value: String);
begin
  if Assigned(FOnShowMessage) then
    FOnShowMessage(Value);
end;

{ TCallBackObj }

constructor TCallBackObj.Create(AOwner: TCDWriter);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TCallBackObj.NotifyAddProgress(nCompletedSteps, nTotalSteps: Integer): HRESULT;
begin
  if Assigned(FOwner) then
    if Assigned(FOwner.OnValueChange) then
      FOwner.OnValueChange(cdvkData, nCompletedSteps, nTotalSteps);

  Result := s_OK;
end;

function TCallBackObj.NotifyBlockProgress(nCompleted, nTotal: Integer): HRESULT;
begin
  if Assigned(FOwner) then
    if Assigned(FOwner.OnValueChange) then
      FOwner.OnValueChange(cdvkBlock, nCompleted, nTotal);

  Result := s_OK;
end;

function TCallBackObj.NotifyBurnComplete(status: HRESULT): HRESULT;
begin
  if Assigned(FOwner) then
  begin
    FOwner.LastMessage := res_WritingComplete;
    if Assigned(FOwner.OnCompletion) then
      FOwner.OnCompletion(Self, cdcoBurning, status);
  end;

  Result := s_OK;
end;

function TCallBackObj.NotifyClosingDisc(nEstimatedSeconds: Integer): HRESULT;
begin
  if Assigned(FOwner) then
    FOwner.LastMessage := Format(res_FinalizeStartsInSeconds,
      [nEstimatedSeconds]);

  Result := s_OK;
end;

function TCallBackObj.NotifyEraseComplete(status: HRESULT): HRESULT;
begin
  if Assigned(FOwner) then
  begin
    FOwner.LastMessage := res_CDErasingComplete;
    if Assigned(FOwner.OnCompletion) then
      FOwner.OnCompletion(Self, cdcoErasing, status);
  end;

  Result := s_OK;
end;

function TCallBackObj.NotifyPnPActivity: HRESULT;
begin
  if Assigned(FOwner) then
    FOwner.LastMessage := res_RecorderListChanged;

  Result := s_OK;
end;

function TCallBackObj.NotifyPreparingBurn(nEstimatedSeconds: Integer): HRESULT;
begin
  if Assigned(FOwner) then
    FOwner.LastMessage := Format(res_WritingBeginsInSeconds, [nEstimatedSeconds]);

  Result := s_OK;
end;

function TCallBackObj.NotifyTrackProgress(nCurrentTrack, nTotalTracks: Integer): HRESULT;
begin
  if Assigned(FOwner) then
    if Assigned(FOwner.OnValueChange) then
      FOwner.OnValueChange(cdvkTrack, nCurrentTrack, nTotalTracks);

  Result := s_OK;
end;

function TCallBackObj.QueryCancel(out pbCancel: LongBool): HRESULT;
var
  Cancel : Boolean;
begin
  if Assigned(FOwner) and Assigned(FOwner.OnCancelAction) then
  begin
    Cancel := false;
    FOwner.OnCancelAction(Cancel);
    pbCancel := Cancel;
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

end.
