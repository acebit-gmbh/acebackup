unit abRestoreWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, abWizardTemplate, ComCtrls, StdCtrls, ExtCtrls,
  CommCtrl, ImgList, nsGlobals, nsTypes, ShellAPI, ActnList, Menus,
  nsProcessFrm, StrUtils, DateUtils, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup;

type
  TTreeView = class(ComCtrls.TTreeView)
  private
    procedure UpdateNodeState(const ANode: TTreeNode);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
  end;

  TfrmRestoreWizard = class(TfrmWizardTemplate)
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts4: TTabSheet;
    Panel3: TPanel;
    Label34: TLabel;
    Label35: TLabel;
    tvRestore: TTreeView;
    imlStateImages: TImageList;
    imlSys16: TImageList;
    OpenDialog: TOpenDialog;
    acContext: TActionList;
    acCheckAll: TAction;
    acUncheckAll: TAction;
    pnlScan: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Panel5: TPanel;
    lblContains: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ts3: TTabSheet;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    pnlProcess: TPanel;
    chkProcessImmediately: TCheckBox;
    Label1: TLabel;
    rbOriginal: TRadioButton;
    rbAlternate: TRadioButton;
    edtAlternate: TEdit;
    btnBrowse: TButton;
    chkSmartRestore: TCheckBox;
    pmContext: TPopupActionBar;
    CheckAll2: TMenuItem;
    UncheckAll2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure tvRestoreGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure acCheckAllExecute(Sender: TObject);
    procedure acUncheckAllExecute(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure tvRestoreExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure rbRestoreClick(Sender: TObject);
  private
    { Private declarations }
    FProject: TNSProject;
    FOldProcess: TfrmProcess;
    FIntProcess: TfrmProcess;
    FNumberOfProcessed: integer;

    function DoScan: Boolean;
    function DoRestore: Boolean;
    function DoFinish: Boolean;

    procedure LoadProject(const AProject: TNSProject);
    procedure ScanCollection(const ACollection: TNSCollection; const AParentNode: TTreeNode);

    procedure MarkForRestore(AItem: TNSItem; var ANotExist: integer; const ASmart: Boolean);
    procedure MarkForRestoreTo(AItem: TNSItem; var ANotExist: integer; const ADest: string);

  protected
    procedure UpdateActions; override;
    function GoForward: integer; override;
    function GoBack: integer; override;
  public
    { Public declarations }
  end;

var
  frmRestoreWizard: TfrmRestoreWizard;

function RestoreWizard(const AProject: TNSProject; const AList: TStrings): Boolean;

implementation

uses
  nsActions, nsUtils;

{$R *.dfm}

const
  NSI_UNCHECKED = 1;
  NSI_CHECKED = 2;
  NSI_UNDEFINED = 3;


function RestoreWizard(const AProject: TNSProject; const AList: TStrings): Boolean;
begin
  frmRestoreWizard := TfrmRestoreWizard.Create(Application);
  with frmRestoreWizard do
    try
      LoadProject(AProject);
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

procedure TfrmRestoreWizard.acCheckAllExecute(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := tvRestore.Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.StateIndex := NSI_CHECKED;
    Node := Node.GetNext;
  end;
end;

procedure TfrmRestoreWizard.acUncheckAllExecute(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := tvRestore.Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.StateIndex := NSI_UNCHECKED;
    Node := Node.GetNext;
  end;
end;


procedure TfrmRestoreWizard.btnCancelClick(Sender: TObject);
begin
  if PageControl.ActivePageIndex = 1 then
  begin
    ModalResult := mrNone;
    g_AbortScan := True;
    Application.ProcessMessages;
    PageControl.ActivePageIndex := 0;
  end
  else
  if PageControl.ActivePageIndex = 2 then
  begin
    ModalResult := mrNone;
    g_AbortProcess := True;
    Application.ProcessMessages;
    PageControl.ActivePageIndex := 0;
  end
  else
    ModalResult := mrCancel;
end;

procedure TfrmRestoreWizard.btnBrowseClick(Sender: TObject);
var
  sFolder: String;
begin
  if DirectoryExists(edtAlternate.Text) then
    sFolder := edtAlternate.Text;
  if SelectDir(EmptyStr, sFolder) then
    edtAlternate.Text := sFolder;
end;

function TfrmRestoreWizard.DoRestore: Boolean;
begin
  PageControl.ActivePageIndex := 2;
  Self.Update;
  Application.ProcessMessages;
  g_AbortProcess := False;
  CurProject.ExecuteExternal(True);
  FNumberOfProcessed := ProcessProject(FProject, csRestore);
  CurProject.ExecuteExternal(False);
  Result := DoFinish;
end;

function TfrmRestoreWizard.DoFinish: Boolean;
begin
  lblContains.Caption := Format(sFilesProcessed, [FNumberOfProcessed]);
  lblContains.Visible := chkProcessImmediately.Checked;
  PageControl.ActivePageIndex := 3;
  Self.Update;
  Result := True;
end;

function TfrmRestoreWizard.DoScan: Boolean;
var
  Node: TTreeNode;
  iNotExist: integer;
  Item: TNSItem;
begin
  Result := False;
  g_AbortProcess := False;
  g_AbortScan := False;
  try

    Self.Update;
    Application.ProcessMessages;
    UpdateActions;
    tvRestore.Items.BeginUpdate;
    try
      Node := tvRestore.Items.GetFirstNode;
      while Node <> nil do
      begin
        if Node.StateIndex = NSI_CHECKED then
        begin
          Item := TNSItem(Node.Data);
          if g_AbortScan or g_AbortProcess then
            Abort;
          if Item <> nil then
          begin
            if rbOriginal.Checked then
              MarkForRestore(Item, iNotExist, chkSmartRestore.Checked)
            else
              MarkForRestoreTo(Item, iNotExist, edtAlternate.Text);
          end;

        end;
        Node := Node.GetNext;
      end;

      if g_AbortScan or g_AbortProcess then
        Abort;
      if chkProcessImmediately.Checked then
        DoRestore
      else
        DoFinish;
    finally
      tvRestore.Items.EndUpdate;
      Result := True;
    end;
  except
    PageControl.ActivePageIndex := 0;
    Application.ProcessMessages;
    UpdateActions;
  end;
end;

procedure TfrmRestoreWizard.FormCreate(Sender: TObject);
begin
  inherited;
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

procedure TfrmRestoreWizard.FormShow(Sender: TObject);
begin
  inherited;
  imlSys16.Handle := g_himlSysSmall;
  rbRestoreClick(nil);
end;

function TfrmRestoreWizard.GoBack: integer;
begin
  case PageControl.ActivePageIndex of
    3: Result := 2;
    else
      Result := 1;
  end;
end;

function TfrmRestoreWizard.GoForward: integer;
begin
  case PageControl.ActivePageIndex of
    1:
    begin
      Result := 0;
      DoScan;
    end;
    else
      Result := 1;
  end;
end;

procedure TfrmRestoreWizard.LoadProject(const AProject: TNSProject);
begin
  tvRestore.Items.BeginUpdate;
  try
    FProject := AProject;
    ScanCollection(FProject.Items, nil);
  finally
    tvRestore.Items.EndUpdate;
  end;
end;

procedure TfrmRestoreWizard.MarkForRestore(AItem: TNSItem; var ANotExist: integer; const ASmart: Boolean);
var
  Modified: Boolean;

  procedure SetState(const AItem: TNSitem);
  var
    SR: TSearchRec;
    sLocalFile: string;
    xTime: TDateTime;
  begin
    if ASmart then
    begin
      sLocalFile := IncludeTrailingPathDelimiter(AItem.LocalPath) + AItem.DisplayName;
      if FindFirst(sLocalFile, faAnyFile, SR) = 0 then
      begin
        xTime := FileGetModified(SR);
        if CompareDateTime(AItem.Modified, xTime) > 0 then
        begin
          AItem.State := isRestore;
          AItem.NotProcessed := True;
        end;
      end
      else
      begin
        AItem.State := isRestore;
        AItem.NotProcessed := True;
      end;
    end
    else
    begin
      AItem.State := isRestore;
      AItem.NotProcessed := True;
    end;
    if AItem.State = isRestore then
      Modified := True;
  end;

  procedure ScanSubItems(ACollection: TNSCollection);
  var
    Index: integer;
    Item:  TNSItem;
  begin
    for Index := 0 to ACollection.Count - 1 do
    begin
      Item := ACollection.Items[Index];
      with Item do
      begin
        if not Exists then
        begin
          Inc(ANotExist);
          Continue;
        end;
        if IsFolder then
          ScanSubItems(SubItems)
        else
        begin
          SetState(Item);
        end;
        DestFolder := EmptyStr;
      end;
    end;
  end;

begin
  if AItem = nil then
    Exit
  else
  begin
    if AItem.Exists then
    begin
      if AItem.IsFolder then
        ScanSubItems(AItem.SubItems)
      else
      begin
        SetState(AItem);
      end;
    end
    else
      Inc(ANotExist);
  end;
end;

procedure TfrmRestoreWizard.MarkForRestoreTo(AItem: TNSItem; var ANotExist: integer; const ADest: string);
var
  tmpDest: string;

  procedure ScanSubItems(ACollection: TNSCollection; const ADestFolder: string);
  var
    Index: integer;
    CItem: TNSItem;
    sDest: string;
  begin
    for Index := 0 to ACollection.Count - 1 do
    begin
      CItem := ACollection.Items[Index];
      if not CItem.Exists then
      begin
        Inc(ANotExist);
        Continue;
      end;
      if CItem.IsFolder then
      begin
        if ExtractFileDrive(CItem.DisplayName) <> EmptyStr then
          sDest := IncludeTrailingPathDelimiter(ADestFolder)
        else
          sDest := IncludeTrailingPathDelimiter(ADestFolder) + CItem.DisplayName;
        ScanSubItems(CItem.SubItems, sDest);
      end
      else
      begin
        CItem.DestFolder := ADestFolder;
        CItem.State := isRestore;
      end;
      CItem.NotProcessed := True;
    end;
  end;

begin
  if AItem = nil then
  begin
    tmpDest := IncludeTrailingPathDelimiter(ADest);
    ScanSubItems(FProject.ActiveVolume.Items, tmpDest);
  end
  else
  begin
    if not AItem.Exists then
      Inc(ANotExist)
    else
    begin
      if AItem.IsFolder then
      begin
        if ExtractFileDrive(AItem.DisplayName) <> EmptyStr then
          tmpDest := IncludeTrailingPathDelimiter(ADest)
        else
          tmpDest := IncludeTrailingPathDelimiter(ADest) + AItem.DisplayName;
        ScanSubItems(AItem.SubItems, tmpDest);
      end
      else
      begin
        AItem.DestFolder := ADest;
        AItem.State := isRestore;
      end;
      AItem.NotProcessed := True;
    end;
  end;
end;

procedure TfrmRestoreWizard.PopupMenu1Popup(Sender: TObject);
begin
  UpdateActions;
end;

procedure TfrmRestoreWizard.rbRestoreClick(Sender: TObject);
begin
  edtAlternate.Enabled := rbAlternate.Checked;
  btnBrowse.Enabled := rbAlternate.Checked;
  chkSmartRestore.Enabled := rbOriginal.Checked;
end;

procedure TfrmRestoreWizard.ScanCollection(const ACollection: TNSCollection; const AParentNode: TTreeNode);
var
  Node: TTreeNode;
  Item: TNSItem;
  I: integer;
begin
  if AParentNode <> nil then
    AParentNode.DeleteChildren;
  for I := 0 to ACollection.Count - 1 do
  begin
    Item := ACollection[I];
    Node := tvRestore.Items.AddChildObject(AParentNode, Item.DisplayName, Item);
    Node.StateIndex := NSI_UNCHECKED;
    if Item.IsFolder then
      tvRestore.Items.AddChild(Node, EmptyStr);
  end;
end;


procedure TfrmRestoreWizard.tvRestoreExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
var
  Collection: TNSCollection;
begin
  if (Node <> nil) and (Node.Data <> nil) then
  begin
    Collection := TNSItem(Node.Data).SubItems;
    ScanCollection(Collection, Node);
  end;
end;

procedure TfrmRestoreWizard.tvRestoreGetImageIndex(Sender: TObject; Node: TTreeNode);
var
  FileInfo: TSHFileInfo;
  pszName: PChar;
  Item: TNSItem;
begin
  if Node.Data = nil then
    Exit;
  Item := TNSItem(Node.Data);
  pszName := PChar(Item.DisplayName);

  if Item.IsFolder then
    SHGetFileInfo(pszName, FILE_ATTRIBUTE_DIRECTORY, FileInfo, SizeOf(FileInfo), SHGFI_SMALLICON or
      SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES)
  else
    SHGetFileInfo(pszName, FILE_ATTRIBUTE_NORMAL, FileInfo, SizeOf(FileInfo), SHGFI_SMALLICON or
      SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES);
  Node.ImageIndex := FileInfo.iIcon;
  Node.SelectedIndex := FileInfo.iIcon;
end;

procedure TfrmRestoreWizard.UpdateActions;
begin
  inherited;
  case PageControl.ActivePageIndex of
    0:
    begin
      acCheckAll.Enabled := tvRestore.Items.Count > 0;
      acUncheckAll.Enabled := tvRestore.Items.Count > 0;
      btnNext.Enabled := acUncheckAll.Enabled;
    end;
    1:
    begin
      btnNext.Enabled := rbOriginal.Checked or (rbAlternate.Checked and DirectoryExists(edtAlternate.Text));
    end;
    2:
    begin
      btnBack.Enabled := False;
      btnNext.Enabled := False;
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
