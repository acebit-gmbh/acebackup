unit intTask;

interface

uses
  Winapi.Windows,
  Winapi.ActiveX,
  System.Classes,
  Vcl.Graphics,
  Vcl.OleServer,
  System.Variants,
  System.Win.StdVCL;

const
  LIBID_TaskScheduler: TGUID = '{E34CB9F1-C7F7-424C-BE29-027DCC09363A}';

  IID_ITaskFolderCollection: TGUID = '{79184A66-8664-423F-97F1-637356A5D812}';
  IID_ITaskFolder: TGUID = '{8CFAC062-A080-4C15-9A88-AA7C2AF80DFC}';
  IID_IRegisteredTask: TGUID = '{9C86F320-DEE3-4DD1-B972-A303F26B061E}';
  IID_IRunningTask: TGUID = '{653758FB-7B9A-4F1E-A471-BEEB8E9B834E}';
  IID_IRunningTaskCollection: TGUID = '{6A67614B-6828-4FEC-AA54-6D52E8F1F2DB}';
  IID_ITaskDefinition: TGUID = '{F5BC8FC5-536D-4F77-B852-FBC1356FDEB6}';
  IID_IRegistrationInfo: TGUID = '{416D8B73-CB41-4EA1-805C-9BE9A5AC4A74}';
  IID_ITriggerCollection: TGUID = '{85DF5081-1B24-4F32-878A-D9D14DF4CB77}';
  IID_ITrigger: TGUID = '{09941815-EA89-4B5B-89E0-2A773801FAC3}';
  IID_IRepetitionPattern: TGUID = '{7FB9ACF1-26BE-400E-85B5-294B9C75DFD6}';
  IID_ITaskSettings: TGUID = '{8FD4711D-2D02-4C8C-87E3-EFF699DE127E}';
  IID_IIdleSettings: TGUID = '{84594461-0053-4342-A8FD-088FABF11F32}';
  IID_INetworkSettings: TGUID = '{9F7DEA84-C30B-4245-80B6-00E9F646F1B4}';
  IID_IPrincipal: TGUID = '{D98D51E5-C9B4-496A-A9C1-18980261CF0F}';
  IID_IActionCollection: TGUID = '{02820E19-7B98-4ED2-B2E8-FDCCCEFF619B}';
  IID_IAction: TGUID = '{BAE54997-48B1-4CBE-9965-D6BE263EBEA4}';
  IID_IRegisteredTaskCollection: TGUID = '{86627EB4-42A7-41E4-A4D9-AC33A72F2D52}';
  IID_ITaskService: TGUID = '{2FABA4C7-4DA9-4013-9697-20CC3FD40F85}';
  IID_ITaskHandler: TGUID = '{839D7762-5121-4009-9234-4F0D19394F04}';
  IID_ITaskHandlerStatus: TGUID = '{EAEC7A8F-27A0-4DDC-8675-14726A01A38A}';
  IID_ITaskVariables: TGUID = '{3E4C9351-D966-4B8B-BB87-CEBA68BB0107}';
  IID_ITaskNamedValuePair: TGUID = '{39038068-2B46-4AFD-8662-7BB6F868D221}';
  IID_ITaskNamedValueCollection: TGUID = '{B4EF826B-63C3-46E4-A504-EF69E4F7EA4D}';
  IID_IIdleTrigger: TGUID = '{D537D2B0-9FB3-4D34-9739-1FF5CE7B1EF3}';
  IID_ILogonTrigger: TGUID = '{72DADE38-FAE4-4B3E-BAF4-5D009AF02B1C}';
  IID_ISessionStateChangeTrigger: TGUID = '{754DA71B-4385-4475-9DD9-598294FA3641}';
  IID_IEventTrigger: TGUID = '{D45B0167-9653-4EEF-B94F-0732CA7AF251}';
  IID_ITimeTrigger: TGUID = '{B45747E0-EBA7-4276-9F29-85C5BB300006}';
  IID_IDailyTrigger: TGUID = '{126C5CD8-B288-41D5-8DBF-E491446ADC5C}';
  IID_IWeeklyTrigger: TGUID = '{5038FC98-82FF-436D-8728-A512A57C9DC1}';
  IID_IMonthlyTrigger: TGUID = '{97C45EF1-6B02-4A1A-9C0E-1EBFBA1500AC}';
  IID_IMonthlyDOWTrigger: TGUID = '{77D025A3-90FA-43AA-B52E-CDA5499B946A}';
  IID_IBootTrigger: TGUID = '{2A9C35DA-D357-41F4-BBC1-207AC1B1F3CB}';
  IID_IRegistrationTrigger: TGUID = '{4C8FEC3A-C218-4E0C-B23D-629024DB91A2}';
  IID_IExecAction: TGUID = '{4C3D624D-FD6B-49A3-B9B7-09CB3CD3F047}';
  IID_IShowMessageAction: TGUID = '{505E9E68-AF89-46B8-A30F-56162A83D537}';
  IID_IComHandlerAction: TGUID = '{6D2FD252-75C5-4F66-90BA-2A7D8CC3039F}';
  IID_IEmailAction: TGUID = '{10F62C64-7E16-4314-A0C2-0C3683F99D40}';
  CLASS_TaskScheduler_: TGUID = '{0F87369F-A4E5-4CFC-BD3E-73E6154572DD}';
  CLASS_TaskHandlerPS: TGUID = '{F2A69DB7-DA2C-4352-9066-86FEE6DACAC9}';
  CLASS_TaskHandlerStatusPS: TGUID = '{9F15266D-D7BA-48F0-93C1-E6895F6FE5AC}';

type
  _TASK_STATE = TOleEnum;

const
  TASK_STATE_UNKNOWN = $00;
  TASK_STATE_DISABLED = $01;
  TASK_STATE_QUEUED = $02;
  TASK_STATE_READY = $03;
  TASK_STATE_RUNNING = $04;

type
  _TASK_TRIGGER_TYPE2 = TOleEnum;

const
  TASK_TRIGGER_EVENT = $00;
  TASK_TRIGGER_TIME = $01;
  TASK_TRIGGER_DAILY = $02;
  TASK_TRIGGER_WEEKLY = $03;
  TASK_TRIGGER_MONTHLY = $04;
  TASK_TRIGGER_MONTHLYDOW = $05;
  TASK_TRIGGER_IDLE = $06;
  TASK_TRIGGER_REGISTRATION = $07;
  TASK_TRIGGER_BOOT = $08;
  TASK_TRIGGER_LOGON = $09;
  TASK_TRIGGER_SESSION_STATE_CHANGE = $0B;

type
  _TASK_INSTANCES_POLICY = TOleEnum;

const
  TASK_INSTANCES_PARALLEL = $00;
  TASK_INSTANCES_QUEUE = $01;
  TASK_INSTANCES_IGNORE_NEW = $02;
  TASK_INSTANCES_STOP_EXISTING = $03;

type
  _TASK_COMPATIBILITY = TOleEnum;

const
  TASK_COMPATIBILITY_AT = $00;
  TASK_COMPATIBILITY_V1 = $01;
  TASK_COMPATIBILITY_V2 = $02;

type
  _TASK_LOGON_TYPE = TOleEnum;

const
  TASK_LOGON_NONE = $00;
  TASK_LOGON_PASSWORD = $01;
  TASK_LOGON_S4U = $02;
  TASK_LOGON_INTERACTIVE_TOKEN = $03;
  TASK_LOGON_GROUP = $04;
  TASK_LOGON_SERVICE_ACCOUNT = $05;
  TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD = $06;

type
  _TASK_RUNLEVEL = TOleEnum;

