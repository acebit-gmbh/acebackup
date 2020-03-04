unit nsLogFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, nsGlobals, nsTypes, nsUtils, ShellAPI, ShlObj,
  Printers, ComCtrls, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ToolWin;

type
  TfrmLogView = class(TForm)
    PrintDialog: TPrintDialog;
    SaveDialog: TSaveDialog;
    SynMemo1: TMemo;
    acLogView: TActionManager;
    acClose: TAction;
    acSaveAs: TAction;
    acPrint: TAction;
    acHelp: TAction;
    acView: TAction;
    cbViewMode: TComboBox;
    sbStatus: TStatusBar;
    ProgressBar1: TProgressBar;
    clbr1: TCoolBar;
    tlbLogView: TToolBar;
    btnacClose: TToolButton;
    btnacSaveAs: TToolButton;
    btnacPrint: TToolButton;
    btnacHelp: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    btn1: TToolButton;
    pnlLocalCaption: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbViewModeChange(Sender: TObject; const Text: string);
    procedure acViewExecute(Sender: TObject);
  private
    FProject: TNSProject;
    FStrings: TStrings;
    FStrings2: TStrings;
    procedure GetSettings(const AProject: TNSProject; const AFileName: string = '');
  end;

procedure DisplayLogDlg(const AProject: TNSProject; const AFileName: string = ''; const AShowFilter: Boolean = True);

implementation

{$R *.dfm}

procedure DisplayLogDlg(const AProject: TNSProject; const AFileName: string = ''; const AShowFilter: Boolean = True);
begin
  with TfrmLogView.Create(Application) do
    try
      Caption := Format(sLogCaption, [AProject.DisplayName]);
      sbStatus.Visible := AShowFilter;
      GetSettings(AProject, AFileName);
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmLogView.FormCreate(Sender: TObject);
begin
  FStrings  := TStringList.Create;
  FStrings2 := TStringList.Create;
end;

procedure TfrmLogView.FormDestroy(Sender: TObject);
begin
  FStrings.Free;
  FStrings2.Free;
  if cbViewMode.Visible then
    g_ViewLogMode := TViewLogMode(cbViewMode.ItemIndex);
end;

procedure TfrmLogView.btnPrintClick(Sender: TObject);
var
  Line: integer;
  PrintText: TextFile; {declares a file variable}
begin
  if PrintDialog.Execute then
  begin
    AssignPrn(PrintText); {assigns PrintText to the printer}
    Rewrite(PrintText); {creates and opens the output file}
    Printer.Canvas.Font := SynMemo1.Font; {assigns Font settings to the canvas}
    for Line := 0 to SynMemo1.Lines.Count - 1 do
      Writeln(PrintText, SynMemo1.Lines[Line]); {writes the contents of the Memo1 to the printer object}
    CloseFile(PrintText); {Closes the printer variable}
  end;
end;

procedure TfrmLogView.btnSaveAsClick(Sender: TObject);
begin
  SaveDialog.FileName := FormatDateTime('"AceBackup Report "yyyy"_"mm"_"dd"_"hh"_"nn".log"', Now);
  if SaveDialog.Execute then
  begin
    if SaveDialog.FilterIndex = 1 then
      SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sLog);
    SynMemo1.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TfrmLogView.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(HelpContext, Application.HelpFile);
end;

procedure TfrmLogView.GetSettings(const AProject: TNSProject; const AFileName: string = '');
begin
  FProject := AProject;
  if AFileName <> EmptyStr then
    FStrings.LoadFromFile(AFileName)
  else
    FStrings.Assign(FProject.GetLog);
  cbViewMode.ItemIndex := Ord(g_ViewLogMode);
  cbViewModeChange(Self, cbViewMode.Items[cbViewMode.ItemIndex]);
end;

procedure TfrmLogView.FormHide(Sender: TObject);
begin
  SaveFormSettings(Self);
end;

procedure TfrmLogView.FormShow(Sender: TObject);
begin
  RestoreFormSettings(Self);
  UpdateVistaFonts(Self);
end;

procedure TfrmLogView.cbViewModeChange(Sender: TObject; const Text: string);
var
  Index: integer;
  S: string;
begin
  FStrings2.Clear;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := FStrings.Count - 1;
  ProgressBar1.Visible := True;
  try
    SynMemo1.Lines.Clear;
    if cbViewMode.Visible and (TViewLogMode(cbViewMode.ItemIndex) = vlFailed) then
    begin
      if FStrings.Count = 0 then
        Exit;
      for Index := 0 to FStrings.Count - 1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        Application.ProcessMessages;
        S := FStrings[Index];
        if S = EmptyStr then
          Continue;
        if S[1] = #1 then
          Continue;
        FStrings2.Add(Trim(S));
      end;
    end
    else
    begin
      for Index := 0 to FStrings.Count - 1 do
      begin
        ProgressBar1.Position := ProgressBar1.Position + 1;
        Application.ProcessMessages;
        S := FStrings[Index];
        FStrings2.Add(Trim(S));
      end;
    end;
    SynMemo1.Lines.Assign(FStrings2);
  finally
    ProgressBar1.Visible := False;
  end;
end;

procedure TfrmLogView.acViewExecute(Sender: TObject);
begin
  // nothing to do here
end;

procedure TfrmLogView.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
