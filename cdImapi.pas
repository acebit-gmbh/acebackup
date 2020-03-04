unit cdImapi;

interface

uses
  Windows, ActiveX;

type
  MEDIA_TYPES = DWORD;
  {$EXTERNALSYM MEDIA_TYPES}
  TMediaTypes = MEDIA_TYPES;

const
  MEDIA_CDDA_CDROM = 1;
  {$EXTERNALSYM MEDIA_CDDA_CDROM}
  MEDIA_CD_ROM_XA  = MEDIA_CDDA_CDROM + 1;
  {$EXTERNALSYM MEDIA_CD_ROM_XA}
  MEDIA_CD_I       = MEDIA_CD_ROM_XA + 1;
  {$EXTERNALSYM MEDIA_CD_I}
  MEDIA_CD_EXTRA   = MEDIA_CD_I + 1;
  {$EXTERNALSYM MEDIA_CD_EXTRA}
  MEDIA_CD_OTHER   = MEDIA_CD_EXTRA + 1;
  {$EXTERNALSYM MEDIA_CD_OTHER}
  MEDIA_SPECIAL    = MEDIA_CD_OTHER + 1;
  {$EXTERNALSYM MEDIA_SPECIAL}

type
  MEDIA_FLAGS = DWORD;
  {$EXTERNALSYM MEDIA_FLAGS}
  TMediaFlags = MEDIA_FLAGS;

const
  MEDIA_BLANK                    = $1;
  {$EXTERNALSYM MEDIA_BLANK}
  MEDIA_RW                       = $2;
  {$EXTERNALSYM MEDIA_RW}
  MEDIA_WRITABLE                 = $4;
  {$EXTERNALSYM MEDIA_WRITABLE}
  MEDIA_FORMAT_UNUSABLE_BY_IMAPI = $8;
  {$EXTERNALSYM MEDIA_FORMAT_UNUSABLE_BY_IMAPI}

type
  RECORDER_TYPES = DWORD;
  {$EXTERNALSYM RECORDER_TYPES}
  TRecorderTypes = RECORDER_TYPES;

const
  RECORDER_CDR  = $1;
  {$EXTERNALSYM RECORDER_CDR}
  RECORDER_CDRW = $2;
  {$EXTERNALSYM RECORDER_CDRW}

  RECORDER_DOING_NOTHING = 0;
  {$EXTERNALSYM RECORDER_DOING_NOTHING}

  RECORDER_OPENED = $1;
  {$EXTERNALSYM RECORDER_OPENED}

  RECORDER_BURNING = $2;
  {$EXTERNALSYM RECORDER_BURNING}

  IID_IDiscRecorder: TGUID = '{85AC9776-CA88-4cf2-894E-09598C078A41}';
  {$EXTERNALSYM IID_IDiscRecorder}