const
  TASK_RUNLEVEL_LUA = $00;
  TASK_RUNLEVEL_HIGHEST = $01;

type
  _TASK_ACTION_TYPE = TOleEnum;

const
  TASK_ACTION_EXEC = $00;
  TASK_ACTION_COM_HANDLER = $05;
  TASK_ACTION_SEND_EMAIL = $06;
  TASK_ACTION_SHOW_MESSAGE = $07;

type
  _TASK_SESSION_STATE_CHANGE_TYPE = TOleEnum;

const
  TASK_CONSOLE_CONNECT = $01;
  TASK_CONSOLE_DISCONNECT = $02;
  TASK_REMOTE_CONNECT = $03;
  TASK_REMOTE_DISCONNECT = $04;
  TASK_SESSION_LOCK = $07;
  TASK_SESSION_UNLOCK = $08;

type
  _TASK_RUN_FLAGS = TOleEnum;

const
  TASK_RUN_NO_FLAGS = $00;
  TASK_RUN_AS_SELF = $01;
  TASK_RUN_IGNORE_CONSTRAINTS = $02;
  TASK_RUN_USE_SESSION_ID = $04;
  TASK_RUN_USER_SID = $08;

type
  _TASK_ENUM_FLAGS = TOleEnum;

const
  TASK_ENUM_HIDDEN = $01;

type
  _TASK_CREATION = TOleEnum;

const
  TASK_VALIDATE_ONLY = $01;
  TASK_CREATE = $02;
  TASK_UPDATE = $04;
  TASK_CREATE_OR_UPDATE = $06;
  TASK_DISABLE = $08;
  TASK_DONT_ADD_PRINCIPAL_ACE = $10;
  TASK_IGNORE_REGISTRATION_TRIGGERS = $20;

