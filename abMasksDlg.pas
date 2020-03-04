unit abMasksDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, nsGlobals, Registry, Menus,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup;

type
  TfrmMasks = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    GroupBox1: TGroupBox;
    chklMasks: TCheckListBox;
    edtNew: TEdit;
    btnAdd: TButton;
    btnDelete: TButton;
    btnReplace: TButton;
    pmContext: TPopupActionBar;
    CheckAll2: TMenuItem;
    UncheckAll2: TMenuItem;
    N2: TMenuItem;
    Delete2: TMenuItem;
    acContext: TActionList;
    acDelete: TAction;
    acCheckAll: TAction;
    acUncheckAll: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure chklMasksClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure tbxClearClick(Sender: TObject);
    procedure tbxCheckAllClick(Sender: TObject);
    procedure tbxUnCheckAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure GetMask(const AMask: string);
    procedure SetMask(var AMask: string);
    procedure RestoreKnownMasks;
    procedure SaveKnownMasks;
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
  end;

function EditMasksDlg(const ACaption: string; var AMask: string): Boolean;

implementation

uses nsUtils, System.StrUtils;

{$R *.dfm}

function IsValidMask(const S: string): Boolean;
begin
  Result := Pos('*.', Trim(S)) = 1;
end;

function EditMasksDlg(const ACaption: string; var AMask: string): Boolean;
begin
  with TfrmMasks.Create(nil) do
    try
      Caption := StripHotkey(ACaption);
      GetMask(AMask);
      Result := ShowModal = mrOk;
      if Result then
        SetMask(AMask);
    finally
      Free;
    end;
end;

{ TMasksForm }

procedure TfrmMasks.GetMask(const AMask: string);
var
  Index: integer;
  Str: TStrings;
  I: integer;
begin
  Str := TStringList.Create;
  try
    Str.Text := ReplaceStr(AMask, #59, #13#10);
    for Index := 0 to Str.Count - 1 do
    begin
      if not IsValidMask(Str[Index]) then
        Continue;
      I := chklMasks.Items.IndexOf(Str[Index]);
      if I = -1 then
        I := chklMasks.Items.Add(Str[Index]);
      chklMasks.Checked[I] := True;
    end;
  finally
    Str.Free;
  end;
end;

procedure TfrmMasks.RestoreKnownMasks;
var
  S: string;
begin
  with TRegIniFile.Create(REG_ROOT) do
    try
      S := ReadString(REG_KEY_LASTVALUES, REG_VAL_KNOWNNEXT, sFileMask);
      chklMasks.Items.Text := ReplaceStr(S, #59, #13#10);
    finally
      Free;
    end;
end;

procedure TfrmMasks.SaveKnownMasks;
var
  S: string;
begin
  with TRegIniFile.Create(REG_ROOT) do
    try
      S := ReplaceStr(chklMasks.Items.Text, #13#10, #59);
      if (Length(S) > 0) and (S[Length(S)] = #59) then
        SetLength(S, Length(S) - 1);
      WriteString(REG_KEY_LASTVALUES, REG_VAL_KNOWNNEXT, S);
    finally
      Free;
    end;
end;

procedure TfrmMasks.SetMask(var AMask: string);
var
  Index: integer;
begin
  AMask := EmptyStr;
  for Index := 0 to chklMasks.Items.Count - 1 do
    if chklMasks.Checked[Index] then
      AMask := AMask + chklMasks.Items[Index] + #59;
  if (Length(AMask) > 0) and (AMask[Length(AMask)] = #59) then
    SetLength(AMask, Length(AMask) - 1);
end;

procedure TfrmMasks.UpdateActions;
begin
  btnDelete.Enabled := chklMasks.ItemIndex <> -1;
  btnAdd.Enabled := IsValidMask(edtNew.Text) and (chklMasks.Items.IndexOf(edtNew.Text) = -1);
  btnReplace.Enabled := IsValidMask(edtNew.Text) and (chklMasks.ItemIndex <> -1) and
    (chklMasks.Items.IndexOf(edtNew.Text) = -1);

  acCheckAll.Enabled := chklMasks.Items.Count > 0;
  acUnCheckAll.Enabled := chklMasks.Items.Count > 0;
  acDelete.Enabled := chklMasks.Items.Count > 0;
end;

procedure TfrmMasks.FormCreate(Sender: TObject);
begin
  RestoreKnownMasks;
end;

procedure TfrmMasks.FormDestroy(Sender: TObject);
begin
  SaveKnownMasks;
end;

procedure TfrmMasks.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

procedure TfrmMasks.btnAddClick(Sender: TObject);
var
  I: integer;
begin
  if IsValidMask(edtNew.Text) and (chklMasks.Items.IndexOf(Trim(edtNew.Text)) = -1) then
  begin
    I := chklMasks.Items.Add(Trim(edtNew.Text));
    chklMasks.Checked[I] := True;
  end;
end;

procedure TfrmMasks.btnReplaceClick(Sender: TObject);
begin
  if IsValidMask(edtNew.Text) and (chklMasks.ItemIndex <> -1) and
    (chklMasks.Items.IndexOf(Trim(edtNew.Text)) = -1) then
    chklMasks.Items[chklMasks.ItemIndex] := Trim(edtNew.Text);
end;

procedure TfrmMasks.chklMasksClick(Sender: TObject);
begin
  if chklMasks.ItemIndex <> -1 then
    edtNew.Text := chklMasks.Items[chklMasks.ItemIndex];
end;

procedure TfrmMasks.btnDeleteClick(Sender: TObject);
begin
  if chklMasks.ItemIndex <> -1 then
    chklMasks.Items.Delete(chklMasks.ItemIndex);
end;

procedure TfrmMasks.tbxClearClick(Sender: TObject);
begin
  if MessageDlg(sConfirmDeleteItems, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  chklMasks.Items.Clear;
end;

procedure TfrmMasks.tbxCheckAllClick(Sender: TObject);
var
  I: integer;
begin
  chklMasks.Items.BeginUpdate;
  try
    for I := 0 to chklMasks.Items.Count - 1 do
      chklMasks.Checked[I] := True;
  finally
    chklMasks.Items.EndUpdate;
  end;
end;

procedure TfrmMasks.tbxUnCheckAllClick(Sender: TObject);
var
  I: integer;
begin
  chklMasks.Items.BeginUpdate;
  try
    for I := 0 to chklMasks.Items.Count - 1 do
      chklMasks.Checked[I] := False;
  finally
    chklMasks.Items.EndUpdate;
  end;
end;

end.
