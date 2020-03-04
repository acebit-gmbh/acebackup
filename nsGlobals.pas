unit nsGlobals;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ActiveX, Winapi.CommCtrl, Winapi.ShellAPI, Winapi.ShlObj,
  System.SysUtils, Vcl.Graphics, IdSMTP, IdSSLOpenSSL, IdExplicitTLSClientServerBase;

{$REGION 'Types'}
type
  HINTERNET = Pointer;

  PSearchRec = ^TSearchRec;
  TFTPSearchRec = record
    Time: integer;
    Size: integer;
    Attr: integer;
    Name: PChar;
    ExcludeAttr: integer;
    FindHandle: HINTERNET;
    FindData: TWin32FindData;
  end;

  TItemDrawRec = record
    Color: COLORREF;
    Style: TFontStyles;
  end;

  TFileAction = (faCopy, faCut, faPaste);
  TCollisionAction = (caOverwrite, caNewFolder, caPreserve);
  TRunMode = (rmNormal, rmScheduled, rmContextMenu);
  TViewLogMode = (vlAll, vlFailed);
  TRootFolder = (rfDesktop, rfNetwork);

  TFTPConnectType = (ftpcDefault, ftpcDirect, ftpcUseProxy);

  PFTPProgressEvent = ^TFTPProgressEvent;
  TFTPProgressEvent = procedure(Current, Total: int64; var AClose: Boolean) of object;

  THashProgress = procedure(CurBlock, TotBlock: integer; var AClose: Boolean) of object;
  TZipProgress = procedure(CurBlock, TotBlock: integer; var AClose: Boolean) of object;

  TAddFilesCallback = function(const ACode: longint; const AMessage: string): longint;
{$ENDREGION}

