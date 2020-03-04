unit nsProcessFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmProcess = class(TForm)
    aniProgress: TAnimate;
    pbxFileName: TLabel;
    pbxAction: TLabel;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    lblTotalSize: TLabel;
    ProgressBar2: TProgressBar;
    lblProcSize: TLabel;
    lblTimeElapsed: TLabel;
    lblSpeed: TLabel;
    lblTimeRemaining: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    pnlBottom: TPanel;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FTotalProcessSize: int64;
    FProcessed: int64;
    FStartTick: DWORD;
    FTimeElapsed: DWORD;
    FTimeRemaining: DWORD;
    FCurItemSize: int64;
    FSpeed: int64;

    procedure SetCurAction(const Value: string);
    procedure SetCurFile(const Value: string);
    procedure SetCurItemSize(const Value: int64);
    { Private declarations }
  protected
    FDivider: DWORD;
  public
    { Public declarations }

    procedure Initialize(const ATotalProcessSize: int64);
    procedure UpdateProgress;

    procedure SetProgress(const AOperation, AFileName: string; const ACurrent, ATotal: int64);
    procedure FTPProgress(Current, Total: int64; var AClose: Boolean);

    procedure HashProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
    procedure ZipProgress(CurBlock, TotBlock: integer; var AClose: Boolean);

    procedure CopyProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
    procedure CopyProgressEx(CurBlock, TotBlock: integer; var AClose: Boolean);
    //    procedure CDRWProgress(Current, Total: Int64; var Abort: Boolean);

    property CurAction: string write SetCurAction;
    property CurFile: string write SetCurFile;

    property CurItemSize: int64 read FCurItemSize write SetCurItemSize;
  end;

var
  frmProcess: TfrmProcess = nil;

implementation

uses
  nsGlobals,
  nsUtils,
  nsTypes;

{$R *.dfm}
{$R avis.res}

procedure TfrmProcess.FormCreate(Sender: TObject);
begin
  FDivider := MAXWORD;
  DoubleBuffered := True;

  aniProgress.ResName := AVI_PROCESS;
  aniProgress.ResHandle := hInstance;
  aniProgress.Active := True;
end;

procedure TfrmProcess.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmProcess.btnCancelClick(Sender: TObject);
begin
  CurProject.KillProcessing;
end;

procedure TfrmProcess.FTPProgress(Current, Total: int64; var AClose: Boolean);
var
  CurBlock, TotBlock: integer;
  dt: DWORD;
begin
  AClose := g_AbortProcess;

  if Total > MaxInt then
  begin
    CurBlock := Current div FDivider;
    TotBlock := Total div FDivider;
  end
  else
  begin
    CurBlock := Current;
    TotBlock := Total;
  end;

  ProgressBar1.Max := TotBlock;
  ProgressBar1.Position := CurBlock;

  ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
  ProgressBar2.Position := FProcessed div FDivider + 1;

(*  if (CurBlock <> LastBlock) and (CurBlock > 1) and (CurBlock mod 3 = 0) then
  begin
    ProgressBar2.Position := ProgressBar2.Position + 1;
    LastBlock := CurBlock;
  end;
*)

  dt := GetTickCount - FStartTick - FTimeElapsed;
  FTimeElapsed := GetTickCount - FStartTick;
  lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

  FTimeRemaining := FTimeRemaining - dt;

  lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);
  Application.ProcessMessages;
end;

procedure TfrmProcess.SetCurAction(const Value: string);
begin
  pbxAction.Caption := Value;
end;

procedure TfrmProcess.SetCurFile(const Value: string);
begin
  pbxFileName.Caption := Value;
end;

procedure TfrmProcess.HashProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
var
  dt: DWORD;
begin
  AClose := g_AbortProcess;
  ProgressBar1.Max := Abs(TotBlock);
  ProgressBar1.Position := Abs(CurBlock);

  ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
  ProgressBar2.Position := FProcessed div FDivider + 1;

(*
  if (CurBlock > 1) and (CurBlock mod (FDivider div 4) = 0) then
    ProgressBar2.Position := ProgressBar2.Position + 1;
*)
  dt := GetTickCount - FStartTick - FTimeElapsed;
  FTimeElapsed := GetTickCount - FStartTick;
  lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

  FTimeRemaining := FTimeRemaining - dt;
  lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);

  Application.ProcessMessages;
end;

procedure TfrmProcess.ZipProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
var
  dt: DWORD;
begin
  AClose := g_AbortProcess;

  ProgressBar1.Max := Abs(TotBlock);
  ProgressBar1.Position := Abs(CurBlock);

(*
  if (CurBlock > 3) and (CurBlock mod 3 = 0) then
    ProgressBar2.Position := ProgressBar2.Position + 1;
*)
  ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
  ProgressBar2.Position := FProcessed div FDivider + 1;


  dt := GetTickCount - FStartTick - FTimeElapsed;

  FTimeElapsed := GetTickCount - FStartTick;
  lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

  FTimeRemaining := FTimeRemaining - dt;
  lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);

  Application.ProcessMessages;
