unit nsConfirmReplaceFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsGlobals, nsUtils, ShellAPI, ShlObj;

type
  TfrmConfirmReplaceDlg = class(TForm)
    Image1: TImage;
    lblCaption: TLabel;
    Label2: TLabel;
    Image2: TImage;
    Label4: TLabel;
    lblSM1: TLabel;
    Label3: TLabel;
    Image3: TImage;
    lblSM2: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    rbOverwrite: TRadioButton;
    rbNewFolder: TRadioButton;
    rbPreserve: TRadioButton;
    btnOK: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    chkDontAsk: TCheckBox;
    lblOrigin1: TEdit;
    lblOrigin2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ConfirmReplaceDlg(const AFileName: string; const AProjDir: string; ASize1: int64;
  AModified1: TDateTime; AOrigin1: string; ASize2: int64; AModified2: TDateTime; AOrigin2: string;
  out AAction: TCollisionAction): integer;

implementation



{$R *.dfm}

function ConfirmReplaceDlg(const AFileName: string; const AProjDir: string; ASize1: int64;
  AModified1: TDateTime; AOrigin1: string; ASize2: int64; AModified2: TDateTime; AOrigin2: string;
  out AAction: TCollisionAction): integer;
var
  FileInfo: TSHFileInfo;
begin
  with TfrmConfirmReplaceDlg.Create(Application) do
    try
      SHGetFileInfo(PChar(AFileName),
        FILE_ATTRIBUTE_NORMAL,
        FileInfo,
        SizeOf(FileInfo),
        SHGFI_USEFILEATTRIBUTES or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_LARGEICON or SHGFI_TYPENAME);
      Image2.Picture.Icon.Handle := FileInfo.hIcon;
      Image3.Picture.Icon.Handle := FileInfo.hIcon;

      lblCaption.Caption := Format(sFileExists, [AProjDir, AFileName]);

      lblSM1.Caption  := Format(sModifiedReplace, [FormatSize(ASize1, False), DateTimeToStr(AModified1)]);
      lblSM2.Caption  := Format(sModifiedReplace, [FormatSize(ASize2, False), DateTimeToStr(AModified2)]);
      lblOrigin1.Text := AOrigin1;
      lblOrigin2.Text := AOrigin2;

      case g_LastCollisionAction of
        caOverwrite: rbOverwrite.Checked := True;
        caNewFolder: rbNewFolder.Checked := True;
        caPreserve: rbPreserve.Checked := True;
      end;

      Result := ShowModal;
      if (Result = mrOk) or (Result = mrYesToAll) then
      begin
        if rbOverwrite.Checked then
          AAction := caOverwrite
        else if rbNewFolder.Checked then
          AAction := caNewFolder
        else
          AAction := caPreserve;
        g_LastCollisionAction := AAction;
        g_DontAskCollision := chkDontAsk.Checked;
      end;
    finally
      Free;
    end;
end;

procedure TfrmConfirmReplaceDlg.FormCreate(Sender: TObject);
begin
  Image1.Picture.Icon.Handle := LoadIcon(g_hmShell, PChar(145));
end;

procedure TfrmConfirmReplaceDlg.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
