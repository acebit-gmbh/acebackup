unit nsTaskPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmTaskPassword = class(TForm)
    Label1: TLabel;
    edtAccount: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtPass1: TEdit;
    edtPass2: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure PassChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure GetSettings(var AAccount: WideString; var APassword: WideString);
    procedure SetSettings(var AAccount: WideString; var APassword: WideString);
  public
    { Public declarations }
  end;

function SetTaskPassword(var AAccount: WideString; var APassword: WideString): Boolean;

implementation

uses nsUtils;

{$R *.dfm}

function SetTaskPassword(var AAccount: WideString; var APassword: WideString): Boolean;
begin
  with TfrmTaskPassword.Create(nil) do
    try
      GetSettings(AAccount, APassword);
      Result := ShowModal = mrOk;
      if Result then
        SetSettings(AAccount, APassword);
    finally
      Free;
    end;
end;

{ TTaskPassword }

procedure TfrmTaskPassword.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmTaskPassword.GetSettings(var AAccount, APassword: WideString);
var
  nSize: DWORD;
  sUserName: string;
begin
  nSize := MAX_PATH;
  SetLength(sUserName, nSize);
  GetUserName(PChar(sUserName), nSize);
  if AAccount <> EmptyStr then
    edtAccount.Text := AAccount
  else
    edtAccount.Text := sUserName;
end;

procedure TfrmTaskPassword.SetSettings(var AAccount, APassword: WideString);
begin
  AAccount  := edtAccount.Text;
  APassword := edtPass1.Text;
end;

procedure TfrmTaskPassword.PassChange(Sender: TObject);
begin
  btnOK.Enabled := SameText(edtPass1.Text, edtPass2.Text);
end;

end.