end;

{procedure TProcessForm.CDRWProgress(Current, Total: Int64;
  var Abort: Boolean);
begin
  ProgressBar.Max := Total;
  ProgressBar.Position := Current;
  Abort := FNeedClose;
  if Current = Total then
    CurFile := sFinalizingTrack;
  Application.ProcessMessages;
  Update;
end;
}

procedure TfrmProcess.SetProgress(const AOperation, AFileName: string; const ACurrent, ATotal: int64);
var
  dt: DWORD;
  mx, ps: integer;
begin
  CurAction := AOperation;
  CurFile := AFileName;

  if ATotal > MaxInt then
  begin
    mx := ATotal div FDivider;
    ps := ACurrent div FDivider;
  end
  else
  begin
    mx := ATotal;
    ps := ACurrent;
  end;

  ProgressBar1.Max := mx;
  ProgressBar1.Position := ps;


  ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
  ProgressBar2.Position := FProcessed div FDivider + 1;

  //  ProgressBar2.Position := ProgressBar2.Position + 1;

  dt := GetTickCount - FStartTick - FTimeElapsed;

  FTimeElapsed := GetTickCount - FStartTick;
  lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

  FTimeRemaining := FTimeRemaining - dt;
  lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);
  Application.ProcessMessages;

end;

procedure TfrmProcess.Initialize(const ATotalProcessSize: int64);
begin
  try
    FDivider := MAXWORD;

    FProcessed := 0;
    FTimeElapsed := 0;
    FStartTick := GetTickCount;
    FTotalProcessSize := ATotalProcessSize;

    lblTotalSize.Caption := FormatSize(FTotalProcessSize, False);
    ProgressBar2.Position := 0;
    ProgressBar2.Max := Abs(FTotalProcessSize div FDivider + 1);


    lblProcSize.Caption := FormatSize(FProcessed, False);

    lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

    FSpeed := 100000;
    lblSpeed.Caption := FormatSize(FSpeed, False) + sPerSec;

    FTimeRemaining := round(1000 * FTotalProcessSize / (FSpeed + 1));

    lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);

  except
  end;
end;

procedure TfrmProcess.SetCurItemSize(const Value: int64);
begin
  FCurItemSize := Value;
end;

procedure TfrmProcess.UpdateProgress;
begin
  try
    FProcessed := FProcessed + FCurItemSize;
    lblProcSize.Caption := FormatSize(FProcessed, False);
    lblTotalSize.Caption := FormatSize(FTotalProcessSize - FProcessed, False);

    ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
    ProgressBar2.Position := FProcessed div FDivider + 1;

    FTimeElapsed := GetTickCount - FStartTick;
    lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

    FSpeed := 1000 * Round(FProcessed / (FTimeElapsed + 1));
    lblSpeed.Caption := FormatSize(FSpeed, False) + sPerSec;

    FTimeRemaining := round(FTimeElapsed * (FTotalProcessSize - FProcessed) / (FProcessed + 1));
    lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);


    Application.ProcessMessages;
  except
  end;
end;

procedure TfrmProcess.CopyProgress(CurBlock, TotBlock: integer; var AClose: Boolean);
var
  dt: DWORD;
begin
  AClose := g_AbortProcess;
  ProgressBar1.Max := Abs(TotBlock);
  ProgressBar1.Position := Abs(CurBlock);

  ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
  ProgressBar2.Position := FProcessed div FDivider + 1;

  dt := GetTickCount - FStartTick - FTimeElapsed;

  FTimeElapsed := GetTickCount - FStartTick;
  lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

  FTimeRemaining := FTimeRemaining - dt;
  lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);

  Application.ProcessMessages;
end;

procedure TfrmProcess.CopyProgressEx(CurBlock, TotBlock: integer; var AClose: Boolean);
var
  dt: DWORD;
begin
  AClose := g_AbortProcess;
  ProgressBar1.Max := TotBlock;
  ProgressBar1.Position := CurBlock;

  ProgressBar2.Max := FTotalProcessSize div FDivider + 1;
  ProgressBar2.Position := FProcessed div FDivider + 1;

(*
  ProgressBar2.Max := ProgressBar1.Max;
  ProgressBar2.Position := ProgressBar1.Position div 4;
*)

  dt := GetTickCount - FStartTick - FTimeElapsed;

  FTimeElapsed := GetTickCount - FStartTick;
  lblTimeElapsed.Caption := TicksToTime(FTimeElapsed);

  FTimeRemaining := FTimeRemaining - dt;
  lblTimeRemaining.Caption := TicksToTime(FTimeRemaining);

  Application.ProcessMessages;
end;

end.