const
  IMAPI_S_PROPERTIESIGNORED     = HRESULT((SEVERITY_SUCCESS shl 31) or (FACILITY_ITF shl 16) or $200);
  {$EXTERNALSYM IMAPI_S_PROPERTIESIGNORED}
  IMAPI_S_BUFFER_TO_SMALL       = HRESULT((SEVERITY_SUCCESS shl 31) or (FACILITY_ITF shl 16) or $201);
  {$EXTERNALSYM IMAPI_S_BUFFER_TO_SMALL}
  IMAPI_E_NOTOPENED             = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 11);
  {$EXTERNALSYM IMAPI_E_NOTOPENED}
  IMAPI_E_NOTINITIALIZED        = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 12);
  {$EXTERNALSYM IMAPI_E_NOTINITIALIZED}
  IMAPI_E_USERABORT             = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 13);
  {$EXTERNALSYM IMAPI_E_USERABORT}
  IMAPI_E_GENERIC               = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 14);
  {$EXTERNALSYM IMAPI_E_GENERIC}
  IMAPI_E_MEDIUM_NOTPRESENT     = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 15);
  {$EXTERNALSYM IMAPI_E_MEDIUM_NOTPRESENT}
  IMAPI_E_MEDIUM_INVALIDTYPE    = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 16);
  {$EXTERNALSYM IMAPI_E_MEDIUM_INVALIDTYPE}
  IMAPI_E_DEVICE_NOPROPERTIES   = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 17);
  {$EXTERNALSYM IMAPI_E_DEVICE_NOPROPERTIES}
  IMAPI_E_DEVICE_NOTACCESSIBLE  = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 18);
  {$EXTERNALSYM IMAPI_E_DEVICE_NOTACCESSIBLE}
  IMAPI_E_DEVICE_NOTPRESENT     = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 19);
  {$EXTERNALSYM IMAPI_E_DEVICE_NOTPRESENT}
  IMAPI_E_DEVICE_INVALIDTYPE    = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 20);
  {$EXTERNALSYM IMAPI_E_DEVICE_INVALIDTYPE}
  IMAPI_E_INITIALIZE_WRITE      = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 21);
  {$EXTERNALSYM IMAPI_E_INITIALIZE_WRITE}
  IMAPI_E_INITIALIZE_ENDWRITE   = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 22);
  {$EXTERNALSYM IMAPI_E_INITIALIZE_ENDWRITE}
  IMAPI_E_FILESYSTEM            = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 23);
  {$EXTERNALSYM IMAPI_E_FILESYSTEM}
  IMAPI_E_FILEACCESS            = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 24);
  {$EXTERNALSYM IMAPI_E_FILEACCESS}
  IMAPI_E_DISCINFO              = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 25);
  {$EXTERNALSYM IMAPI_E_DISCINFO}
  IMAPI_E_TRACKNOTOPEN          = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 26);
  {$EXTERNALSYM IMAPI_E_TRACKNOTOPEN}
  IMAPI_E_TRACKOPEN             = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 27);
  {$EXTERNALSYM IMAPI_E_TRACKOPEN}
  IMAPI_E_DISCFULL              = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 28);
  {$EXTERNALSYM IMAPI_E_DISCFULL}
  IMAPI_E_BADJOLIETNAME         = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 29);
  {$EXTERNALSYM IMAPI_E_BADJOLIETNAME}
  IMAPI_E_INVALIDIMAGE          = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 30);
  {$EXTERNALSYM IMAPI_E_INVALIDIMAGE}
  IMAPI_E_NOACTIVEFORMAT        = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 31);
  {$EXTERNALSYM IMAPI_E_NOACTIVEFORMAT}
  IMAPI_E_NOACTIVERECORDER      = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 32);
  {$EXTERNALSYM IMAPI_E_NOACTIVERECORDER}
  IMAPI_E_WRONGFORMAT           = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 33);
  {$EXTERNALSYM IMAPI_E_WRONGFORMAT}
  IMAPI_E_ALREADYOPEN           = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 34);
  {$EXTERNALSYM IMAPI_E_ALREADYOPEN}
  IMAPI_E_WRONGDISC             = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 35);
  {$EXTERNALSYM IMAPI_E_WRONGDISC}
  IMAPI_E_FILEEXISTS            = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 36);
  {$EXTERNALSYM IMAPI_E_FILEEXISTS}
  IMAPI_E_STASHINUSE            = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 37);
  {$EXTERNALSYM IMAPI_E_STASHINUSE}
  IMAPI_E_DEVICE_STILL_IN_USE   = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 38);
  {$EXTERNALSYM IMAPI_E_DEVICE_STILL_IN_USE}
  IMAPI_E_LOSS_OF_STREAMING     = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 39);
  {$EXTERNALSYM IMAPI_E_LOSS_OF_STREAMING}
  IMAPI_E_COMPRESSEDSTASH       = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 40);
  {$EXTERNALSYM IMAPI_E_COMPRESSEDSTASH}
  IMAPI_E_ENCRYPTEDSTASH        = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 41);
  {$EXTERNALSYM IMAPI_E_ENCRYPTEDSTASH}
  IMAPI_E_NOTENOUGHDISKFORSTASH = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 42);
  {$EXTERNALSYM IMAPI_E_NOTENOUGHDISKFORSTASH}
  IMAPI_E_REMOVABLESTASH        = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 43);
  {$EXTERNALSYM IMAPI_E_REMOVABLESTASH}
  IMAPI_E_CANNOT_WRITE_TO_MEDIA = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 44);
  {$EXTERNALSYM IMAPI_E_CANNOT_WRITE_TO_MEDIA}
  IMAPI_E_TRACK_NOT_BIG_ENOUGH  = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 45);
  {$EXTERNALSYM IMAPI_E_TRACK_NOT_BIG_ENOUGH}
  IMAPI_E_BOOTIMAGE_AND_NONBLANK_DISC = HRESULT((SEVERITY_ERROR shl 31) or (FACILITY_ITF shl 16) or $200 + 46);
  {$EXTERNALSYM IMAPI_E_BOOTIMAGE_AND_NONBLANK_DISC}

