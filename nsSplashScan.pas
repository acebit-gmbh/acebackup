unit nsSplashScan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, nsGlobals;

type
  TfrmScanner = class(TForm)
    btnCancel: TButton;
    pbxFileName: TLabel;
    Label1: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SetCurFile(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property CurFile: string write SetCurFile;
  end;

var
  frmScanner: TfrmScanner;
  AbortScan:  Boolean;

procedure ShowScanSplash;
procedure HideScanSplash;

implementation

uses nsUtils;

{$R *.dfm}

procedure ShowScanSplash;
begin
  AbortScan := False;
  if frmScanner = nil then
    frmScanner := TfrmScanner.Create(Application);
  frmScanner.Show;

  Application.MainForm.Enabled := False;
  frmScanner.Update;
  SetForegroundWindow(frmScanner.Handle);
end;

procedure HideScanSplash;
begin
  Application.MainForm.Enabled := True;
  frmScanner.Hide;
  FreeAndNil(frmScanner);
end;


procedure TfrmScanner.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmScanner.SetCurFile(const Value: string);
begin
  pbxFileName.Caption := Value;
end;

procedure TfrmScanner.btnCancelClick(Sender: TObject);
begin
  g_AbortScan := True;
  AbortScan := True;
end;

end.