{$REGION 'Resourcestrings'}
resourcestring
  sAddingToCD = 'Adding files to layout';
  sAceArchive = 'AceBackup Archive';
  sAceBackup = 'AceBackup Backup';
  sActionReplaceFile = 'Replace existing file(s)';
  sActionUpdateFile = 'Update older file(s) only';
  sActionNewVersion = 'Create a new version';
  sAddFolderToProject = 'Add folder to project';
  sAllIn = 'All in %s';
  sAllOfType = 'All of type %s';
  sAnotherTaskRunning = 'Another task with the same name already exists. Specify a different name.';
  sBackupedItem = 'Backup Item';
  sBackupFailed = 'Backup "%s" to "%s": Failed';
  sBackupItem = 'Backup File "%s"';
  sBackupSucceeded = 'Backup "%s" to "%s": Succeeded';
  SCannotAddToProject = 'Cannot add "%s" to the project. The source item is located on the media of project.';
  sCannotConnect = 'Could not connect to the media. Working offline.';
  sCannotCreateDir = 'Could not create directory "%s"';
  sCannotDeleteOpenProject = 'Could not delete the opened project %s';
  sCannotFindDir = 'Cannot find directory "%s"';
  sCannotFindLogFile = 'Cannot find log file "%s"';
  sCannotFindProjFile = 'Cannot find project file "%s"';
  sCannotMangleFile = 'Cannot mangle file name.';
  sCannotMove = 'Could not move the archive to "%s"';
  sCannotOpenFile = 'Could not open file "%s". System response:';
  sCannotOpenProject = 'Cannot open project file "%s".';
  sCannotRename = 'Cannot rename %s: A folder with the name you specified already exists. Specify a different name.';
  sCannotRenameFile = 'Cannot rename %s: A file with the name you specified already exists. Specify a different name.';
  sCannotWriteToDir = 'Could not write to directory "%s"';
  sCaption = '<%s> on %s - AceBackup';
  SCDNotAvailable = 'CD/DVD Media is not accessible.';
  SCDNotWriteable = 'The CD/DVD drive does not support writing';
  sChangePassword = 'Change password';
  sChoiceNo = 'No';
  sChoiceYes = 'Yes';
  sCipherNotInit = 'Cipher is not initialized!';
  sCodeFormatted = '%s (Code %d)';
  sClosing = 'Closing...';
  sCollapse = '&Collapse';
  sCompressing = 'Compressing:';
  sCompression = 'Compression:';
  sCompressNone = 'None';
  sCompressFastest = 'Fastest';
  sCompressDefault = 'Default';
  sCompressMaximum = 'Maximum';
  sConfirm = 'Confirm';
  sConfirmApplyDefAction = 'You have choosen to set the default action on names collision to';
  sConfirmContinue = 'Are you sure you want to continue?';
  sConfirmDeleteItems = 'Are you sure you want to delete all items?';
  sConfirmDeleteVolume = 'All information about %s will be lost. Are you sure you want to continue?';
  sConfirmDeletion = 'Item(s) marked for deletion will be removed from the media. Are you sure you want to continue?';
  sConfirmProjectsDeletion = 'Selected project file(s) will be permanently deleted. Are you sure you want to continue?';
  sConfirmSave = 'The project contains non-processed items. Do you want to save changes?';
  sConfirmWizardExit = 'Do you want to quit the wizard?';
  sConnecting = 'Connecting...';
  sConnectingTo = 'Connecting to remote FTP Server "%s"';
  sContent = 'Content:';
  sCorrupted = 'The project file "%s" is corrupted. If the backup media is available you can use Import Project Wizard to open the project.';
  sCouldNotConnect = 'Could not connect to remote FTP server. Working offline. Error: %s';
  sCouldNotFindDir = 'Could not find directory "%s"';
  sCouldNotMarkForRestore = '%d of the selected file(s) have not backuped yet and could not be restored';
  sCouldNotOpenFile = 'Could not open file "%s". Reason: "%s"';
  sCreateDir = 'Create Folder "%s"';
  sCreateDirConfirm = 'Could not find directory "%s". Do you want to create it?';
  sCustom = 'Custom...';
  sDecompress = 'Decompressing:';
  sDecrypt = 'Decrypting:';
  sDecryption = 'Decrypt File "%s"';
  sDecryptionFailed = '%s: Decryption failed';
  sDeleteVerFailed = 'Deletion "%s" Ver.%d: Failed';
  sDeleteVerSucceeded = 'Deletion "%s" Ver.%d: Succeeded';
  sDeleting = 'Deleting...';
  sDeletionFailed = 'Deletion "%s": Failed';
  sDeletionSucceeded = 'Deletion "%s": Succeeded';
  sDestinationFolder = 'Select destination folder to restore "%s"';
  sDestinationToRestore = 'Select destination folder to restore the selected item(s)';
  sDestinationSelect = 'Select destination directory';
  sDisconnecting = 'Disconnecting...';
  SDiskClosed = 'Disk Closed/Finalized';
  sDuplicateVolumes = '%s already has the same destination. Please specify other destination settings for this volume.';
  sEjectingCD = 'Ejecting disk';
  sEmailTestSend = 'Test E-mail message has been sent to "%s". Please check your inbox in a few minutes.';
  sEmailTestSubject = 'AceBackup Test E-mail Message';
  sEmailTestBody = 'This E-mail message has been automatically sent by WinSurvey 3 to test its connection settings.';
  sEmptyPassword = 'Password cannot be empty!';
  sEncounteredProblems = 'AceBackup has encountered problems during processing the project. Do you want to view the report?';
  sEncrypting = 'Encrypting:';
  sEncryption = 'Encryption:';
  sEncryptionNone = 'No encryption';
  sEncryptionActive = 'Use encryption';
  sEnterValidEmail = 'Please enter a vaild E-mail address.';
  SEraseCD = 'Erasing CD/DVD disk...';
  sError = 'Error';
  sErrorConnecting = 'Error connecting to the server. %s';
  sErrorCreatingDir = 'Could not create directory "%s" %s';
  sErrorExecute = 'Error executing %s!';
  sErrorNewTask = 'Error creating task';
  sErrorOpening = 'Error opening file';
  sErrorRename = 'Cannot rename "%s".';
  sErrorRenaming = 'Error Renaming File or Folder';
  sErrorRenProject = 'Error Renaming Project';
  sErrorsDetected = 'Errors detected';
  sErrorSendingEmail = 'Error sending report by E-mail:';
  sExecutedExternalApp = '"%s" executed.';
  sExecutingExternalApp = 'Executing "%s"...';
  sExecuteAfterProcessAndWait = 'Execute "%s" after processing and wait termination.';
  sExecuteAfterProcessDontWait = 'Execute "%s" after processing and do not wait termination.';
  sExecuteBeforeProcessAndWait = 'Execute "%s" before processing and wait termination.';
  sExecuteBeforeProcessDontWait = 'Execute "%s" before processing and do not wait termination.';
  sExpand = 'E&xpand';
  sFFInfo = '%d Files, %d Folders';
  sFileDeletion = 'Delete File "%s"';
  sFileExists = 'The project folder %s already contains a file named "%s"';
  sFileFormatASIS = 'The file format "AS IS" does not allow storing multiple versions of a file.';
  sFileFound = 'The file named "%s" was found on backup media and added to the Project';
  sFilesProcessed = '%d files/folders have been processed';
  sFinalizingTrack = 'Finalizing session';
  sFinish = '&Finish';
  sFolderDeletion = 'Delete Folder "%s"';
  sFolderFound = 'The folder named "%s" was found on backup media and added to the Project';
  sID_AceBackup = 'http://www.acebackup.com';
  sID_HelloEngines = 'http://www.hello-engines.com';
  sID_HelpFile = 'AceBackup.chm';
  sID_HomePage = 'http://www.acebit.com';
  sID_PasswordDepot = 'http://www.password-depot.com';
  sID_RankingToolbox = 'http://www.ranking-toolbox.com';
  sID_Tutorial = 'tutorial.chm';
  sID_WinSurvey = 'http://www.winsurvey.com';
  sID_WISEFTP = 'http://www.wise-ftp.com';
  sIllegalSymbols = 'Project name cannot contain symbols: \ / ; * ? " < > |';
  sInformation = 'Information';
  sInitCD = 'Initializing Writer';
  SInvalidCD = 'Invalid disk';
  sInvalidFileFormat = 'Invalid File Format';
  SItemsProcessed = '%d item(s) have been succesfully processed. Time elapsed: %s';
  sItemsSelectForDel = '%d file objects are selected for deletion';
  sLoadingCD = 'Loading disk';
  sLocalFileExists = 'The local folder %s already contains a file named "%s"';
  sLogCaption = '%s - Report';
  sLogEnded = '%s - %s - Log ended: %s';
  sLogStarted = '%s - %s - Log started: %s';
  sMaximize = '&Maximize Project View';
  sMediaCD = 'CD/DVD Drive';
  sMediaFTP = 'FTP Server';
  sMediaLocal = 'Local Directory';
  sMediaNAS = 'Network Resource';
  sMediaOffline = 'Media Offline';
  sMediaOnline = 'Media Online';
  sMediaSettings = 'Media Settings';
  sModified = '"modified: "dddddd", "tt';
  sModifiedReplace = '%s Modified: %s';
  sMultipleLocations = 'Multiple locations';
  sMultipleTypes = 'Multiple types';
  sMultiProperties = '%s,... Properties';
  sMustSave = 'You must save the project before applying updates.';
  sNewDetected = 'There is a newer version of "%s" in: %s';
  sNewFolder = 'New folder';
  sNext = '&Next >';
  sNonEmptyRequired = 'You must type a non-empty title.';
  sNoProject = '<No project>';
  sNoProjectFile = 'No project file specified.';
  sNotFoundOnBackUpFile = 'File "%s" was not found on backup media and has been deleted from the project';
  sNotFoundOnBackUpFolder = 'Folder "%s" was not found on backup media and has been deleted from the project';
  sNoValidItems = 'No valid folders or files types found to backup.';
  sOpening = 'Opening...';
  sOperation = 'Operation:';
  sOriginalLocation = 'Original location';
  sPasswordRequired = 'Password required';
  sPasswordsMismatch = 'The passwords you typed do not match. Type new passwords in both text boxes!';
  sPerSec = '/Sec';
  sPrep = 'Preparing to process...';
  sPrepDelete = 'Preparing for deletion...';
  sProcessing = '%s - Processing';
  sProjectFileDontExists = 'Project file "%s" does not exist.';
  sProjectTitle = 'Project Title:';
  sProperties = '%s Properties';
  sRefresh = '%s Synchronizing';
  sReportFrom = '%s - Report from %s';
  sResponse = 'Server response: %s';
  sRestore = '&Restore Project View';
  sRestoreFailed = 'Restoring "%s" to "%s": Failed';
  sRestoreFile = 'Restore File "%s"';
  sRestoreSucceeded = 'Restoring "%s" to "%s": Succeeded';
  sRestoreVerFailed = 'Restore "%s" Ver.%d to %s: Failed';
  sRestoreVerSucceeded = 'Restore "%s" Ver.%d to %s: Succeeded';
  sResult = 'Result:';
  sRoot = '<Root>';
  sSaveProj = 'Do you want to save the project?';
  sSelectFolder = 'Select folder';
  sSelectVolumePath = 'Select path of the volume.';
  sSelectBackupPath = 'Select path to the backup volume.';
  sSelectDefaultLocItem = 'Select default location for this item.';
  sSelectDefaultLocItems = 'Select default location for these items.';
  sSizeOnVolume = 'Size on volume:';
  sSpecifyLocation = 'Some of the selected item(s) have unknown original location and might not be properly restored.' +
    'Please either specify the original location for the item(s) or mark them to restore in alternate location.';
  sStorePasswort = 'Store Password:';
  sSyncronizationNeeded = 'AceBackup has found changes in the backup items. Do you want to start the project backup now?';
  sTaskIsNotScheduled = 'Task not scheduled';
  sTaskRunning = 'The project %s is currently processed as a scheduled task and cannot be opened.';
  stAttributesCol = 'Attributes';
  stDateDeleted = 'Date Deleted';
  sTerminatedExternalApp = '"%s" terminated.';
  sTerminatingCD = 'Terminating session';
  STestWrite = 'AceBackup will perform a test write to CD. Please insert a writeable CD to "%s" and click OK.';
  stFile = 'File';
  stFileFolder = 'File Folder';
  stModifiedCol = 'Modified';
  stNameCol = 'Name';
  stOriginalLoc = 'Original Location';
  sTaskNotScheduled = 'Task not scheduled.';
  sTransfer = 'Transferring:';
  stSizeCol = 'Size';
  stSystemFolder = 'System Folder';
  stTypeCol = 'Type';
  sUnknown = '<Unknown>';
  sUnsaved = '<Unsaved>';
  sUserOrPassIsEmpty = 'Your user name and/or password is empty.';
  sVerifiyng = 'Verifiyng archive folder "%s"';
  sVerifyCD = 'Verifying CD/DVD Drive';
  sVerifyFile = 'Verifiyng File "%s"';
  sVerifyFolder = 'Verifiyng Folder "%s"';
  sVolCoincident = 'Volumes are coincident';
  sVolIndependent = 'Volumes are independent';
  sVolume = 'Volume #%d';
  sWait = 'Please wait...';
  sWarning = 'Warning';
  sWarningBIG = 'WARNING!';
  sWriteToCD = 'Writing to disk';
  sWritingToCD = 'Writing to %s. Please wait...';
  sWrongPassword = 'The password you entered is invalid. The project cannot be opened.';
{$ENDREGION}

