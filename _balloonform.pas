unit _balloonform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, System.Types;

type
  TFormOrientation = (foLeftBottom, foLeftTop, foRightBottom, foRightTop);

  TBallloonCloseEvent = procedure(Sender: TObject; IsChecked: Boolean; const Data: integer) of object;

  TBalloonForm = class(TForm)
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Image1: TImage;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Region, Hand: HRGN;
    BMP: TBitmap;
    br: TBrush;
    HostRect: TRect;
    FFormOrient: TFormOrientation;
    WasClosed: Boolean;
    OnBalloonClose: TBallloonCloseEvent;
    FAppData: integer;
    //    OldAppDeactivate: TNotifyEvent;
    //    procedure AppDeactivate(Sender: TObject);
  public
    { Public declarations }
  end;

const
  ii_None        = 0;
  ii_Warning     = 1;
  ii_Information = 2;
  ii_Error       = 3;

procedure CreateBalloon(const Image: byte; const ATitle, AText: string; Control: TControl;
  const AOnClose: TBallloonCloseEvent = nil; const AData: integer = 0; const Checked: Boolean = False;
  const HelpCtx: THelpContext = 0; const DelaySecs: integer = 0; const ShowCheckbox: Boolean = True;
  const CheckboxMsg: string = ''; const LearnMsg: string = '');

procedure CloseBalloon;

var
  BalloonForm: TBalloonForm;

implementation

uses nsUtils;


{$R *.DFM}

var
  HideBalloon: Boolean = False;

procedure CloseBalloon;
begin
  if BalloonForm <> nil then
    try
      FreeAndNil(BalloonForm);
    except
    end;
end;

procedure CreateBalloon(const Image: byte; const ATitle, AText: string; Control: TControl;
  const AOnClose: TBallloonCloseEvent = nil; const AData: integer = 0; const Checked: Boolean = False;
  const HelpCtx: THelpContext = 0; const DelaySecs: integer = 0; const ShowCheckbox: Boolean = True;
  const CheckboxMsg: string = ''; const LearnMsg: string = '');
type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;
var
  X, Y: integer;
  Points: array[1..3] of TPoint;
  R:  TRect;
  pt: TPoint;
  hUserLib: HMODULE;
