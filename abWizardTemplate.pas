unit abWizardTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsGlobals, ComCtrls;

type

  TPageControl = class(ComCtrls.TPageControl)
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
  end;

  TfrmWizardTemplate = class(TForm)
    Bevel5: TBevel;
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    PageControl: TPageControl;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    FWizardReady: Boolean;
    procedure UpdateActions; override;
    function GoForward: integer; virtual;
    function GoBack: integer; virtual;
  public
    { Public declarations }
  end;

var
  frmWizardTemplate: TfrmWizardTemplate;

implementation

uses nsUtils;

{$R *.dfm}

{$R bmps.res}

procedure TfrmWizardTemplate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then
    CanClose := FWizardReady
  else
    CanClose := MessageDlg(sConfirmWizardExit, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TfrmWizardTemplate.UpdateActions;
begin
  inherited UpdateActions;
  btnBack.Enabled := PageControl.ActivePageIndex > 0;
  if PageControl.ActivePageIndex = PageControl.PageCount - 1 then
  begin
    btnNext.Caption := sFinish;
    btnNext.ModalResult := mrOk;
  end
  else
  begin
    btnNext.Caption := sNext;
    btnNext.ModalResult := mrNone;
  end;
end;

procedure TfrmWizardTemplate.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  FWizardReady := True;
end;

function TfrmWizardTemplate.GoForward: integer;
begin
  if PageControl.ActivePageIndex < PageControl.PageCount - 1 then
    Result := 1
  else
    Result := 0;
end;

function TfrmWizardTemplate.GoBack: integer;
begin
  if PageControl.ActivePageIndex > 0 then
    Result := 1
  else
    Result := 0;
end;

procedure TfrmWizardTemplate.btnNextClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := PageControl.ActivePageIndex + GoForward;
end;

procedure TfrmWizardTemplate.btnBackClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := PageControl.ActivePageIndex - GoBack;
end;

{ TPageControl }

procedure TPageControl.AdjustClientRect(var Rect: TRect);
begin
  Rect := DisplayRect;
  InflateRect(Rect, 6, 6);
end;

procedure TfrmWizardTemplate.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    Application.HelpContext(HelpContext);
end;

procedure TfrmWizardTemplate.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