{$REGION 'Stringarrays'}
const
  sNone: string = '';

  sNo: string = sChoiceNo;
  sYes: string = sChoiceYes;

  YesNoNames: array[Boolean] of PString =
    (@sNo, @sYes);

// EncryptionMethod
type
  TEncryptionMethod = (tmNone, tmRC4);

const
  sNoneEnc: string = sEncryptionNone;
  sRC4Enc: string = sEncryptionActive;

  Encryptions: array[TEncryptionMethod] of PString =
    (@sNoneEnc, @sRC4Enc);

// BackupMedia
type
  TBackupMedia = (bmLocal, bmFTP, bmCD, bmNAS);

const
  sLocal: string = sMediaLocal;
  sFTP: string = sMediaFTP;
  sCD: string = sMediaCD;
  sNAS: string = sMediaNAS;

  BackupMediaNames: array[TBackupMedia] of PString =
    (@sLocal, @sFTP, @sCD, @sNAS);

// DefaultActions
type
  TDefaultAction = (daReplace, daUpdate, daNewVersion);

const
  sReplaceFile: string = sActionReplaceFile;
  sUpdateFile: string = sActionUpdateFile;
  sNewVersion: string = sActionNewVersion;

  ActionNames: array[TDefaultAction] of PString =
    (@sReplaceFile, @sUpdateFile, @sNewVersion);

