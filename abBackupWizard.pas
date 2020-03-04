unit abBackupWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, abWizardTemplate, ComCtrls, StdCtrls, ExtCtrls,
  CommCtrl, ImgList, nsGlobals, nsTypes, ShellAPI, ActnList, Menus,
  nsProcessFrm, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup;

type

  TTreeView = class(ComCtrls.TTreeView)
  private
    procedure UpdateNodeState(const ANode: TTreeNode);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
  end;

  TfrmBackupWizard = class(TfrmWizardTemplate)
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts4: TTabSheet;
    Panel3: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    tvBackup: TTreeView;
    imlStateImages: TImageList;
    imlSys16: TImageList;
    btnAddFolder: TButton;
    btnAddFiles: TButton;
    btnDelete: TButton;
    OpenDialog: TOpenDialog;
    acContext: TActionList;
    acDelete: TAction;
    acCheckAll: TAction;
    acUncheckAll: TAction;
    pnlScan: TPanel;
    Label1: TLabel;
    pbxFileName: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    aniProgress: TAnimate;
    chkProcessImmediately: TCheckBox;
    Panel5: TPanel;
    lblContains: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ts3: TTabSheet;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    pnlProcess: TPanel;
    pmContext: TPopupActionBar;
    CheckAll2: TMenuItem;
    UncheckAll2: TMenuItem;
    Delete2: TMenuItem;
    N2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnAddFolderClick(Sender: TObject);
    procedure tvBackupGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure btnAddFilesClick(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acCheckAllExecute(Sender: TObject);
    procedure acUncheckAllExecute(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure tvBackupExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FProject: TNSProject;
    FOldProcess: TfrmProcess;
    FIntProcess: TfrmProcess;
    FNumberOfProcessed: integer;
    procedure ScanDir(const ADirectory: string; const AParentNode: TTreeNode);
    procedure AddFolder(const AName: string);
    procedure AddFiles(const AFileList: TStrings);
    procedure AddFile(const AFileName: string);
    function GetFullPath(const ANode: TTreeNode): string;
    function NodeExists(const APath: string): Boolean;
    function DoScan: Boolean;
    function DoBackup: Boolean;
    function DoFinish: Boolean;
    procedure SetCurFile(const Value: string);
  protected
    procedure UpdateActions; override;
    function GoForward: integer; override;
    function GoBack: integer; override;
  public
    { Public declarations }
    property CurFile: string write SetCurFile;
  end;

var
  frmBackupWizard: TfrmBackupWizard;

function BackupWizard(const AProject: TNSProject; const AList: TStrings): Boolean;

implementation

uses
  nsUtils,
  nsActions;

{$R *.dfm}

const
  NSI_UNCHECKED = 1;
  NSI_CHECKED = 2;
  NSI_UNDEFINED = 3;


function BackupWizard(const AProject: TNSProject; const AList: TStrings): Boolean;
var
  I: integer;
begin
  frmBackupWizard := TfrmBackupWizard.Create(Application);
  with frmBackupWizard do
    try
      FProject := AProject;
      if AList <> nil then
      begin
        for I := 0 to AList.Count - 1 do
        begin
          if DirectoryExists(AList[I]) then
            AddFolder(AList[I])
          else if FileExists(AList[I]) then
            AddFile(AList[I]);
        end;
        if tvBackup.Items.Count = 0 then
        begin
          MessageBox(GetActiveWindow, PChar(sNoValidItems), PChar(Application.Title), MB_ICONINFORMATION or MB_OK);
          Result := False;
          Exit;
        end;
      end;
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


{ TTreeView }

procedure TTreeView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //  Params.Style := Params.Style or TVS_CHECKBOXES;
end;

procedure TfrmBackupWizard.acCheckAllExecute(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := tvBackup.Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.StateIndex := NSI_CHECKED;
    Node := Node.GetNext;
  end;
end;

procedure TfrmBackupWizard.acDeleteExecute(Sender: TObject);
begin
  if tvBackup.Selected = nil then
    Exit;
  tvBackup.Items.Delete(tvBackup.Selected);
end;

procedure TfrmBackupWizard.acUncheckAllExecute(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := tvBackup.Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.StateIndex := NSI_UNCHECKED;
    Node := Node.GetNext;
  end;
end;

procedure TfrmBackupWizard.AddFile(const AFileName: string);
var
  Node: TTreeNode;
begin
  tvBackup.Items.BeginUpdate;
  try
    if NodeExists(AFileName) then
      Exit;
    if (FProject <> nil) and not FProject.IsValidExt(AFileName) then
      Exit;
    Node := tvBackup.Items.AddChildObject(nil, AFileName, nil);
    Node.StateIndex := NSI_CHECKED;
  finally
    tvBackup.Items.EndUpdate;
  end;
end;

procedure TfrmBackupWizard.AddFiles(const AFileList: TStrings);
var
  I: integer;
  sName: string;
  Node: TTreeNode;
begin
  tvBackup.Items.BeginUpdate;
  try
    for I := 0 to AFileList.Count - 1 do
    begin
      sName := AFileList[I];
      if NodeExists(sName) then
        Continue;
      if (FProject <> nil) and not FProject.IsValidExt(sName) then
        Continue;
      Node := tvBackup.Items.AddChildObject(nil, sName, nil);
      Node.StateIndex := NSI_CHECKED;
    end;
  finally
    tvBackup.Items.EndUpdate;
  end;
end;

procedure TfrmBackupWizard.AddFolder(const AName: string);
var
  RootNode: TTreeNode;
begin
  tvBackup.Items.BeginUpdate;
  try
    if NodeExists(AName) then
      Exit;
    RootNode := tvBackup.Items.AddChildObject(nil, AName, Pointer(1));
    RootNode.StateIndex := NSI_CHECKED;
    ScanDir(AName, RootNode);
  finally
    tvBackup.Items.EndUpdate;
  end;
end;

procedure TfrmBackupWizard.btnAddFolderClick(Sender: TObject);
var
  sFolder: String;
begin
  if SelectDir(sAddFolderToProject, sFolder) then
    AddFolder(sFolder);
end;

procedure TfrmBackupWizard.btnCancelClick(Sender: TObject);
begin
  if PageControl.ActivePageIndex in [1, 2] then
  begin
    ModalResult := mrNone;
    g_AbortScan := True;
    g_AbortProcess := True;
    Application.ProcessMessages;
  end;
end;

function TfrmBackupWizard.DoBackup: Boolean;
begin
  Result := False;
  if g_AbortScan or g_AbortProcess then
    Exit;

  PageControl.ActivePageIndex := 2;
  UpdateActions;
  Self.Update;
  Application.ProcessMessages;

  CurProject.ExecuteExternal(True);
  FNumberOfProcessed := ProcessProject(CurProject, csBackup);
  CurProject.ExecuteExternal(False);

  Result := DoFinish;
end;

function TfrmBackupWizard.DoFinish: Boolean;
begin
  UpdateActions;
  lblContains.Caption := Format(sFilesProcessed, [FNumberOfProcessed]);
  lblContains.Visible := chkProcessImmediately.Checked;
  PageControl.ActivePageIndex := 3;
  Self.Update;
  Result := True;
end;

function TfrmBackupWizard.DoScan: Boolean;
var
  st: TStringList;
  Node: TTreeNode;
begin
  Result := False;
  g_AbortScan := False;
  g_AbortProcess := False;

  AniProgress.Active := True;
  PageControl.ActivePageIndex := 1;
  Application.ProcessMessages;

  try

    st := TStringList.Create;
    tvBackup.Items.BeginUpdate;
    try
      Node := tvBackup.Items.GetFirstNode;
      while Node <> nil do
      begin
        if Node.StateIndex = NSI_CHECKED then
          st.Add(GetFullPath(Node));
        Node := Node.GetNext;
      end;


      UpdateActions;
      if g_AbortScan or g_AbortProcess then
        Abort;
      InsertItemsToProject(FProject, st, nil, 2);
      if g_AbortScan or g_AbortProcess then
        Abort;


      UpdateActions;
      Application.ProcessMessages;

      if g_AbortScan or g_AbortProcess then
        Abort;
      if chkProcessImmediately.Checked then
        DoBackup
      else
        DoFinish;

    finally
      st.Free;
      tvBackup.Items.EndUpdate;
      AniProgress.Active := False;
      Result := True;
    end;
  except
    PageControl.ActivePageIndex := 0;
    Application.ProcessMessages;
    UpdateActions;
  end;
end;

procedure TfrmBackupWizard.btnAddFilesClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    AddFiles(OpenDialog.Files);
end;

procedure TfrmBackupWizard.FormCreate(Sender: TObject);
begin
  inherited;
  aniProgress.ResName := AVI_PROCESS;
  aniProgress.ResHandle := hInstance;
  aniProgress.Active := False;
  pnlScan.DoubleBuffered := True;
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

procedure TfrmBackupWizard.FormShow(Sender: TObject);
begin
  inherited;
  imlSys16.Handle := g_himlSysSmall;

end;

function TfrmBackupWizard.GetFullPath(const ANode: TTreeNode): string;
var
  Node: TTreeNode;
begin
  Result := EmptyStr;
  Node := ANode;
  while Node <> nil do
  begin
    Result := Node.Text + sBackslash + Result;
    Node := Node.Parent;
  end;
  Result := ExcludeTrailingPathDelimiter(Result);
end;

function TfrmBackupWizard.GoBack: integer;
begin
  case PageControl.ActivePageIndex of
    2: Result := 2;
    3: Result := 3;
    else
      Result := 1;
  end;
end;

function TfrmBackupWizard.GoForward: integer;
begin
  Result := 0;
  case PageControl.ActivePageIndex of
    0:
    begin
      DoScan;
    end;
  end;
end;

function TfrmBackupWizard.NodeExists(const APath: string): Boolean;
var
  Node: TTreeNode;
begin
  Node := tvBackup.Items.GetFirstNode;
  while Node <> nil do
  begin
    if SameFileName(GetFullPath(Node), APath) then
    begin
      tvBackup.Selected := Node;
      Result := True;
      Exit;
    end;
    Node := Node.GetNext;
  end;
  Result := False;
end;

procedure TfrmBackupWizard.PopupMenu1Popup(Sender: TObject);
begin
  UpdateActions;
end;

procedure TfrmBackupWizard.ScanDir(const ADirectory: string; const AParentNode: TTreeNode);
var
  SR: TSearchRec;
  Node: TTreeNode;
begin
  AParentNode.DeleteChildren;
  FillChar(SR, SizeOf(TSearchRec), #0);
  if FindFirst(IncludeTrailingPathDelimiter(ADirectory) + sFileMask, faAnyFile, SR) <> ERROR_SUCCESS then
    Exit;
  repeat
    if (SR.Name = sDot) or (SR.Name = sDoubleDot) then
      Continue;
    if (SR.Attr and faDirectory = 0) then
    begin
      if (FProject <> nil) and not FProject.IsValidExt(SR.Name) then
        Continue;
      Node := tvBackup.Items.AddChildObject(AParentNode, SR.Name, nil);
      Node.StateIndex := AParentNode.StateIndex;
    end
    else
    begin
      Node := tvBackup.Items.AddChildObject(AParentNode, SR.Name, Pointer(1));
      Node.StateIndex := AParentNode.StateIndex;
      tvBackup.Items.AddChildFirst(Node, EmptyStr);
      //      ScanDir(IncludeTrailingBackslash(ADirectory) + SR.Name, Node);
    end;
  until FindNext(SR) <> ERROR_SUCCESS;
  FindClose(SR);
end;

procedure TfrmBackupWizard.SetCurFile(const Value: string);
begin
  pbxFileName.Caption := Value;
end;

procedure TfrmBackupWizard.tvBackupExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  ScanDir(GetFullPath(Node), Node);
end;

procedure TfrmBackupWizard.tvBackupGetImageIndex(Sender: TObject; Node: TTreeNode);
var
  FileInfo: TSHFileInfo;
  pszName:  PChar;
begin
  pszName := PChar(Node.Text);
  if Node.Data <> nil then
    SHGetFileInfo(pszName, FILE_ATTRIBUTE_DIRECTORY, FileInfo, SizeOf(FileInfo), SHGFI_SMALLICON or
      SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES)
  else
    SHGetFileInfo(pszName, FILE_ATTRIBUTE_NORMAL, FileInfo, SizeOf(FileInfo), SHGFI_SMALLICON or
      SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES);
  Node.ImageIndex := FileInfo.iIcon;
  Node.SelectedIndex := FileInfo.iIcon;
end;

procedure TfrmBackupWizard.UpdateActions;
begin
  inherited;
  case PageControl.ActivePageIndex of
    0:
    begin
      acDelete.Enabled := tvBackup.Selected <> nil;
      acCheckAll.Enabled := tvBackup.Items.Count > 0;
      acUncheckAll.Enabled := tvBackup.Items.Count > 0;
      btnNext.Enabled  := acUncheckAll.Enabled;
    end;
    1, 2:
    begin
      btnBack.Enabled := False;
      btnNext.Enabled := False;
    end;
    3:
    begin
      btnBack.Enabled := True;
      btnNext.Enabled := True;
    end;
  end;
end;

procedure TTreeView.KeyDown(var Key: word; Shift: TShiftState);
var
  Node: TTreeNode;
begin
  if (Key = VK_SPACE) and (Selected <> nil) then
  begin
    Node := Selected;
    if Node.StateIndex = NSI_UNCHECKED then
      Node.StateIndex := NSI_CHECKED
    else
      Node.StateIndex := NSI_UNCHECKED;
    UpdateNodeState(Node);
  end
  else
    inherited;
end;

procedure TTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  Node: TTreeNode;
begin
  if (Button = mbLeft) and (htOnStateIcon in GetHitTestInfoAt(X, Y)) then
  begin
    Node := GetNodeAt(X, Y);
    if Node.StateIndex = NSI_UNCHECKED then
      Node.StateIndex := NSI_CHECKED
    else
      Node.StateIndex := NSI_UNCHECKED;
    UpdateNodeState(Node);
  end
  else
    inherited;
end;


procedure TTreeView.UpdateNodeState(const ANode: TTreeNode);

  procedure UpdateChildren(const ANode: TTreeNode);
  var
    Node: TTreeNode;
  begin
    Node := ANode.GetFirstChild;
    while Node <> nil do
    begin
      Node.StateIndex := ANode.StateIndex;
      if Node.HasChildren then
        UpdateChildren(Node);
      Node := Node.getNextSibling;
    end;
  end;

  procedure UpdateParent(const ANode: TTreeNode);
  var
    Parent: TTreeNode;
    Node: TTreeNode;
    Flag: Boolean;
  begin
    Parent := ANode.Parent;
    if Parent = nil then
      Exit;
    Flag := True;
    Node := Parent.GetFirstChild;
    while (Node <> nil) and Flag do
    begin
      Flag := Flag and (ANode.StateIndex = Node.StateIndex);
      Node := Node.getNextSibling;
    end;
    if Flag then
      Parent.StateIndex := ANode.StateIndex
    else
      Parent.StateIndex := NSI_UNDEFINED;
    UpdateParent(Parent);
  end;

begin
  UpdateChildren(ANode);
  UpdateParent(ANode);
end;

end.
