unit abWaitDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmWaitDlg = class(TForm)
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WaitProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
  end;

var
  frmWaitDlg: TfrmWaitDlg;

implementation

uses
  //nsMainFrm,
  nsUtils;

{$R *.dfm}

procedure TfrmWaitDlg.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
end;

procedure TfrmWaitDlg.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmWaitDlg.WaitProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
begin
  ProgressBar1.Max := TotBlock;
  ProgressBar1.Position := CurBlock;
  Application.ProcessMessages;
end;

end.