type
  ITaskFolder = interface;
  IRunningTaskCollection = interface;
  ITaskDefinition = interface;
  IRegisteredTask = interface;
  IRegisteredTaskCollection = interface;
  IRunningTask = interface;
  IRegistrationInfo = interface;
  ITriggerCollection = interface;
  ITaskSettings = interface;
  IPrincipal = interface;
  IActionCollection = interface;
  ITrigger = interface;
  IRepetitionPattern = interface;
  IIdleSettings = interface;
  INetworkSettings = interface;
  IAction = interface;

  TaskScheduler2 = interface (IDispatch)
   ['{2FABA4C7-4DA9-4013-9697-20CC3FD40F85}']
    function GetFolder(const Path: WideString): ITaskFolder safecall;
    function GetRunningTasks(flags: Integer): IRunningTaskCollection
      safecall;
    function NewTask(flags: LongWord): ITaskDefinition safecall;
    procedure Connect(serverName: OleVariant; user: OleVariant;
      domain: OleVariant; password: OleVariant) safecall;
    function Get_Connected: WordBool safecall;
    function Get_TargetServer: WideString safecall;
    function Get_ConnectedUser: WideString safecall;
    function Get_ConnectedDomain: WideString safecall;
    function Get_HighestVersion: LongWord safecall;
    property Connected:WordBool read Get_Connected;
    property TargetServer:WideString read Get_TargetServer;
    property ConnectedUser:WideString read Get_ConnectedUser;
    property ConnectedDomain:WideString read Get_ConnectedDomain;
    property HighestVersion:LongWord read Get_HighestVersion;
  end;

  TaskHandlerPS = interface (IUnknown) 
   ['{839D7762-5121-4009-9234-4F0D19394F04}']
    function Start(const pHandlerServices: IUnknown;
      const Data: WideString): HRESULT stdcall;
    function Stop(var pRetCode: HRESULT): HRESULT stdcall;
    function Pause: HRESULT stdcall;
    function Resume: HRESULT stdcall;
  end;

  TaskHandlerStatusPS = interface (IUnknown) 
   ['{EAEC7A8F-27A0-4DDC-8675-14726A01A38A}']
    function UpdateStatus(percentComplete: SmallInt;
      const statusMessage: WideString): HRESULT stdcall;
    function TaskCompleted(taskErrCode: HRESULT): HRESULT stdcall;
  end;

  PUserType1 = ^_SYSTEMTIME;

  ITaskFolderCollection = interface (IDispatch) 
   ['{79184A66-8664-423F-97F1-637356A5D812}']
    function Get_Count: Integer safecall;
    function Get_Item(index: OleVariant): ITaskFolder safecall;
    function Get__NewEnum: IUnknown safecall;
    property Count:Integer read Get_Count;
    property Item[index: OleVariant]: ITaskFolder read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

  ITaskFolderCollectionDisp = dispinterface  
   ['{79184A66-8664-423F-97F1-637356A5D812}']
  {published}
    property Count: Integer readonly dispid $60020000;
    property Item: ITaskFolder readonly dispid $0;
    property _NewEnum: IUnknown readonly dispid $FFFFFFFC;
  end platform;

  ITaskFolder = interface (IDispatch) 
   ['{8CFAC062-A080-4C15-9A88-AA7C2AF80DFC}']
    function Get_Name: WideString safecall;
    function Get_Path: WideString safecall;
    function GetFolder(const Path: WideString): ITaskFolder safecall;
    function GetFolders(flags: Integer): ITaskFolderCollection safecall;
    function CreateFolder(const subFolderName: WideString;
      sddl: OleVariant): ITaskFolder safecall;
    procedure DeleteFolder(const subFolderName: WideString; flags: Integer)
      safecall;
    function GetTask(const Path: WideString): IRegisteredTask safecall;
    function GetTasks(flags: Integer): IRegisteredTaskCollection safecall;
    procedure DeleteTask(const Name: WideString; flags: Integer) safecall;
    function RegisterTask(const Path: WideString;
      const XmlText: WideString; flags: Integer; UserId: OleVariant;
      password: OleVariant; LogonType: TOleEnum; sddl: OleVariant):
      IRegisteredTask safecall;
    function RegisterTaskDefinition(const Path: WideString;
      const pDefinition: ITaskDefinition; flags: Integer;
      UserId: OleVariant; password: OleVariant; LogonType: TOleEnum;
      sddl: OleVariant): IRegisteredTask safecall;
    function GetSecurityDescriptor(securityInformation: Integer):
      WideString safecall;
    procedure SetSecurityDescriptor(const sddl: WideString; flags: Integer)
      safecall;
    property Name:WideString read Get_Name;
    property Path:WideString read Get_Path;
  end;

  ITaskFolderDisp = dispinterface  
   ['{8CFAC062-A080-4C15-9A88-AA7C2AF80DFC}']
  {published}
    property Name: WideString readonly dispid $1;
    property Path: WideString readonly dispid $0;
    function GetFolder(const Path: WideString): ITaskFolder;
    function GetFolders(flags: Integer): ITaskFolderCollection;
    function CreateFolder(const subFolderName: WideString;
      sddl: OleVariant): ITaskFolder;
    procedure DeleteFolder(const subFolderName: WideString;
      flags: Integer);
    function GetTask(const Path: WideString): IRegisteredTask;
    function GetTasks(flags: Integer): IRegisteredTaskCollection;
    procedure DeleteTask(const Name: WideString; flags: Integer);
    function RegisterTask(const Path: WideString;
      const XmlText: WideString; flags: Integer; UserId: OleVariant;
      password: OleVariant; LogonType: TOleEnum; sddl: OleVariant):
      IRegisteredTask;
    function RegisterTaskDefinition(const Path: WideString;
      const pDefinition: ITaskDefinition; flags: Integer;
      UserId: OleVariant; password: OleVariant; LogonType: TOleEnum;
      sddl: OleVariant): IRegisteredTask;
    function GetSecurityDescriptor(securityInformation: Integer):
      WideString;
    procedure SetSecurityDescriptor(const sddl: WideString;
      flags: Integer);
  end platform;

  IRegisteredTask = interface (IDispatch) 
   ['{9C86F320-DEE3-4DD1-B972-A303F26B061E}']
    function Get_Name: WideString safecall;
    function Get_Path: WideString safecall;
    function Get_State: TOleEnum safecall;
    function Get_Enabled: WordBool safecall;
    procedure Set_Enabled(pEnabled: WordBool) safecall;
    function Run(params: OleVariant): IRunningTask safecall;
    function RunEx(params: OleVariant; flags: Integer; sessionID: Integer;
      const user: WideString): IRunningTask safecall;
    function GetInstances(flags: Integer): IRunningTaskCollection safecall;
    function Get_LastRunTime: TDateTime safecall;
    function Get_LastTaskResult: Integer safecall;
    function Get_NumberOfMissedRuns: Integer safecall;
    function Get_NextRunTime: TDateTime safecall;
    function Get_Definition: ITaskDefinition safecall;
    function Get_Xml: WideString safecall;
    function GetSecurityDescriptor(securityInformation: Integer):
      WideString safecall;
    procedure SetSecurityDescriptor(const sddl: WideString; flags: Integer)
      safecall;
    procedure Stop(flags: Integer) safecall;
    procedure GetRunTimes(var pstStart: _SYSTEMTIME;
      var pstEnd: _SYSTEMTIME; var pCount: LongWord;
      var pRunTimes: PUserType1) safecall;
    property Name:WideString read Get_Name;
    property Path:WideString read Get_Path;
    property State:TOleEnum read Get_State;
    property Enabled:WordBool read Get_Enabled write Set_Enabled;
    property LastRunTime:TDateTime read Get_LastRunTime;
    property LastTaskResult:Integer read Get_LastTaskResult;
    property NumberOfMissedRuns:Integer read Get_NumberOfMissedRuns;
    property NextRunTime:TDateTime read Get_NextRunTime;
    property Definition:ITaskDefinition read Get_Definition;
    property Xml:WideString read Get_Xml;
  end;

  IRegisteredTaskDisp = dispinterface  
   ['{9C86F320-DEE3-4DD1-B972-A303F26B061E}']
  {published}
    property Name: WideString readonly dispid $1;
    property Path: WideString readonly dispid $0;
    property State: TOleEnum readonly dispid $2;
    property Enabled: WordBool dispid $3;
    function Run(params: OleVariant): IRunningTask;
    function RunEx(params: OleVariant; flags: Integer; sessionID: Integer;
      const user: WideString): IRunningTask;
    function GetInstances(flags: Integer): IRunningTaskCollection;
    property LastRunTime: TDateTime readonly dispid $8;
    property LastTaskResult: Integer readonly dispid $9;
    property NumberOfMissedRuns: Integer readonly dispid $B;
    property NextRunTime: TDateTime readonly dispid $C;
    property Definition: ITaskDefinition readonly dispid $D;
    property Xml: WideString readonly dispid $E;
    function GetSecurityDescriptor(securityInformation: Integer):
      WideString;
    procedure SetSecurityDescriptor(const sddl: WideString;
      flags: Integer);
    procedure Stop(flags: Integer);
    procedure GetRunTimes(var pstStart: OleVariant; var pstEnd: OleVariant;
      var pCount: LongWord; var pRunTimes: OleVariant);
  end platform;

  IRunningTask = interface (IDispatch) 
   ['{653758FB-7B9A-4F1E-A471-BEEB8E9B834E}']
    function Get_Name: WideString safecall;
    function Get_InstanceGuid: WideString safecall;
    function Get_Path: WideString safecall;
    function Get_State: TOleEnum safecall;
    function Get_CurrentAction: WideString safecall;
    procedure Stop safecall;
    procedure Refresh safecall;
    function Get_EnginePID: LongWord safecall;
    property Name:WideString read Get_Name;
    property InstanceGuid:WideString read Get_InstanceGuid;
    property Path:WideString read Get_Path;
    property State:TOleEnum read Get_State;
    property CurrentAction:WideString read Get_CurrentAction;
    property EnginePID:LongWord read Get_EnginePID;
  end;

  IRunningTaskDisp = dispinterface  
   ['{653758FB-7B9A-4F1E-A471-BEEB8E9B834E}']
  {published}
    property Name: WideString readonly dispid $1;
    property InstanceGuid: WideString readonly dispid $0;
    property Path: WideString readonly dispid $2;
    property State: TOleEnum readonly dispid $3;
    property CurrentAction: WideString readonly dispid $4;
    procedure Stop;
    procedure Refresh;
    property EnginePID: LongWord readonly dispid $7;
  end platform;

  IRunningTaskCollection = interface (IDispatch) 
   ['{6A67614B-6828-4FEC-AA54-6D52E8F1F2DB}']
    function Get_Count: Integer safecall;
    function Get_Item(index: OleVariant): IRunningTask safecall;
    function Get__NewEnum: IUnknown safecall;
    property Count: Integer read Get_Count;
    property Item[index: OleVariant]: IRunningTask read Get_Item; default;
    property _NewEnum:IUnknown read Get__NewEnum;
  end;

  IRunningTaskCollectionDisp = dispinterface  
   ['{6A67614B-6828-4FEC-AA54-6D52E8F1F2DB}']
  {published}
    property Count: Integer readonly dispid $1;
    property Item: IRunningTask readonly dispid $0;
    property _NewEnum: IUnknown readonly dispid $FFFFFFFC;
  end platform;

  ITaskDefinition = interface (IDispatch) 
   ['{F5BC8FC5-536D-4F77-B852-FBC1356FDEB6}']
    function Get_RegistrationInfo: IRegistrationInfo safecall;
    procedure Set_RegistrationInfo(const ppRegistrationInfo: IRegistrationInfo)
      safecall;
    function Get_Triggers: ITriggerCollection safecall;
    procedure Set_Triggers(const ppTriggers: ITriggerCollection) safecall;
    function Get_Settings: ITaskSettings safecall;
    procedure Set_Settings(const ppSettings: ITaskSettings) safecall;
    function Get_Data: WideString safecall;
    procedure Set_Data(const pData: WideString) safecall;
    function Get_Principal: IPrincipal safecall;
    procedure Set_Principal(const ppPrincipal: IPrincipal) safecall;
    function Get_Actions: IActionCollection safecall;
    procedure Set_Actions(const ppActions: IActionCollection) safecall;
    function Get_XmlText: WideString safecall;
    procedure Set_XmlText(const pXml: WideString) safecall;
    property RegistrationInfo:IRegistrationInfo read Get_RegistrationInfo
      write Set_RegistrationInfo;
    property Triggers:ITriggerCollection read Get_Triggers
      write Set_Triggers;
    property Settings:ITaskSettings read Get_Settings write Set_Settings;
    property Data:WideString read Get_Data write Set_Data;
    property Principal:IPrincipal read Get_Principal write Set_Principal;
    property Actions:IActionCollection read Get_Actions write Set_Actions;
    property XmlText:WideString read Get_XmlText write Set_XmlText;
  end;

  ITaskDefinitionDisp = dispinterface  
   ['{F5BC8FC5-536D-4F77-B852-FBC1356FDEB6}']
  {published}
    property RegistrationInfo: IRegistrationInfo dispid $1;
    property Triggers: ITriggerCollection dispid $2;
    property Settings: ITaskSettings dispid $7;
    property Data: WideString dispid $B;
    property Principal: IPrincipal dispid $C;
    property Actions: IActionCollection dispid $D;
    property XmlText: WideString dispid $E;
  end platform;

  IRegistrationInfo = interface (IDispatch) 
   ['{416D8B73-CB41-4EA1-805C-9BE9A5AC4A74}']
    function Get_Description: WideString safecall;
    procedure Set_Description(const pDescription: WideString) safecall;
    function Get_Author: WideString safecall;
    procedure Set_Author(const pAuthor: WideString) safecall;
    function Get_Version: WideString safecall;
    procedure Set_Version(const pVersion: WideString) safecall;
    function Get_Date: WideString safecall;
    procedure Set_Date(const pDate: WideString) safecall;
    function Get_Documentation: WideString safecall;
    procedure Set_Documentation(const pDocumentation: WideString) safecall;
    function Get_XmlText: WideString safecall;
    procedure Set_XmlText(const pText: WideString) safecall;
    function Get_URI: WideString safecall;
    procedure Set_URI(const pUri: WideString) safecall;
    function Get_SecurityDescriptor: OleVariant safecall;
    procedure Set_SecurityDescriptor(pSddl: OleVariant) safecall;
    function Get_Source: WideString safecall;
    procedure Set_Source(const pSource: WideString) safecall;
    property Description:WideString read Get_Description
      write Set_Description;
    property Author:WideString read Get_Author write Set_Author;
    property Version:WideString read Get_Version write Set_Version;
    property Date:WideString read Get_Date write Set_Date;
    property Documentation:WideString read Get_Documentation
      write Set_Documentation;
    property XmlText:WideString read Get_XmlText write Set_XmlText;
    property URI:WideString read Get_URI write Set_URI;
    property SecurityDescriptor:OleVariant read Get_SecurityDescriptor
      write Set_SecurityDescriptor;
    property Source:WideString read Get_Source write Set_Source;
  end;

  IRegistrationInfoDisp = dispinterface  
   ['{416D8B73-CB41-4EA1-805C-9BE9A5AC4A74}']
  {published}
    property Description: WideString dispid $1;
    property Author: WideString dispid $2;
    property Version: WideString dispid $4;
    property Date: WideString dispid $5;
    property Documentation: WideString dispid $6;
    property XmlText: WideString dispid $9;
    property URI: WideString dispid $A;
    property SecurityDescriptor: OleVariant dispid $B;
    property Source: WideString dispid $C;
  end platform;

  ITriggerCollection = interface (IDispatch) 
   ['{85DF5081-1B24-4F32-878A-D9D14DF4CB77}']
    function Get_Count: Integer safecall;
    function Get_Item(index: Integer): ITrigger safecall;
    function Get__NewEnum: IUnknown safecall;
    function Create(Type_: TOleEnum): ITrigger safecall;
    procedure Remove(index: OleVariant) safecall;
    procedure Clear safecall;
    property Count:Integer read Get_Count;
    property Item[index: Integer]: ITrigger read Get_Item; default;
    property _NewEnum:IUnknown read Get__NewEnum;
  end;

  ITriggerCollectionDisp = dispinterface  
   ['{85DF5081-1B24-4F32-878A-D9D14DF4CB77}']
  {published}
    property Count: Integer readonly dispid $1;
    property Item: ITrigger readonly dispid $0;
    property _NewEnum: IUnknown readonly dispid $FFFFFFFC;
    function Create(Type_: TOleEnum): ITrigger;
    procedure Remove(index: OleVariant);
    procedure Clear;
  end platform;

  ITrigger = interface (IDispatch) 
   ['{09941815-EA89-4B5B-89E0-2A773801FAC3}']
    function Get_type_: TOleEnum safecall;
    function Get_Id: WideString safecall;
    procedure Set_Id(const pId: WideString) safecall;
    function Get_Repetition: IRepetitionPattern safecall;
    procedure Set_Repetition(const ppRepeat: IRepetitionPattern) safecall;
    function Get_ExecutionTimeLimit: WideString safecall;
    procedure Set_ExecutionTimeLimit(const pTimeLimit: WideString)
      safecall;
    function Get_StartBoundary: WideString safecall;
    procedure Set_StartBoundary(const pStart: WideString) safecall;
    function Get_EndBoundary: WideString safecall;
    procedure Set_EndBoundary(const pEnd: WideString) safecall;
    function Get_Enabled: WordBool safecall;
    procedure Set_Enabled(pEnabled: WordBool) safecall;
    property type_:TOleEnum read Get_type_;
    property Id:WideString read Get_Id write Set_Id;
    property Repetition:IRepetitionPattern read Get_Repetition
      write Set_Repetition;
    property ExecutionTimeLimit:WideString read Get_ExecutionTimeLimit
      write Set_ExecutionTimeLimit;
    property StartBoundary:WideString read Get_StartBoundary
      write Set_StartBoundary;
    property EndBoundary:WideString read Get_EndBoundary
      write Set_EndBoundary;
    property Enabled:WordBool read Get_Enabled write Set_Enabled;
  end;

  ITriggerDisp = dispinterface  
   ['{09941815-EA89-4B5B-89E0-2A773801FAC3}']
  {published}
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IRepetitionPattern = interface (IDispatch) 
   ['{7FB9ACF1-26BE-400E-85B5-294B9C75DFD6}']
    function Get_Interval: WideString safecall;
    procedure Set_Interval(const pInterval: WideString) safecall;
    function Get_Duration: WideString safecall;
    procedure Set_Duration(const pDuration: WideString) safecall;
    function Get_StopAtDurationEnd: WordBool safecall;
    procedure Set_StopAtDurationEnd(pStop: WordBool) safecall;
    property Interval:WideString read Get_Interval write Set_Interval;
    property Duration:WideString read Get_Duration write Set_Duration;
    property StopAtDurationEnd:WordBool read Get_StopAtDurationEnd
      write Set_StopAtDurationEnd;
  end;

  IRepetitionPatternDisp = dispinterface  
   ['{7FB9ACF1-26BE-400E-85B5-294B9C75DFD6}']
  {published}
    property Interval: WideString dispid $1;
    property Duration: WideString dispid $2;
    property StopAtDurationEnd: WordBool dispid $3;
  end platform;

  ITaskSettings = interface (IDispatch) 
   ['{8FD4711D-2D02-4C8C-87E3-EFF699DE127E}']
    function Get_AllowDemandStart: WordBool safecall;
    procedure Set_AllowDemandStart(pAllowDemandStart: WordBool) safecall;
    function Get_RestartInterval: WideString safecall;
    procedure Set_RestartInterval(const pRestartInterval: WideString)
      safecall;
    function Get_RestartCount: SYSINT safecall;
    procedure Set_RestartCount(pRestartCount: SYSINT) safecall;
    function Get_MultipleInstances: TOleEnum safecall;
    procedure Set_MultipleInstances(pPolicy: TOleEnum) safecall;
    function Get_StopIfGoingOnBatteries: WordBool safecall;
    procedure Set_StopIfGoingOnBatteries(pStopIfOnBatteries: WordBool)
      safecall;
    function Get_DisallowStartIfOnBatteries: WordBool safecall;
    procedure Set_DisallowStartIfOnBatteries(pDisallowStart: WordBool)
      safecall;
    function Get_AllowHardTerminate: WordBool safecall;
    procedure Set_AllowHardTerminate(pAllowHardTerminate: WordBool)
      safecall;
    function Get_StartWhenAvailable: WordBool safecall;
    procedure Set_StartWhenAvailable(pStartWhenAvailable: WordBool)
      safecall;
    function Get_XmlText: WideString safecall;
    procedure Set_XmlText(const pText: WideString) safecall;
    function Get_RunOnlyIfNetworkAvailable: WordBool safecall;
    procedure Set_RunOnlyIfNetworkAvailable(pRunOnlyIfNetworkAvailable: WordBool)
      safecall;
    function Get_ExecutionTimeLimit: WideString safecall;
    procedure Set_ExecutionTimeLimit(const pExecutionTimeLimit: WideString)
      safecall;
    function Get_Enabled: WordBool safecall;
    procedure Set_Enabled(pEnabled: WordBool) safecall;
    function Get_DeleteExpiredTaskAfter: WideString safecall;
    procedure Set_DeleteExpiredTaskAfter(const pExpirationDelay: WideString)
      safecall;
    function Get_Priority: SYSINT safecall;
    procedure Set_Priority(pPriority: SYSINT) safecall;
    function Get_Compatibility: TOleEnum safecall;
    procedure Set_Compatibility(pCompatLevel: TOleEnum) safecall;
    function Get_Hidden: WordBool safecall;
    procedure Set_Hidden(pHidden: WordBool) safecall;
    function Get_IdleSettings: IIdleSettings safecall;
    procedure Set_IdleSettings(const ppIdleSettings: IIdleSettings)
      safecall;
    function Get_RunOnlyIfIdle: WordBool safecall;
    procedure Set_RunOnlyIfIdle(pRunOnlyIfIdle: WordBool) safecall;
    function Get_WakeToRun: WordBool safecall;
    procedure Set_WakeToRun(pWake: WordBool) safecall;
    function Get_NetworkSettings: INetworkSettings safecall;
    procedure Set_NetworkSettings(const ppNetworkSettings: INetworkSettings)
      safecall;
    property AllowDemandStart:WordBool read Get_AllowDemandStart
      write Set_AllowDemandStart;
    property RestartInterval:WideString read Get_RestartInterval
      write Set_RestartInterval;
    property RestartCount:SYSINT read Get_RestartCount
      write Set_RestartCount;
    property MultipleInstances:TOleEnum read Get_MultipleInstances
      write Set_MultipleInstances;
    property StopIfGoingOnBatteries:WordBool
      read Get_StopIfGoingOnBatteries write Set_StopIfGoingOnBatteries;
    property DisallowStartIfOnBatteries:WordBool
      read Get_DisallowStartIfOnBatteries
      write Set_DisallowStartIfOnBatteries;
    property AllowHardTerminate:WordBool read Get_AllowHardTerminate
      write Set_AllowHardTerminate;
    property StartWhenAvailable:WordBool read Get_StartWhenAvailable
      write Set_StartWhenAvailable;
    property XmlText:WideString read Get_XmlText write Set_XmlText;
    property RunOnlyIfNetworkAvailable:WordBool
      read Get_RunOnlyIfNetworkAvailable
      write Set_RunOnlyIfNetworkAvailable;
    property ExecutionTimeLimit:WideString read Get_ExecutionTimeLimit
      write Set_ExecutionTimeLimit;
    property Enabled:WordBool read Get_Enabled write Set_Enabled;
    property DeleteExpiredTaskAfter:WideString
      read Get_DeleteExpiredTaskAfter write Set_DeleteExpiredTaskAfter;
    property Priority:SYSINT read Get_Priority write Set_Priority;
    property Compatibility:TOleEnum read Get_Compatibility
      write Set_Compatibility;
    property Hidden:WordBool read Get_Hidden write Set_Hidden;
    property IdleSettings:IIdleSettings read Get_IdleSettings
      write Set_IdleSettings;
    property RunOnlyIfIdle:WordBool read Get_RunOnlyIfIdle
      write Set_RunOnlyIfIdle;
    property WakeToRun:WordBool read Get_WakeToRun write Set_WakeToRun;
    property NetworkSettings:INetworkSettings read Get_NetworkSettings
      write Set_NetworkSettings;
  end;

  ITaskSettingsDisp = dispinterface  
   ['{8FD4711D-2D02-4C8C-87E3-EFF699DE127E}']
  {published}
    property AllowDemandStart: WordBool dispid $3;
    property RestartInterval: WideString dispid $4;
    property RestartCount: SYSINT dispid $5;
    property MultipleInstances: TOleEnum dispid $6;
    property StopIfGoingOnBatteries: WordBool dispid $7;
    property DisallowStartIfOnBatteries: WordBool dispid $8;
    property AllowHardTerminate: WordBool dispid $9;
    property StartWhenAvailable: WordBool dispid $A;
    property XmlText: WideString dispid $B;
    property RunOnlyIfNetworkAvailable: WordBool dispid $C;
    property ExecutionTimeLimit: WideString dispid $D;
    property Enabled: WordBool dispid $E;
    property DeleteExpiredTaskAfter: WideString dispid $F;
    property Priority: SYSINT dispid $10;
    property Compatibility: TOleEnum dispid $11;
    property Hidden: WordBool dispid $12;
    property IdleSettings: IIdleSettings dispid $13;
    property RunOnlyIfIdle: WordBool dispid $14;
    property WakeToRun: WordBool dispid $15;
    property NetworkSettings: INetworkSettings dispid $16;
  end platform;

  IIdleSettings = interface (IDispatch) 
   ['{84594461-0053-4342-A8FD-088FABF11F32}']
    function Get_IdleDuration: WideString safecall;
    procedure Set_IdleDuration(const pDelay: WideString) safecall;
    function Get_WaitTimeout: WideString safecall;
    procedure Set_WaitTimeout(const pTimeout: WideString) safecall;
    function Get_StopOnIdleEnd: WordBool safecall;
    procedure Set_StopOnIdleEnd(pStop: WordBool) safecall;
    function Get_RestartOnIdle: WordBool safecall;
    procedure Set_RestartOnIdle(pRestart: WordBool) safecall;
    property IdleDuration:WideString read Get_IdleDuration
      write Set_IdleDuration;
    property WaitTimeout:WideString read Get_WaitTimeout
      write Set_WaitTimeout;
    property StopOnIdleEnd:WordBool read Get_StopOnIdleEnd
      write Set_StopOnIdleEnd;
    property RestartOnIdle:WordBool read Get_RestartOnIdle
      write Set_RestartOnIdle;
  end;

  IIdleSettingsDisp = dispinterface  
   ['{84594461-0053-4342-A8FD-088FABF11F32}']
  {published}
    property IdleDuration: WideString dispid $1;
    property WaitTimeout: WideString dispid $2;
    property StopOnIdleEnd: WordBool dispid $3;
    property RestartOnIdle: WordBool dispid $4;
  end platform;

  INetworkSettings = interface (IDispatch) 
   ['{9F7DEA84-C30B-4245-80B6-00E9F646F1B4}']
    function Get_Name: WideString safecall;
    procedure Set_Name(const pName: WideString) safecall;
    function Get_Id: WideString safecall;
    procedure Set_Id(const pId: WideString) safecall;
    property Name:WideString read Get_Name write Set_Name;
    property Id:WideString read Get_Id write Set_Id;
  end;

  INetworkSettingsDisp = dispinterface  
   ['{9F7DEA84-C30B-4245-80B6-00E9F646F1B4}']
  {published}
    property Name: WideString dispid $1;
    property Id: WideString dispid $2;
  end platform;

  IPrincipal = interface (IDispatch) 
   ['{D98D51E5-C9B4-496A-A9C1-18980261CF0F}']
    function Get_Id: WideString safecall;
    procedure Set_Id(const pId: WideString) safecall;
    function Get_DisplayName: WideString safecall;
    procedure Set_DisplayName(const pName: WideString) safecall;
    function Get_UserId: WideString safecall;
    procedure Set_UserId(const pUser: WideString) safecall;
    function Get_LogonType: TOleEnum safecall;
    procedure Set_LogonType(pLogon: TOleEnum) safecall;
    function Get_GroupId: WideString safecall;
    procedure Set_GroupId(const pGroup: WideString) safecall;
    function Get_RunLevel: TOleEnum safecall;
    procedure Set_RunLevel(pRunLevel: TOleEnum) safecall;
    property Id:WideString read Get_Id write Set_Id;
    property DisplayName:WideString read Get_DisplayName
      write Set_DisplayName;
    property UserId:WideString read Get_UserId write Set_UserId;
    property LogonType:TOleEnum read Get_LogonType write Set_LogonType;
    property GroupId:WideString read Get_GroupId write Set_GroupId;
    property RunLevel:TOleEnum read Get_RunLevel write Set_RunLevel;
  end;

  IPrincipalDisp = dispinterface  
   ['{D98D51E5-C9B4-496A-A9C1-18980261CF0F}']
  {published}
    property Id: WideString dispid $1;
    property DisplayName: WideString dispid $2;
    property UserId: WideString dispid $3;
    property LogonType: TOleEnum dispid $4;
    property GroupId: WideString dispid $5;
    property RunLevel: TOleEnum dispid $6;
  end platform;

  IActionCollection = interface (IDispatch) 
   ['{02820E19-7B98-4ED2-B2E8-FDCCCEFF619B}']
    function Get_Count: Integer safecall;
    function Get_Item(index: Integer): IAction safecall;
    function Get__NewEnum: IUnknown safecall;
    function Get_XmlText: WideString safecall;
    procedure Set_XmlText(const pText: WideString) safecall;
    function Create(Type_: TOleEnum): IAction safecall;
    procedure Remove(index: OleVariant) safecall;
    procedure Clear safecall;
    function Get_Context: WideString safecall;
    procedure Set_Context(const pContext: WideString) safecall;
    property Count:Integer read Get_Count;
    property Item[index: Integer]: IAction read Get_Item; default;
    property _NewEnum:IUnknown read Get__NewEnum;
    property XmlText:WideString read Get_XmlText write Set_XmlText;
    property Context:WideString read Get_Context write Set_Context;
  end;

  IActionCollectionDisp = dispinterface  
   ['{02820E19-7B98-4ED2-B2E8-FDCCCEFF619B}']
  {published}
    property Count: Integer readonly dispid $1;
    property Item: IAction readonly dispid $0;
    property _NewEnum: IUnknown readonly dispid $FFFFFFFC;
    property XmlText: WideString dispid $2;
    function Create(Type_: TOleEnum): IAction;
    procedure Remove(index: OleVariant);
    procedure Clear;
    property Context: WideString dispid $6;
  end platform;

  IAction = interface (IDispatch) 
   ['{BAE54997-48B1-4CBE-9965-D6BE263EBEA4}']
    function Get_Id: WideString safecall;
    procedure Set_Id(const pId: WideString) safecall;
    function Get_type_: TOleEnum safecall;
    property Id:WideString read Get_Id write Set_Id;
    property type_:TOleEnum read Get_type_;
  end;

  IActionDisp = dispinterface  
   ['{BAE54997-48B1-4CBE-9965-D6BE263EBEA4}']
  {published}
    property Id: WideString dispid $1;
    property type_: TOleEnum readonly dispid $2;
  end platform;

  IRegisteredTaskCollection = interface (IDispatch) 
   ['{86627EB4-42A7-41E4-A4D9-AC33A72F2D52}']
    function Get_Count: Integer safecall;
    function Get_Item(index: OleVariant): IRegisteredTask safecall;
    function Get__NewEnum: IUnknown safecall;
    property Count:Integer read Get_Count;
    property Item[index: OleVariant]: IRegisteredTask
      read Get_Item; default;
    property _NewEnum:IUnknown read Get__NewEnum;
  end;

  IRegisteredTaskCollectionDisp = dispinterface  
   ['{86627EB4-42A7-41E4-A4D9-AC33A72F2D52}']
  {published}
    property Count: Integer readonly dispid $60020000;
    property Item: IRegisteredTask readonly
      dispid $0;
    property _NewEnum: IUnknown readonly dispid $FFFFFFFC;
  end platform;

  ITaskService = TaskScheduler2;

  ITaskServiceDisp = dispinterface  
   ['{2FABA4C7-4DA9-4013-9697-20CC3FD40F85}']
  {published}
    function GetFolder(const Path: WideString): ITaskFolder;
    function GetRunningTasks(flags: Integer): IRunningTaskCollection;
    function NewTask(flags: LongWord): ITaskDefinition;
    procedure Connect(serverName: OleVariant; user: OleVariant;
      domain: OleVariant; password: OleVariant);
    property Connected: WordBool readonly dispid $5;
    property TargetServer: WideString readonly dispid $0;
    property ConnectedUser: WideString readonly dispid $6;
    property ConnectedDomain: WideString readonly dispid $7;
    property HighestVersion: LongWord readonly dispid $8;
  end platform;

  ITaskHandler = TaskHandlerPS;

  ITaskHandlerStatus = TaskHandlerStatusPS;

  ITaskVariables = interface (IUnknown) 
   ['{3E4C9351-D966-4B8B-BB87-CEBA68BB0107}']
    function GetInput(var pInput: WideString): HRESULT stdcall;
    function SetOutput(const input: WideString): HRESULT stdcall;
    function GetContext(var pContext: WideString): HRESULT stdcall;
  end;

  ITaskNamedValuePair = interface (IDispatch) 
   ['{39038068-2B46-4AFD-8662-7BB6F868D221}']
    function Get_Name: WideString safecall;
    procedure Set_Name(const pName: WideString) safecall;
    function Get_Value: WideString safecall;
    procedure Set_Value(const pValue: WideString) safecall;
    property Name:WideString read Get_Name write Set_Name;
    property Value:WideString read Get_Value write Set_Value;
  end;

  ITaskNamedValuePairDisp = dispinterface  
   ['{39038068-2B46-4AFD-8662-7BB6F868D221}']
  {published}
    property Name: WideString dispid $0;
    property Value: WideString dispid $1;
  end platform;

  ITaskNamedValueCollection = interface (IDispatch) 
   ['{B4EF826B-63C3-46E4-A504-EF69E4F7EA4D}']
    function Get_Count: Integer safecall;
    function Get_Item(index: Integer): ITaskNamedValuePair safecall;
    function Get__NewEnum: IUnknown safecall;
    function Create(const Name: WideString; const Value: WideString):
      ITaskNamedValuePair safecall;
    procedure Remove(index: Integer) safecall;
    procedure Clear safecall;
    property Count:Integer read Get_Count;
    property Item[index: Integer]: ITaskNamedValuePair
      read Get_Item; default;
    property _NewEnum:IUnknown read Get__NewEnum;
  end;

  ITaskNamedValueCollectionDisp = dispinterface  
   ['{B4EF826B-63C3-46E4-A504-EF69E4F7EA4D}']
  {published}
    property Count: Integer readonly dispid $1;
    property Item: ITaskNamedValuePair readonly
      dispid $0;
    property _NewEnum: IUnknown readonly dispid $FFFFFFFC;
    function Create(const Name: WideString; const Value: WideString):
      ITaskNamedValuePair;
    procedure Remove(index: Integer);
    procedure Clear;
  end platform;

  IIdleTrigger = interface (ITrigger) 
   ['{D537D2B0-9FB3-4D34-9739-1FF5CE7B1EF3}']
  end;

  IIdleTriggerDisp = dispinterface  
   ['{D537D2B0-9FB3-4D34-9739-1FF5CE7B1EF3}']
  {published}
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  ILogonTrigger = interface (ITrigger) 
   ['{72DADE38-FAE4-4B3E-BAF4-5D009AF02B1C}']
    function Get_Delay: WideString safecall;
    procedure Set_Delay(const pDelay: WideString) safecall;
    function Get_UserId: WideString safecall;
    procedure Set_UserId(const pUser: WideString) safecall;
    property Delay:WideString read Get_Delay write Set_Delay;
    property UserId:WideString read Get_UserId write Set_UserId;
  end;

  ILogonTriggerDisp = dispinterface  
   ['{72DADE38-FAE4-4B3E-BAF4-5D009AF02B1C}']
  {published}
    property Delay: WideString dispid $14;
    property UserId: WideString dispid $15;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  ISessionStateChangeTrigger = interface (ITrigger) 
   ['{754DA71B-4385-4475-9DD9-598294FA3641}']
    function Get_Delay: WideString safecall;
    procedure Set_Delay(const pDelay: WideString) safecall;
    function Get_UserId: WideString safecall;
    procedure Set_UserId(const pUser: WideString) safecall;
    function Get_StateChange: TOleEnum safecall;
    procedure Set_StateChange(pType: TOleEnum) safecall;
    property Delay:WideString read Get_Delay write Set_Delay;
    property UserId:WideString read Get_UserId write Set_UserId;
    property StateChange:TOleEnum read Get_StateChange
      write Set_StateChange;
  end;

  ISessionStateChangeTriggerDisp = dispinterface  
   ['{754DA71B-4385-4475-9DD9-598294FA3641}']
  {published}
    property Delay: WideString dispid $14;
    property UserId: WideString dispid $15;
    property StateChange: TOleEnum dispid $16;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IEventTrigger = interface (ITrigger) 
   ['{D45B0167-9653-4EEF-B94F-0732CA7AF251}']
    function Get_Subscription: WideString safecall;
    procedure Set_Subscription(const pQuery: WideString) safecall;
    function Get_Delay: WideString safecall;
    procedure Set_Delay(const pDelay: WideString) safecall;
    function Get_ValueQueries: ITaskNamedValueCollection safecall;
    procedure Set_ValueQueries(const ppNamedXPaths: ITaskNamedValueCollection)
      safecall;
    property Subscription:WideString read Get_Subscription
      write Set_Subscription;
    property Delay:WideString read Get_Delay write Set_Delay;
    property ValueQueries:ITaskNamedValueCollection read Get_ValueQueries
      write Set_ValueQueries;
  end;

  IEventTriggerDisp = dispinterface  
   ['{D45B0167-9653-4EEF-B94F-0732CA7AF251}']
  {published}
    property Subscription: WideString dispid $14;
    property Delay: WideString dispid $15;
    property ValueQueries: ITaskNamedValueCollection dispid $16;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  ITimeTrigger = interface (ITrigger) 
   ['{B45747E0-EBA7-4276-9F29-85C5BB300006}']
    function Get_RandomDelay: WideString safecall;
    procedure Set_RandomDelay(const pRandomDelay: WideString) safecall;
    property RandomDelay:WideString read Get_RandomDelay
      write Set_RandomDelay;
  end;

  ITimeTriggerDisp = dispinterface  
   ['{B45747E0-EBA7-4276-9F29-85C5BB300006}']
  {published}
    property RandomDelay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IDailyTrigger = interface (ITrigger) 
   ['{126C5CD8-B288-41D5-8DBF-E491446ADC5C}']
    function Get_DaysInterval: SmallInt safecall;
    procedure Set_DaysInterval(pDays: SmallInt) safecall;
    function Get_RandomDelay: WideString safecall;
    procedure Set_RandomDelay(const pRandomDelay: WideString) safecall;
    property DaysInterval:SmallInt read Get_DaysInterval
      write Set_DaysInterval;
    property RandomDelay:WideString read Get_RandomDelay
      write Set_RandomDelay;
  end;

  IDailyTriggerDisp = dispinterface  
   ['{126C5CD8-B288-41D5-8DBF-E491446ADC5C}']
  {published}
    property DaysInterval: SmallInt dispid $19;
    property RandomDelay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IWeeklyTrigger = interface (ITrigger) 
   ['{5038FC98-82FF-436D-8728-A512A57C9DC1}']
    function Get_DaysOfWeek: SmallInt safecall;
    procedure Set_DaysOfWeek(pDays: SmallInt) safecall;
    function Get_WeeksInterval: SmallInt safecall;
    procedure Set_WeeksInterval(pWeeks: SmallInt) safecall;
    function Get_RandomDelay: WideString safecall;
    procedure Set_RandomDelay(const pRandomDelay: WideString) safecall;
    property DaysOfWeek:SmallInt read Get_DaysOfWeek write Set_DaysOfWeek;
    property WeeksInterval:SmallInt read Get_WeeksInterval
      write Set_WeeksInterval;
    property RandomDelay:WideString read Get_RandomDelay
      write Set_RandomDelay;
  end;

  IWeeklyTriggerDisp = dispinterface  
   ['{5038FC98-82FF-436D-8728-A512A57C9DC1}']
  {published}
    property DaysOfWeek: SmallInt dispid $19;
    property WeeksInterval: SmallInt dispid $1A;
    property RandomDelay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IMonthlyTrigger = interface (ITrigger) 
   ['{97C45EF1-6B02-4A1A-9C0E-1EBFBA1500AC}']
    function Get_DaysOfMonth: Integer safecall;
    procedure Set_DaysOfMonth(pDays: Integer) safecall;
    function Get_MonthsOfYear: SmallInt safecall;
    procedure Set_MonthsOfYear(pMonths: SmallInt) safecall;
    function Get_RunOnLastDayOfMonth: WordBool safecall;
    procedure Set_RunOnLastDayOfMonth(pLastDay: WordBool) safecall;
    function Get_RandomDelay: WideString safecall;
    procedure Set_RandomDelay(const pRandomDelay: WideString) safecall;
    property DaysOfMonth:Integer read Get_DaysOfMonth
      write Set_DaysOfMonth;
    property MonthsOfYear:SmallInt read Get_MonthsOfYear
      write Set_MonthsOfYear;
    property RunOnLastDayOfMonth:WordBool read Get_RunOnLastDayOfMonth
      write Set_RunOnLastDayOfMonth;
    property RandomDelay:WideString read Get_RandomDelay
      write Set_RandomDelay;
  end;

  IMonthlyTriggerDisp = dispinterface  
   ['{97C45EF1-6B02-4A1A-9C0E-1EBFBA1500AC}']
  {published}
    property DaysOfMonth: Integer dispid $19;
    property MonthsOfYear: SmallInt dispid $1A;
    property RunOnLastDayOfMonth: WordBool dispid $1B;
    property RandomDelay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IMonthlyDOWTrigger = interface (ITrigger) 
   ['{77D025A3-90FA-43AA-B52E-CDA5499B946A}']
    function Get_DaysOfWeek: SmallInt safecall;
    procedure Set_DaysOfWeek(pDays: SmallInt) safecall;
    function Get_WeeksOfMonth: SmallInt safecall;
    procedure Set_WeeksOfMonth(pWeeks: SmallInt) safecall;
    function Get_MonthsOfYear: SmallInt safecall;
    procedure Set_MonthsOfYear(pMonths: SmallInt) safecall;
    function Get_RunOnLastWeekOfMonth: WordBool safecall;
    procedure Set_RunOnLastWeekOfMonth(pLastWeek: WordBool) safecall;
    function Get_RandomDelay: WideString safecall;
    procedure Set_RandomDelay(const pRandomDelay: WideString) safecall;
    property DaysOfWeek:SmallInt read Get_DaysOfWeek write Set_DaysOfWeek;
    property WeeksOfMonth:SmallInt read Get_WeeksOfMonth
      write Set_WeeksOfMonth;
    property MonthsOfYear:SmallInt read Get_MonthsOfYear
      write Set_MonthsOfYear;
    property RunOnLastWeekOfMonth:WordBool read Get_RunOnLastWeekOfMonth
      write Set_RunOnLastWeekOfMonth;
    property RandomDelay:WideString read Get_RandomDelay
      write Set_RandomDelay;
  end;

  IMonthlyDOWTriggerDisp = dispinterface  
   ['{77D025A3-90FA-43AA-B52E-CDA5499B946A}']
  {published}
    property DaysOfWeek: SmallInt dispid $19;
    property WeeksOfMonth: SmallInt dispid $1A;
    property MonthsOfYear: SmallInt dispid $1B;
    property RunOnLastWeekOfMonth: WordBool dispid $1C;
    property RandomDelay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IBootTrigger = interface (ITrigger) 
   ['{2A9C35DA-D357-41F4-BBC1-207AC1B1F3CB}']
    function Get_Delay: WideString safecall;
    procedure Set_Delay(const pDelay: WideString) safecall;
    property Delay:WideString read Get_Delay write Set_Delay;
  end;

  IBootTriggerDisp = dispinterface  
   ['{2A9C35DA-D357-41F4-BBC1-207AC1B1F3CB}']
  {published}
    property Delay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IRegistrationTrigger = interface (ITrigger) 
   ['{4C8FEC3A-C218-4E0C-B23D-629024DB91A2}']
    function Get_Delay: WideString safecall;
    procedure Set_Delay(const pDelay: WideString) safecall;
    property Delay:WideString read Get_Delay write Set_Delay;
  end;

  IRegistrationTriggerDisp = dispinterface  
   ['{4C8FEC3A-C218-4E0C-B23D-629024DB91A2}']
  {published}
    property Delay: WideString dispid $14;
    property type_: TOleEnum readonly dispid $1;
    property Id: WideString dispid $2;
    property Repetition: IRepetitionPattern dispid $3;
    property ExecutionTimeLimit: WideString dispid $4;
    property StartBoundary: WideString dispid $5;
    property EndBoundary: WideString dispid $6;
    property Enabled: WordBool dispid $7;
  end platform;

  IExecAction = interface (IAction) 
   ['{4C3D624D-FD6B-49A3-B9B7-09CB3CD3F047}']
    function Get_Path: WideString safecall;
    procedure Set_Path(const pPath: WideString) safecall;
    function Get_Arguments: WideString safecall;
    procedure Set_Arguments(const pArgument: WideString) safecall;
    function Get_WorkingDirectory: WideString safecall;
    procedure Set_WorkingDirectory(const pWorkingDirectory: WideString)
      safecall;
    property Path:WideString read Get_Path write Set_Path;
    property Arguments:WideString read Get_Arguments write Set_Arguments;
    property WorkingDirectory:WideString read Get_WorkingDirectory
      write Set_WorkingDirectory;
  end;

  IExecActionDisp = dispinterface  
   ['{4C3D624D-FD6B-49A3-B9B7-09CB3CD3F047}']
  {published}
    property Path: WideString dispid $A;
    property Arguments: WideString dispid $B;
    property WorkingDirectory: WideString dispid $C;
    property Id: WideString dispid $1;
    property type_: TOleEnum readonly dispid $2;
  end platform;

  IShowMessageAction = interface (IAction) 
   ['{505E9E68-AF89-46B8-A30F-56162A83D537}']
    function Get_Title: WideString safecall;
    procedure Set_Title(const pTitle: WideString) safecall;
    function Get_MessageBody: WideString safecall;
    procedure Set_MessageBody(const pMessageBody: WideString) safecall;
    property Title:WideString read Get_Title write Set_Title;
    property MessageBody:WideString read Get_MessageBody
      write Set_MessageBody;
  end;

  IShowMessageActionDisp = dispinterface  
   ['{505E9E68-AF89-46B8-A30F-56162A83D537}']
  {published}
    property Title: WideString dispid $A;
    property MessageBody: WideString dispid $B;
    property Id: WideString dispid $1;
    property type_: TOleEnum readonly dispid $2;
  end platform;

  IComHandlerAction = interface (IAction) 
   ['{6D2FD252-75C5-4F66-90BA-2A7D8CC3039F}']
    function Get_ClassId: WideString safecall;
    procedure Set_ClassId(const pClsid: WideString) safecall;
    function Get_Data: WideString safecall;
    procedure Set_Data(const pData: WideString) safecall;
    property ClassId:WideString read Get_ClassId write Set_ClassId;
    property Data:WideString read Get_Data write Set_Data;
  end;

  IComHandlerActionDisp = dispinterface  
   ['{6D2FD252-75C5-4F66-90BA-2A7D8CC3039F}']
  {published}
    property ClassId: WideString dispid $A;
    property Data: WideString dispid $B;
    property Id: WideString dispid $1;
    property type_: TOleEnum readonly dispid $2;
  end platform;

  IEmailAction = interface (IAction) 
   ['{10F62C64-7E16-4314-A0C2-0C3683F99D40}']
    function Get_Server: WideString safecall;
    procedure Set_Server(const pServer: WideString) safecall;
    function Get_Subject: WideString safecall;
    procedure Set_Subject(const pSubject: WideString) safecall;
    function Get_To_: WideString safecall;
    procedure Set_To_(const pTo: WideString) safecall;
    function Get_Cc: WideString safecall;
    procedure Set_Cc(const pCc: WideString) safecall;
    function Get_Bcc: WideString safecall;
    procedure Set_Bcc(const pBcc: WideString) safecall;
    function Get_ReplyTo: WideString safecall;
    procedure Set_ReplyTo(const pReplyTo: WideString) safecall;
    function Get_From: WideString safecall;
    procedure Set_From(const pFrom: WideString) safecall;
    function Get_HeaderFields: ITaskNamedValueCollection safecall;
    procedure Set_HeaderFields(const ppHeaderFields: ITaskNamedValueCollection)
      safecall;
    function Get_Body: WideString safecall;
    procedure Set_Body(const pBody: WideString) safecall;
    function Get_Attachments: PSafeArray safecall;
    procedure Set_Attachments(pAttachements: PSafeArray) safecall;
    property Server:WideString read Get_Server write Set_Server;
    property Subject:WideString read Get_Subject write Set_Subject;
    property To_:WideString read Get_To_ write Set_To_;
    property Cc:WideString read Get_Cc write Set_Cc;
    property Bcc:WideString read Get_Bcc write Set_Bcc;
    property ReplyTo:WideString read Get_ReplyTo write Set_ReplyTo;
    property From:WideString read Get_From write Set_From;
    property HeaderFields:ITaskNamedValueCollection read Get_HeaderFields
      write Set_HeaderFields;
    property Body:WideString read Get_Body write Set_Body;
    property Attachments:PSafeArray read Get_Attachments
      write Set_Attachments;
  end;

  IEmailActionDisp = dispinterface  
   ['{10F62C64-7E16-4314-A0C2-0C3683F99D40}']
  {published}
    property Server: WideString dispid $A;
    property Subject: WideString dispid $B;
    property To_: WideString dispid $C;
    property Cc: WideString dispid $D;
    property Bcc: WideString dispid $E;
    property ReplyTo: WideString dispid $F;
    property From: WideString dispid $10;
    property HeaderFields: ITaskNamedValueCollection dispid $11;
    property Body: WideString dispid $12;
    property Attachments: OleVariant dispid $13;
    property Id: WideString dispid $1;
    property type_: TOleEnum readonly dispid $2;
  end platform;

implementation

end.


