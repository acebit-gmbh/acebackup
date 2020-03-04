unit nsProjPwdFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmProjectPwd = class(TForm)
    btnOK: TButton;
    edtPassword: TEdit;
    Label1: TLabel;
    Panel9: TPanel;
    Image3: TImage;
    Label3: TLabel;
    lblTitle: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    chkMask1: TCheckBox;
    chkStoreArchivePwd: TCheckBox;
    btnCancel: TButton;
    procedure chkMask1Click(Sender: TObject);
    procedure edRetypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ProjPassword(AOwner: TForm; const ACaption: string; const ATitle: string; var ARemember: Boolean): string;

implementation

uses
  nsUtils;

{$R *.dfm}

function ProjPassword(AOwner: TForm; const ACaption: string; const ATitle: string; var ARemember: Boolean): string;
begin
  Result := EmptyStr;
  with TfrmProjectPwd.Create(AOwner) do
    try
      Caption := ACaption;
      lblTitle.Caption := ATitle;
      if ShowModal = mrOk then
      begin
        Result := edtPassword.Text;
        ARemember := chkStoreArchivePwd.Checked;
      end
      else
        Result := EmptyStr;
    finally
      Free;
    end;
end;

procedure TfrmProjectPwd.chkMask1Click(Sender: TObject);
begin
  if chkMask1.Checked then
    edtPassword.PasswordChar := #42
  else
    edtPassword.PasswordChar := #0;
end;

procedure TfrmProjectPwd.edRetypeChange(Sender: TObject);
begin
  btnOK.Enabled := (edtPassword.Text <> EmptyStr);
end;

procedure TfrmProjectPwd.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