begin
  //  if not g_Baloon then exit;
  CloseBalloon;

  BalloonForm := TBalloonForm.Create(Application);
  with BalloonForm do
  begin
    FAppData := AData;
    OnBalloonClose := AOnClose;
    Label2.Caption := ATitle;

    hUserLib := LoadLibrary('user32.dll');
    case Image of
      ii_Warning: Image1.Picture.Icon.Handle := LoadImage(hUserLib, PChar(101), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
      ii_Error: Image1.Picture.Icon.Handle := LoadImage(hUserLib, PChar(103), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
      ii_Information: Image1.Picture.Icon.Handle :=
          LoadImage(hUserLib, PChar(104), IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
      else
        Image1.Visible := False;
    end;
    FreeLibrary(hUserLib);

    if ATitle = EmptyStr then
    begin
      Label2.Visible := False;
      Label1.Top := Image1.Top + 10;
      Height := Height - Image1.Height;
    end;
    HelpContext := HelpCtx;
    if LearnMsg <> EmptyStr then
      Label3.Caption := LearnMsg;

    if HelpContext = 0 then
    begin
      Label3.Visible := False;
      Height := Height - Label3.Height;
    end;
    HostRect := Control.ClientRect;
    if Control.Parent <> nil then
      pt := Control.Parent.ClientToScreen(Point(Control.Left, Control.Top))
    else
      pt := Point(Control.Left, Control.Top);
    HostRect.Left := pt.X;
    HostRect.Top := pt.Y;
    HostRect.Right := pt.X + Control.Width;
    HostRect.Bottom := pt.Y + Control.Height;
    FFormOrient  := foRightTop;
    if (HostRect.Bottom + ClientHeight < Screen.Height) then
      if (HostRect.Left - ClientWidth > 0) then
        FFormOrient := foRightTop
      else
        FFormOrient := foLeftTop
    else
    if (HostRect.Left + ClientWidth < Screen.Width) then
      FFormOrient := foLeftBottom
    else
      FFormOrient := foRightBottom;
    Label1.Caption := AText;
    R := Label1.ClientRect;
    DrawText(Canvas.Handle, PChar(AText), -1, R, DT_LEFT or DT_CALCRECT or DT_WORDBREAK);
    if R.Bottom - R.Top > Label1.Height then
    begin
      Height := Height + R.Bottom - R.Top - Label1.Height;
      Label1.Height := R.Bottom - R.Top;
    end;
    if ShowCheckbox then
    begin
      if CheckboxMsg <> EmptyStr then
        CheckBox1.Caption := CheckboxMsg;
      CheckBox1.Width := Canvas.TextWidth(CheckBox1.Caption) + 42;
      CheckBox1.Checked := Checked;
    end
    else
      Height := Height - 30;
    X := (Width - ClientWidth) div 2;
    Y := Height - ClientHeight - X;

    Region := CreateRoundRectRgn(X + 20, Y + 20, ClientWidth - 20, ClientHeight - 8, 1, 1);
    //    Region := CreateRoundRectRgn(X + 20, Y + 20, ClientWidth - 20, ClientHeight - 8, 11, 11);

    case FFormOrient of
      foLeftBottom:
      begin
        Points[1] := Point(X + 20, ClientHeight - 30);
        Points[2] := Point(X + 35, ClientHeight - 30);
        Points[3] := Point(X, ClientHeight);
        Left := 1 + HostRect.Left;
        Top  := HostRect.Bottom - Height;
        //(HostRect.Bottom + HostRect.Top) div 2 - Height + (HostRect.Bottom - HostRect.Top) div 2;
      end;
      foLeftTop:
      begin
        Points[1] := Point(X + 35, 85);
        Points[2] := Point(X + 45, 65);
        Points[3] := Point(X + 1, Y + 10);
        Left := 1 + HostRect.Left;
        Top  := HostRect.Bottom - 32;
      end;
      foRightBottom:
      begin
        Points[1] := Point(Width - 60, ClientHeight - 75);
        Points[2] := Point(Width - 40, ClientHeight - 25);
        Points[3] := Point(ClientWidth, ClientHeight); // - 35);
        Left := HostRect.Left - 1 - ClientWidth;
        Top  := HostRect.Bottom - Height;
        //(HostRect.Bottom + HostRect.Top) div 2 - Height + (HostRect.Bottom - HostRect.Top) div 2;
      end;
      foRightTop:
      begin
        Points[1] := Point(Width - 70, 75);
        Points[2] := Point(Width - 70, 115);
        Points[3] := Point(ClientWidth, 35);
        Left := HostRect.Left - 1 - Width + 8;
        Top  := HostRect.Bottom - 38;
      end;
    end; {case...}
    Hand := CreatePolygonRgn(PPoints(@Points)^, 3, WINDING);
    CombineRgn(Region, Region, Hand, RGN_OR);
    DeleteObject(Hand);
    BMP := TBitmap.Create;
    BMP.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientRect.Right - ClientRect.Left,
      ClientRect.Bottom - ClientRect.Top);
    br  := TBrush.Create;
    br.Color := Color;
    FillRgn(BMP.Canvas.Handle, Region, Br.Handle);
    with br do
    begin
      Style := bsSolid;
      Color := $00993300;
    end;

    FrameRgn(BMP.Canvas.Handle, Region, br.Handle, 1, 1);
    SetWindowRgn(Handle, Region, True);
    WasClosed := False;
    HideBalloon := False;
    //    Application.OnDeactivate := AppDeactivate;

    ShowWindow(Handle, SW_SHOWNA);
    if ShowCheckbox then
      ShowWindow(CheckBox1.Handle, SW_SHOWNA);
    if DelaySecs <> 0 then
      Timer1.Interval := 1000 * DelaySecs
    else
    begin
      Timer1.Interval := 1000 * (10 * Length(AText) div 100);
      if Timer1.Interval < 5000 then
        Timer1.Interval := 5000;
    end;
    Timer1.Enabled := True;
  end;
end;

procedure TBalloonForm.FormDestroy(Sender: TObject);
begin
  DeleteObject(Region);
  br.Free;
  BMP.Free;
end;

procedure TBalloonForm.FormPaint(Sender: TObject);
begin
  Canvas.Draw(-((Width - ClientWidth) div 2), -(Height - ClientHeight - (Width - ClientWidth) div 2), BMP);
end;

procedure TBalloonForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //  Application.OnDeactivate := OldAppDeactivate;
  WasClosed := True;
  try
    Action := caFree;
    if Assigned(OnBalloonClose) then
      OnBalloonClose(Self, CheckBox1.Checked, FAppData);
  except
  end;
  BalloonForm := nil;
end;

procedure TBalloonForm.Label1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if (Button = mbLeft) then
    Close;
end;

procedure TBalloonForm.Timer1Timer(Sender: TObject);
begin
  Close;
end;

procedure TBalloonForm.CheckBox1Click(Sender: TObject);
begin
  if Timer1.Enabled then
    Timer1.Interval := 50;
end;

(*
procedure TBalloonForm.AppDeactivate(Sender: TObject);
begin
 Self.Close;
end;
*)

procedure TBalloonForm.Label3Click(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TBalloonForm.FormCreate(Sender: TObject);
begin
  UpdateVistaFonts(Self);
  //  OldAppDeactivate := Application.OnDeactivate;
  //  Application.OnDeactivate := AppDeactivate;
end;

end.