// CompressionLevel
type
  TCompressionLevel = (clCompNone, clCompFastest, clCompDefault, clCompMaximum);

const
  sNoCompression: string = sCompressNone;
  sFastestCompression: string = sCompressFastest;
  sDefaultCompression: string = sCompressDefault;
  sMaximumCompression: string = sCompressMaximum;

  CompressionNames: array[TCompressionLevel] of PString =
    (@sNoCompression, @sFastestCompression, @sDefaultCompression, @sMaximumCompression);

// ProjectKinds
type
  TProjectKind = (pkArchive, pkBackup);

const
  sArchive: string = sAceArchive;
  sBackup: string = sAceBackup;

  ProjectKindNames: array[TProjectKind] of PString =
    (@sArchive, @sBackup);

// SyncModes
type
  TSyncMode = (smIndependent, smSynchronized);

const
  sIndependent: string = sVolCoincident;
  sCoincident: string  = sVolIndependent;

  SyncModeNames: array[TSyncMode] of PString = (@sIndependent, @sCoincident);

{$ENDREGION}

{$REGION 'Integer-Consts'}
const
  ZCompressionNone    = 0;
  ZCompressionFastest = 1;
  ZCompressionDefault = 2;
  ZCompressionMax     = 3;

  SHGFI_FOLDER     = SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES;
  SHGFI_FOLDEROPEN = SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or SHGFI_OPENICON;

  WM_SCHEDULEDPROCESS = WM_USER + $0133;
  WM_ACTIVATEINSTANCE = WM_USER + $1456;

  SID_FACE_AB3 = $ACEBAC02;
  SID_FACE     = $ACEBAC0F;

  SID_ENCRYPTION_NONE = $00;
  SID_RIJNDAEL_128    = $01;
  SID_RIJNDAEL_192    = $02;
  SID_RIJNDAEL_256    = $03;
  SID_BLOWFISH        = $04;
  SID_TRIPLEDES       = $05;

  SID_COMPRESSION_NONE    = $00;
  SID_COMPRESSION_FASTEST = $01;
  SID_COMPRESSION_DEFAULT = $02;
  SID_COMPRESSION_MAX     = $03;

  NSN_FLUSHNOWAIT = $00000001;
  NSN_FLUSH       = $00000002;

  NSN_RENAMEPROJECT = WM_USER + $0601;
  NSN_CREATEPROJECT = WM_USER + $0602;
  NSN_REMOVEPROJECT = WM_USER + $0603;
  NSN_UPDATEPROJECT = WM_USER + $0604;

  NSN_RENAMEFOLDER = WM_USER + $0701;
  NSN_CREATEFOLDER = WM_USER + $0702;
  NSN_REMOVEFOLDER = WM_USER + $0703;
  NSN_UPDATEFOLDER = WM_USER + $0704;

  NSN_RENAMEITEM = WM_USER + $0801;
  NSN_CREATEITEM = WM_USER + $0802;
  NSN_REMOVEITEM = WM_USER + $0803;
  NSN_UPDATEITEM = WM_USER + $0804;

  NSN_STATUSCHANGED = WM_USER + $0900;

  CMD_OK        = 0;
  CMD_STARTSCAN = $1000;
  CMD_ABORT     = $1001;
  CMD_ENDSCAN   = $1002;
  CMD_UPDATE    = $1003;
  CMD_CONTINUE  = $1004;
{$ENDREGION}

