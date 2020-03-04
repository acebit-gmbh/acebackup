unit nsReplaceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsGlobals, nsUtils, ShellAPI, ShlObj;

type
  TfrmReplaceDlg = class(TForm)
    Image1: TImage;
    lblCaption: TLabel;
    Label2: TLabel;
    Image2: TImage;
    lblSize1: TLabel;
    Label3: TLabel;
    Image3: TImage;
    lblSize2: TLabel;
    lblMod1: TLabel;
    lblMod2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ReplaceLocalDlg(const AFileName: string; const AFolder: string; ASize1: int64;
  AModified1: TDateTime; ASize2: int64; AModified2: TDateTime): integer;

implementation



{$R *.dfm}

function ReplaceLocalDlg(const AFileName: string; const AFolder: string; ASize1: int64;
  AModified1: TDateTime; ASize2: int64; AModified2: TDateTime): integer;
var
  FileInfo: TSHFileInfo;
begin
  with TfrmReplaceDlg.Create(Application) do
    try
      SHGetFileInfo(PChar(AFileName),
        FILE_ATTRIBUTE_NORMAL,
        FileInfo,
        SizeOf(FileInfo),
        SHGFI_USEFILEATTRIBUTES or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_LARGEICON or SHGFI_TYPENAME);
      Image2.Picture.Icon.Handle := FileInfo.hIcon;
      Image3.Picture.Icon.Handle := FileInfo.hIcon;

      lblCaption.Caption := Format(sLocalFileExists, [AFolder, AFileName]);

      lblSize1.Caption := FormatSize(ASize2, True);
      lblMod1.Caption  := FormatDateTime(sModified, AModified2);

      lblSize2.Caption := FormatSize(ASize1, True);
      lblMod2.Caption  := FormatDateTime(sModified, AModified1);

      Result := ShowModal;
    finally
      Free;
    end;
end;


procedure TfrmReplaceDlg.FormCreate(Sender: TObject);
begin
  Image1.Picture.Icon.Handle := LoadIcon(g_hmShell, PChar(145));
end;

procedure TfrmReplaceDlg.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