type
  IDiscRecorder = interface(IUnknown)
  ['{85AC9776-CA88-4cf2-894E-09598C078A41}']
    function Init(pbyUniqueID: PByte; nulIDSize, nulDriveNumber: ULONG): HRESULT; stdcall;
    function GetRecorderGUID(pbyUniqueID: PByte; ulBufferSize: ULONG; out pulReturnSizeRequired: ULONG): HRESULT; stdcall;
    function GetRecorderType(out fTypeCode: Longint): HRESULT; stdcall;
    function GetDisplayNames(var pbstrVendorID, pbstrProductID, pbstrRevision: PWideChar): HRESULT; stdcall;
    function GetBasePnPID(out pbstrBasePnPID: PWideChar): HRESULT; stdcall;
    function GetPath(out pbstrPath: PWideChar): HRESULT; stdcall;
    function GetRecorderProperties(out ppPropStg: IPropertyStorage): HRESULT; stdcall;
    function SetRecorderProperties(pPropStg: IPropertyStorage): HRESULT; stdcall;
    function GetRecorderState(out pulDevStateFlags: ULONG): HRESULT; stdcall;
    function OpenExclusive: HRESULT; stdcall;
    function QueryMediaType(out fMediaType, fMediaFlags: Longint): HRESULT; stdcall;
    function QueryMediaInfo(out pbSessions, pbLastTrack: Byte; out ulStartAddress, ulNextWritable, ulFreeBlocks: ULONG): HRESULT; stdcall;
    function Eject: HRESULT; stdcall;
    function Erase(bFullErase: BOOL): HRESULT; stdcall;
    function Close: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDiscRecorder}

//
// interface IEnumDiscRecorders
//

const
  IID_IEnumDiscRecorders: TGUID = '{9B1921E1-54AC-11d3-9144-00104BA11C5E}';
  {$EXTERNALSYM IID_IEnumDiscRecorders}

type
  IEnumDiscRecorders = interface(IUnknown)
  ['{9B1921E1-54AC-11d3-9144-00104BA11C5E}']
    function Next(cRecorders: ULONG; out ppRecorder: IDiscRecorder; out pcFetched: ULONG): HRESULT; stdcall;
    function Skip(cRecorders: ULONG): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
    function Clone(out ppEnum: IEnumDiscRecorders): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IEnumDiscRecorders}

//
// interface IEnumDiscMasterFormats
//

const
  IID_IEnumDiscMasterFormats: TGUID = '{DDF445E1-54BA-11d3-9144-00104BA11C5E}';
  {$EXTERNALSYM IID_IEnumDiscMasterFormats}

type
  IEnumDiscMasterFormats = interface(IUnknown)
  ['{DDF445E1-54BA-11d3-9144-00104BA11C5E}']
    function Next(cFormats: ULONG; out lpiidFormatID: TGUID; out pcFetched: ULONG): HRESULT; stdcall;
    function Skip(cFormats: ULONG): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
    function Clone(out ppEnum: IEnumDiscMasterFormats): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IEnumDiscMasterFormats}

//
// interface IRedbookDiscMaster
//

const
  IID_IRedbookDiscMaster: TGUID = '{E3BC42CD-4E5C-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM IID_IRedbookDiscMaster}

type
  IRedbookDiscMaster = interface(IUnknown)
  ['{E3BC42CD-4E5C-11D3-9144-00104BA11C5E}']
    function GetTotalAudioTracks(out pnTracks: Longint): HRESULT; stdcall;
    function GetTotalAudioBlocks(out pnBlocks: Longint): HRESULT; stdcall;
    function GetUsedAudioBlocks(out pnBlocks: Longint): HRESULT; stdcall;
    function GetAvailableAudioTrackBlocks(out pnBlocks: Longint): HRESULT; stdcall;
    function GetAudioBlockSize(out pnBlockBytes: Longint): HRESULT; stdcall;
    function CreateAudioTrack(nBlocks: Longint): HRESULT; stdcall;
    function AddAudioTrackBlocks(pby: PByte; cb: Longint): HRESULT; stdcall;
    function CloseAudioTrack: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IRedbookDiscMaster}

//
// interface IJolietDiscMaster
//

const
  IID_IJolietDiscMaster: TGUID = '{E3BC42CE-4E5C-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM IID_IJolietDiscMaster}

type
  IJolietDiscMaster = interface(IUnknown)
  ['{E3BC42CE-4E5C-11D3-9144-00104BA11C5E}']
    function GetTotalDataBlocks(out pnBlocks: Longint): HRESULT; stdcall;
    function GetUsedDataBlocks(out pnBlocks: Longint): HRESULT; stdcall;
    function GetDataBlockSize(out pnBlockBytes: Longint): HRESULT; stdcall;
    function AddData(pStorage: IStorage; lFileOverwrite: Longint): HRESULT; stdcall;
    function GetJolietProperties(out ppPropStg: IPropertyStorage): HRESULT; stdcall;
    function SetJolietProperties(pPropStg: IPropertyStorage): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IJolietDiscMaster}

//
// interface IDiscMasterProgressEvents
//

const
  IID_IDiscMasterProgressEvents: TGUID = '{EC9E51C1-4E5D-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM IID_IDiscMasterProgressEvents}

