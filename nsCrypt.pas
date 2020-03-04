unit nsCrypt;

interface

uses
  Windows, Classes, SysUtils, WinCrypt;

type
  THashProgress = procedure(CurBlock, TotBlock: integer; var AClose: Boolean) of object;

  THashKey = array[1..20] of Byte;

  TWinCrypt = class(TObject)
  strict private
    hProv: HCRYPTPROV;
    hKey: HCRYPTKEY;
    FPassword: string;
  private
    FOnProgress: THashProgress;
    FWorkStream: TStream;
    function CryptStream(var InStr, OutStr: TStream; ToCrypt: Boolean): Boolean;
    function GetHashKey: THashKey;
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    function GetHashEmpty: THashKey;
  public
    constructor Create;
    destructor Destroy; override;

    function EncryptFile(var InStr: TStream; var OutStr: TFileStream): Boolean;
    function DecryptFile(var InStr: TFileStream; var OutStr: TStream): Boolean;
    class function CryptText(const SourceText, Password: string; CryptIt: Boolean): string;
    property OnProgress: THashProgress read FOnProgress write FOnProgress;
    property Password: string read GetPassword write SetPassword;
    property HashKey: THashKey read GetHashKey;
    property HashEmpty: THashKey read GetHashEmpty;
  end;

implementation

{ TWinCrypt }

constructor TWinCrypt.Create;
begin
  inherited;

  CryptAcquireContext(hProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
end;

destructor TWinCrypt.Destroy;
begin
  CryptReleaseContext(hProv, 0);

  inherited;
end;

function TWinCrypt.CryptStream(var InStr, OutStr: TStream; ToCrypt: Boolean): Boolean;
var
  Buffer: PByte;
  len: dWord;
  b: Boolean;
  IsEndOfFile: Boolean;
begin
  GetHashKey;

  GetMem(Buffer, 512);
  try
    b := False;
    repeat
      IsEndOfFile := (InStr.Position >= InStr.Size) or b;
      if IsEndOfFile then
        break;

      len := InStr.Read(Buffer^, 512);

      if ToCrypt then
        CryptEncrypt(hKey, 0, IsEndOfFile, 0, Buffer, len, len)
      else
        CryptDecrypt(hKey, 0, IsEndOfFile, 0, Buffer, len);

      if Assigned(OnProgress) then
        OnProgress(InStr.Position, InStr.Size, b);

      OutStr.Write(Buffer^, len)
    until IsEndOfFile;

    Result := OutStr.Size > 0;
  finally
    FreeMem(Buffer, 512);
  end;
end;

class function TWinCrypt.CryptText(const SourceText, Password: string; CryptIt: Boolean): string;
var
  crypt: TWinCrypt;
  iLen: Integer;
  InputText: String;
  OutputText: String;
  fsIn, fsOut: TStream;
begin
  crypt := TWinCrypt.Create;
  try
    if CryptIt or (SourceText = '') then
    begin
      InputText := SourceText;
    end else
    begin
      iLen := Ord(SourceText[1]);
      InputText := Copy(SourceText, 2, iLen);
    end;

    fsIn := TStringStream.Create(InputText);
    fsOut := TStringStream.Create(OutputText);
    try
      crypt.Password := Password;
      if crypt.CryptStream(fsIn, fsOut, CryptIt) then
        Result := TStringStream(fsOut).DataString
      else
        Result := InputText;

      if CryptIt then
      begin
        Result := Chr(Length(Result)) + Result;
        while Length(Result) < 16 do
        begin
          Result := Result + Chr(Random(255));
        end;
      end;
    finally
      fsIn.Free;
      fsOut.Free;
    end;
  finally
    FreeAndNil(crypt);
  end;
end;

function TWinCrypt.DecryptFile(var InStr: TFileStream; var OutStr: TStream): Boolean;
begin
  FWorkStream := InStr;
  Result := CryptStream(FWorkStream, Outstr, False);
end;

function TWinCrypt.EncryptFile(var InStr: TStream; var OutStr: TFileStream): Boolean;
begin
  FWorkStream := OutStr;
  Result := CryptStream(InStr, FWorkStream, True);
end;

function TWinCrypt.GetPassword: string;
begin
  Result := FPassword;
end;

function TWinCrypt.GetHashEmpty: THashKey;
begin
  FillChar(Result, SizeOf(THashKey), 0);
end;

function TWinCrypt.GetHashKey: THashKey;
var
  hash: HCRYPTHASH;
  iLen: Cardinal;
begin
  CryptCreateHash(hProv, CALG_SHA, 0, 0, hash);
  CryptHashData(hash, @Password[1], Length(Password), 0);
  CryptDeriveKey(hProv, CALG_RC4, hash, 0, hKey);

  iLen := SizeOf(THashKey);
  FillChar(Result, iLen, 0);
  CryptGetHashParam(hash, HP_HASHVAL, @Result, iLen, 0);

  CryptDestroyHash(hash);
end;

procedure TWinCrypt.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

end.
