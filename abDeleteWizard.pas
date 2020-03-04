unit abDeleteWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, abWizardTemplate, ComCtrls, StdCtrls, ExtCtrls,
  nsProcessFrm, nsGlobals, nsTypes;

type
  TfrmDeleteWizard = class(TfrmWizardTemplate)
    ts1: TTabSheet;
    ts2: TTabSheet;
    Panel3: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    chkProcessImmediately: TCheckBox;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    pnlProcess: TPanel;
    Image1: TImage;
    lblCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FProject: TNSProject;
    FOldProcess: TfrmProcess;
    FIntProcess: TfrmProcess;
    FNumberOfProcessed: integer;
    FList: TStrings;
    procedure InitList(const AList: TStrings);
    procedure MarkForDeletion;
  public
    { Public declarations }
    function GoForward: integer; override;
    function GoBack: integer; override;
  end;

var
  frmDeleteWizard: TfrmDeleteWizard;

function DeleteWizard(const AProject: TNSProject; const AList: TStrings): Boolean;

implementation

uses nsActions;

{$R *.dfm}

function DeleteWizard(const AProject: TNSProject; const AList: TStrings): Boolean;
begin
  frmDeleteWizard := TfrmDeleteWizard.Create(Application);
  with frmDeleteWizard do
    try
      FProject := AProject;
      InitList(AList);
      if FProject <> nil then
      begin
        FOldProcess := FProject.FProgress;
        FProject.FProgress := FIntProcess;
      end;
      Result := ShowModal = mrOk;
    finally
      if FProject <> nil then
        FProject.FProgress := FOldProcess;
      Free;
    end;
end;



procedure TfrmDeleteWizard.btnCancelClick(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1 then
  begin
    g_AbortProcess := True;
    Application.ProcessMessages;
    ModalResult := mrCancel;
  end
  else
    ModalResult := mrCancel;
end;

procedure TfrmDeleteWizard.FormCreate(Sender: TObject);
begin
  inherited;
  FIntProcess := TfrmProcess.Create(Self);
  with FIntProcess do
  begin
    Color  := clWhite;
    Parent := pnlProcess;
    BorderStyle := bsNone;
    Align  := alClient;
    pnlBottom.Visible := False;
    Visible := True;
  end;

end;

function TfrmDeleteWizard.GoBack: integer;
begin
  Result := 1;
end;

function TfrmDeleteWizard.GoForward: integer;
begin
  Result := 0;
  case PageControl.ActivePageIndex of
    0:
    begin
      MarkForDeletion;
    end;
  end;
end;

procedure TfrmDeleteWizard.InitList(const AList: TStrings);
begin
  FList := AList;
  lblCount.Caption := Format(sItemsSelectForDel, [FList.Count]);
end;

procedure TfrmDeleteWizard.MarkForDeletion;
var
  I: integer;
  Item: TNSItem;
  NeedRebuild: Boolean;
begin
  for I := 0 to FList.Count - 1 do
  begin
    Item := TNSItem(FList.Objects[I]);
    MarkItemForDeletion(FProject, Item, NeedRebuild);
  end;
  PageControl.ActivePageIndex := 1;

  //  if chkProcessImmediately.Checked then
  begin
    Self.Update;
    Application.ProcessMessages;
    g_AbortProcess := False;
    FNumberOfProcessed := ProcessProject(FProject, csDelete);
    ModalResult := mrOk;
  end;
(*
  else
  begin
    ModalResult := mrOk;
  end;
*)
end;

end.