type
  IDiscMasterProgressEvents = interface(IUnknown)
  ['{EC9E51C1-4E5D-11D3-9144-00104BA11C5E}']
    function QueryCancel(out pbCancel: BOOL): HRESULT; stdcall;
    function NotifyPnPActivity: HRESULT; stdcall;
    function NotifyAddProgress(nCompletedSteps, nTotalSteps: Longint): HRESULT; stdcall;
    function NotifyBlockProgress(nCompleted, nTotal: Longint): HRESULT; stdcall;
    function NotifyTrackProgress(nCurrentTrack, nTotalTracks: Longint): HRESULT; stdcall;
    function NotifyPreparingBurn(nEstimatedSeconds: Longint): HRESULT; stdcall;
    function NotifyClosingDisc(nEstimatedSeconds: Longint): HRESULT; stdcall;
    function NotifyBurnComplete(status: HRESULT): HRESULT; stdcall;
    function NotifyEraseComplete(status: HRESULT): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDiscMasterProgressEvents}

//
// interface IDiscMaster
//

const
  IID_IDiscMaster: TGUID = '{520CCA62-51A5-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM IID_IDiscMaster}

type
  IDiscMaster = interface(IUnknown)
  ['{520CCA62-51A5-11D3-9144-00104BA11C5E}']
    function Open: HRESULT; stdcall;
    function EnumDiscMasterFormats(out ppEnum: IEnumDiscMasterFormats): HRESULT; stdcall;
    function GetActiveDiscMasterFormat(out lpiid: TGUID): HRESULT; stdcall;
    function SetActiveDiscMasterFormat(const riid: TGUID; out ppUnk: IUnknown): HRESULT; stdcall;
    function EnumDiscRecorders(out ppEnum: IEnumDiscRecorders): HRESULT; stdcall;
    function GetActiveDiscRecorder(out ppRecorder: IDiscRecorder): HRESULT; stdcall;
    function SetActiveDiscRecorder(pRecorder: IDiscRecorder): HRESULT; stdcall;
    function ClearFormatContent: HRESULT; stdcall;
    function ProgressAdvise(pEvents: IDiscMasterProgressEvents; out pvCookie: UINT): HRESULT; stdcall;
    function ProgressUnadvise(vCookie: UINT): HRESULT; stdcall;
    function RecordDisc(bSimulate, bEjectAfterBurn: BOOL): HRESULT; stdcall;
    function Close: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IDiscMaster}

//
// library IMAPILib
//

const
  //EXTERN_C const IID LIBID_IMAPILib;

  CLSID_MSDiscRecorderObj: TGUID = '{520CCA61-51A5-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM CLSID_MSDiscRecorderObj}
  MSDiscRecorderObj: TGUID = '{520CCA61-51A5-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM MSDiscRecorderObj}

  CLSID_MSDiscMasterObj: TGUID = '{520CCA63-51A5-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM CLSID_MSDiscMasterObj}
  MSDiscMasterObj: TGUID = '{520CCA63-51A5-11D3-9144-00104BA11C5E}';
  {$EXTERNALSYM MSDiscMasterObj}

  CLSID_MSEnumDiscRecordersObj: TGUID = '{8A03567A-63CB-4BA8-BAF6-52119816D1EF}';
  {$EXTERNALSYM CLSID_MSEnumDiscRecordersObj}
  MSEnumDiscRecordersObj: TGUID = '{8A03567A-63CB-4BA8-BAF6-52119816D1EF}';
  {$EXTERNALSYM MSEnumDiscRecordersObj}

type
  HANDLE = Windows.THandle;

function GetVolumePathNamesForVolumeName(lpszVolumeName, lpszVolumePathNames: LPCWSTR;
  cchBufferLength: DWORD; var lpcchReturnLength: DWORD): BOOL; stdcall;
{$EXTERNALSYM GetVolumePathNamesForVolumeName}

function FindFirstVolume(lpszVolumeName: LPWSTR; cchBufferLength: DWORD): HANDLE; stdcall;
{$EXTERNALSYM FindFirstVolume}

function FindNextVolume(hFindVolume: HANDLE; lpszVolumeName: LPWSTR;
  cchBufferLength: DWORD): BOOL; stdcall;
{$EXTERNALSYM FindNextVolume}

function FindVolumeClose(hFindVolume: HANDLE): BOOL; stdcall;
{$EXTERNALSYM FindVolumeClose}

implementation

function GetVolumePathNamesForVolumeName; external kernel32 name 'GetVolumePathNamesForVolumeNameW';
function FindFirstVolume; external kernel32 name 'FindFirstVolumeW';
function FindNextVolume; external kernel32 name 'FindNextVolumeW';
function FindVolumeClose; external kernel32 name 'FindVolumeClose';

end.

