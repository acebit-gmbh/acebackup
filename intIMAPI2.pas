unit intIMAPI2;

interface

uses
  Winapi.Windows,
  Winapi.ActiveX,
  System.Classes,
  Vcl.Graphics,
  Vcl.OleServer,
  Vcl.OleCtrls,
  System.Win.StdVCL;

const
  IMAPI2MajorVersion = $01;
  IMAPI2MinorVersion = $00;

  LIBID_IMAPI2: TGUID =
    (D1: $2735412F; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IWriteEngine2EventArgs: TGUID =
    (D1: $27354136; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2DataEventArgs: TGUID =
    (D1: $2735413D; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2TrackAtOnceEventArgs: TGUID =
    (D1: $27354140; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2RawCDEventArgs: TGUID =
    (D1: $27354143; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IWriteSpeedDescriptor: TGUID =
    (D1: $27354144; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_DDiscMaster2Events: TGUID =
    (D1: $27354131; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_DWriteEngine2Events: TGUID =
    (D1: $27354137; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_DDiscFormat2EraseEvents: TGUID =
    (D1: $2735413A; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_DDiscFormat2DataEvents: TGUID =
    (D1: $2735413C; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_DDiscFormat2TrackAtOnceEvents: TGUID =
    (D1: $2735413F; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_DDiscFormat2RawCDEvents: TGUID =
    (D1: $27354142; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IRawCDImageCreator: TGUID =
    (D1: $25983550; D2: $9D65; D3: $49CE;
      D4: ($B3, $35, $40, $63, $0D, $90, $12, $27));

  IID_ISequentialStream: TGUID =
    (D1: $0C733A30; D2: $2A1C; D3: $11CE;
      D4: ($AD, $E5, $00, $AA, $00, $44, $77, $3D));

  IID_IStream: TGUID =
    (D1: $0000000C; D2: $0000; D3: $0000;
      D4: ($C0, $00, $00, $00, $00, $00, $00, $46));

  IID_IRawCDImageTrackInfo: TGUID =
    (D1: $25983551; D2: $9D65; D3: $49CE;
      D4: ($B3, $35, $40, $63, $0D, $90, $12, $27));

  IID_IBurnVerification: TGUID =
    (D1: $D2FFD834; D2: $958B; D3: $426D;
      D4: ($84, $70, $2A, $13, $87, $9C, $6A, $91));

  IID_IBlockRange: TGUID =
    (D1: $B507CA25; D2: $2204; D3: $11DD;
      D4: ($96, $6A, $00, $1A, $A0, $1B, $BC, $58));

  IID_IBlockRangeList: TGUID =
    (D1: $B507CA26; D2: $2204; D3: $11DD;
      D4: ($96, $6A, $00, $1A, $A0, $1B, $BC, $58));

  IID_IDiscMaster2: TGUID =
    (D1: $27354130; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IConnectionPointContainer: TGUID =
    (D1: $B196B284; D2: $BAB4; D3: $101A;
      D4: ($B6, $9C, $00, $AA, $00, $34, $1D, $07));

  CLASS_MsftDiscMaster2: TGUID =
    (D1: $2735412E; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IEnumConnectionPoints: TGUID =
    (D1: $B196B285; D2: $BAB4; D3: $101A;
      D4: ($B6, $9C, $00, $AA, $00, $34, $1D, $07));

  IID_IConnectionPoint: TGUID =
    (D1: $B196B286; D2: $BAB4; D3: $101A;
      D4: ($B6, $9C, $00, $AA, $00, $34, $1D, $07));

  IID_IEnumConnections: TGUID =
    (D1: $B196B287; D2: $BAB4; D3: $101A;
      D4: ($B6, $9C, $00, $AA, $00, $34, $1D, $07));

  IID_IDiscRecorder2: TGUID =
    (D1: $27354133; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscRecorder2Ex: TGUID =
    (D1: $27354132; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftDiscRecorder2: TGUID =
    (D1: $2735412D; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IWriteEngine2: TGUID =
    (D1: $27354135; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftWriteEngine2: TGUID =
    (D1: $2735412C; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2: TGUID =
    (D1: $27354152; D2: $8F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2Erase: TGUID =
    (D1: $27354156; D2: $8F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftDiscFormat2Erase: TGUID =
    (D1: $2735412B; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2Data: TGUID =
    (D1: $27354153; D2: $9F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftDiscFormat2Data: TGUID =
    (D1: $2735412A; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2TrackAtOnce: TGUID =
    (D1: $27354154; D2: $8F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftDiscFormat2TrackAtOnce: TGUID =
    (D1: $27354129; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IDiscFormat2RawCD: TGUID =
    (D1: $27354155; D2: $8F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftDiscFormat2RawCD: TGUID =
    (D1: $27354128; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftStreamZero: TGUID =
    (D1: $27354127; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IStreamPseudoRandomBased: TGUID =
    (D1: $27354145; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftStreamPrng001: TGUID =
    (D1: $27354126; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IStreamConcatenate: TGUID =
    (D1: $27354146; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftStreamConcatenate: TGUID =
    (D1: $27354125; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IStreamInterleave: TGUID =
    (D1: $27354147; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftStreamInterleave: TGUID =
    (D1: $27354124; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  CLASS_MsftWriteSpeedDescriptor: TGUID =
    (D1: $27354123; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IMultisession: TGUID =
    (D1: $27354150; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IMultisessionSequential: TGUID =
    (D1: $27354151; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IMultisessionSequential2: TGUID =
    (D1: $B507CA22; D2: $2204; D3: $11DD;
      D4: ($96, $6A, $00, $1A, $A0, $1B, $BC, $58));

  CLASS_MsftMultisessionSequential: TGUID =
    (D1: $27354122; D2: $7F64; D3: $5B0F;
      D4: ($8F, $00, $5D, $77, $AF, $BE, $26, $1E));

  IID_IMultisessionRandomWrite: TGUID =
    (D1: $B507CA23; D2: $2204; D3: $11DD;
      D4: ($96, $6A, $00, $1A, $A0, $1B, $BC, $58));

  CLASS_MsftMultisessionRandomWrite: TGUID =
    (D1: $B507CA24; D2: $2204; D3: $11DD;
      D4: ($96, $6A, $00, $1A, $A0, $1B, $BC, $58));

  CLASS_MsftRawCDImageCreator: TGUID =
    (D1: $25983561; D2: $9D65; D3: $49CE;
      D4: ($B3, $35, $40, $63, $0D, $90, $12, $27));

type
  _IMAPI_FORMAT2_DATA_WRITE_ACTION = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_FORMAT2_DATA_WRITE_ACTION_VALIDATING_MEDIA = $00;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_FORMATTING_MEDIA = $01;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_INITIALIZING_HARDWARE = $02;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_CALIBRATING_POWER = $03;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_WRITING_DATA = $04;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_FINALIZATION = $05;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_COMPLETED = $06;
  IMAPI_FORMAT2_DATA_WRITE_ACTION_VERIFYING = $07;

type
  _IMAPI_FORMAT2_TAO_WRITE_ACTION = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_FORMAT2_TAO_WRITE_ACTION_UNKNOWN = $00;
  IMAPI_FORMAT2_TAO_WRITE_ACTION_PREPARING = $01;
  IMAPI_FORMAT2_TAO_WRITE_ACTION_WRITING = $02;
  IMAPI_FORMAT2_TAO_WRITE_ACTION_FINISHING = $03;
  IMAPI_FORMAT2_TAO_WRITE_ACTION_VERIFYING = $04;

type
  _IMAPI_FORMAT2_RAW_CD_WRITE_ACTION = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_UNKNOWN = $00;
  IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_PREPARING = $01;
  IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_WRITING = $02;
  IMAPI_FORMAT2_RAW_CD_WRITE_ACTION_FINISHING = $03;

type
  _IMAPI_MEDIA_PHYSICAL_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_MEDIA_TYPE_UNKNOWN = $00;
  IMAPI_MEDIA_TYPE_CDROM = $01;
  IMAPI_MEDIA_TYPE_CDR = $02;
  IMAPI_MEDIA_TYPE_CDRW = $03;
  IMAPI_MEDIA_TYPE_DVDROM = $04;
  IMAPI_MEDIA_TYPE_DVDRAM = $05;
  IMAPI_MEDIA_TYPE_DVDPLUSR = $06;
  IMAPI_MEDIA_TYPE_DVDPLUSRW = $07;
  IMAPI_MEDIA_TYPE_DVDPLUSR_DUALLAYER = $08;
  IMAPI_MEDIA_TYPE_DVDDASHR = $09;
  IMAPI_MEDIA_TYPE_DVDDASHRW = $0A;
  IMAPI_MEDIA_TYPE_DVDDASHR_DUALLAYER = $0B;
  IMAPI_MEDIA_TYPE_DISK = $0C;
  IMAPI_MEDIA_TYPE_DVDPLUSRW_DUALLAYER = $0D;
  IMAPI_MEDIA_TYPE_HDDVDROM = $0E;
  IMAPI_MEDIA_TYPE_HDDVDR = $0F;
  IMAPI_MEDIA_TYPE_HDDVDRAM = $10;
  IMAPI_MEDIA_TYPE_BDROM = $11;
  IMAPI_MEDIA_TYPE_BDR = $12;
  IMAPI_MEDIA_TYPE_BDRE = $13;
  IMAPI_MEDIA_TYPE_MAX = $13;

type
  _IMAPI_CD_SECTOR_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_CD_SECTOR_AUDIO = $00;
  IMAPI_CD_SECTOR_MODE_ZERO = $01;
  IMAPI_CD_SECTOR_MODE1 = $02;
  IMAPI_CD_SECTOR_MODE2FORM0 = $03;
  IMAPI_CD_SECTOR_MODE2FORM1 = $04;
  IMAPI_CD_SECTOR_MODE2FORM2 = $05;
  IMAPI_CD_SECTOR_MODE1RAW = $06;
  IMAPI_CD_SECTOR_MODE2FORM0RAW = $07;
  IMAPI_CD_SECTOR_MODE2FORM1RAW = $08;
  IMAPI_CD_SECTOR_MODE2FORM2RAW = $09;

type
  _IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_FORMAT2_RAW_CD_SUBCODE_PQ_ONLY = $01;
  IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_COOKED = $02;
  IMAPI_FORMAT2_RAW_CD_SUBCODE_IS_RAW = $03;

type
  _IMAPI_CD_TRACK_DIGITAL_COPY_SETTING = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_CD_TRACK_DIGITAL_COPY_PERMITTED = $00;
  IMAPI_CD_TRACK_DIGITAL_COPY_PROHIBITED = $01;
  IMAPI_CD_TRACK_DIGITAL_COPY_SCMS = $02;

type
  _IMAPI_BURN_VERIFICATION_LEVEL = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_BURN_VERIFICATION_NONE = $00;
  IMAPI_BURN_VERIFICATION_QUICK = $01;
  IMAPI_BURN_VERIFICATION_FULL = $02;

type
  _IMAPI_READ_TRACK_ADDRESS_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_READ_TRACK_ADDRESS_TYPE_LBA = $00;
  IMAPI_READ_TRACK_ADDRESS_TYPE_TRACK = $01;
  IMAPI_READ_TRACK_ADDRESS_TYPE_SESSION = $02;

type
  _IMAPI_FEATURE_PAGE_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_FEATURE_PAGE_TYPE_PROFILE_LIST = $00;
  IMAPI_FEATURE_PAGE_TYPE_CORE = $01;
  IMAPI_FEATURE_PAGE_TYPE_MORPHING = $02;
  IMAPI_FEATURE_PAGE_TYPE_REMOVABLE_MEDIUM = $03;
  IMAPI_FEATURE_PAGE_TYPE_WRITE_PROTECT = $04;
  IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_READABLE = $10;
  IMAPI_FEATURE_PAGE_TYPE_CD_MULTIREAD = $1D;
  IMAPI_FEATURE_PAGE_TYPE_CD_READ = $1E;
  IMAPI_FEATURE_PAGE_TYPE_DVD_READ = $1F;
  IMAPI_FEATURE_PAGE_TYPE_RANDOMLY_WRITABLE = $20;
  IMAPI_FEATURE_PAGE_TYPE_INCREMENTAL_STREAMING_WRITABLE = $21;
  IMAPI_FEATURE_PAGE_TYPE_SECTOR_ERASABLE = $22;
  IMAPI_FEATURE_PAGE_TYPE_FORMATTABLE = $23;
  IMAPI_FEATURE_PAGE_TYPE_HARDWARE_DEFECT_MANAGEMENT = $24;
  IMAPI_FEATURE_PAGE_TYPE_WRITE_ONCE = $25;
  IMAPI_FEATURE_PAGE_TYPE_RESTRICTED_OVERWRITE = $26;
  IMAPI_FEATURE_PAGE_TYPE_CDRW_CAV_WRITE = $27;
  IMAPI_FEATURE_PAGE_TYPE_MRW = $28;
  IMAPI_FEATURE_PAGE_TYPE_ENHANCED_DEFECT_REPORTING = $29;
  IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_RW = $2A;
  IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R = $2B;
  IMAPI_FEATURE_PAGE_TYPE_RIGID_RESTRICTED_OVERWRITE = $2C;
  IMAPI_FEATURE_PAGE_TYPE_CD_TRACK_AT_ONCE = $2D;
  IMAPI_FEATURE_PAGE_TYPE_CD_MASTERING = $2E;
  IMAPI_FEATURE_PAGE_TYPE_DVD_DASH_WRITE = $2F;
  IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_READ = $30;
  IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_R_WRITE = $31;
  IMAPI_FEATURE_PAGE_TYPE_DOUBLE_DENSITY_CD_RW_WRITE = $32;
  IMAPI_FEATURE_PAGE_TYPE_LAYER_JUMP_RECORDING = $33;
  IMAPI_FEATURE_PAGE_TYPE_CD_RW_MEDIA_WRITE_SUPPORT = $37;
  IMAPI_FEATURE_PAGE_TYPE_BD_PSEUDO_OVERWRITE = $38;
  IMAPI_FEATURE_PAGE_TYPE_DVD_PLUS_R_DUAL_LAYER = $3B;
  IMAPI_FEATURE_PAGE_TYPE_BD_READ = $40;
  IMAPI_FEATURE_PAGE_TYPE_BD_WRITE = $41;
  IMAPI_FEATURE_PAGE_TYPE_HD_DVD_READ = $50;
  IMAPI_FEATURE_PAGE_TYPE_HD_DVD_WRITE = $51;
  IMAPI_FEATURE_PAGE_TYPE_POWER_MANAGEMENT = $0100;
  IMAPI_FEATURE_PAGE_TYPE_SMART = $0101;
  IMAPI_FEATURE_PAGE_TYPE_EMBEDDED_CHANGER = $0102;
  IMAPI_FEATURE_PAGE_TYPE_CD_ANALOG_PLAY = $0103;
  IMAPI_FEATURE_PAGE_TYPE_MICROCODE_UPDATE = $0104;
  IMAPI_FEATURE_PAGE_TYPE_TIMEOUT = $0105;
  IMAPI_FEATURE_PAGE_TYPE_DVD_CSS = $0106;
  IMAPI_FEATURE_PAGE_TYPE_REAL_TIME_STREAMING = $0107;
  IMAPI_FEATURE_PAGE_TYPE_LOGICAL_UNIT_SERIAL_NUMBER = $0108;
  IMAPI_FEATURE_PAGE_TYPE_MEDIA_SERIAL_NUMBER = $0109;
  IMAPI_FEATURE_PAGE_TYPE_DISC_CONTROL_BLOCKS = $010A;
  IMAPI_FEATURE_PAGE_TYPE_DVD_CPRM = $010B;
  IMAPI_FEATURE_PAGE_TYPE_FIRMWARE_INFORMATION = $010C;
  IMAPI_FEATURE_PAGE_TYPE_AACS = $010D;
  IMAPI_FEATURE_PAGE_TYPE_VCPS = $0110;

type
  _IMAPI_MODE_PAGE_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_MODE_PAGE_TYPE_READ_WRITE_ERROR_RECOVERY = $01;
  IMAPI_MODE_PAGE_TYPE_MRW = $03;
  IMAPI_MODE_PAGE_TYPE_WRITE_PARAMETERS = $05;
  IMAPI_MODE_PAGE_TYPE_CACHING = $08;
  IMAPI_MODE_PAGE_TYPE_INFORMATIONAL_EXCEPTIONS = $1C;
  IMAPI_MODE_PAGE_TYPE_TIMEOUT_AND_PROTECT = $1D;
  IMAPI_MODE_PAGE_TYPE_POWER_CONDITION = $1A;
  IMAPI_MODE_PAGE_TYPE_LEGACY_CAPABILITIES = $2A;

type
  _IMAPI_MODE_PAGE_REQUEST_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_MODE_PAGE_REQUEST_TYPE_CURRENT_VALUES = $00;
  IMAPI_MODE_PAGE_REQUEST_TYPE_CHANGEABLE_VALUES = $01;
  IMAPI_MODE_PAGE_REQUEST_TYPE_DEFAULT_VALUES = $02;
  IMAPI_MODE_PAGE_REQUEST_TYPE_SAVED_VALUES = $03;

type
  _IMAPI_PROFILE_TYPE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_PROFILE_TYPE_INVALID = $00;
  IMAPI_PROFILE_TYPE_NON_REMOVABLE_DISK = $01;
  IMAPI_PROFILE_TYPE_REMOVABLE_DISK = $02;
  IMAPI_PROFILE_TYPE_MO_ERASABLE = $03;
  IMAPI_PROFILE_TYPE_MO_WRITE_ONCE = $04;
  IMAPI_PROFILE_TYPE_AS_MO = $05;
  IMAPI_PROFILE_TYPE_CDROM = $08;
  IMAPI_PROFILE_TYPE_CD_RECORDABLE = $09;
  IMAPI_PROFILE_TYPE_CD_REWRITABLE = $0A;
  IMAPI_PROFILE_TYPE_DVDROM = $10;
  IMAPI_PROFILE_TYPE_DVD_DASH_RECORDABLE = $11;
  IMAPI_PROFILE_TYPE_DVD_RAM = $12;
  IMAPI_PROFILE_TYPE_DVD_DASH_REWRITABLE = $13;
  IMAPI_PROFILE_TYPE_DVD_DASH_RW_SEQUENTIAL = $14;
  IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_SEQUENTIAL = $15;
  IMAPI_PROFILE_TYPE_DVD_DASH_R_DUAL_LAYER_JUMP = $16;
  IMAPI_PROFILE_TYPE_DVD_PLUS_RW = $1A;
  IMAPI_PROFILE_TYPE_DVD_PLUS_R = $1B;
  IMAPI_PROFILE_TYPE_DDCDROM = $20;
  IMAPI_PROFILE_TYPE_DDCD_RECORDABLE = $21;
  IMAPI_PROFILE_TYPE_DDCD_REWRITABLE = $22;
  IMAPI_PROFILE_TYPE_DVD_PLUS_RW_DUAL = $2A;
  IMAPI_PROFILE_TYPE_DVD_PLUS_R_DUAL = $2B;
  IMAPI_PROFILE_TYPE_BD_ROM = $40;
  IMAPI_PROFILE_TYPE_BD_R_SEQUENTIAL = $41;
  IMAPI_PROFILE_TYPE_BD_R_RANDOM_RECORDING = $42;
  IMAPI_PROFILE_TYPE_BD_REWRITABLE = $43;
  IMAPI_PROFILE_TYPE_HD_DVD_ROM = $50;
  IMAPI_PROFILE_TYPE_HD_DVD_RECORDABLE = $51;
  IMAPI_PROFILE_TYPE_HD_DVD_RAM = $52;
  IMAPI_PROFILE_TYPE_NON_STANDARD = $FFFF;

type
  _IMAPI_FORMAT2_DATA_MEDIA_STATE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_FORMAT2_DATA_MEDIA_STATE_UNKNOWN = $00;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_INFORMATIONAL_MASK = $0F;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MASK = $FC00;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_OVERWRITE_ONLY = $01;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_RANDOMLY_WRITABLE = $01;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_BLANK = $02;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_APPENDABLE = $04;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_FINAL_SESSION = $08;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_DAMAGED = $0400;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_ERASE_REQUIRED = $0800;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_NON_EMPTY_SESSION = $1000;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_WRITE_PROTECTED = $2000;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_FINALIZED = $4000;
  IMAPI_FORMAT2_DATA_MEDIA_STATE_UNSUPPORTED_MEDIA = $8000;

type
  _IMAPI_MEDIA_WRITE_PROTECT_STATE = Vcl.OleCtrls.TOleEnum;

const
  IMAPI_WRITEPROTECTED_UNTIL_POWERDOWN = $01;
  IMAPI_WRITEPROTECTED_BY_CARTRIDGE = $02;
  IMAPI_WRITEPROTECTED_BY_MEDIA_SPECIFIC_REASON = $04;
  IMAPI_WRITEPROTECTED_BY_SOFTWARE_WRITE_PROTECT = $08;
  IMAPI_WRITEPROTECTED_BY_DISC_CONTROL_BLOCK = $10;
  IMAPI_WRITEPROTECTED_READ_ONLY_MEDIA = $4000;


type
  MsftStreamZero = interface;
  IDiscRecorder2Ex = interface;
  MsftDiscRecorder2 = interface;
  IRawCDImageTrackInfo = interface;

  IDiscFormat2 = interface (IDispatch)
   ['{27354152-8F64-5B0F-8F00-5D77AFBE261E}']
    function IsRecorderSupported(const Recorder: MsftDiscRecorder2):
      WordBool safecall;
    function IsCurrentMediaSupported(const Recorder: MsftDiscRecorder2):
      WordBool safecall;
    function Get_MediaPhysicallyBlank: WordBool safecall;
    function Get_MediaHeuristicallyBlank: WordBool safecall;
    function Get_SupportedMediaTypes: PSafeArray safecall;
    property MediaPhysicallyBlank:WordBool read Get_MediaPhysicallyBlank;
    property MediaHeuristicallyBlank:WordBool
      read Get_MediaHeuristicallyBlank;
    property SupportedMediaTypes:PSafeArray read Get_SupportedMediaTypes;
  end;

  MsftDiscMaster2 = interface (IDispatch)
   ['{27354130-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get__NewEnum: IEnumVARIANT safecall;
    function Get_Item(index: Integer): WideString safecall;
    function Get_Count: Integer safecall;
    function Get_IsSupportedEnvironment: WordBool safecall;
    property _NewEnum:IEnumVARIANT read Get__NewEnum;
    property Item[index: Integer]: WideString read Get_Item; default;
    property Count:Integer read Get_Count;
    property IsSupportedEnvironment:WordBool
      read Get_IsSupportedEnvironment;
  end;

  MsftDiscRecorder2 = interface (IDispatch) 
   ['{27354133-7F64-5B0F-8F00-5D77AFBE261E}']
    procedure EjectMedia safecall;
    procedure CloseTray safecall;
    procedure AcquireExclusiveAccess(force: WordBool;
      const __MIDL__IDiscRecorder20000: WideString) safecall;
    procedure ReleaseExclusiveAccess safecall;
    procedure DisableMcn safecall;
    procedure EnableMcn safecall;
    procedure InitializeDiscRecorder(const recorderUniqueId: WideString)
      safecall;
    function Get_ActiveDiscRecorder: WideString safecall;
    function Get_VendorId: WideString safecall;
    function Get_ProductId: WideString safecall;
    function Get_ProductRevision: WideString safecall;
    function Get_VolumeName: WideString safecall;
    function Get_VolumePathNames: PSafeArray safecall;
    function Get_DeviceCanLoadMedia: WordBool safecall;
    function Get_LegacyDeviceNumber: Integer safecall;
    function Get_SupportedFeaturePages: PSafeArray safecall;
    function Get_CurrentFeaturePages: PSafeArray safecall;
    function Get_SupportedProfiles: PSafeArray safecall;
    function Get_CurrentProfiles: PSafeArray safecall;
    function Get_SupportedModePages: PSafeArray safecall;
    function Get_ExclusiveAccessOwner: WideString safecall;
    property ActiveDiscRecorder:WideString read Get_ActiveDiscRecorder;
    property VendorId:WideString read Get_VendorId;
    property ProductId:WideString read Get_ProductId;
    property ProductRevision:WideString read Get_ProductRevision;
    property VolumeName:WideString read Get_VolumeName;
    property VolumePathNames:PSafeArray read Get_VolumePathNames;
    property DeviceCanLoadMedia:WordBool read Get_DeviceCanLoadMedia;
    property LegacyDeviceNumber:Integer read Get_LegacyDeviceNumber;
    property SupportedFeaturePages:PSafeArray
      read Get_SupportedFeaturePages;
    property CurrentFeaturePages:PSafeArray read Get_CurrentFeaturePages;
    property SupportedProfiles:PSafeArray read Get_SupportedProfiles;
    property CurrentProfiles:PSafeArray read Get_CurrentProfiles;
    property SupportedModePages:PSafeArray read Get_SupportedModePages;
    property ExclusiveAccessOwner:WideString read Get_ExclusiveAccessOwner;
  end;

  MsftWriteEngine2 = interface (IDispatch) 
   ['{27354135-7F64-5B0F-8F00-5D77AFBE261E}']
    procedure WriteSection(const data: MsftStreamZero;
      startingBlockAddress: Integer; numberOfBlocks: Integer) safecall;
    procedure CancelWrite safecall;
    procedure Set_Recorder(const value: IDiscRecorder2Ex) safecall;
    function Get_Recorder: IDiscRecorder2Ex safecall;
    procedure Set_UseStreamingWrite12(value: WordBool) safecall;
    function Get_UseStreamingWrite12: WordBool safecall;
    procedure Set_StartingSectorsPerSecond(value: Integer) safecall;
    function Get_StartingSectorsPerSecond: Integer safecall;
    procedure Set_EndingSectorsPerSecond(value: Integer) safecall;
    function Get_EndingSectorsPerSecond: Integer safecall;
    procedure Set_BytesPerSector(value: Integer) safecall;
    function Get_BytesPerSector: Integer safecall;
    function Get_WriteInProgress: WordBool safecall;
    property Recorder:IDiscRecorder2Ex read Get_Recorder
      write Set_Recorder;
    property UseStreamingWrite12:WordBool read Get_UseStreamingWrite12
      write Set_UseStreamingWrite12;
    property StartingSectorsPerSecond:Integer
      read Get_StartingSectorsPerSecond write Set_StartingSectorsPerSecond;
    property EndingSectorsPerSecond:Integer read Get_EndingSectorsPerSecond
      write Set_EndingSectorsPerSecond;
    property BytesPerSector:Integer read Get_BytesPerSector
      write Set_BytesPerSector;
    property WriteInProgress:WordBool read Get_WriteInProgress;
  end;

  MsftDiscFormat2Erase = interface (IDiscFormat2) 
   ['{27354156-8F64-5B0F-8F00-5D77AFBE261E}']
    procedure Set_Recorder(const value: MsftDiscRecorder2) safecall;
    function Get_Recorder: MsftDiscRecorder2 safecall;
    procedure Set_FullErase(value: WordBool) safecall;
    function Get_FullErase: WordBool safecall;
    function Get_CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum safecall;
    procedure Set_ClientName(const value: WideString) safecall;
    function Get_ClientName: WideString safecall;
    procedure EraseMedia safecall;
    property Recorder:MsftDiscRecorder2 read Get_Recorder
      write Set_Recorder;
    property FullErase:WordBool read Get_FullErase write Set_FullErase;
    property CurrentPhysicalMediaType:Vcl.OleCtrls.TOleEnum
      read Get_CurrentPhysicalMediaType;
    property ClientName:WideString read Get_ClientName
      write Set_ClientName;
  end;

  MsftDiscFormat2Data = interface (IDiscFormat2) 
   ['{27354153-9F64-5B0F-8F00-5D77AFBE261E}']
    procedure Set_Recorder(const value: MsftDiscRecorder2) safecall;
    function Get_Recorder: MsftDiscRecorder2 safecall;
    procedure Set_BufferUnderrunFreeDisabled(value: WordBool) safecall;
    function Get_BufferUnderrunFreeDisabled: WordBool safecall;
    procedure Set_PostgapAlreadyInImage(value: WordBool) safecall;
    function Get_PostgapAlreadyInImage: WordBool safecall;
    function Get_CurrentMediaStatus: Vcl.OleCtrls.TOleEnum safecall;
    function Get_WriteProtectStatus: Vcl.OleCtrls.TOleEnum safecall;
    function Get_TotalSectorsOnMedia: Integer safecall;
    function Get_FreeSectorsOnMedia: Integer safecall;
    function Get_NextWritableAddress: Integer safecall;
    function Get_StartAddressOfPreviousSession: Integer safecall;
    function Get_LastWrittenAddressOfPreviousSession: Integer safecall;
    procedure Set_ForceMediaToBeClosed(value: WordBool) safecall;
    function Get_ForceMediaToBeClosed: WordBool safecall;
    procedure Set_DisableConsumerDvdCompatibilityMode(value: WordBool)
      safecall;
    function Get_DisableConsumerDvdCompatibilityMode: WordBool safecall;
    function Get_CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum safecall;
    procedure Set_ClientName(const value: WideString) safecall;
    function Get_ClientName: WideString safecall;
    function Get_RequestedWriteSpeed: Integer safecall;
    function Get_RequestedRotationTypeIsPureCAV: WordBool safecall;
    function Get_CurrentWriteSpeed: Integer safecall;
    function Get_CurrentRotationTypeIsPureCAV: WordBool safecall;
    function Get_SupportedWriteSpeeds: PSafeArray safecall;
    function Get_SupportedWriteSpeedDescriptors: PSafeArray safecall;
    procedure Set_ForceOverwrite(value: WordBool) safecall;
    function Get_ForceOverwrite: WordBool safecall;
    function Get_MultisessionInterfaces: PSafeArray safecall;
    procedure Write(const data: MsftStreamZero) safecall;
    procedure CancelWrite safecall;
    procedure SetWriteSpeed(RequestedSectorsPerSecond: Integer;
      RotationTypeIsPureCAV: WordBool) safecall;
    property Recorder:MsftDiscRecorder2 read Get_Recorder
      write Set_Recorder;
    property BufferUnderrunFreeDisabled:WordBool
      read Get_BufferUnderrunFreeDisabled
      write Set_BufferUnderrunFreeDisabled;
    property PostgapAlreadyInImage:WordBool read Get_PostgapAlreadyInImage
      write Set_PostgapAlreadyInImage;
    property CurrentMediaStatus:Vcl.OleCtrls.TOleEnum
      read Get_CurrentMediaStatus;
    property WriteProtectStatus:Vcl.OleCtrls.TOleEnum
      read Get_WriteProtectStatus;
    property TotalSectorsOnMedia:Integer read Get_TotalSectorsOnMedia;
    property FreeSectorsOnMedia:Integer read Get_FreeSectorsOnMedia;
    property NextWritableAddress:Integer read Get_NextWritableAddress;
    property StartAddressOfPreviousSession:Integer
      read Get_StartAddressOfPreviousSession;
    property LastWrittenAddressOfPreviousSession:Integer
      read Get_LastWrittenAddressOfPreviousSession;
    property ForceMediaToBeClosed:WordBool read Get_ForceMediaToBeClosed
      write Set_ForceMediaToBeClosed;
    property DisableConsumerDvdCompatibilityMode:WordBool
      read Get_DisableConsumerDvdCompatibilityMode
      write Set_DisableConsumerDvdCompatibilityMode;
    property CurrentPhysicalMediaType:Vcl.OleCtrls.TOleEnum
      read Get_CurrentPhysicalMediaType;
    property ClientName:WideString read Get_ClientName
      write Set_ClientName;
    property RequestedWriteSpeed:Integer read Get_RequestedWriteSpeed;
    property RequestedRotationTypeIsPureCAV:WordBool
      read Get_RequestedRotationTypeIsPureCAV;
    property CurrentWriteSpeed:Integer read Get_CurrentWriteSpeed;
    property CurrentRotationTypeIsPureCAV:WordBool
      read Get_CurrentRotationTypeIsPureCAV;
    property SupportedWriteSpeeds:PSafeArray read Get_SupportedWriteSpeeds;
    property SupportedWriteSpeedDescriptors:PSafeArray
      read Get_SupportedWriteSpeedDescriptors;
    property ForceOverwrite:WordBool read Get_ForceOverwrite
      write Set_ForceOverwrite;
    property MultisessionInterfaces:PSafeArray
      read Get_MultisessionInterfaces;
  end;

  MsftDiscFormat2TrackAtOnce = interface (IDiscFormat2) 
   ['{27354154-8F64-5B0F-8F00-5D77AFBE261E}']
    procedure PrepareMedia safecall;
    procedure AddAudioTrack(const data: MsftStreamZero) safecall;
    procedure CancelAddTrack safecall;
    procedure ReleaseMedia safecall;
    procedure SetWriteSpeed(RequestedSectorsPerSecond: Integer;
      RotationTypeIsPureCAV: WordBool) safecall;
    procedure Set_Recorder(const value: MsftDiscRecorder2) safecall;
    function Get_Recorder: MsftDiscRecorder2 safecall;
    procedure Set_BufferUnderrunFreeDisabled(value: WordBool) safecall;
    function Get_BufferUnderrunFreeDisabled: WordBool safecall;
    function Get_NumberOfExistingTracks: Integer safecall;
    function Get_TotalSectorsOnMedia: Integer safecall;
    function Get_FreeSectorsOnMedia: Integer safecall;
    function Get_UsedSectorsOnMedia: Integer safecall;
    procedure Set_DoNotFinalizeMedia(value: WordBool) safecall;
    function Get_DoNotFinalizeMedia: WordBool safecall;
    function Get_ExpectedTableOfContents: PSafeArray safecall;
    function Get_CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum safecall;
    procedure Set_ClientName(const value: WideString) safecall;
    function Get_ClientName: WideString safecall;
    function Get_RequestedWriteSpeed: Integer safecall;
    function Get_RequestedRotationTypeIsPureCAV: WordBool safecall;
    function Get_CurrentWriteSpeed: Integer safecall;
    function Get_CurrentRotationTypeIsPureCAV: WordBool safecall;
    function Get_SupportedWriteSpeeds: PSafeArray safecall;
    function Get_SupportedWriteSpeedDescriptors: PSafeArray safecall;
    property Recorder:MsftDiscRecorder2 read Get_Recorder
      write Set_Recorder;
    property BufferUnderrunFreeDisabled:WordBool
      read Get_BufferUnderrunFreeDisabled
      write Set_BufferUnderrunFreeDisabled;
    property NumberOfExistingTracks:Integer
      read Get_NumberOfExistingTracks;
    property TotalSectorsOnMedia:Integer read Get_TotalSectorsOnMedia;
    property FreeSectorsOnMedia:Integer read Get_FreeSectorsOnMedia;
    property UsedSectorsOnMedia:Integer read Get_UsedSectorsOnMedia;
    property DoNotFinalizeMedia:WordBool read Get_DoNotFinalizeMedia
      write Set_DoNotFinalizeMedia;
    property ExpectedTableOfContents:PSafeArray
      read Get_ExpectedTableOfContents;
    property CurrentPhysicalMediaType:Vcl.OleCtrls.TOleEnum
      read Get_CurrentPhysicalMediaType;
    property ClientName:WideString read Get_ClientName
      write Set_ClientName;
    property RequestedWriteSpeed:Integer read Get_RequestedWriteSpeed;
    property RequestedRotationTypeIsPureCAV:WordBool
      read Get_RequestedRotationTypeIsPureCAV;
    property CurrentWriteSpeed:Integer read Get_CurrentWriteSpeed;
    property CurrentRotationTypeIsPureCAV:WordBool
      read Get_CurrentRotationTypeIsPureCAV;
    property SupportedWriteSpeeds:PSafeArray read Get_SupportedWriteSpeeds;
    property SupportedWriteSpeedDescriptors:PSafeArray
      read Get_SupportedWriteSpeedDescriptors;
  end;

  MsftDiscFormat2RawCD = interface (IDiscFormat2) 
   ['{27354155-8F64-5B0F-8F00-5D77AFBE261E}']
    procedure PrepareMedia safecall;
    procedure WriteMedia(const data: MsftStreamZero) safecall;
    procedure WriteMedia2(const data: MsftStreamZero;
      streamLeadInSectors: Integer) safecall;
    procedure CancelWrite safecall;
    procedure ReleaseMedia safecall;
    procedure SetWriteSpeed(RequestedSectorsPerSecond: Integer;
      RotationTypeIsPureCAV: WordBool) safecall;
    procedure Set_Recorder(const value: MsftDiscRecorder2) safecall;
    function Get_Recorder: MsftDiscRecorder2 safecall;
    procedure Set_BufferUnderrunFreeDisabled(value: WordBool) safecall;
    function Get_BufferUnderrunFreeDisabled: WordBool safecall;
    function Get_StartOfNextSession: Integer safecall;
    function Get_LastPossibleStartOfLeadout: Integer safecall;
    function Get_CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum safecall;
    function Get_SupportedSectorTypes: PSafeArray safecall;
    procedure Set_RequestedSectorType(value: Vcl.OleCtrls.TOleEnum)
      safecall;
    function Get_RequestedSectorType: Vcl.OleCtrls.TOleEnum safecall;
    procedure Set_ClientName(const value: WideString) safecall;
    function Get_ClientName: WideString safecall;
    function Get_RequestedWriteSpeed: Integer safecall;
    function Get_RequestedRotationTypeIsPureCAV: WordBool safecall;
    function Get_CurrentWriteSpeed: Integer safecall;
    function Get_CurrentRotationTypeIsPureCAV: WordBool safecall;
    function Get_SupportedWriteSpeeds: PSafeArray safecall;
    function Get_SupportedWriteSpeedDescriptors: PSafeArray safecall;
    property Recorder:MsftDiscRecorder2 read Get_Recorder
      write Set_Recorder;
    property BufferUnderrunFreeDisabled:WordBool
      read Get_BufferUnderrunFreeDisabled
      write Set_BufferUnderrunFreeDisabled;
    property StartOfNextSession:Integer read Get_StartOfNextSession;
    property LastPossibleStartOfLeadout:Integer
      read Get_LastPossibleStartOfLeadout;
    property CurrentPhysicalMediaType:Vcl.OleCtrls.TOleEnum
      read Get_CurrentPhysicalMediaType;
    property SupportedSectorTypes:PSafeArray read Get_SupportedSectorTypes;
    property RequestedSectorType:Vcl.OleCtrls.TOleEnum
      read Get_RequestedSectorType write Set_RequestedSectorType;
    property ClientName:WideString read Get_ClientName
      write Set_ClientName;
    property RequestedWriteSpeed:Integer read Get_RequestedWriteSpeed;
    property RequestedRotationTypeIsPureCAV:WordBool
      read Get_RequestedRotationTypeIsPureCAV;
    property CurrentWriteSpeed:Integer read Get_CurrentWriteSpeed;
    property CurrentRotationTypeIsPureCAV:WordBool
      read Get_CurrentRotationTypeIsPureCAV;
    property SupportedWriteSpeeds:PSafeArray read Get_SupportedWriteSpeeds;
    property SupportedWriteSpeedDescriptors:PSafeArray
      read Get_SupportedWriteSpeedDescriptors;
  end;

  MsftStreamZero = interface (ISequentialStream) 
   ['{0000000C-0000-0000-C000-000000000046}']
    function RemoteSeek(dlibMove: TGUID; dwOrigin: LongWord;
      var plibNewPosition: TGUID): HRESULT stdcall;
    function SetSize(libNewSize: TGUID): HRESULT stdcall;
    function RemoteCopyTo(const pstm: MsftStreamZero; cb: Int64;
      var pcbRead: Int64; var pcbWritten: Int64): HRESULT stdcall;
    function Commit(grfCommitFlags: LongWord): HRESULT stdcall;
    function Revert: HRESULT stdcall;
    function LockRegion(libOffset: TGUID; cb: TGUID; dwLockType: LongWord):
      HRESULT stdcall;
    function UnlockRegion(libOffset: TGUID; cb: TGUID;
      dwLockType: LongWord): HRESULT stdcall;
    function Stat(var pstatstg: TGUID; grfStatFlag: LongWord): HRESULT
      stdcall;
    function Clone(var ppstm: MsftStreamZero): HRESULT stdcall;
  end;

  MsftWriteSpeedDescriptor = interface (IDispatch)
   ['{27354144-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_MediaType: Vcl.OleCtrls.TOleEnum safecall;
    function Get_RotationTypeIsPureCAV: WordBool safecall;
    function Get_WriteSpeed: Integer safecall;
    property MediaType:Vcl.OleCtrls.TOleEnum read Get_MediaType;
    property RotationTypeIsPureCAV:WordBool read Get_RotationTypeIsPureCAV;
    property WriteSpeed:Integer read Get_WriteSpeed;
  end;

  IMultisession = interface (IDispatch)
   ['{27354150-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_IsSupportedOnCurrentMediaState: WordBool safecall;
    procedure Set_InUse(value: WordBool) safecall;
    function Get_InUse: WordBool safecall;
    function Get_ImportRecorder: MsftDiscRecorder2 safecall;
    property IsSupportedOnCurrentMediaState:WordBool
      read Get_IsSupportedOnCurrentMediaState;
    property InUse:WordBool read Get_InUse write Set_InUse;
    property ImportRecorder:MsftDiscRecorder2 read Get_ImportRecorder;
  end;

  IMultisessionSequential = interface (IMultisession)
   ['{27354151-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_IsFirstDataSession: WordBool safecall;
    function Get_StartAddressOfPreviousSession: Integer safecall;
    function Get_LastWrittenAddressOfPreviousSession: Integer safecall;
    function Get_NextWritableAddress: Integer safecall;
    function Get_FreeSectorsOnMedia: Integer safecall;
    property IsFirstDataSession:WordBool read Get_IsFirstDataSession;
    property StartAddressOfPreviousSession:Integer
      read Get_StartAddressOfPreviousSession;
    property LastWrittenAddressOfPreviousSession:Integer
      read Get_LastWrittenAddressOfPreviousSession;
    property NextWritableAddress:Integer read Get_NextWritableAddress;
    property FreeSectorsOnMedia:Integer read Get_FreeSectorsOnMedia;
  end;

  MsftMultisessionSequential = interface (IMultisessionSequential)
   ['{B507CA22-2204-11DD-966A-001AA01BBC58}']
    function Get_WriteUnitSize: Integer safecall;
    property WriteUnitSize:Integer read Get_WriteUnitSize;
  end;

  MsftMultisessionRandomWrite = interface (IMultisession) 
   ['{B507CA23-2204-11DD-966A-001AA01BBC58}']
    function Get_WriteUnitSize: Integer safecall;
    function Get_LastWrittenAddress: Integer safecall;
    function Get_TotalSectorsOnMedia: Integer safecall;
    property WriteUnitSize:Integer read Get_WriteUnitSize;
    property LastWrittenAddress:Integer read Get_LastWrittenAddress;
    property TotalSectorsOnMedia:Integer read Get_TotalSectorsOnMedia;
  end;

  MsftRawCDImageCreator = interface (IDispatch) 
   ['{25983550-9D65-49CE-B335-40630D901227}']
    function CreateResultImage: MsftStreamZero safecall;
    function AddTrack(dataType: Vcl.OleCtrls.TOleEnum;
      const data: MsftStreamZero): Integer safecall;
    procedure AddSpecialPregap(const data: MsftStreamZero) safecall;
    procedure AddSubcodeRWGenerator(const subcode: MsftStreamZero)
      safecall;
    procedure Set_ResultingImageType(value: Vcl.OleCtrls.TOleEnum)
      safecall;
    function Get_ResultingImageType: Vcl.OleCtrls.TOleEnum safecall;
    function Get_StartOfLeadout: Integer safecall;
    procedure Set_StartOfLeadoutLimit(value: Integer) safecall;
    function Get_StartOfLeadoutLimit: Integer safecall;
    procedure Set_DisableGaplessAudio(value: WordBool) safecall;
    function Get_DisableGaplessAudio: WordBool safecall;
    procedure Set_MediaCatalogNumber(const value: WideString) safecall;
    function Get_MediaCatalogNumber: WideString safecall;
    procedure Set_StartingTrackNumber(value: Integer) safecall;
    function Get_StartingTrackNumber: Integer safecall;
    function Get_TrackInfo(trackIndex: Integer): IRawCDImageTrackInfo
      safecall;
    function Get_NumberOfExistingTracks: Integer safecall;
    function Get_LastUsedUserSectorInImage: Integer safecall;
    function Get_ExpectedTableOfContents: PSafeArray safecall;
    property ResultingImageType:Vcl.OleCtrls.TOleEnum
      read Get_ResultingImageType write Set_ResultingImageType;
    property StartOfLeadout:Integer read Get_StartOfLeadout;
    property StartOfLeadoutLimit:Integer read Get_StartOfLeadoutLimit
      write Set_StartOfLeadoutLimit;
    property DisableGaplessAudio:WordBool read Get_DisableGaplessAudio
      write Set_DisableGaplessAudio;
    property MediaCatalogNumber:WideString read Get_MediaCatalogNumber
      write Set_MediaCatalogNumber;
    property StartingTrackNumber:Integer read Get_StartingTrackNumber
      write Set_StartingTrackNumber;
    property TrackInfo[trackIndex: Integer]: IRawCDImageTrackInfo
      read Get_TrackInfo;
    property NumberOfExistingTracks:Integer
      read Get_NumberOfExistingTracks;
    property LastUsedUserSectorInImage:Integer
      read Get_LastUsedUserSectorInImage;
    property ExpectedTableOfContents:PSafeArray
      read Get_ExpectedTableOfContents;
  end;

  PByte1 = ^Byte;

  PUserType1 = ^TGUID;

  PUserType2 = ^Vcl.OleCtrls.TOleEnum;

  PUserType3 = ^Vcl.OleCtrls.TOleEnum;

  PUserType4 = ^Vcl.OleCtrls.TOleEnum;

  PUINT1 = ^LongWord;

  PPUserType1 = ^MsftStreamZero;

  IMAPI_FORMAT2_DATA_WRITE_ACTION = Vcl.OleCtrls.TOleEnum;

  IMAPI_FORMAT2_TAO_WRITE_ACTION = Vcl.OleCtrls.TOleEnum;

  IMAPI_FORMAT2_RAW_CD_WRITE_ACTION = Vcl.OleCtrls.TOleEnum;

  IMAPI_MEDIA_PHYSICAL_TYPE = Vcl.OleCtrls.TOleEnum;

  _LARGE_INTEGER = record 
    QuadPart: Int64;
  end;

  _ULARGE_INTEGER = record 
    QuadPart: Largeuint;
  end;

  _FILETIME = record 
    dwLowDateTime: LongWord;
    dwHighDateTime: LongWord;
  end;

  tagSTATSTG = record 
    pwcsName: PWideChar;
    type_: LongWord;
    cbSize: TGUID;
    mtime: TGUID;
    ctime: TGUID;
    atime: TGUID;
    grfMode: LongWord;
    grfLocksSupported: LongWord;
    clsid: TGUID;
    grfStateBits: LongWord;
    reserved: LongWord;
  end;

  IMAPI_CD_SECTOR_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_FORMAT2_RAW_CD_DATA_SECTOR_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_CD_TRACK_DIGITAL_COPY_SETTING = Vcl.OleCtrls.TOleEnum;

  IMAPI_BURN_VERIFICATION_LEVEL = Vcl.OleCtrls.TOleEnum;

  tagCONNECTDATA = record 
    pUnk: IUnknown;
    dwCookie: LongWord;
  end;

  IMAPI_READ_TRACK_ADDRESS_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_FEATURE_PAGE_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_MODE_PAGE_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_MODE_PAGE_REQUEST_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_PROFILE_TYPE = Vcl.OleCtrls.TOleEnum;

  IMAPI_FORMAT2_DATA_MEDIA_STATE = Vcl.OleCtrls.TOleEnum;

  IMAPI_MEDIA_WRITE_PROTECT_STATE = Vcl.OleCtrls.TOleEnum;

  PrivateAlias1 = array[$0..$11] of Byte;

  MsftStreamPrng001 = interface (MsftStreamZero)
   ['{27354145-7F64-5B0F-8F00-5D77AFBE261E}']
    function put_Seed(value: LongWord): HRESULT stdcall;
    function get_Seed(var value: LongWord): HRESULT stdcall;
    function put_ExtendedSeed(var values: LongWord; eCount: LongWord):
      HRESULT stdcall;
    function get_ExtendedSeed(var values: PUINT1; var eCount: LongWord):
      HRESULT stdcall;
  end;

  MsftStreamConcatenate = interface (MsftStreamZero)
   ['{27354146-7F64-5B0F-8F00-5D77AFBE261E}']
    function Initialize(const stream1: MsftStreamZero;
      const stream2: MsftStreamZero): HRESULT stdcall;
    function Initialize2(var streams: MsftStreamZero;
      streamCount: LongWord): HRESULT stdcall;
    function Append(const stream: MsftStreamZero): HRESULT stdcall;
    function Append2(var streams: MsftStreamZero; streamCount: LongWord):
      HRESULT stdcall;
  end;

  MsftStreamInterleave = interface (MsftStreamZero)
   ['{27354147-7F64-5B0F-8F00-5D77AFBE261E}']
    function Initialize(var streams: MsftStreamZero;
      var interleaveSizes: LongWord; streamCount: LongWord): HRESULT
      stdcall;
  end;

  IWriteEngine2EventArgs = interface (IDispatch)
   ['{27354136-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_StartLba: Integer safecall;
    function Get_SectorCount: Integer safecall;
    function Get_LastReadLba: Integer safecall;
    function Get_LastWrittenLba: Integer safecall;
    function Get_TotalSystemBuffer: Integer safecall;
    function Get_UsedSystemBuffer: Integer safecall;
    function Get_FreeSystemBuffer: Integer safecall;
    property StartLba:Integer read Get_StartLba;
    property SectorCount:Integer read Get_SectorCount;
    property LastReadLba:Integer read Get_LastReadLba;
    property LastWrittenLba:Integer read Get_LastWrittenLba;
    property TotalSystemBuffer:Integer read Get_TotalSystemBuffer;
    property UsedSystemBuffer:Integer read Get_UsedSystemBuffer;
    property FreeSystemBuffer:Integer read Get_FreeSystemBuffer;
  end;

  IWriteEngine2EventArgsDisp = dispinterface  
   ['{27354136-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property StartLba: Integer readonly dispid $100;
    property SectorCount: Integer readonly dispid $101;
    property LastReadLba: Integer readonly dispid $102;
    property LastWrittenLba: Integer readonly dispid $103;
    property TotalSystemBuffer: Integer readonly dispid $106;
    property UsedSystemBuffer: Integer readonly dispid $107;
    property FreeSystemBuffer: Integer readonly dispid $108;
  end platform;

  IDiscFormat2DataEventArgs = interface (IWriteEngine2EventArgs) 
   ['{2735413D-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_ElapsedTime: Integer safecall;
    function Get_RemainingTime: Integer safecall;
    function Get_TotalTime: Integer safecall;
    function Get_CurrentAction: Vcl.OleCtrls.TOleEnum safecall;
    property ElapsedTime:Integer read Get_ElapsedTime;
    property RemainingTime:Integer read Get_RemainingTime;
    property TotalTime:Integer read Get_TotalTime;
    property CurrentAction:Vcl.OleCtrls.TOleEnum read Get_CurrentAction;
  end;

  IDiscFormat2DataEventArgsDisp = dispinterface  
   ['{2735413D-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property ElapsedTime: Integer readonly dispid $300;
    property RemainingTime: Integer readonly dispid $301;
    property TotalTime: Integer readonly dispid $302;
    property CurrentAction: Vcl.OleCtrls.TOleEnum readonly dispid $303;
    property StartLba: Integer readonly dispid $100;
    property SectorCount: Integer readonly dispid $101;
    property LastReadLba: Integer readonly dispid $102;
    property LastWrittenLba: Integer readonly dispid $103;
    property TotalSystemBuffer: Integer readonly dispid $106;
    property UsedSystemBuffer: Integer readonly dispid $107;
    property FreeSystemBuffer: Integer readonly dispid $108;
  end platform;

  IDiscFormat2TrackAtOnceEventArgs = interface (IWriteEngine2EventArgs) 
   ['{27354140-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_CurrentTrackNumber: Integer safecall;
    function Get_CurrentAction: Vcl.OleCtrls.TOleEnum safecall;
    function Get_ElapsedTime: Integer safecall;
    function Get_RemainingTime: Integer safecall;
    property CurrentTrackNumber:Integer read Get_CurrentTrackNumber;
    property CurrentAction:Vcl.OleCtrls.TOleEnum read Get_CurrentAction;
    property ElapsedTime:Integer read Get_ElapsedTime;
    property RemainingTime:Integer read Get_RemainingTime;
  end;

  IDiscFormat2TrackAtOnceEventArgsDisp = dispinterface  
   ['{27354140-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property CurrentTrackNumber: Integer readonly dispid $300;
    property CurrentAction: Vcl.OleCtrls.TOleEnum readonly dispid $301;
    property ElapsedTime: Integer readonly dispid $302;
    property RemainingTime: Integer readonly dispid $303;
    property StartLba: Integer readonly dispid $100;
    property SectorCount: Integer readonly dispid $101;
    property LastReadLba: Integer readonly dispid $102;
    property LastWrittenLba: Integer readonly dispid $103;
    property TotalSystemBuffer: Integer readonly dispid $106;
    property UsedSystemBuffer: Integer readonly dispid $107;
    property FreeSystemBuffer: Integer readonly dispid $108;
  end platform;

  IDiscFormat2RawCDEventArgs = interface (IWriteEngine2EventArgs) 
   ['{27354143-7F64-5B0F-8F00-5D77AFBE261E}']
    function Get_CurrentAction: Vcl.OleCtrls.TOleEnum safecall;
    function Get_ElapsedTime: Integer safecall;
    function Get_RemainingTime: Integer safecall;
    property CurrentAction:Vcl.OleCtrls.TOleEnum read Get_CurrentAction;
    property ElapsedTime:Integer read Get_ElapsedTime;
    property RemainingTime:Integer read Get_RemainingTime;
  end;

  IDiscFormat2RawCDEventArgsDisp = dispinterface  
   ['{27354143-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property CurrentAction: Vcl.OleCtrls.TOleEnum readonly dispid $301;
    property ElapsedTime: Integer readonly dispid $302;
    property RemainingTime: Integer readonly dispid $303;
    property StartLba: Integer readonly dispid $100;
    property SectorCount: Integer readonly dispid $101;
    property LastReadLba: Integer readonly dispid $102;
    property LastWrittenLba: Integer readonly dispid $103;
    property TotalSystemBuffer: Integer readonly dispid $106;
    property UsedSystemBuffer: Integer readonly dispid $107;
    property FreeSystemBuffer: Integer readonly dispid $108;
  end platform;

  IWriteSpeedDescriptor = MsftWriteSpeedDescriptor;

  IWriteSpeedDescriptorDisp = dispinterface  
   ['{27354144-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property MediaType: Vcl.OleCtrls.TOleEnum readonly dispid $101;
    property RotationTypeIsPureCAV: WordBool readonly dispid $102;
    property WriteSpeed: Integer readonly dispid $103;
  end platform;

  DDiscMaster2Events = interface (IDispatch) 
   ['{27354131-7F64-5B0F-8F00-5D77AFBE261E}']
    function NotifyDeviceAdded(const object_: IDispatch;
      const uniqueId: WideString): HRESULT stdcall;
    function NotifyDeviceRemoved(const object_: IDispatch;
      const uniqueId: WideString): HRESULT stdcall;
  end;

  DWriteEngine2Events = interface (IDispatch) 
   ['{27354137-7F64-5B0F-8F00-5D77AFBE261E}']
    function Update(const object_: IDispatch; const progress: IDispatch):
      HRESULT stdcall;
  end;

  DDiscFormat2EraseEvents = interface (IDispatch) 
   ['{2735413A-7F64-5B0F-8F00-5D77AFBE261E}']
    function Update(const object_: IDispatch; elapsedSeconds: Integer;
      estimatedTotalSeconds: Integer): HRESULT stdcall;
  end;

  DDiscFormat2DataEvents = interface (IDispatch) 
   ['{2735413C-7F64-5B0F-8F00-5D77AFBE261E}']
    function Update(const object_: IDispatch; const progress: IDispatch):
      HRESULT stdcall;
  end;

  DDiscFormat2TrackAtOnceEvents = interface (IDispatch) 
   ['{2735413F-7F64-5B0F-8F00-5D77AFBE261E}']
    function Update(const object_: IDispatch; const progress: IDispatch):
      HRESULT stdcall;
  end;

  DDiscFormat2RawCDEvents = interface (IDispatch) 
   ['{27354142-7F64-5B0F-8F00-5D77AFBE261E}']
    function Update(const object_: IDispatch; const progress: IDispatch):
      HRESULT stdcall;
  end;

  IRawCDImageCreator = MsftRawCDImageCreator;

  IRawCDImageCreatorDisp = dispinterface  
   ['{25983550-9D65-49CE-B335-40630D901227}']
  {published}
    function CreateResultImage: MsftStreamZero;
    function AddTrack(dataType: Vcl.OleCtrls.TOleEnum;
      const data: MsftStreamZero): Integer;
    procedure AddSpecialPregap(const data: MsftStreamZero);
    procedure AddSubcodeRWGenerator(const subcode: MsftStreamZero);
    property ResultingImageType: Vcl.OleCtrls.TOleEnum dispid $100;
    property StartOfLeadout: Integer readonly dispid $101;
    property StartOfLeadoutLimit: Integer dispid $102;
    property DisableGaplessAudio: WordBool dispid $103;
    property MediaCatalogNumber: WideString dispid $104;
    property StartingTrackNumber: Integer dispid $105;
    property TrackInfo: IRawCDImageTrackInfo readonly dispid $106;
    property NumberOfExistingTracks: Integer readonly dispid $107;
    property LastUsedUserSectorInImage: Integer readonly dispid $108;
    property ExpectedTableOfContents: OleVariant readonly dispid $109;
  end platform;

  ISequentialStream = interface (IUnknown) 
   ['{0C733A30-2A1C-11CE-ADE5-00AA0044773D}']
    function RemoteRead(var pv: Byte; cb: LongWord; var pcbRead: LongWord):
      HRESULT stdcall;
    function RemoteWrite(var pv: Byte; cb: LongWord;
      var pcbWritten: LongWord): HRESULT stdcall;
  end;

  IStream = MsftStreamZero;

  IRawCDImageTrackInfo = interface (IDispatch) 
   ['{25983551-9D65-49CE-B335-40630D901227}']
    function Get_StartingLba: Integer safecall;
    function Get_SectorCount: Integer safecall;
    function Get_TrackNumber: Integer safecall;
    function Get_SectorType: Vcl.OleCtrls.TOleEnum safecall;
    function Get_ISRC: WideString safecall;
    procedure Set_ISRC(const value: WideString) safecall;
    function Get_DigitalAudioCopySetting: Vcl.OleCtrls.TOleEnum safecall;
    procedure Set_DigitalAudioCopySetting(value: Vcl.OleCtrls.TOleEnum)
      safecall;
    function Get_AudioHasPreemphasis: WordBool safecall;
    procedure Set_AudioHasPreemphasis(value: WordBool) safecall;
    function Get_TrackIndexes: PSafeArray safecall;
    procedure AddTrackIndex(lbaOffset: Integer) safecall;
    procedure ClearTrackIndex(lbaOffset: Integer) safecall;
    property StartingLba:Integer read Get_StartingLba;
    property SectorCount:Integer read Get_SectorCount;
    property TrackNumber:Integer read Get_TrackNumber;
    property SectorType:Vcl.OleCtrls.TOleEnum read Get_SectorType;
    property ISRC:WideString read Get_ISRC write Set_ISRC;
    property DigitalAudioCopySetting:Vcl.OleCtrls.TOleEnum
      read Get_DigitalAudioCopySetting write Set_DigitalAudioCopySetting;
    property AudioHasPreemphasis:WordBool read Get_AudioHasPreemphasis
      write Set_AudioHasPreemphasis;
    property TrackIndexes:PSafeArray read Get_TrackIndexes;
  end;

  IRawCDImageTrackInfoDisp = dispinterface  
   ['{25983551-9D65-49CE-B335-40630D901227}']
  {published}
    property StartingLba: Integer readonly dispid $100;
    property SectorCount: Integer readonly dispid $101;
    property TrackNumber: Integer readonly dispid $102;
    property SectorType: Vcl.OleCtrls.TOleEnum readonly dispid $103;
    property ISRC: WideString dispid $104;
    property DigitalAudioCopySetting: Vcl.OleCtrls.TOleEnum dispid $105;
    property AudioHasPreemphasis: WordBool dispid $106;
    property TrackIndexes: OleVariant readonly dispid $107;
    procedure AddTrackIndex(lbaOffset: Integer);
    procedure ClearTrackIndex(lbaOffset: Integer);
  end platform;

  IBurnVerification = interface (IUnknown) 
   ['{D2FFD834-958B-426D-8470-2A13879C6A91}']
    function Set_BurnVerificationLevel(value: Vcl.OleCtrls.TOleEnum):
      HRESULT stdcall;
    function Get_BurnVerificationLevel(var value: Vcl.OleCtrls.TOleEnum):
      HRESULT stdcall;
  end;

  IBlockRange = interface (IDispatch) 
   ['{B507CA25-2204-11DD-966A-001AA01BBC58}']
    function Get_StartLba: Integer safecall;
    function Get_EndLba: Integer safecall;
    property StartLba:Integer read Get_StartLba;
    property EndLba:Integer read Get_EndLba;
  end;

  IBlockRangeDisp = dispinterface  
   ['{B507CA25-2204-11DD-966A-001AA01BBC58}']
  {published}
    property StartLba: Integer readonly dispid $100;
    property EndLba: Integer readonly dispid $101;
  end platform;

  IBlockRangeList = interface (IDispatch) 
   ['{B507CA26-2204-11DD-966A-001AA01BBC58}']
    function Get_BlockRanges: PSafeArray safecall;
    property BlockRanges:PSafeArray read Get_BlockRanges;
  end;

  IBlockRangeListDisp = dispinterface  
   ['{B507CA26-2204-11DD-966A-001AA01BBC58}']
  {published}
    property BlockRanges: OleVariant readonly dispid $100;
  end platform;

  IDiscMaster2 = MsftDiscMaster2;

  IDiscMaster2Disp = dispinterface  
   ['{27354130-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property _NewEnum: IEnumVARIANT readonly dispid $FFFFFFFC;
    property Item: WideString readonly dispid $0;
    property Count: Integer readonly dispid $1;
    property IsSupportedEnvironment: WordBool readonly dispid $2;
  end platform;

  IConnectionPointContainer = interface (IUnknown) 
   ['{B196B284-BAB4-101A-B69C-00AA00341D07}']
    function EnumConnectionPoints(var ppEnum: IEnumConnectionPoints):
      HRESULT stdcall;
    function FindConnectionPoint(var riid: TGUID;
      var ppCP: IConnectionPoint): HRESULT stdcall;
  end;

  IEnumConnectionPoints = interface (IUnknown) 
   ['{B196B285-BAB4-101A-B69C-00AA00341D07}']
    function RemoteNext(cConnections: LongWord; var ppCP: IConnectionPoint;
      var pcFetched: LongWord): HRESULT stdcall;
    function Skip(cConnections: LongWord): HRESULT stdcall;
    function Reset: HRESULT stdcall;
    function Clone(var ppEnum: IEnumConnectionPoints): HRESULT stdcall;
  end;

  IConnectionPoint = interface (IUnknown) 
   ['{B196B286-BAB4-101A-B69C-00AA00341D07}']
    function GetConnectionInterface(var pIID: TGUID): HRESULT stdcall;
    function GetConnectionPointContainer(var ppCPC: IConnectionPointContainer):
      HRESULT stdcall;
    function Advise(const pUnkSink: IUnknown; var pdwCookie: LongWord):
      HRESULT stdcall;
    function Unadvise(dwCookie: LongWord): HRESULT stdcall;
    function EnumConnections(var ppEnum: IEnumConnections): HRESULT
      stdcall;
  end;

  IEnumConnections = interface (IUnknown) 
   ['{B196B287-BAB4-101A-B69C-00AA00341D07}']
    function RemoteNext(cConnections: LongWord; var rgcd: TGUID;
      var pcFetched: LongWord): HRESULT stdcall;
    function Skip(cConnections: LongWord): HRESULT stdcall;
    function Reset: HRESULT stdcall;
    function Clone(var ppEnum: IEnumConnections): HRESULT stdcall;
  end;

  IDiscRecorder2 = MsftDiscRecorder2;

  IDiscRecorder2Disp = dispinterface  
   ['{27354133-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    procedure EjectMedia;
    procedure CloseTray;
    procedure AcquireExclusiveAccess(force: WordBool;
      const __MIDL__IDiscRecorder20000: WideString);
    procedure ReleaseExclusiveAccess;
    procedure DisableMcn;
    procedure EnableMcn;
    procedure InitializeDiscRecorder(const recorderUniqueId: WideString);
    property ActiveDiscRecorder: WideString readonly dispid $0;
    property VendorId: WideString readonly dispid $201;
    property ProductId: WideString readonly dispid $202;
    property ProductRevision: WideString readonly dispid $203;
    property VolumeName: WideString readonly dispid $204;
    property VolumePathNames: OleVariant readonly dispid $205;
    property DeviceCanLoadMedia: WordBool readonly dispid $206;
    property LegacyDeviceNumber: Integer readonly dispid $207;
    property SupportedFeaturePages: OleVariant readonly dispid $208;
    property CurrentFeaturePages: OleVariant readonly dispid $209;
    property SupportedProfiles: OleVariant readonly dispid $20A;
    property CurrentProfiles: OleVariant readonly dispid $20B;
    property SupportedModePages: OleVariant readonly dispid $20C;
    property ExclusiveAccessOwner: WideString readonly dispid $20D;
  end platform;

  IDiscRecorder2Ex = interface (IUnknown) 
   ['{27354132-7F64-5B0F-8F00-5D77AFBE261E}']
    function SendCommandNoData(var Cdb: Byte; CdbSize: LongWord;
      SenseBuffer: PrivateAlias1; Timeout: LongWord): HRESULT stdcall;
    function SendCommandSendDataToDevice(var Cdb: Byte; CdbSize: LongWord;
      SenseBuffer: PrivateAlias1; Timeout: LongWord; var Buffer: Byte;
      BufferSize: LongWord): HRESULT stdcall;
    function SendCommandGetDataFromDevice(var Cdb: Byte; CdbSize: LongWord;
      SenseBuffer: PrivateAlias1; Timeout: LongWord; var Buffer: Byte;
      BufferSize: LongWord; var BufferFetched: LongWord): HRESULT stdcall;
    function ReadDvdStructure(format: LongWord; address: LongWord;
      layer: LongWord; agid: LongWord; var data: PByte1;
      var Count: LongWord): HRESULT stdcall;
    function SendDvdStructure(format: LongWord; var data: Byte;
      Count: LongWord): HRESULT stdcall;
    function GetAdapterDescriptor(var data: PByte1;
      var byteSize: LongWord): HRESULT stdcall;
    function GetDeviceDescriptor(var data: PByte1; var byteSize: LongWord):
      HRESULT stdcall;
    function GetDiscInformation(var discInformation: PByte1;
      var byteSize: LongWord): HRESULT stdcall;
    function GetTrackInformation(address: LongWord;
      addressType: Vcl.OleCtrls.TOleEnum; var trackInformation: PByte1;
      var byteSize: LongWord): HRESULT stdcall;
    function GetFeaturePage(requestedFeature: Vcl.OleCtrls.TOleEnum;
      currentFeatureOnly: ShortInt; var featureData: PByte1;
      var byteSize: LongWord): HRESULT stdcall;
    function GetModePage(requestedModePage: Vcl.OleCtrls.TOleEnum;
      requestType: Vcl.OleCtrls.TOleEnum; var modePageData: PByte1;
      var byteSize: LongWord): HRESULT stdcall;
    function SetModePage(requestType: Vcl.OleCtrls.TOleEnum;
      var data: Byte; byteSize: LongWord): HRESULT stdcall;
    function GetSupportedFeaturePages(currentFeatureOnly: ShortInt;
      var featureData: PUserType2; var byteSize: LongWord): HRESULT
      stdcall;
    function GetSupportedProfiles(currentOnly: ShortInt;
      var profileTypes: PUserType3; var validProfiles: LongWord): HRESULT
      stdcall;
    function GetSupportedModePages(requestType: Vcl.OleCtrls.TOleEnum;
      var modePageTypes: PUserType4; var validPages: LongWord): HRESULT
      stdcall;
    function GetByteAlignmentMask(var value: LongWord): HRESULT stdcall;
    function GetMaximumNonPageAlignedTransferSize(var value: LongWord):
      HRESULT stdcall;
    function GetMaximumPageAlignedTransferSize(var value: LongWord):
      HRESULT stdcall;
  end;

  IWriteEngine2 = MsftWriteEngine2;

  IWriteEngine2Disp = dispinterface  
   ['{27354135-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    procedure WriteSection(const data: MsftStreamZero;
      startingBlockAddress: Integer; numberOfBlocks: Integer);
    procedure CancelWrite;
    property Recorder: IDiscRecorder2Ex dispid $100;
    property UseStreamingWrite12: WordBool dispid $101;
    property StartingSectorsPerSecond: Integer dispid $102;
    property EndingSectorsPerSecond: Integer dispid $103;
    property BytesPerSector: Integer dispid $104;
    property WriteInProgress: WordBool readonly dispid $105;
  end platform;

  IDiscFormat2Disp = dispinterface
   ['{27354152-8F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    function IsRecorderSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    function IsCurrentMediaSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    property MediaPhysicallyBlank: WordBool readonly dispid $700;
    property MediaHeuristicallyBlank: WordBool readonly dispid $701;
    property SupportedMediaTypes: OleVariant readonly dispid $702;
  end platform;

  IDiscFormat2Erase = MsftDiscFormat2Erase;

  IDiscFormat2EraseDisp = dispinterface  
   ['{27354156-8F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property Recorder: MsftDiscRecorder2 dispid $100;
    property FullErase: WordBool dispid $101;
    property CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum readonly
      dispid $102;
    property ClientName: WideString dispid $103;
    procedure EraseMedia;
    function IsRecorderSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    function IsCurrentMediaSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    property MediaPhysicallyBlank: WordBool readonly dispid $700;
    property MediaHeuristicallyBlank: WordBool readonly dispid $701;
    property SupportedMediaTypes: OleVariant readonly dispid $702;
  end platform;

  IDiscFormat2Data = MsftDiscFormat2Data;

  IDiscFormat2DataDisp = dispinterface  
   ['{27354153-9F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property Recorder: MsftDiscRecorder2 dispid $100;
    property BufferUnderrunFreeDisabled: WordBool dispid $101;
    property PostgapAlreadyInImage: WordBool dispid $104;
    property CurrentMediaStatus: Vcl.OleCtrls.TOleEnum readonly
      dispid $106;
    property WriteProtectStatus: Vcl.OleCtrls.TOleEnum readonly
      dispid $107;
    property TotalSectorsOnMedia: Integer readonly dispid $108;
    property FreeSectorsOnMedia: Integer readonly dispid $109;
    property NextWritableAddress: Integer readonly dispid $10A;
    property StartAddressOfPreviousSession: Integer readonly dispid $10B;
    property LastWrittenAddressOfPreviousSession: Integer readonly
      dispid $10C;
    property ForceMediaToBeClosed: WordBool dispid $10D;
    property DisableConsumerDvdCompatibilityMode: WordBool dispid $10E;
    property CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum readonly
      dispid $10F;
    property ClientName: WideString dispid $110;
    property RequestedWriteSpeed: Integer readonly dispid $111;
    property RequestedRotationTypeIsPureCAV: WordBool readonly dispid $112;
    property CurrentWriteSpeed: Integer readonly dispid $113;
    property CurrentRotationTypeIsPureCAV: WordBool readonly dispid $114;
    property SupportedWriteSpeeds: OleVariant readonly dispid $115;
    property SupportedWriteSpeedDescriptors: OleVariant readonly
      dispid $116;
    property ForceOverwrite: WordBool dispid $117;
    property MultisessionInterfaces: OleVariant readonly dispid $118;
    procedure Write(const data: MsftStreamZero);
    procedure CancelWrite;
    procedure SetWriteSpeed(RequestedSectorsPerSecond: Integer;
      RotationTypeIsPureCAV: WordBool);
    function IsRecorderSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    function IsCurrentMediaSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    property MediaPhysicallyBlank: WordBool readonly dispid $700;
    property MediaHeuristicallyBlank: WordBool readonly dispid $701;
    property SupportedMediaTypes: OleVariant readonly dispid $702;
  end platform;

  IDiscFormat2TrackAtOnce = MsftDiscFormat2TrackAtOnce;

  IDiscFormat2TrackAtOnceDisp = dispinterface  
   ['{27354154-8F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    procedure PrepareMedia;
    procedure AddAudioTrack(const data: MsftStreamZero);
    procedure CancelAddTrack;
    procedure ReleaseMedia;
    procedure SetWriteSpeed(RequestedSectorsPerSecond: Integer;
      RotationTypeIsPureCAV: WordBool);
    property Recorder: MsftDiscRecorder2 dispid $100;
    property BufferUnderrunFreeDisabled: WordBool dispid $102;
    property NumberOfExistingTracks: Integer readonly dispid $103;
    property TotalSectorsOnMedia: Integer readonly dispid $104;
    property FreeSectorsOnMedia: Integer readonly dispid $105;
    property UsedSectorsOnMedia: Integer readonly dispid $106;
    property DoNotFinalizeMedia: WordBool dispid $107;
    property ExpectedTableOfContents: OleVariant readonly dispid $10A;
    property CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum readonly
      dispid $10B;
    property ClientName: WideString dispid $10E;
    property RequestedWriteSpeed: Integer readonly dispid $10F;
    property RequestedRotationTypeIsPureCAV: WordBool readonly dispid $110;
    property CurrentWriteSpeed: Integer readonly dispid $111;
    property CurrentRotationTypeIsPureCAV: WordBool readonly dispid $112;
    property SupportedWriteSpeeds: OleVariant readonly dispid $113;
    property SupportedWriteSpeedDescriptors: OleVariant readonly
      dispid $114;
    function IsRecorderSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    function IsCurrentMediaSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    property MediaPhysicallyBlank: WordBool readonly dispid $700;
    property MediaHeuristicallyBlank: WordBool readonly dispid $701;
    property SupportedMediaTypes: OleVariant readonly dispid $702;
  end platform;

  IDiscFormat2RawCD = MsftDiscFormat2RawCD;

  IDiscFormat2RawCDDisp = dispinterface  
   ['{27354155-8F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    procedure PrepareMedia;
    procedure WriteMedia(const data: MsftStreamZero);
    procedure WriteMedia2(const data: MsftStreamZero;
      streamLeadInSectors: Integer);
    procedure CancelWrite;
    procedure ReleaseMedia;
    procedure SetWriteSpeed(RequestedSectorsPerSecond: Integer;
      RotationTypeIsPureCAV: WordBool);
    property Recorder: MsftDiscRecorder2 dispid $100;
    property BufferUnderrunFreeDisabled: WordBool dispid $102;
    property StartOfNextSession: Integer readonly dispid $103;
    property LastPossibleStartOfLeadout: Integer readonly dispid $104;
    property CurrentPhysicalMediaType: Vcl.OleCtrls.TOleEnum readonly
      dispid $105;
    property SupportedSectorTypes: OleVariant readonly dispid $108;
    property RequestedSectorType: Vcl.OleCtrls.TOleEnum dispid $109;
    property ClientName: WideString dispid $10A;
    property RequestedWriteSpeed: Integer readonly dispid $10B;
    property RequestedRotationTypeIsPureCAV: WordBool readonly dispid $10C;
    property CurrentWriteSpeed: Integer readonly dispid $10D;
    property CurrentRotationTypeIsPureCAV: WordBool readonly dispid $10E;
    property SupportedWriteSpeeds: OleVariant readonly dispid $10F;
    property SupportedWriteSpeedDescriptors: OleVariant readonly
      dispid $110;
    function IsRecorderSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    function IsCurrentMediaSupported(const Recorder: MsftDiscRecorder2):
      WordBool;
    property MediaPhysicallyBlank: WordBool readonly dispid $700;
    property MediaHeuristicallyBlank: WordBool readonly dispid $701;
    property SupportedMediaTypes: OleVariant readonly dispid $702;
  end platform;

  IStreamPseudoRandomBased = MsftStreamPrng001;

  IStreamConcatenate = MsftStreamConcatenate;

  IStreamInterleave = MsftStreamInterleave;

  IMultisessionDisp = dispinterface
   ['{27354150-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property IsSupportedOnCurrentMediaState: WordBool readonly dispid $100;
    property InUse: WordBool dispid $101;
    property ImportRecorder: MsftDiscRecorder2 readonly dispid $102;
  end platform;

  IMultisessionSequentialDisp = dispinterface
   ['{27354151-7F64-5B0F-8F00-5D77AFBE261E}']
  {published}
    property IsFirstDataSession: WordBool readonly dispid $200;
    property StartAddressOfPreviousSession: Integer readonly dispid $201;
    property LastWrittenAddressOfPreviousSession: Integer readonly
      dispid $202;
    property NextWritableAddress: Integer readonly dispid $203;
    property FreeSectorsOnMedia: Integer readonly dispid $204;
    property IsSupportedOnCurrentMediaState: WordBool readonly dispid $100;
    property InUse: WordBool dispid $101;
    property ImportRecorder: MsftDiscRecorder2 readonly dispid $102;
  end platform;

  IMultisessionSequential2 = MsftMultisessionSequential;

  IMultisessionSequential2Disp = dispinterface  
   ['{B507CA22-2204-11DD-966A-001AA01BBC58}']
  {published}
    property WriteUnitSize: Integer readonly dispid $205;
    property IsFirstDataSession: WordBool readonly dispid $200;
    property StartAddressOfPreviousSession: Integer readonly dispid $201;
    property LastWrittenAddressOfPreviousSession: Integer readonly
      dispid $202;
    property NextWritableAddress: Integer readonly dispid $203;
    property FreeSectorsOnMedia: Integer readonly dispid $204;
    property IsSupportedOnCurrentMediaState: WordBool readonly dispid $100;
    property InUse: WordBool dispid $101;
    property ImportRecorder: MsftDiscRecorder2 readonly dispid $102;
  end platform;

  IMultisessionRandomWrite = MsftMultisessionRandomWrite;

  IMultisessionRandomWriteDisp = dispinterface  
   ['{B507CA23-2204-11DD-966A-001AA01BBC58}']
  {published}
    property WriteUnitSize: Integer readonly dispid $205;
    property LastWrittenAddress: Integer readonly dispid $206;
    property TotalSectorsOnMedia: Integer readonly dispid $207;
    property IsSupportedOnCurrentMediaState: WordBool readonly dispid $100;
    property InUse: WordBool dispid $101;
    property ImportRecorder: MsftDiscRecorder2 readonly dispid $102;
  end platform;

implementation

end.