{$REGION 'String-Consts'}
const
  REG_ROOT  = '\Software\AceBIT\AceBackup 3\';
  REG_FORMS = REG_ROOT + 'Forms\';
  REG_MAIN = 'Main';
  REG_VAL_MRU = 'MRU';
  REG_VAL_STATUSBAR = 'StatusBar';
  REG_VAL_STARTFOLDER = 'StartFolder';

  REG_KEY_LASTVALUES = 'LastValues';
  REG_VAL_KNOWNNEXT = 'KnownExtensions';


  sRemoteFileName = 'nsFolder.dat';
  sDefaultFolder = 'C:\';
  sArchives  = 'Archives';
  sNsz       = '.nsz.';
  sMsz       = '.msz.';
  sNsa       = '.nsa';
  sNsb       = '.nsb';
  sLog       = '.log';
  sBak       = '.bac';
  sCmp       = '.cmp';
  sUpdate    = ' -update ';
  sFileMask  = '*.*';
  sDot       = '.';
  sDoubleDot = '..';
  sColon     = ':';
  sINS       = 'INS';
  sTempPre   = 'nsp';
  nscPrefix  = '_nsc_';
  nsdPrefix  = '_nsd_';
  sDrive     = ':\';
  sMachine   = '\\';
  sBackslash = '\';
  sSlash     = '/';

  SConnectedSound = 'AceBackup_ConnectedToMedia';
  SProjectClosedSound = 'AceBackup_ProjectClosed';
  SProcessStartSound = 'AceBackup_ProcessStart';
  SProcessCompletedSound = 'AceBackup_ProcessCompleted';
  SStartupSound = 'AceBackup_StartUp';
  SExitSound = 'AceBackup_Exit';

  STmpFolder = 'AceTmp.Dir';
  STmpISO    = 'AceBackup.iso';
  PROJECT_SUFFIX = 'BCK%d';

  AVI_PROCESS = 'AVI_PROCESS';

  pOpen: PChar = 'open';

  IllegalSymbols: set of AnsiChar = ['\', '/', ':', '*', '?', '"', '<', '>', '|'];
{$ENDREGION}

{$REGION 'Empty Variables'}
var
  g_RunMode:      TRunMode = rmNormal;
  g_hmShell:      HMODULE = 0;
  g_himlSmall:    HIMAGELIST = 0;
  g_himlLarge:    HIMAGELIST = 0;
  g_himlSysSmall: HIMAGELIST = 0;
  g_hiRoot:       integer = 0;
  g_hiFolder:     integer = 0;
  g_hiFolderOpen: integer = 0;

  g_ProxyName:   string = '';
  g_ProxyPort:   string = '';
  g_ConnectType: TFTPConnectType = ftpcDefault;

  g_dwLastError: DWORD = 0;

  IML_NORMAL:  integer = -1;
  IML_BACKUP:  integer = -1;
  IML_RESTORE: integer = -1;
  IML_DELETE:  integer = -1;

  g_LastSelDir: string;

  g_LastMedia:       integer;
  g_LastServer:      string;
  g_LastUserName:    string;
  g_LastHostDir:     string;
  g_LastlocalFolder: string;
  g_LastNetPath:     string;

  g_TempDir:     string;
  g_ProjectsDir: string;
  g_LogDir:      string;
  g_WorkingDir:  string;

  g_LastCollisionAction: TCollisionAction;

  g_DontAskCollision: Boolean;
  g_AutoRefresh:      Boolean;
  g_AbortRefresh:     Boolean;

  g_RecipEMail: string;
  g_RecipName:  string;

  g_SenderEMail: string;
  g_SenderName:  string;

  g_SMTPServer: string;
  g_SMTPPort: integer = 25;
  g_SMTPAccount: string;
  g_SMTPPassword: string;
  g_AuthenticationType: TIdSMTPAuthenticationType;
  g_UseSSL: Boolean = False;
  g_UseTLS: TIdUseTLS;

  g_PlaySounds: Boolean = True;

  g_LastExe1: string = '';
  g_LastExe2: string = '';
  g_WaitExe1: Boolean = False;
  g_WaitExe2: Boolean = False;

  g_DefaultBackupLast:    Boolean = True;
  g_DefaultBackupDefined: Boolean = False;
  g_DefaultBackupMedia:   integer = 0;
  g_DefaultLocalFolder:   string = '';

  g_DefaultHostName:    string = '';
  g_DefaultPort:        string = '21';
  g_DefaultUserName:    string = 'anonymous';
  g_DefaultPassword:    string = '';
  g_DefaultHostDirName: string = '\';
  g_DefaultUsePassive:  Boolean = True;

  g_Passive: Boolean;

  g_DefaultAutoDial:          Boolean = False;
  g_DefaultHangUpOnCompleted: Boolean = False;
  g_ProcessImmediately:       Boolean = True;

  g_Encryption:  TEncryptionMethod;
  g_ViewLogMode: TViewLogMode = vlAll;

  g_AbortScan:    Boolean = False;
  g_AbortProcess: Boolean = False;

  g_ActivationCode: string;
  g_LastTheme:      integer = 4;

  g_EraseCD: Boolean = True;
  g_ReadSpeed:  integer = 100;
  g_WriteSpeed: integer = 100;
  g_ShowHidden: Boolean = True;
  g_SSLVersion: TIdSSLVersion = sslvTLSv1;

  g_drNormal: TItemDrawRec = (Color: clBlack; Style: []);
  g_drDelete: TItemDrawRec = (Color: clGray; Style: [fsBold]);
  g_drRestore: TItemDrawRec = (Color: clGreen; Style: [fsBold]);
  g_drBackup: TItemDrawRec = (Color: clNavy; Style: [fsBold]);


var
  CF_NSINTERNAL: TClipFormat = 0;
  CF_IDLIST:     TClipFormat = 0;

  CF_HDROP_FormatEtc:      TFormatEtc;
  CF_NSINTERNAL_FormatEtc: TFormatEtc;
  CF_IDLIST_FormatEtc:     TFormatEtc;

var
  lpBuffer: array[0..MAX_PATH] of char;
{$ENDREGION}

implementation

initialization
  CF_NSINTERNAL := RegisterClipBoardFormat('AceBackup Internal Clipboard Format');
  CF_IDLIST := RegisterClipBoardFormat(CFSTR_SHELLIDLIST);

  with CF_HDROP_FormatEtc do
  begin
    cfFormat := CF_HDROP;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;

  with CF_NSINTERNAL_FormatEtc do
  begin
    cfFormat := CF_NSINTERNAL;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;

  with CF_IDLIST_FormatEtc do
  begin
    cfFormat := CF_IDLIST;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;

  GetTempPath(MAX_PATH, lpBuffer);
  g_TempDir := string(lpBuffer);
  try
    if SHGetSpecialFolderPath(0, lpBuffer, CSIDL_PERSONAL, True) then
    begin
      g_WorkingDir := StrPas(lpBuffer) + '\AceBackup 3\';
      g_ProjectsDir := StrPas(lpBuffer) + '\AceBackup 3\Projects\';
      g_LogDir := StrPas(lpBuffer) + '\AceBackup 3\Reports\';
      g_DefaultLocalFolder := StrPas(lpBuffer) + '\AceBackup 3\Backups\';
    end;
  except
    g_WorkingDir := EmptyStr;
    g_ProjectsDir := EmptyStr;
    g_LogDir := EmptyStr;
  end;

  if (g_ProjectsDir = EmptyStr) or (g_LogDir = EmptyStr) or (g_WorkingDir = EmptyStr) then
  begin
{$IFNDEF LITE}
    GetModuleFileName(hInstance, lpBuffer, MAX_PATH);
    g_WorkingDir := ExtractFilePath(string(lpBuffer));
    g_ProjectsDir := ExtractFilePath(string(lpBuffer)) + 'Projects\';
    g_LogDir := ExtractFilePath(string(lpBuffer)) + 'Reports\';
{$ELSE}
    TipsDir := ExtractFilePath(string(lpBuffer));
    ProjDir := ExtractFilePath(string(lpBuffer)) + 'Projects\';
    LogDir := IncludeTrailingPathDelimiter(tmpDir) + 'Reports\';
{$ENDIF}
  end;

end.

