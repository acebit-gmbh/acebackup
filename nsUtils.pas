unit nsUtils;

interface

uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShellAPI, CommCtrl, Registry, ShlObj, ActiveX,
  WinSvc, nsGlobals, nsTypes, IdSMTP, IdExplicitTLSClientServerBase, MMSystem,
  nsCrypt, Math, TypInfo, IdSSLOpenSSL, FileCtrl, SysUtils;

procedure SetFileModifiedTime(const AFileName: string; const ADateTime: TDateTime);

function MangleFileName(const AFileName: string): string;
function IntToFontStyle(AValue: integer): TFontStyles;
function FontStyleToInt(AStyle: TFontStyles): integer;

function GetLastLocalResponse: string;
function FolderExists(const Directory: string): Boolean;

function FindTreeNode(ATreeView: TTreeView; AData: Pointer): TTreeNode;
function FindListItem(AListView: TListView; AData: TNSItem): TListItem;

procedure SaveSettings;
procedure RestoreSettings;
procedure SaveFormSettings(AForm: TForm);
procedure RestoreFormSettings(AForm: TForm);

procedure GetDefaultProxySettings(var ProxyServer, ProxyPort: string);

procedure CreateImageLists;
procedure DestroyImageLists;

procedure NSChangeNotify(hWndSender: HWnd; uMsg: DWORD; dwFlags: DWORD; ANSCollection: TNSCollection;
  ANSItem: TNSItem);

function FormatSize(const ASize: int64; AExactSize: Boolean): string;

procedure PlaySoundEvent(const AEventLabel: string);

function ExecWait(const Cmd: string; const ATimeOut: integer): integer;
procedure ExecuteApp(const Cmd: string);

procedure WriteAppPathToRegistry;

function CopyFileRaw(lpSrcName: PChar; lpDstName: PChar; lpProgressRoutine: TFNProgressRoutine;
  lpData: Pointer; pbCancel: PBool; dwCopyFlags: DWORD): Boolean;
function ConnectToNAS(const AWnd: HWND; const ANetPath, AUserName, APassword: string;
  var AConnection: string): Boolean;
procedure DisconnectNAS(const AConnection: string);
function IsValidEmail(email: string): Boolean;

function GetDrives: string;
function GetCDDrives: string;

function FileGetSize(const AFileName: string): int64; overload;
function FileGetSize(const ASR: TSearchRec): int64; overload;
function FileGetSize(const ASR: TFTPSearchRec): int64; overload;

function FileGetModified(const ASR: TSearchRec): TDateTime; overload;

function FileGetModified(const ASR: TFTPSearchRec): TDateTime; overload;

function TicksToTime(const ATicks: cardinal): string;
procedure UpdateVistaFonts(const AForm: TCustomForm);

function SelectDir(const Caption: string; var Directory: string; Root: TRootFolder = rfDesktop;
  Options: TSelectDirExtOpts = [sdNewFolder]): Boolean;

implementation

const
  PrivateKey3 = '@vTjmrl)8#4bdrf_988uyhUTbhjbh_cvzx&*5l';

  // 29.04.2004
  // New Table to allow some additional symbols in filenames

  HashTable: array[Ansichar] of Ansichar = (
    #0, #8, #7, #23, #6, #124, #4, #2, #1, #10, #9, #26, #14, #34, #12, #22, #25,
    #17, #24, #20, #19, #31, #15, #3, #18, #16, #11, #30, #29, #28, #27, #21, #69,
    #169, #13, #167, #91, #181, #146, #61, #148, #242, #42, #194, #137, #138, #88, #47, #109,
    #85, #120, #115, #114, #102, #121, #83, #87, #105, #180, #147, #60, #39, #62, #63, #96,
    #89, #70, #110, #118, #32, #66, #81, #95, #76, #108, #79, #73, #77, #90, #75, #113,
    #71, #97, #55, #101, #49, #106, #56, #46, #65, #78, #36, #92, #93, #247, #72, #64,
    #82, #112, #104, #119, #84, #53, #103, #99, #57, #86, #122, #74, #48, #67, #116, #98,
    #80, #52, #51, #111, #117, #68, #100, #50, #54, #107, #125, #5, #123, #252, #214, #170,
    #153, #177, #143, #196, #240, #249, #182, #176, #44, #45, #139, #164, #154, #204, #131, #202,
    #210, #38, #59, #40, #152, #155, #151, #149, #129, #141, #150, #163, #171, #190, #217, #185,
    #243, #213, #156, #140, #187, #168, #35, #166, #33, #128, #157, #183, #253, #238, #175, #136,
    #130, #207, #179, #58, #37, #135, #172, #241, #160, #186, #165, #239, #237, #158, #244, #198,
    #193, #43, #224, #132, #255, #192, #209, #200, #215, #144, #230, #142, #208, #232, #178, #205,
    #199, #145, #219, #212, #162, #127, #201, #223, #159, #222, #211, #231, #251, #218, #216, #195,
    #233, #250, #245, #228, #254, #203, #220, #206, #225, #235, #234, #246, #189, #174, #188, #133,
    #184, #41, #161, #191, #227, #236, #94, #248, #134, #226, #221, #126, #173, #229, #197);


procedure SetFileModifiedTime(const AFileName: string; const ADateTime: TDateTime);
var
  hFile: integer;
  lpSystemTime: TSystemTime;
  lpFileTime: TFileTime;
  lpLocalFileTime: TFileTime;
begin
  hFile := FileOpen(AFileName, fmOpenReadWrite or fmShareDenyWrite);
  if hFile <> -1 then
    try
      DateTimeToSystemTime(ADateTime, lpSystemTime);
      SystemTimeToFileTime(lpSystemTime, lpLocalFileTime);
      LocalFileTimeToFileTime(lpLocalFileTime, lpFileTime);
      SetFileTime(hFile, @lpFileTime, nil, @lpFileTime);
    finally
      FileClose(hFile);
    end;
end;

function MangleFileName(const AFileName: string): string;
var
  Ansi: AnsiString;
  Extn: String;
  Index: integer;
begin
  Result := AFileName;
  Extn := ExtractFileExt(Result);
  if Extn <> EmptyStr then
    SetLength(Result, Length(Result) - Length(Extn));
  Ansi := AnsiString(Result);
  for Index := 1 to Length(Ansi) do
    Ansi[Index] := HashTable[Ansi[Index]];
  Result := String(Ansi) + Extn;
end;

function FontStyleToInt(AStyle: TFontStyles): integer;
var
  fs: TFontStyle;
begin
  Result := 0;
  for fs := Low(TFontStyle) to High(TFontStyle) do
    if fs in AStyle then
      Result := Result or (1 shl Ord(fs));
end;

function IntToFontStyle(AValue: integer): TFontStyles;
var
  fs: TFontStyle;
begin
  Result := [];
  for fs := Low(TFontStyle) to High(TFontStyle) do
    if ((1 shl Ord(fs)) and AValue <> 0) then
      Result := Result + [fs];
end;

procedure GetDefaultProxySettings(var ProxyServer, ProxyPort: string);
var
  usep: Boolean;
  S: string;
begin
  usep := False;
  ProxyPort := EmptyStr;
  ProxyServer := EmptyStr;
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', False) then
      begin

        if ValueExists('ProxyEnable') then
          usep := boolean(ReadInteger('ProxyEnable'));

        if usep then
        begin
          if ValueExists('ProxyServer') then
            S := ReadString('ProxyServer');
          if AnsiPos('ftp', S) > 0 then
          begin
            S := Copy(S, AnsiPos('ftp', S) + 4, MaxInt);
            if AnsiPos(sColon, S) > 0 then
            begin
              ProxyServer := Copy(S, 1, AnsiPos(sColon, S) - 1);
              Delete(S, 1, AnsiPos(sColon, S));
            end;
            if AnsiPos(';', S) > 0 then
              ProxyPort := Copy(S, 1, AnsiPos(';', S) - 1)
            else
              ProxyPort := S;
          end;
        end
        else
        begin
          ProxyPort := '';
          ProxyServer := '';
        end;

        CloseKey;
      end;
    finally
      Free;
    end;
end;

procedure NSChangeNotify(hWndSender: HWnd; uMsg: DWORD; dwFlags: DWORD; ANSCollection: TNSCollection;
  ANSItem: TNSItem);
var
  I: integer;
begin
  if (NSN_FLUSH and dwFlags <> 0) then
  begin
    for I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I].Handle <> hWndSender then
        SendMessage(
          Screen.Forms[I].Handle,
          uMsg,
          WParam(ANSCollection),
          LParam(ANSItem)
          );
  end
  else
  begin
    for I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I].Handle <> hWndSender then
        PostMessage(
          Screen.Forms[I].Handle,
          uMsg,
          WParam(ANSCollection),
          LParam(ANSItem)
          );
  end;
