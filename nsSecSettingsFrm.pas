unit nsSecSettingsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsGlobals, nsTypes;

type
  TfrmSecSettings = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    chkStorePwd: TCheckBox;
    Bevel2: TBevel;
    Panel9: TPanel;
    Image3: TImage;
    lblTitle: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtOldPwd: TEdit;
    Label4: TLabel;
    cbEncryption: TComboBox;
    Label3: TLabel;
    edtNewPwd: TEdit;
    Label5: TLabel;
    edtVerifyPwd: TEdit;
    Bevel1: TBevel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FProject: TNSProject;
    procedure GetSettings(AProject: TNSProject);
    procedure SetSettings(AProject: TNSProject);
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
  end;

function DisplaySecSettingsDialog(AOwner: TForm; AProject: TNSProject): Boolean;

implementation

uses
  nsUtils;

{$R *.dfm}

function DisplaySecSettingsDialog(AOwner: TForm; AProject: TNSProject): Boolean;
begin
  with TfrmSecSettings.Create(AOwner) do
    try
      GetSettings(AProject);
      if ShowModal = mrOk then
      begin
        SetSettings(AProject);
        Result := True;
      end
      else
        Result := False;
    finally
      Free;
    end;
end;

{ TSecSettingsForm }

procedure TfrmSecSettings.GetSettings(AProject: TNSProject);
var
  Method: TEncryptionMethod;
begin
  FProject := AProject;
  for Method := Low(TEncryptionMethod) to High(TEncryptionMethod) do
    cbEncryption.Items.Add(Encryptions[Method]^);
  cbEncryption.ItemIndex := Ord(AProject.EncryptionMethod);
  chkStorePwd.Checked := AProject.StoreArchivePwd;
end;

procedure TfrmSecSettings.SetSettings(AProject: TNSProject);
begin
  AProject.EncryptionMethod := TEncryptionMethod(cbEncryption.ItemIndex);
  AProject.ProjPwd := edtNewPwd.Text;
  AProject.StoreArchivePwd := chkStorePwd.Checked;
end;

procedure TfrmSecSettings.UpdateActions;
begin
  btnOK.Enabled := AnsiSameStr(edtOldPwd.Text, FProject.ProjPwd);
end;

procedure TfrmSecSettings.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult <> mrOk then
    CanClose := True
  else
  begin
    if cbEncryption.ItemIndex <> 0 then
    begin
      if (edtNewPwd.Text = EmptyStr) or (edtVerifyPwd.Text = EmptyStr) then
      begin
        MessageBox(
          Handle,
          PChar(sEmptyPassword),
          PChar(sChangePassword),
          $00000030);
        CanClose := False;
      end
      else if not AnsiSameStr(edtNewPwd.Text, edtVerifyPwd.Text) then
      begin
        MessageBox(
          Handle,
          PChar(sPasswordsMismatch),
          PChar(sChangePassword),
          $00000030);
        edtNewPwd.Text := EmptyStr;
        ;
        edtVerifyPwd.Text := EmptyStr;
        ;
        CanClose := False;
      end;
    end;
  end;
end;

procedure TfrmSecSettings.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmSecSettings.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(HelpContext, Application.HelpFile);
end;

end.
