unit winftp;

interface

uses
  Classes, Windows, WinInet, SysUtils, StrUtils, nsGlobals;

function InitializeFTPSession(const AConnectionType: TFTPConnectType;
  const HostName, UserName, Password, Port, ProxyName, ProxyPort, ProxyUser, ProxyPassword: string;
  const APassive: Boolean): DWORD;
procedure FinalizeFTPSession;

function InitializeFTP(const HostName, UserName, Password, Port, ProxyName, ProxyPort: string): DWORD;
function FinalFTP: DWORD;
function GetDirContent(const ADirName: PChar): string;
function UploadFTPFile(ALocalName, ARemoteName: PChar; Event: TFTPProgressEvent): DWORD;
function DownloadFTPFile(ALocalName, ARemoteName: PChar; Event: TFTPProgressEvent): DWORD;
function DeleteFTPFile(AFileName: PChar): DWORD;
function DeleteFTPFolder(AFolderName: PChar): DWORD;
function RenameFTPFile(AFromName, AToName: PChar): DWORD;
function CreateFTPFolder(AFolderName: PChar): DWORD;
function IntFileExists(AFileName: PChar): Boolean;

function TestWriteToFTP(AFileName: PChar): Boolean;

function GetLastFTPResponse: PChar;

function FTPFindFirst(const Path: PChar; Attr: integer; var F: TFTPSearchRec): integer;
function FTPFindNext(var F: TFTPSearchRec): integer;
procedure FTPFindClose(var F: TFTPSearchRec);

function FTPFileExists(AFileName: PChar): Boolean;
function FTPDirectoryExists(ADirName: PChar): Boolean;

implementation

const
  dwNumberOfBytes: DWORD = 512;

var
  InetG: HInternet = nil;
  InetC: HInternet = nil;

  g_Error: DWORD;

  lpszBuffer: array[0..MAX_PATH] of char;
  lpdwBufferLength: DWORD = MAX_PATH;

  g_ModuleHandle: HMODULE;


function InitializeFTPSession(const AConnectionType: TFTPConnectType;
  const HostName, UserName, Password, Port, ProxyName, ProxyPort, ProxyUser, ProxyPassword: string;
  const APassive: Boolean): DWORD;
begin
  g_ConnectType := AConnectionType;
  g_Passive := APassive;
  Result := InitializeFTP(HostName, UserName, Password, Port, ProxyName, ProxyPort);
end;

procedure FinalizeFTPSession;
begin
  FinalFTP;
  g_ConnectType := ftpcDefault;
  g_Passive := False;
end;


function FinalFTP: DWORD;
begin
  try
    if InetC <> nil then
      InternetCloseHandle(InetC);
    if InetG <> nil then
      InternetCloseHandle(InetG);
  finally
    InetC := nil;
    InetG := nil;
  end;
  Result := GetLastError;
end;

function InitializeFTP(const HostName, UserName, Password, Port, ProxyName, ProxyPort: string): DWORD;
var
  ConFlg: cardinal;
  FTPPort: word;
  S: string;
  ProxyStr: string;
begin
  if InetG = nil then
    InternetCloseHandle(InetG);
  if InetC = nil then
    InternetCloseHandle(InetC);

  // 22.02.2004
  g_Error := InternetAttemptConnect(0);
  Result  := g_Error;
  if g_Error <> ERROR_SUCCESS then
    Exit;

  ProxyStr := EmptyStr;
  case g_ConnectType of
    ftpcDirect: ConFlg := INTERNET_OPEN_TYPE_DIRECT;
    ftpcUseProxy:
    begin
      ConFlg := INTERNET_OPEN_TYPE_PROXY;
      if ProxyPort = EmptyStr then
        ProxyStr := Format('ftp=ftp://%s', [ProxyName])
      else
        ProxyStr := Format('ftp=ftp://%s:%s', [ProxyName, ProxyPort]);
    end;
    else
      ConFlg := INTERNET_OPEN_TYPE_PRECONFIG;
  end;
  S := Port;
  if (S = EmptyStr) or AnsiSameText(S, 'ftp') then
    FTPPort := INTERNET_DEFAULT_FTP_PORT
  else
    FTPPort := StrToIntDef(S, 21);

  InetG := InternetOpen('AceBackup3', ConFlg, PChar(ProxyStr), nil, 0);
  if InetG = nil then
  begin
    g_Error := GetLastError;
    Result  := g_Error;
    Exit;
  end;

  ConFlg := INTERNET_FLAG_RELOAD;
  if g_Passive then
    ConFlg := ConFlg or INTERNET_FLAG_PASSIVE;

  InetC := InternetConnect(InetG, PChar(HostName), FTPPort, PChar(UserName), PChar(Password),
    INTERNET_SERVICE_FTP, ConFlg, 0);

  if InetC <> nil then
    g_Error := ERROR_SUCCESS
  else
    g_Error := GetLastError;

  Result := g_Error;