end;

function FindTreeNode(ATreeView: TTreeView; AData: Pointer): TTreeNode;
var
  Current: TTreeNode;
begin
  Result  := nil;
  Current := ATreeView.Items.GetFirstNode;
  while Current <> nil do
    if Current.Data = AData then
    begin
      Result := Current;
      Exit;
    end
    else
      Current := Current.GetNext;
end;

function FindListItem(AListView: TListView; AData: TNSItem): TListItem;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to AListView.Items.Count - 1 do
    if AData = AListView.Items[I].Data then
    begin
      Result := AListView.Items[I];
      Break;
    end;
end;

function FormatSize(const ASize: int64; AExactSize: Boolean): string;
const
  gigs = 1024*1024*1024;
  megs = 1024*1024;
  kils = 1024;
begin
  if ASize > gigs then
      Result := FloatToStrF(ASize / gigs, ffFixed, 15, 2) + ' GB'
  else if ASize > megs then
      Result := FloatToStrF(ASize / megs, ffFixed, 15, 2) + ' MB'
  else if ASize > kils then
      Result := FloatToStrF(ASize / kils, ffFixed, 15, 2) + ' KB'
  else
      Result := IntToStr(ASize) + ' bytes';

  if AExactSize and (ASize > kils) then
    Result := Result + ' (' + IntToStr(ASize) + ' bytes)';
end;

{var
  FileInfo: TSHFileInfo;
}

procedure CreateImageLists;
var
  cx, cy: integer;
  Icon: HICON;
  FileInfo: TSHFileInfo;
