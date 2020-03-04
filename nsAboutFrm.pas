unit nsAboutFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ShellAPI,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmAbout = class(TForm)
    btnOK: TButton;
    lbLicenced: TLabel;
    lbToolVersion: TLabel;
    Label1: TLabel;
    Image1: TImage;
    Label4: TLabel;
    Label8: TLabel;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  end;


implementation

uses
  nsGlobals, nsUtils;

{$R *.dfm}

procedure TfrmAbout.FormShow(Sender: TObject);
var
  sz, lpHandle, tbl: cardinal;
  FData, lpBuffer: Pointer;
  Str, Str2: PChar;
  strtbl: string;
  Int: PInteger;
  hiW, Low: word;
  FSize: integer;
begin
  UpdateVistaFonts(Self);

  FSize := GetFileVersionInfoSize(PChar(Application.ExeName), lpHandle);
  FData := AllocMem(FSize);
  try
    GetFileVersionInfo(PChar(Application.ExeName), lpHandle, FSize, FData);

    VerQueryValue(FData, '\\VarFileInfo\Translation', lpBuffer, sz);
    Int := lpBuffer;
    hiW := HiWord(Int^);
    Low := LOWORD(Int^);
    tbl := (Low shl 16) or hiW;
    strtbl := Format('%x', [tbl]);
    if Length(strtbl) < 8 then
      strtbl := '0' + strtbl;

    VerQueryValue(FData, PChar('\\StringFileInfo\' + strtbl + '\ProductVersion'), lpBuffer, sz);
    Str := lpBuffer;
    VerQueryValue(FData, PChar('\\StringFileInfo\' + strtbl + '\FileVersion'), lpBuffer, sz);
    Str2 := lpBuffer;
    lbToolVersion.Caption := Format(lbToolVersion.Caption, [Str, Str2]);

    VerQueryValue(FData, PChar('\\StringFileInfo\' + strtbl + '\LegalCopyright'), lpBuffer, sz);
  finally
    FreeMem(FData);
  end;
end;

procedure TfrmAbout.Label1Click(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clPurple;
  ShellExecute(0, pOpen, PChar(sID_AceBackup), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.Image2Click(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clPurple;
  ShellExecute(0, pOpen, PChar(sID_Homepage), nil, nil, SW_SHOWNORMAL);
end;

end.
