unit nsConfirmUpdateFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsGlobals, nsTypes, nsUtils, ShellAPI, ShlObj;

type
  TfrmConfirmUpdateDlg = class(TForm)
    Bevel1: TBevel;
    btnYes: TButton;
    btnCancel: TButton;
    btnNo: TButton;
    btnYesToAll: TButton;
    Image1: TImage;
    lblCaption: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Label3: TLabel;
    Image3: TImage;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Modified1: TLabel;
    Modified2: TLabel;
    Size1: TLabel;
    Size2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ConfirmUpdateDlg(const AProject: TNSProject; const AItem: TNSItem; const ANewRec: TSearchRec): integer;

implementation



{$R *.dfm}

function ConfirmUpdateDlg(const AProject: TNSProject; const AItem: TNSItem; const ANewRec: TSearchRec): integer;
var
  FileInfo: TSHFileInfo;
begin
  with TfrmConfirmUpdateDlg.Create(Application) do
    try
      Caption := Format(sRefresh, [AProject.DisplayName]);
      lblCaption.Caption := Format(sNewDetected, [AItem.DisplayName, AItem.LocalPath]);

      SHGetFileInfo(PChar(AItem.DisplayName),
        FILE_ATTRIBUTE_NORMAL,
        FileInfo,
        SizeOf(FileInfo),
        SHGFI_USEFILEATTRIBUTES or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_LARGEICON);
      Image2.Picture.Icon.Handle := FileInfo.hIcon;
      Image3.Picture.Icon.Handle := FileInfo.hIcon;


      Modified2.Caption := DateTimeToStr(FileGetModified(ANewRec));
      Size2.Caption := FormatSize(FileGetSize(ANewRec), True);

      Modified1.Caption := DateTimeToStr(AItem.Modified);
      Size1.Caption := FormatSize(AItem.Size, True);

      Result := ShowModal;
      case Result of
        mrYesToAll: g_AutoRefresh := True;
        mrCancel: g_AbortRefresh  := True;
      end;
    finally
      Free;
    end;
end;

procedure TfrmConfirmUpdateDlg.FormCreate(Sender: TObject);
begin
  Image1.Picture.Icon.Handle := LoadIcon(g_hmShell, PChar(146));
end;

procedure TfrmConfirmUpdateDlg.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