begin
  // Small icons
  cx := GetSystemMetrics(SM_CXSMICON);
  cy := GetSystemMetrics(SM_CYSMICON);

  g_hmShell := GetModuleHandle(PChar('Shell32.dll'));
  if g_hmShell = 0 then
    Exit;

  {  SHGetFileInfo(PChar(Application.ExeName), FILE_ATTRIBUTE_NORMAL, FileInfo, SizeOf(FileInfo),
        SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_ICON);
    g_hiRoot := FileInfo.iIcon;
    SHGetFileInfo(PChar(ACollection[i].DisplayName), FILE_ATTRIBUTE_DIRECTORY, FileInfo, SizeOf(FileInfo),
      SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_ICON or
      SHGFI_USEFILEATTRIBUTES);
    g_hiFolder := FileInfo.iIcon;
          SHGetFileInfo(PChar(ACollection[i].DisplayName), FILE_ATTRIBUTE_DIRECTORY, FileInfo, SizeOf(FileInfo),
            SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_OPENICON or
            SHGFI_USEFILEATTRIBUTES or SHGFI_DISPLAYNAME);
          Node.SelectedIndex := FileInfo.iIcon;
   g_hiFolderOpen := FileInfo.iIcon;
   }

  if g_himlSmall <> 0 then
    ImageList_Destroy(g_himlSmall);

  g_himlSmall := ImageList_Create(cx, cy, ILC_COLOR32 or ILC_MASK, 8, 0);

  if g_himlSmall = 0 then
    Exit;

  Icon := LoadImage(hInstance, PChar('MAINICON'), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  ImageList_AddIcon(g_himlSmall, Icon);
  DestroyIcon(Icon);

  Icon := LoadImage(g_hmShell, PChar(4), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  ImageList_AddIcon(g_himlSmall, Icon);
  DestroyIcon(Icon);

  Icon := LoadImage(g_hmShell, PChar(5), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  ImageList_AddIcon(g_himlSmall, Icon);
  DestroyIcon(Icon);

  //  g_himDriveConnected := LoadImage(g_hmShell, PChar(10), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  //  g_himDriveNotConnected := LoadImage(g_hmShell, PChar(11), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);

  (*
  hShDoc := LoadLibrary('shdocvw.dll');
  if hShDoc <> 0 then
  begin
    g_himLock := LoadImage(hShDoc, PChar(103), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
    FreeLibrary(hShDoc);
  end;
  *)

  // System Image List Small

  FillChar(FileInfo, SizeOf(FileInfo), #0);
  g_himlSysSmall := SHGetFileInfo('C:\', 0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

  // Large icons

  cx := GetSystemMetrics(SM_CXICON);
  cy := GetSystemMetrics(SM_CYICON);

  if g_himlLarge <> 0 then
    ImageList_Destroy(g_himlLarge);

  g_himlLarge := ImageList_Create(cx, cy, ILC_COLOR32 or ILC_MASK, 8, 0);
  if g_himlLarge = 0 then
    Exit;

  Icon := LoadImage(hInstance, PChar('MAINICON'), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  ImageList_AddIcon(g_himlLarge, Icon);
  DestroyIcon(Icon);

  Icon := LoadImage(g_hmShell, PChar(4), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  ImageList_AddIcon(g_himlLarge, Icon);
  DestroyIcon(Icon);

  Icon := LoadImage(g_hmShell, PChar(5), IMAGE_ICON, cx, cy, LR_DEFAULTCOLOR);
  ImageList_AddIcon(g_himlLarge, Icon);
  DestroyIcon(Icon);

end;

procedure DestroyImageLists;
begin
  if g_himlSmall <> 0 then
    ImageList_Destroy(g_himlSmall);
  if g_himlLarge <> 0 then
    ImageList_Destroy(g_himlLarge);
  //  if g_himlSysSmall <> 0 then ImageList_Destroy(g_himlSysSmall);
  //  DestroyIcon(g_himDriveNotConnected);
  //  DestroyIcon(g_himDriveConnected);
  //  DestroyIcon(g_himLock);
  FreeLibrary(g_hmShell);
end;

procedure RestoreSettings;
const
  Section1: string = 'Settings';
  Section2: string = 'LastValues';
var
  Hash: string;
begin
  with TRegIniFile.Create(REG_ROOT) do
    try
      GetDefaultProxySettings(g_ProxyName, g_ProxyPort);
      g_ConnectType := TFTPConnectType(ReadInteger(Section1, 'ConnectionType', 0));
      if g_ConnectType = ftpcUseProxy then
      begin
        g_ProxyName := ReadString(Section1, 'ProxyServer', g_ProxyName);
        g_ProxyPort := ReadString(Section1, 'ProxyPort', g_ProxyPort);
      end;
      g_drNormal.Color  := COLORREF(ReadInteger(Section1, 'NormalColor', clBlack));
      g_drNormal.Style  := IntToFontStyle(ReadInteger(Section1, 'NormalStyle', 0));
      g_drBackup.Color  := COLORREF(ReadInteger(Section1, 'BackupColor', clNavy));
      g_drBackup.Style  := IntToFontStyle(ReadInteger(Section1, 'BackupStyle', 1));
      g_drRestore.Color := COLORREF(ReadInteger(Section1, 'RestoreColor', clGreen));
      g_drRestore.Style := IntToFontStyle(ReadInteger(Section1, 'RestoreStyle', 1));
      //      g_drDelete.Color  := COLORREF(ReadInteger(Section1, 'DeleteColor', clGray));
      //      g_drDelete.Style  := IntToFontStyle(ReadInteger(Section1, 'DeleteStyle', 1));

      //    g_LargeIcons := ReadBool(Section1, 'LargeIcons', True);
      //    g_NoTextLabels := ReadBool(Section1, 'NoTextLabels', False);
      //      g_CollisionFolder := ReadString(Section1, 'CollisionFolder', 'Collision');

      g_LastSelDir := ReadString(Section2, 'LastRestoreDirectory', EmptyStr);
      g_LastMedia  := ReadInteger(Section2, 'LastMedia', 0);
      g_LastServer := ReadString(Section2, 'LastServer', EmptyStr);
      g_LastUserName := ReadString(Section2, 'LastUserName', EmptyStr);
      g_LastHostDir := ReadString(Section2, 'LastHostDir', EmptyStr);
      g_LastLocalFolder := ReadString(Section2, 'LastLocalFolder', g_LastLocalFolder);
      if not DirectoryExists(g_LastLocalFolder) then
        g_LastLocalFolder := IncludeTrailingPathDelimiter(g_WorkingDir) + 'Backups';

      g_LastNetPath := ReadString(Section2, 'LastNetPath', EmptyStr);

      g_LastCollisionAction := TCollisionAction(ReadInteger(Section2, 'LastCollisionAction', 0));
      g_DontAskCollision := ReadBool(Section1, 'DontAskCollision', False);

      g_RecipEMail := ReadString(Section1, 'RecipEMail', g_RecipEMail);
      g_RecipName  := ReadString(Section1, 'RecipName', g_RecipName);

      g_SenderEMail := ReadString(Section1, 'SenderEMail', g_SenderEMail);
      g_SenderName  := ReadString(Section1, 'SenderName', Application.Title);

      g_SMTPServer := ReadString(Section1, 'SMTPServer', EmptyStr);
      g_SMTPPort := ReadInteger(Section1, 'SMTPPort', 25);
      g_SMTPAccount := ReadString(Section1, 'SMTPAccount', EmptyStr);
      g_AuthenticationType := TIdSMTPAuthenticationType(ReadInteger(Section1, 'SMTPAuthentication', 0));
      g_UseSSL := ReadBool(Section1, 'UseSSL', g_UseSSL);
      g_UseTLS := TIdUseTLS(ReadInteger(Section1, 'UseTLS', 0));

      Hash := ReadString(Section1, 'SMTPPwd4', EmptyStr);
      g_SMTPPassword := TWinCrypt.CryptText(Hash, PrivateKey3, False);

      g_PlaySounds := ReadBool(Section1, 'PlaySounds', g_PlaySounds);

      g_LastExe1 := ReadString(Section2, 'LastExternalExe1', g_LastExe1);
      g_LastExe2 := ReadString(Section2, 'LastExternalExe2', g_LastExe2);
      g_WaitExe1 := ReadBool(Section2, 'WaitExternalExe1', g_WaitExe1);
      g_WaitExe2 := ReadBool(Section2, 'WaitExternalExe2', g_WaitExe2);

      g_DefaultBackupLast  := ReadBool(Section1, 'DefaultBackupLast', g_DefaultBackupLast);
      g_DefaultBackupDefined := ReadBool(Section1, 'DefaultBackupDefined', g_DefaultBackupDefined);
      g_DefaultBackupMedia := ReadInteger(Section1, 'DefaultBackupMedia', g_DefaultBackupMedia);

      g_DefaultLocalFolder := ReadString(Section1, 'DefaultLocalFolder', g_DefaultLocalFolder);
      if not DirectoryExists(g_DefaultLocalFolder) then
        g_DefaultLocalFolder := IncludeTrailingPathDelimiter(g_WorkingDir) + 'Backups\';
      ForceDirectories(g_DefaultLocalFolder);

      g_DefaultHostName := ReadString(Section1, 'DefaultHostName', g_DefaultHostName);

      g_DefaultPort := ReadString(Section1, 'DefaultPort', g_DefaultPort);
      g_DefaultUserName := ReadString(Section1, 'DefaultUserName', g_DefaultUserName);

      Hash := ReadString(Section1, 'DefaultPassword4', EmptyStr);
      g_DefaultPassword := TWinCrypt.CryptText(Hash, PrivateKey3, False);

      g_DefaultHostDirName := ReadString(Section1, 'DefaultHostDirName', g_DefaultHostDirName);
      g_DefaultUsePassive  := ReadBool(Section1, 'DefaultUsePassive', g_DefaultUsePassive);

      g_DefaultHangUpOnCompleted := ReadBool(Section1, 'DefaultHangUpOnCompleted', g_DefaultHangUpOnCompleted);
      g_ProcessImmediately := ReadBool(Section1, 'ProcessImmediately', g_ProcessImmediately);

      g_ViewLogMode := TViewLogMode(ReadInteger(Section1, 'ViewLogMode', 0));
      g_ActivationCode := ReadString(Section1, 'ActivationCode', '');

      g_LastTheme := ReadInteger(Section1, 'Theme', g_LastTheme);

      g_ProjectsDir := ReadString(Section1, 'ProjDir', g_ProjectsDir);
      g_LogDir := ReadString(Section1, 'LogDir', g_LogDir);

      g_ReadSpeed  := ReadInteger(Section1, 'ReadSpeed', g_ReadSpeed);
      g_WriteSpeed := ReadInteger(Section1, 'WriteSpeed', g_WriteSpeed);
      g_ShowHidden := ReadBool(Section1, 'ShowHidden', g_ShowHidden);

      g_SSLVersion := TidSSLVersion(ReadInteger(Section1, 'SSLVersion', Ord(g_SSLVersion)));

    finally
      Free;
    end;
end;

procedure SaveSettings;
const
  Section1: string = 'Settings';
  Section2: string = 'LastValues';
var
  Hash: string;
begin
  with TRegIniFile.Create(REG_ROOT) do
    try
      WriteInteger(Section1, 'ConnectionType', Ord(g_ConnectType));
      if g_ConnectType = ftpcUseProxy then
      begin
        WriteString(Section1, 'ProxyServer', g_ProxyName);
        WriteString(Section1, 'ProxyPort', g_ProxyPort);
      end;
      WriteInteger(Section1, 'NormalColor', g_drNormal.Color);
      WriteInteger(Section1, 'NormalStyle', FontStyleToInt(g_drNormal.Style));
      WriteInteger(Section1, 'RestoreColor', g_drRestore.Color);
      WriteInteger(Section1, 'RestoreStyle', FontStyleToInt(g_drRestore.Style));
      WriteInteger(Section1, 'BackupColor', g_drBackup.Color);
      WriteInteger(Section1, 'BackupStyle', FontStyleToInt(g_drBackup.Style));
      //      WriteInteger(Section1, 'DeleteColor', g_drDelete.Color);
      //      WriteInteger(Section1, 'DeleteStyle', FontStyleToInt(g_drDelete.Style));

      //    WriteBool(Section1, 'LargeIcons', g_LargeIcons);
      //    WriteBool(Section1, 'NoTextLabels', g_NoTextLabels);
      WriteBool(Section1, 'DontAskCollision', g_DontAskCollision);
      //      WriteString(Section1, 'CollisionFolder', g_CollisionFolder);

      WriteString(Section2, 'LastRestoreDirectory', g_LastSelDir);
      WriteInteger(Section2, 'LastMedia', g_LastMedia);
      WriteString(Section2, 'LastServer', g_LastServer);
      WriteString(Section2, 'LastUserName', g_LastUserName);
      WriteString(Section2, 'LastHostDir', g_LastHostDir);
      WriteString(Section2, 'LastLocalFolder', g_LastLocalFolder);
      WriteString(Section2, 'LastNetPath', g_LastNetPath);

      WriteInteger(Section2, 'LastCollisionAction', Ord(g_LastCollisionAction));

      WriteString(Section2, 'LastExternalExe1', g_LastExe1);
      WriteString(Section2, 'LastExternalExe2', g_LastExe2);
      WriteBool(Section2, 'WaitExternalExe1', g_WaitExe1);
      WriteBool(Section2, 'WaitExternalExe2', g_WaitExe2);


      WriteString(Section1, 'RecipEMail', g_RecipEMail);
      WriteString(Section1, 'RecipName', g_RecipName);
      WriteString(Section1, 'SenderEMail', g_SenderEMail);
      WriteString(Section1, 'SenderName', g_SenderName);

      WriteString(Section1, 'SMTPServer', g_SMTPServer);
      WriteInteger(Section1, 'SMTPPort', g_SMTPPort);
      WriteString(Section1, 'SMTPAccount', g_SMTPAccount);
      WriteInteger(Section1, 'SMTPAuthentication', Ord(g_AuthenticationType));

      WriteBool(Section1, 'UseSSL', g_UseSSL);
      WriteInteger(Section1, 'UseTLS', Ord(g_UseTLS));

      Hash := TWinCrypt.CryptText(g_SMTPPassword, PrivateKey3, True);
      WriteString(Section1, 'SMTPPwd4', Hash);

      WriteBool(Section1, 'PlaySounds', g_PlaySounds);
      WriteBool(Section1, 'DefaultBackupLast', g_DefaultBackupLast);
      WriteBool(Section1, 'DefaultBackupDefined', g_DefaultBackupDefined);
      WriteInteger(Section1, 'DefaultBackupMedia', g_DefaultBackupMedia);
      WriteString(Section1, 'DefaultLocalFolder', g_DefaultLocalFolder);
      WriteString(Section1, 'DefaultHostName', g_DefaultHostName);
      WriteString(Section1, 'DefaultPort', g_DefaultPort);
      WriteString(Section1, 'DefaultUserName', g_DefaultUserName);

      Hash := TWinCrypt.CryptText(g_DefaultPassword, PrivateKey3, True);
      WriteString(Section1, 'DefaultPassword4', Hash);

      WriteString(Section1, 'DefaultHostDirName', g_DefaultHostDirName);
      WriteBool(Section1, 'DefaultUsePassive', g_DefaultUsePassive);
      WriteBool(Section1, 'DefaultHangUpOnCompleted', g_DefaultHangUpOnCompleted);
      WriteBool(Section1, 'ProcessImmediately', g_ProcessImmediately);
      WriteInteger(Section1, 'ViewLogMode', Ord(g_ViewLogMode));

      WriteString(Section1, 'ActivationCode', g_ActivationCode);
      WriteInteger(Section1, 'Theme', g_LastTheme);

      // 2.1
      WriteString(Section1, 'ProjDir', g_ProjectsDir);
      WriteString(Section1, 'LogDir', g_LogDir);

      WriteInteger(Section1, 'ReadSpeed', g_ReadSpeed);
      WriteInteger(Section1, 'WriteSpeed', g_WriteSpeed);
      WriteBool(Section1, 'ShowHidden', g_ShowHidden);
            WriteInteger(Section1, 'SSLVersion', Ord(g_SSLVersion));



    finally
      Free;
    end;
end;

procedure SaveFormSettings(AForm: TForm);
var
  WindowPlacement: TWindowPlacement;
begin
  with TRegistry.Create do
    try
      FillChar(WindowPlacement, SizeOf(TWindowPlacement), #0);
      WindowPlacement.Length := SizeOf(TWindowPlacement);
      GetWindowPlacement(AForm.Handle, @WindowPlacement);
      if OpenKey(REG_FORMS, True) then
        try
          WriteBinaryData(AForm.ClassName, WindowPlacement, SizeOf(TWindowPlacement));
        finally
          CloseKey;
        end;
    finally
      Free;
    end;
end;

procedure RestoreFormSettings(AForm: TForm);
var
  WindowPlacement: TWindowPlacement;
  X: integer;
  Y: integer;
begin
  with TRegistry.Create do
    try
      FillChar(WindowPlacement, SizeOf(TWindowPlacement), #0);
      WindowPlacement.Length := SizeOf(TWindowPlacement);
      GetWindowPlacement(AForm.Handle, @WindowPlacement);
      if OpenKey(REG_FORMS, False) then
        try
          ReadBinaryData(AForm.ClassName, WindowPlacement, SizeOf(TWindowPlacement));
        finally
          CloseKey;
        end
      else
      begin
        X := (Screen.Width - AForm.Width) div 2;
        Y := (Screen.Height - AForm.Height) div 2;
        WindowPlacement.rcNormalPosition := Rect(X, Y, X + AForm.Width, Y + AForm.Height);
      end;
      SetWindowPlacement(AForm.Handle, @WindowPlacement);
    finally
      Free;
    end;
end;

function FolderExists(const Directory: string): Boolean;
var
  code: integer;
begin
  code := GetFileAttributes(PChar(Directory));
  g_dwLastError := GetLastError;
  Result := (code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and code <> 0);
end;

function GetLastLocalResponse: string;
begin
  //Result := SysErrorMessage(g_dwLastError);
  Result := Format('%s (Code: %d)', [SysErrorMessage(g_dwLastError), g_dwLastError]);
end;

procedure PlaySoundEvent(const AEventLabel: string);
begin
  if g_PlaySounds then
    PlaySound(PChar(AEventLabel), 0, SND_APPLICATION or SND_ASYNC or SND_NOWAIT or SND_NODEFAULT);
end;

function ExecWait(const Cmd: string; const ATimeOut: integer): integer;
var
  ProcessInfo: TProcessInformation;
  hProcess: THandle;
  ReturnCode: cardinal;
  StartupInfo: TStartupInfo;
begin
  Result := 0;
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  if not CreateProcess(nil, PChar(Cmd), nil, nil, False, CREATE_DEFAULT_ERROR_MODE +
    NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
  begin
    Result := GetLastError;
    Exit;
  end;
  hProcess := ProcessInfo.hProcess; // save the process handle
  //Close the thread handle as soon as it is no longer needed
  CloseHandle(ProcessInfo.hThread);
  ReturnCode := WaitForSingleObject(hProcess, ATimeOut * 60000);
  if ReturnCode = WAIT_FAILED then
  begin
    Result := GetLastError;
    Exit;
  end;
  // The process terminated
  //  ChkBool(GetExitCodeProcess(hProcess, dword(Result)),
  //    'Error in GetExitCodeProcess');
  // Close the process handle as soon as it is no longer needed
  CloseHandle(hProcess);
end;

procedure ExecuteApp(const Cmd: string);
begin
  ShellExecute(0, 'open', PChar(Cmd), '', '', SW_SHOWNORMAL);
end;

procedure WriteAppPathToRegistry;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey(REG_ROOT, True);
      WriteString('ExePath', Application.ExeName);
    finally
      Free;
    end;
end;

{function CDRWDiskTypeNameByType(AType: TCDDriveType): string;
begin
  Result := GetEnumName(TypeInfo(TCDDriveType), Ord(AType));
  Delete(Result, 1, 2);
  Result := StringReplace(Result, '_', '-', [rfReplaceAll]);
  Result := StringReplace(Result, 'Plus', '+', [rfIgnoreCase, rfReplaceAll]);
end;

function CDRWIsCDDrive(AInfo: TCDDeviceInfo): Boolean;
var
  TmpInfo: TCDDeviceInfo;
  P1, P2: PCDDeviceInfo;
begin
  FillChar(TmpInfo, SizeOf(TCDDeviceInfo), #0);
  P1 := @TmpInfo;
  P2 := @AInfo;
  Result := not CompareMem(P1, P2, SizeOf(TCDDeviceInfo));
end;
}

function GetDrives: string;
var
  I: cardinal;
  Pc, Pc2: PChar;
begin
  I := GetLogicalDriveStrings(0, nil);
  GetMem(Pc, I);
  Pc2 := Pc;
  try
    Result := '';
    GetLogicalDriveStrings(I, Pc);
    while (Pc <> nil) and (StrLen(Pc) > 0) do
    begin
      Result := Result + string(Pc) + #13#10;
      Inc(Pc, 4);
    end;
  finally
    FreeMem(Pc2);
  end;
end;

function GetCDDrives: string;
var
  I: cardinal;
  Pc, Pc2: PChar;
begin
  I := GetLogicalDriveStrings(0, nil);
  GetMem(Pc, I);
  Pc2 := Pc;
  try
    Result := '';
    GetLogicalDriveStrings(I, Pc);
    while (Pc <> nil) and (StrLen(Pc) > 0) do
    begin
      if GetDriveType(Pc) = DRIVE_CDROM then
        Result := Result + string(Pc) + #13#10;
      Inc(Pc, 4);
    end;
  finally
    FreeMem(Pc2);
  end;
end;

function FileGetSize(const AFileName: string): int64; overload;
var
  SR: TSearchRec;
begin
  if FindFirst(AFileName, faAnyFile and not faDirectory, SR) = 0 then
  begin
    Result := SR.Size;
    FindClose(SR);
  end
  else
    Result := -1;
end;


function FileGetSize(const ASR: TSearchRec): int64; overload;
begin
  Result := ASR.Size;
end;

function FileGetSize(const ASR: TFTPSearchRec): int64; overload;
begin
  Result := Int64(ASR.Size);
end;

function FileGetModified(const ASR: TSearchRec): TDateTime; overload;
begin
(*
  if FileTimeToLocalFileTime(ASR.FindData.ftLastWriteTime, LocalFileTime) then
  begin
    FileTimeToSystemTime(LocalFileTime, LSystemTime);
    with LSystemTime do
      Result := EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
  end
  else
*)  
    try
      //Result := FileDateToDateTime(ASR.Time);
      Result := ASR.TimeStamp;
    except
      Result := Now;
    end;
end;

function FileGetModified(const ASR: TFTPSearchRec): TDateTime; overload;
begin
(*
  if FileTimeToLocalFileTime(ASR.FindData.ftLastWriteTime, LocalFileTime) then
  begin
    FileTimeToSystemTime(LocalFileTime, LSystemTime);
    with LSystemTime do
      Result := EncodeDate(wYear, wMonth, wDay) + EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
  end
  else
*)
    try
      Result := FileDateToDateTime(ASR.Time);
    except
      Result := Now;
    end;
end;

function TicksToTime(const ATicks: cardinal): string;
var
  DT: TTime;
begin
  DT := ATicks / MSecsPerDay;
  Result := FormatDateTime('h:nn:ss', DT);
end;


type
  TAccControl = class(TControl);

procedure UpdateVistaFonts(const AForm: TCustomForm);
var
  I: integer;
begin
  if SysUtils.Win32MajorVersion < 6 then
    Exit;
  AForm.Font.Name := 'Segoe UI';
  AForm.Font.Size := 9;
  for I := 0 to AForm.ComponentCount - 1 do
    if AForm.Components[I] is TControl then
      if (TAccControl(AForm.Components[I]).Font.Size = 11) and
        (TAccControl(AForm.Components[I]).Font.Name = 'Tahoma') then
      begin
        TAccControl(AForm.Components[I]).Font.Name := 'Segoe UI';
        TAccControl(AForm.Components[I]).Font.Size := 12;
      end;
end;

const
  FILE_READ_ATTRIBUTES = $80;
  FSCTL_GET_RETRIEVAL_POINTERS = 589939; //(($00000009) shr 16) or ((28) shr 14) or ((3) shr 2) or (0);

type
  ULONGLONG  = ULONG;
  PULONGLONG = ^ULONGLONG;
  TClusters  = array of LONGLONG;

  STARTING_VCN_INPUT_BUFFER = record
    StartingVcn: LARGE_INTEGER;
  end;
  PSTARTING_VCN_INPUT_BUFFER = ^STARTING_VCN_INPUT_BUFFER;

  Extents = record
    NextVcn: LARGE_INTEGER;
    Lcn: LARGE_INTEGER;
  end;

  RETRIEVAL_POINTERS_BUFFER = record
    ExtentCount: DWORD;
    StartingVcn: LARGE_INTEGER;
    Extents: array[0..0] of Extents;
  end;
  PRETRIEVAL_POINTERS_BUFFER = ^RETRIEVAL_POINTERS_BUFFER;


function GetFileClusters(lpFileName: PChar; ClusterSize: int64; ClCount: PInt64; var FileSize: int64): TClusters;
var
  hFile:  THandle;
  OutSize: ULONG;
  Bytes, Cls, CnCount, r: ULONG;
  Clusters: TClusters;
  PrevVCN, lcn: LARGE_INTEGER;
  InBuf:  STARTING_VCN_INPUT_BUFFER;
  OutBuf: PRETRIEVAL_POINTERS_BUFFER;
begin
  Clusters := nil;

  hFile := CreateFile(lpFileName, FILE_READ_ATTRIBUTES, FILE_SHARE_READ or FILE_SHARE_WRITE or
    FILE_SHARE_DELETE, nil, OPEN_EXISTING, 0, 0);


  if (hFile <> INVALID_HANDLE_VALUE) then
  begin
    FileSize := GetFileSize(hFile, nil);

    OutSize := SizeOf(RETRIEVAL_POINTERS_BUFFER) + (FileSize div ClusterSize) * SizeOf(OutBuf^.Extents);

    GetMem(OutBuf, OutSize);

    InBuf.StartingVcn.QuadPart := 0;

    if (DeviceIoControl(hFile, FSCTL_GET_RETRIEVAL_POINTERS, @InBuf, SizeOf(InBuf), OutBuf,
      OutSize, Bytes, nil)) then
    begin
      ClCount^ := (FileSize + ClusterSize - 1) div ClusterSize;

      SetLength(Clusters, ClCount^);
      PrevVCN := OutBuf^.StartingVcn;

      Cls := 0;
      r := 0;
      while (r < OutBuf^.ExtentCount) do
      begin
        Lcn := OutBuf^.Extents[r].Lcn;

        CnCount := ULONG(OutBuf^.Extents[r].NextVcn.QuadPart - PrevVCN.QuadPart);
        while (CnCount > 0) do
        begin
          Clusters[Cls] := Lcn.QuadPart;
          Dec(CnCount);
          Inc(Cls);
          Inc(Lcn.QuadPart);
        end;
        PrevVCN := OutBuf^.Extents[r].NextVcn;

        Inc(r);
      end;
    end;
    FreeMem(OutBuf);
    CloseHandle(hFile);
  end;
  Result := Clusters;
end;


type
  TCopyProgressRoutine = function(TotalFileSize: int64; TotalBytesTransferred: int64;
    StreamSize: int64; StreamBytesTransferred: int64; dwStreamNumber: DWORD; dwCallbackReason: DWORD;
    hSourceFile: THandle; hDestinationFile: THandle; lpData: Pointer): DWORD; stdcall;

function CopyFileRaw(lpSrcName: PChar; lpDstName: PChar; lpProgressRoutine: TFNProgressRoutine;
  lpData: Pointer; pbCancel: PBool; dwCopyFlags: DWORD): Boolean;
var
  FileSize, ClusterSize, BlockSize, FullSize, CopyedSize: int64;
  Clusters: TClusters;
  r, ClCount: ULONG;
  Bytes: ULONG;
  hDrive, hFile: THandle;
  SecPerCl, BtPerSec, FreeClusters, NumOfClusters: DWORD;
  Buff:  PByte;
  Offset: LARGE_INTEGER;
  Name:  array[0..6] of char;
  rslt:  integer;
begin
  Result := True;
  try
    Name[0] := lpSrcName[0];
    Name[1] := ':';
    Name[2] := char(0);

    FreeClusters  := 0;
    NumOfClusters := 0;
    GetDiskFreeSpace(Name, SecPerCl, BtPerSec, FreeClusters, NumOfClusters);

    ClusterSize := SecPerCl * BtPerSec;

    Clusters := GetFileClusters(lpSrcName, ClusterSize, @ClCount, FileSize);
    FullSize := FileSize;

    if (Clusters <> nil) then
    begin
      Name[0] := '\';
      Name[1] := '\';
      Name[2] := '.';
      Name[3] := '\';
      Name[4] := lpSrcName[0];
      Name[5] := ':';
      Name[6] := char(0);

      hDrive := CreateFile(Name, GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);

      if hDrive <> INVALID_HANDLE_VALUE then
        try
          hFile := CreateFile(lpDstName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, 0, 0);

          if (hFile <> INVALID_HANDLE_VALUE) then
            try
              GetMem(Buff, ClusterSize);
              try
                r := 0;
                CopyedSize := 0;
                while (r < ClCount) do
                begin
                  if Assigned(@lpProgressRoutine) then
                  begin
                    rslt := TCopyProgressRoutine(lpProgressRoutine)(ClCount, r, FullSize,
                      CopyedSize, 0, 4, hDrive, hFile, lpData);
                    if rslt = PROGRESS_STOP then
                      Abort;
                  end;


                  Offset.QuadPart := ClusterSize * Clusters[r];
                  SetFilePointer(hDrive, Offset.LowPart, @Offset.HighPart, FILE_BEGIN);
                  ReadFile(hDrive, Buff^, ClusterSize, Bytes, nil);
                  BlockSize := Min(FileSize, ClusterSize);
                  WriteFile(hFile, Buff^, BlockSize, Bytes, nil);
                  CopyedSize := CopyedSize + BlockSize;
                  FileSize := FileSize - BlockSize;
                  Inc(r);
                end;
              finally
                FreeMem(Buff);
              end;
            finally
              CloseHandle(hFile);
            end;
        finally
          CloseHandle(hDrive);
        end;
    end;
  except
    Result := False;
  end;
end;

function ConnectToNAS(const AWnd: HWND; const ANetPath, AUserName, APassword: string;
  var AConnection: string): Boolean;
var
  lpNetResource: TNetResource;
  lpAccessName: array[0..MAX_PATH] of char;
  lpBufferSize: DWORD;
  lpUserID: PChar;
  lpPassword: PChar;
  lpResult: DWORD;
begin
  FillChar(lpNetResource, SizeOf(TNetResource), #0);
  lpNetResource.dwType := RESOURCETYPE_DISK;
  lpNetResource.lpRemoteName := PChar(ExcludeTrailingPathDelimiter(ANetPath));

  FillChar(lpAccessName[0], MAX_PATH + 1, #0);
  lpBufferSize := MAX_PATH;
  if AUserName <> EmptyStr then
    lpUserID := PChar(AUserName)
  else
    lpUserID := nil;

  if APassword <> EmptyStr then
    lpPassword := PChar(APassword)
  else
    lpPassword := nil;


  Result := WNetUseConnection(AWnd, lpNetResource, lpPassword, lpUserID, 0, lpAccessName, lpBufferSize, lpResult) = ERROR_SUCCESS;
  g_dwLastError := GetLastError;

  if not Result then
  begin
    if AWnd <> 0 then
      MessageBox(AWnd, PChar(GetLastLocalResponse), PChar(sError), $00000030);
    Exit;
  end;
  AConnection := StrPas(lpAccessName);
end;

(*

function ConnectToNAS(const AWnd: HWND; const ANetPath, AUserName, APassword: string;
  var AConnection: string): boolean;
var
  lpNetResource: TNetResource;
  lpAccessName: array[0..MAX_PATH] of char;
  lpBufferSize: DWORD;
  lpUserID: PChar;
  lpPassword: PChar;
  lpResult: DWORD;
begin
  FillChar(lpNetResource, SizeOf(TNetResource), #0);
  lpNetResource.dwType := RESOURCETYPE_DISK;
  lpNetResource.lpRemoteName := PChar(ANetPath);
  FillChar(lpAccessName[0], MAX_PATH + 1, #0);
  lpBufferSize := MAX_PATH;
  if AUserName <> EmptyStr then
    lpUserID := PChar(AUserName)
  else
    lpUserID := nil;

  if APassword <> EmptyStr then
    lpPassword := PChar(APassword)
  else
    lpPassword := nil;

  Result := WNetUseConnection(AWnd, lpNetResource, lpPassword, lpUserID, 0, lpAccessName, lpBufferSize, lpResult) =
    ERROR_SUCCESS;
  g_dwLastError := GetLastError;

  if not Result then
  begin
    if AWnd <> 0 then
      MessageBox(AWnd, PChar(GetLastLocalResponse), PChar(sError), $00000030);
    Exit;
  end;
  AConnection := StrPas(lpAccessName);
end;
*)

procedure DisconnectNAS(const AConnection: string);
begin
  WNetCancelConnection2(PChar(AConnection), 0, True);
end;


const
  DomainExt: array[1..259] of string = ('AC', 'AD', 'AE', 'AERO', 'AF', 'AG', 'AI', 'AL', 'AM', 'AN', 'AO', 'AQ', 'AR',
    'AS', 'AT', 'AU', 'AW', 'AZ', 'BA', 'BB', 'BD', 'BE', 'BF', 'BG', 'BH', 'BI',
    'BIZ', 'BJ', 'BM', 'BN', 'BO', 'BR', 'BS', 'BT', 'BV', 'BW', 'BY', 'BZ', 'CA',
    'CC', 'CD', 'CF', 'CG', 'CH', 'CI', 'CK', 'CL', 'CM', 'CN', 'CO', 'COM', 'COOP',
    'CR', 'CU', 'CV', 'CX', 'CY', 'CZ', 'DE', 'DJ', 'DK', 'DM', 'DO', 'DZ', 'EC',
    'EDU', 'EE', 'EG', 'EH', 'ER', 'ES', 'ET', 'EU', 'FI', 'FJ', 'FK', 'FM', 'FO', 'FR',
    'GA', 'GD', 'GE', 'GF', 'GG', 'GH', 'GI', 'GL', 'GM', 'GN', 'GOV', 'GP', 'GQ', 'GR', 'GS',
    'GT', 'GU', 'GW', 'GY', 'HK', 'HM', 'HN', 'HR', 'HT', 'HU', 'ID', 'IE', 'IL', 'IM', 'IN', 'INFO',
    'INT', 'IO', 'IQ', 'IR', 'IS', 'IT', 'JE', 'JM', 'JO', 'JP', 'KE', 'KG', 'KH', 'KI', 'KM',
    'KN', 'KP', 'KR', 'KW', 'KY', 'KZ', 'LA', 'LB', 'LC', 'LI', 'LK', 'LR', 'LS', 'LU', 'LV', 'LY',
    'MA', 'MC', 'MD', 'MG', 'MH', 'MIL', 'MK', 'ML', 'MM', 'MN', 'MO', 'MP', 'MQ', 'MR', 'MS', 'MT',
    'MU', 'MUSEUM', 'MV', 'MW', 'MX', 'MY', 'MZ', 'NA', 'NAME', 'NC', 'NE', 'NET', 'NF', 'NG',
    'NI', 'NL', 'NO', 'NP', 'NR', 'NU', 'NZ', 'OM', 'ORG', 'PA', 'PE', 'PF', 'PG', 'PH',
    'PK', 'PL', 'PM', 'PN', 'PR', 'PRO', 'PS', 'PT', 'PW', 'PY', 'QA', 'RE', 'RO', 'RU',
    'RW', 'SA', 'SB', 'SC', 'SD', 'SE', 'SG', 'SH', 'SHOP', 'SI', 'SJ', 'SK', 'SL', 'SM',
    'SN', 'SO', 'SR', 'ST', 'SV', 'SY', 'SZ', 'TC', 'TD', 'TF', 'TG', 'TH', 'TJ', 'TK',
    'TM', 'TN', 'TO', 'TP', 'TR', 'TT', 'TV', 'TW', 'TZ', 'UA', 'UG', 'UK', 'UM', 'US',
    'UY', 'UZ', 'VA', 'VC', 'VE', 'VG', 'VI', 'VN', 'VU', 'WF', 'WS', 'YE', 'YT', 'YU',
    'ZA', 'ZM', 'ZR', 'ZW');


function IsValidEmail(email: string): Boolean;
var
  nameStr, DomainExtension, DomainStr: string;
  ok: Boolean;
  a, b, i: integer;
begin
  email  := trim(email);
  Result := False;
  if email <> '' then //darf nicht leer sein
    if length(email) > 6 then //darf nicht kleiner als 7 sein
      if pos('@', email) > 0 then //muss @ enthalten
        if pos('.', email) > 0 then //muss . enthalten
        begin
          a := pos('@', email);
          b := length(email);
          nameStr := copy(email, 1, a - 1);
          if nameStr = '' then //One or more characters before the "@"
            exit;
          if not CharInSet(nameStr[1], ['0'..'9', 'a'..'z', 'A'..'Z']) then //Name muß mit Ziffer oder Buchstabe beginnen
            exit;
          for i := 1 to length(nameStr) do
            //Nur Ziffern und Buchstaben (ohne Umlaute) sowie Punkt '.', Bindestrich '-' und Unterstrich '_'.
            if not CharInSet(nameStr[i], ['0'..'9', 'a'..'z', 'A'..'Z', '.', '-', '_', '&']) then
              exit;
          DomainStr := copy(email, a + 1, b - a);
          if DomainStr = '' then
            exit;
          if pos('.', DomainStr) = 0 then //domainstr must contain a period that is not the first character
            exit;
          if DomainStr[1] = '.' then //domainstr must contain a period that is not the first character
            exit;
          if not CharInSet(DomainStr[length(DomainStr)], ['A'..'Z', 'a'..'z', 'ä', 'ü', 'ö', 'Ä', 'Ü', 'Ö']) then
            //The last character must be an alphabetic character
            exit;
          DomainExtension := '';
          for i := length(DomainStr) downto 1 do
          begin
            if DomainStr[i] <> '.' then
              DomainExtension := DomainStr[i] + DomainExtension
            else
              break;
          end;

          ok := False;
          for i := low(DomainExt) to high(DomainExt) do
          begin
            if uppercase(DomainExtension) = DomainExt[i] then
            begin
              ok := True;
              break;
            end;
          end;
          if not OK then
            exit;
          Result := True;
        end;
end;

function SelectDir(const Caption: string; var Directory: string; Root: TRootFolder = rfDesktop;
  Options: TSelectDirExtOpts = [sdNewFolder]): Boolean;
var
  RootDir: String;
begin
  RootDir := '';
  Result := SelectDirectory(Caption, RootDir, Directory, Options + [sdNewUI]);
end;

end.
