unit nsErrRestoreFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, nsGlobals, nsTypes, StrUtils;

type
  TfrmErrorRestore = class(TForm)
    btnYes: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    cbEncryption: TComboBox;
    lblPassword: TLabel;
    edtPassword: TEdit;
    chkMask1: TCheckBox;
    btnYesToAll: TButton;
    btnIgnore: TButton;
    btnAbort: TButton;
    pbFile: TLabel;
    procedure chkMask1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FileName: string;
    procedure GetSettings(AProject: TNSProject; AItem: TNSItem);
  public
    { Public declarations }
  end;

function ErrorRestoreDialog(AOwner: TForm; AProject: TNSProject; AItem: TNSItem;
  out AMethod: TEncryptionMethod; out APassword: string): TModalResult;

implementation

uses
  nsUtils;

{$R *.dfm}

function ErrorRestoreDialog(AOwner: TForm; AProject: TNSProject; AItem: TNSItem;
  out AMethod: TEncryptionMethod; out APassword: string): TModalResult;
begin
  with TfrmErrorRestore.Create(AOwner) do
    try
      if AOwner <> nil then
        AOwner.Hide;
      GetSettings(AProject, AItem);
      Result  := ShowModal;
      AMethod := TEncryptionMethod(cbEncryption.ItemIndex);
      APassword := edtPassword.Text;
    finally
      if AOwner <> nil then
        AOwner.Show;
      Free;
    end;
end;

{ TErrorRestoreForm }

procedure TfrmErrorRestore.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmErrorRestore.GetSettings(AProject: TNSProject; AItem: TNSItem);
var
  Method: TEncryptionMethod;
begin
  Image1.Picture.Icon.Handle := LoadIcon(GetModuleHandle('User32.dll'), PChar(101));
  for Method := Low(TEncryptionMethod) to High(TEncryptionMethod) do
    cbEncryption.Items.Add(Encryptions[Method]^);
  cbEncryption.ItemIndex := Ord(g_Encryption);
  FileName := AItem.GetPathOnMedia + AItem.DisplayName;
  pbFile.Caption := FileName;
end;

procedure TfrmErrorRestore.chkMask1Click(Sender: TObject);
begin
  if chkMask1.Checked then
    edtPassword.PasswordChar := #42
  else
    edtPassword.PasswordChar := #0;
end;

end.