end;

function GetFindDataStr(FindData: TWin32FindData): string;
var
  S, S1, S2: string;
  LocalFileTime: TFileTime;
  DosTime: integer;
  ISize64: int64;
begin
  Result := EmptyStr;
  case FindData.dwFileAttributes of
    //    FILE_ATTRIBUTE_ARCHIVE: S := '-rwxrwxrwx';
    //    FILE_ATTRIBUTE_COMPRESSED: S := '-rwxrwxrwx';
    FILE_ATTRIBUTE_DIRECTORY: S := '<DIR>';
      //    FILE_ATTRIBUTE_HIDDEN: S := 'H';
      //    FILE_ATTRIBUTE_NORMAL: S := '-rwxrwxrwx';
      //    FILE_ATTRIBUTE_READONLY: S := '-r-xr-xr-x';
      //    FILE_ATTRIBUTE_SYSTEM: S := '-rwxrwxrwx';
      //    FILE_ATTRIBUTE_TEMPORARY: S := '-rwxrwxrwx';
    else
      S := EmptyStr; //IntToStr(FindData.dwFileAttributes);
  end;

  Int64Rec(ISize64).Lo := FindData.nFileSizeLow;
  Int64Rec(ISize64).Hi := FindData.nFileSizeHigh;
  if S = EmptyStr then
    S2 := IntToStr(ISize64)
  else
    S2 := EmptyStr;
  if FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime) then
    FileTimeToDosDateTime(LocalFileTime, LongRec(DosTime).Hi,
      LongRec(DosTime).Lo);
  S1 := FormatDateTime('mm-dd-yy  hh:nnAM/PM', FileDateToDateTime(DosTime));
  Result := Format('%s%12s%9s %s'#13#10, [S1, S, S2, FindData.cFileName]);
end;

function GetDirContent(const ADirName: PChar): string;
var
  WF32:  TWin32FindData;
  HFind: HInternet;
begin
  Result := EmptyStr;
  FillChar(WF32, SizeOf(WF32), #0);
  HFind := FtpFindFirstFile(InetC, PChar(ADirName), WF32, INTERNET_FLAG_RELOAD, 0);
  if HFind = nil then
    Exit;
  repeat
    Result := Result + GetFindDataStr(WF32);
  until not InternetFindNextFile(HFind, @WF32);
  InternetCloseHandle(HFind);
end;


function IntFileExists(AFileName: PChar): Boolean;
var
  WF32:  TWin32FindData;
  HFind: HInternet;
begin
  Result := False;
  FillChar(WF32, SizeOf(WF32), #0);
  HFind := FtpFindFirstFile(InetC, AFileName, WF32, INTERNET_FLAG_RELOAD, 0);
  if HFind <> nil then
  begin
    Result := GetLastError = 0;
    InternetCloseHandle(HFind);
  end;
end;

function UploadFTPFile(ALocalName, ARemoteName: PChar; Event: TFTPProgressEvent): DWORD;
var
  FtpFile: HInternet;
  FS:  TFileStream;
  Buf: Pointer;
  dwNumberOfBytesToWrite: DWORD;
  lpdwNumberOfBytesWritten: DWORD;
  //  Bytes: dword;
  Current: dword;
  Total: int64;
  NeedClose: Boolean;
  rslt: Boolean;
begin
  NeedClose := False;
  FS := TFileStream.Create(ALocalName, fmOpenRead or fmShareDenyNone);
  try
    if Assigned(Event) then
      Event(0, 0, NeedClose);
    if NeedClose then
    begin
      Result := S_FALSE;
      Abort;
    end;
    Total := FS.Size;
    Current := 0;
    FtpFile := FtpOpenFile(InetC, ARemoteName, GENERIC_WRITE, FTP_TRANSFER_TYPE_BINARY, 0);
    if FtpFile = nil then
    begin
      g_Error := GetLastError;
      Result  := g_Error;
      Exit;
    end;

    GetMem(Buf, dwNumberOfBytes);
    try
      repeat
        dwNumberOfBytesToWrite := FS.Read(Buf^, dwNumberOfBytes);
        rslt := InternetWriteFile(FtpFile, Buf, dwNumberOfBytesToWrite, lpdwNumberOfBytesWritten);
        Current := Current + lpdwNumberOfBytesWritten;
        if Assigned(Event) then
          Event(Current, Total, NeedClose);
        if NeedClose then
        begin
          Result := S_FALSE;
          Abort;
        end;
      until (lpdwNumberOfBytesWritten = 0) or not rslt;
      if Assigned(Event) then
        Event(Current, Total, NeedClose);
      if NeedClose then
      begin
        Result := S_FALSE;
        Abort;
      end;
    finally
      if Current >= Total then
        g_Error := ERROR_SUCCESS
      else
        g_Error := GetLastError;

      Result := g_Error;
      InternetCloseHandle(FtpFile);
      FreeMem(Buf);
    end;
  finally
    FS.Free;
  end;
end;

function TestWriteToFTP(AFileName: PChar): Boolean;
var
  FtpFile:  HInternet;
  lpdwNumberOfBytesWritten: DWORD;
  lpBuffer: Pointer;
begin
  lpBuffer := AllocMem(MAX_PATH);
  try
    FtpFile := FtpOpenFile(InetC, AFileName, GENERIC_WRITE, FTP_TRANSFER_TYPE_BINARY, 0);
    if FtpFile = nil then
    begin
      Result  := False;
      g_Error := GetLastError;
      Exit;
    end;

    Result := InternetWriteFile(FtpFile, lpBuffer, MAX_PATH - 1, lpdwNumberOfBytesWritten);
    InternetCloseHandle(FtpFile);
    if Result then
      Result := FtpDeleteFile(InetC, AFileName);

    if Result then
      g_Error := ERROR_SUCCESS
    else
      g_Error := GetLastError;

  finally
    FreeMem(lpBuffer);
  end;
end;

function DownloadFTPFile(ALocalName, ARemoteName: PChar; Event: TFTPProgressEvent): DWORD;
var
  FtpFile: HInternet;
  FS:  TFileStream;
  Buf: Pointer;
  Bytes: dword;
  Current: dword;
  //  Total64: Int64;
  NeedClose: Boolean;
  br:  Boolean;
begin
  NeedClose := False;

  FS := TFileStream.Create(ALocalName, fmCreate);
  try
    if Assigned(Event) then
      Event(0, 0, NeedClose);
    if NeedClose then
    begin
      Result := S_FALSE;
      Abort;
    end;
    FtpFile := FtpOpenFile(InetC, ARemoteName, GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0);
    if FtpFile = nil then
    begin
      g_Error := GetLastError;
      Result  := g_Error;
      Exit;
    end;

    Current := 0;
    br := False;
    GetMem(Buf, dwNumberOfBytes);
    try
      repeat
        br := InternetReadFile(FtpFile, Buf, dwNumberOfBytes, Bytes);
        if Bytes > 0 then
        begin
          FS.Write(Buf^, Bytes);
          Current := Current + Bytes;
        end;
        if Assigned(Event) then
          Event(Current, 0, NeedClose);
        if NeedClose then
        begin
          Result := S_FALSE;
          Abort;
        end;
      until (Bytes < dwNumberOfBytes) or not br;
    finally
      if br then
        g_Error := ERROR_SUCCESS
      else
        g_Error := GetLastError;
      Result := g_Error;
      InternetCloseHandle(FtpFile);
      FreeMem(Buf);
    end;
  finally
    FS.Free;
  end;
end;

function DeleteFTPFile(AFileName: PChar): DWORD;
begin
  if FtpDeleteFile(InetC, AFileName) then
    g_Error := ERROR_SUCCESS
  else
    g_Error := GetLastError;
  Result := g_Error;
end;

function DeleteFTPFolder(AFolderName: PChar): DWORD;
begin
  if FtpRemoveDirectory(InetC, AFolderName) then
    g_Error := ERROR_SUCCESS
  else
    g_Error := GetLastError;
  Result := g_Error;
end;

function RenameFTPFile(AFromName, AToName: PChar): DWORD;
begin
  if FtpRenameFile(InetC, AFromName, AToName) then
    g_Error := ERROR_SUCCESS
  else
    g_Error := GetLastError;
  Result := g_Error;
end;

function CreateFTPFolder(AFolderName: PChar): DWORD;
begin
  if FtpCreateDirectory(InetC, AFolderName) then
    g_Error := ERROR_SUCCESS
  else
    g_Error := GetLastError;
  Result := g_Error;
end;

function FTPFindMatchingFile(var F: TFTPSearchRec): integer;
var
  LocalFileTime: TFileTime;
begin
  with F do
  begin
    while FindData.dwFileAttributes and ExcludeAttr <> 0 do
      if not InternetFindNextFile(FindHandle, @FindData) then
      begin
        Result := GetLastError;
        Exit;
      end;
    FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime);
    FileTimeToDosDateTime(LocalFileTime, LongRec(Time).Hi,
      LongRec(Time).Lo);
    Size := FindData.nFileSizeLow;
    Attr := FindData.dwFileAttributes;
    Name := FindData.cFileName;
  end;
  Result := 0;
end;

procedure FTPFindClose(var F: TFTPSearchRec);
begin
  if F.FindHandle <> nil then
  begin
    InternetCloseHandle(F.FindHandle);
    F.FindHandle := nil;
  end;
end;

function FTPFindNext(var F: TFTPSearchRec): integer;
begin
  if InternetFindNextFile(F.FindHandle, @F.FindData) then
    Result := FTPFindMatchingFile(F)
  else
    Result := GetLastError;
end;

function FTPFindFirst(const Path: PChar; Attr: integer; var F: TFTPSearchRec): integer;
const
  faSpecial = faHidden or faSysFile or faDirectory;
var
  //  br: Boolean;
  sPath: string;
begin
  F.ExcludeAttr := not Attr and faSpecial;
  // 17
  sPath := string(Path);
  if (Length(sPath) > 0) and (sPath[1] <> sSlash) then
    sPath := sSlash + sPath;

  if not FtpSetCurrentDirectory(InetC, PChar(sPath)) then
  begin
    Result := GetLastError;
    Exit;
  end;
  F.FindHandle := FtpFindFirstFile(InetC, nil, F.FindData, INTERNET_FLAG_RELOAD, 0);
  //  F.FindHandle := FtpFindFirstFile(InetC, PChar(Path), F.FindData, INTERNET_FLAG_RELOAD, 0);
  //  F.FindHandle := FtpFindFirstFile(InetC, PChar(sPath), F.FindData, INTERNET_FLAG_RELOAD, 0);
  if F.FindHandle <> nil then
  begin
    Result := FTPFindMatchingFile(F);
    if Result <> 0 then
      FTPFindClose(F);
  end
  else
    Result := GetLastError;
end;

function FTPFileExists(AFileName: PChar): Boolean;
var
  FindHandle: HINTERNET;
begin
  FindHandle := FtpOpenFile(InetC, AFileName, GENERIC_READ, FTP_TRANSFER_TYPE_BINARY, 0);
  g_Error := GetLastError;
  Result  := FindHandle <> nil;
  if Result then
    InternetCloseHandle(FindHandle);
end;

function FTPDirectoryExists(ADirName: PChar): Boolean;
var
  lpdwOldDirectory: DWORD;
  lpszOldDirectory: array[0..MAX_PATH] of char;
begin
  lpdwOldDirectory := MAX_PATH;
  Result := FtpGetCurrentDirectory(InetC, lpszOldDirectory, lpdwOldDirectory);
  if Result then
    try
      Result  := FtpSetCurrentDirectory(InetC, ADirName);
      g_Error := GetLastError;
    finally
      FtpSetCurrentDirectory(InetC, lpszOldDirectory);
    end;
end;

function GetLastFTPResponse: PChar;
var
  S: string;
begin
  lpdwBufferLength := MAX_PATH;
  case g_Error of
    ERROR_SUCCESS:
      FormatMessage(
        FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ARGUMENT_ARRAY,
        nil,
        g_Error,
        0,
        lpszBuffer,
        lpdwBufferLength,
        nil);
    ERROR_INTERNET_EXTENDED_ERROR:
      InternetGetLastResponseInfo(g_Error, lpszBuffer, lpdwBufferLength);
    else
    begin
      if FormatMessage(FORMAT_MESSAGE_FROM_HMODULE, LPDWORD(g_ModuleHandle),
        g_Error, 0, lpszBuffer, lpdwBufferLength, nil) = 0 then
        FormatMessage(
          FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ARGUMENT_ARRAY,
          nil,
          g_Error,
          0,
          lpszBuffer,
          lpdwBufferLength,
          nil);
    end;
  end;
  S := Format(sCodeFormatted, [Trim(String(@lpszBuffer)), g_Error]);
  Result := PChar(S); //lpszBuffer;
end;

initialization

  g_ModuleHandle := LoadLibrary('wininet.dll');

finalization

  if g_ModuleHandle <> 0 then
    FreeLibrary(g_ModuleHandle);

end.
