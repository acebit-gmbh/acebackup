unit nsMainFrm;

{$J+}

interface

uses
  System.Classes, Winapi.Windows, Winapi.Messages, Winapi.ActiveX, Vcl.ActnColorMaps,
  Vcl.ActnCtrls, Vcl.ActnList, Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnPopup, Vcl.ComCtrls,
  Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms, Vcl.ImgList, Vcl.Menus, System.UITypes,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Shell.ShellCtrls, Vcl.StdCtrls, Vcl.ToolWin,
  tsTaskman, nsGlobals, nsTypes, System.Actions, System.ImageList;

type
  TfrmMain = class(TForm)
    acAbout: TAction;
    acBackupWizard: TAction;
    acCloseProject: TAction;
    acConnect: TAction;
    acCopy: TAction;
    acDelete: TAction;
    acDeleteWizard: TAction;
    acDisconnect: TAction;
    acExit: TAction;
    acHelpContents: TAction;
    acImport: TAction;
    acLocalDelete: TAction;
    acLocalProperties: TAction;
    acLocalSystem: TAction;
    acLocalUp: TAction;
    acMarkBackup: TAction;
    acMarkNormal: TAction;
    acMarkRestore: TAction;
    acMarkRestoreTo: TAction;
    acMoreHello: TAction;
    acMorePassword: TAction;
    acMoreRanking: TAction;
    acMoreSurvey: TAction;
    acMoreWise: TAction;
    acNewFolder: TAction;
    acNewLocalFolder: TAction;
    acNewProject: TAction;
    acOpen: TAction;
    acOpenProject: TAction;
    acOpenRemote: TAction;
    acOptions: TAction;
    acPaste: TAction;
    acPasteLocal: TAction;
    acPasteProject: TAction;
    acProcessAll: TAction;
    acProcessBackup: TAction;
    acProcessDelete: TAction;
    acProcessRestore: TAction;
    acProjectProperties: TAction;
    acProperties: TAction;
    acRefresh: TAction;
    acRemoteProperties: TAction;
    acRemoteUp: TAction;
    acRename: TAction;
    acReopen: TAction;
    acReset: TAction;
    acRestoreSmart: TAction;
    acRestoreWizard: TAction;
    acSaveAs: TAction;
    acSaveProject: TAction;
    acSelectAll: TAction;
    acStatusBar: TAction;
    acSynchronize: TAction;
    actToolbarLocal: TAction;
    actToolbarRemote: TAction;
    acTutorial: TAction;
    acUp: TAction;
    acVerify: TAction;
    acViewLog: TAction;
    acVolume: TAction;
    amMainmenu: TActionManager;
    cbVolumes: TComboBox;
    iml16d: TImageList;
    iml16n: TImageList;
    iml24d: TImageList;
    iml24n: TImageList;
    imlStatusBar: TImageList;
    lvRemote: TListView;
    miAbout: TMenuItem;
    miClose: TMenuItem;
    miConnect: TMenuItem;
    miCopy: TMenuItem;
    miDelete: TMenuItem;
    miDisconnect: TMenuItem;
    miEdit: TMenuItem;
    miExit: TMenuItem;
    miFile: TMenuItem;
    miHelloEngines: TMenuItem;
    miHelp: TMenuItem;
    miHelptopics: TMenuItem;
    miImport: TMenuItem;
    miMoreproducts: TMenuItem;
    miNew: TMenuItem;
    miOpen: TMenuItem;
    miOptions: TMenuItem;
    miPasswordDepot: TMenuItem;
    miPaste: TMenuItem;
    miPopAddtoBackup: TMenuItem;
    miPopCopyLoc: TMenuItem;
    miPopDeleteLoc: TMenuItem;
    miPopDeleteLV: TMenuItem;
    miPopDeleteTV: TMenuItem;
    miPopOpenLV: TMenuItem;
    miPopPasteLoc: TMenuItem;
    miPopPasteLV: TMenuItem;
    miPopPropertiesLoc: TMenuItem;
    miPopPropertiesLV: TMenuItem;
    miPopPropertiesLV2: TMenuItem;
    miPopPropertiesTV: TMenuItem;
    miPopRefresh: TMenuItem;
    miPopRenameLV: TMenuItem;
    miPopRenameTV: TMenuItem;
    miPopRevertLV: TMenuItem;
    miPopRevertTV: TMenuItem;
    miPopUpdateLV: TMenuItem;
    miPopUpdateTV: TMenuItem;
    miProcess: TMenuItem;
    miProcessall: TMenuItem;
    miProcessBackup: TMenuItem;
    miProcessDelete: TMenuItem;
    miProcessRestore: TMenuItem;
    miProject: TMenuItem;
    miProjectlog: TMenuItem;
    miProperties: TMenuItem;
    miProperty: TMenuItem;
    miRankingToolbox: TMenuItem;
    miRefresh: TMenuItem;
    miRename: TMenuItem;
    miReopen: TMenuItem;
    miSave: TMenuItem;
    miSaveAs: TMenuItem;
    miSelectAll: TMenuItem;
    miStatusbar: TMenuItem;
    miToolBackup: TMenuItem;
    miToolbar: TMenuItem;
    miToolLocal: TMenuItem;
    miTools: TMenuItem;
    miTutorial: TMenuItem;
    miVerify: TMenuItem;
    miView: TMenuItem;
    miViewLocal: TMenuItem;
    miWinSurvey: TMenuItem;
    miWISEFTP: TMenuItem;
    miWizBackup: TMenuItem;
    miWizRestore: TMenuItem;
    mmMainMenu: TMainMenu;
    OpenDialog: TOpenDialog;
    pmLocalSystem: TPopupMenu;
    pmRemoteLV1: TPopupMenu;
    pmRemoteLV2: TPopupMenu;
    pmRemoteTV: TPopupMenu;
    pnlBackupCaption: TPanel;
    pnlLocalCaption: TPanel;
    pnlLocalLV: TPanel;
    pnlLocalSystem: TPanel;
    pnlLocalTV: TPanel;
    pnlMain: TPanel;
    pnlRemote: TPanel;
    pnlSystem: TPanel;
    Resetupdates1: TMenuItem;
    SaveDialog: TSaveDialog;
    sbMain: TStatusBar;
    sepEdit: TMenuItem;
    sepFile1: TMenuItem;
    sepFile2: TMenuItem;
    sepFile3: TMenuItem;
    sepHelp1: TMenuItem;
    sepHelp2: TMenuItem;
    sepPopLocal1: TMenuItem;
    sepPopLocal2: TMenuItem;
    sepPopLocal3: TMenuItem;
    sepPopLV1: TMenuItem;
    sepPopLV2: TMenuItem;
    sepPopLV3: TMenuItem;
    sepPopLV4: TMenuItem;
    sepPopLV5: TMenuItem;
    sepPopTV1: TMenuItem;
    sepPopTV2: TMenuItem;
    sepProcess: TMenuItem;
    sepProject1: TMenuItem;
    sepProject2: TMenuItem;
    sepProject3: TMenuItem;
    sepProject4: TMenuItem;
    sepView1: TMenuItem;
    sepView2: TMenuItem;
    spAreas: TSplitter;
    spBackup: TSplitter;
    spLocal: TSplitter;
    tvRemote: TTreeView;
    tlbLocalSystem: TToolBar;
    btnacUp: TToolButton;
    btn1: TToolButton;
    btnacCopy: TToolButton;
    btnacPasteLocal: TToolButton;
    btnacDelete: TToolButton;
    btn2: TToolButton;
    btnacRemoteProperties: TToolButton;
    btn3: TToolButton;
    btnacRefresh: TToolButton;
    btn4: TToolButton;
    btnacMarkBackup: TToolButton;
    tlbBackupProject: TToolBar;
    btnacNewProject: TToolButton;
    btn6: TToolButton;
    btnacOpenProject: TToolButton;
    btnacCloseProject: TToolButton;
    btn9: TToolButton;
    btnacBackupWizard: TToolButton;
    btnacRestoreWizard: TToolButton;
    btn12: TToolButton;
    btnacSynchronize: TToolButton;
    btn14: TToolButton;
    btnacVerify: TToolButton;
    btnacProcessAll: TToolButton;
    btn17: TToolButton;
    btn18: TToolButton;
    clbrProject: TCoolBar;
    clbrLocalSystem: TCoolBar;
    miSortitems: TMenuItem;
    miByName: TMenuItem;
    miBySize: TMenuItem;
    miByType: TMenuItem;
    miByDate: TMenuItem;
    miByLoc: TMenuItem;
    procedure acNewProjectExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acCloseProjectExecute(Sender: TObject);
    procedure acOpenProjectExecute(Sender: TObject);
    procedure acNewFolderExecute(Sender: TObject);
    procedure tvRemoteEdited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure acRenameExecute(Sender: TObject);
    procedure tvRemoteMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure tvRemoteChange(Sender: TObject; Node: TTreeNode);
    procedure lvRemoteEdited(Sender: TObject; Item: TListItem; var S: string);
    procedure lvRemoteDblClick(Sender: TObject);
    procedure acUpExecute(Sender: TObject);
    procedure lvRemoteCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      var DefaultDraw: boolean);
    procedure tvRemoteCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
      var DefaultDraw: boolean);
    procedure lvRemoteCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: integer; State: TCustomDrawState; var DefaultDraw: boolean);
    procedure acProcessAllExecute(Sender: TObject);
    procedure lvRemoteColumnClick(Sender: TObject; Column: TListColumn);
    procedure acMarkRestoreExecute(Sender: TObject);
    procedure acDeleteWizardExecute(Sender: TObject);
    procedure acResetExecute(Sender: TObject);
    procedure acOptionsExecute(Sender: TObject);
    procedure acMarkRestoreToExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acPasteProjectExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acStatusBarExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure acSelectAllExecute(Sender: TObject);
    procedure acLocalDeleteExecute(Sender: TObject);
    procedure acPasteExecute(Sender: TObject);
    procedure acPasteLocalExecute(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure acProjectPropertiesExecute(Sender: TObject);
    procedure acPropertiesExecute(Sender: TObject);
    procedure acLocalPropertiesExecute(Sender: TObject);
    procedure acRemotePropertiesExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acLocalUpExecute(Sender: TObject);
    procedure acRemoteUpExecute(Sender: TObject);
    procedure acImportExecute(Sender: TObject);
    procedure acViewLogExecute(Sender: TObject);
    procedure popRemoteTVPopup(Sender: TObject);
    procedure lvRemoteContextPopup(Sender: TObject; MousePos: TPoint; var Handled: boolean);
    procedure PopSortClick(Sender: TObject);
    procedure acDisconnectExecute(Sender: TObject);
    procedure acConnectExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure acVerifyExecute(Sender: TObject);
    procedure popRemoteLV1Popup(Sender: TObject);
    procedure popRemoteLV2Popup(Sender: TObject);
    procedure acSaveProjectExecute(Sender: TObject);
    procedure acSaveAsExecute(Sender: TObject);
    procedure tvRemoteCompare(Sender: TObject; Node1, Node2: TTreeNode; Data: integer; var Compare: integer);
    procedure acMarkBackupExecute(Sender: TObject);
    procedure acOpenExecute(Sender: TObject);
    procedure acProcessBackupExecute(Sender: TObject);
    procedure acProcessDeleteExecute(Sender: TObject);
    procedure acProcessRestoreExecute(Sender: TObject);
    procedure tvRemoteGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvRemoteGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure acNewLocalFolderExecute(Sender: TObject);
    procedure popProcessPopup(Sender: TObject);
    procedure acMarkNormalExecute(Sender: TObject);
    procedure acHelpContentsExecute(Sender: TObject);
    procedure ClickMoreProducts(Sender: TObject);
    procedure tvRemoteEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: boolean);
    procedure acSynchronizeExecute(Sender: TObject);
    procedure cbVolumesSelect(Sender: TObject);
    procedure acTutorialExecute(Sender: TObject);
    procedure acBackupWizardExecute(Sender: TObject);
    procedure acRestoreWizardExecute(Sender: TObject);
    procedure popLocalSystemPopup(Sender: TObject);
    procedure acReopenExecute(Sender: TObject);
    procedure acLocalSystemExecute(Sender: TObject);
    procedure sbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbMainDblClick(Sender: TObject);
    procedure acVolumeExecute(Sender: TObject);
    procedure actToolbarLocalExecute(Sender: TObject);
    procedure actToolbarRemoteExecute(Sender: TObject);
  protected
    procedure UpdateActions; override;
    procedure UpdateStatusBar;
    procedure CDFinish(Sender: TObject);
    procedure AppHint(Sender: TObject);
    procedure StatusChanged(var Msg: TMessage); message NSN_STATUSCHANGED;
    procedure UpdateFolder(var Msg: TMessage); message NSN_UPDATEFOLDER;
    procedure RemoveItem(var Msg: TMessage); message NSN_REMOVEITEM;
    procedure RemoveFolder(var Msg: TMessage); message NSN_REMOVEFOLDER;
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure WMScheduledProcess(var Msg: TMessage); message WM_SCHEDULEDPROCESS;
    procedure WMActivateInstance(var Msg: TMessage); message WM_ACTIVATEINSTANCE;
  private
    tvLocal: TShellTreeView;
    lvLocal: TShellListView;
    FRemoteTVTarget: IDropTarget;
    FRemoteLVTarget: IDropTarget;
    FRefCount: integer;
    FFirstTimeActivated: boolean;

    function CanDeleteLocalFolder: boolean;
    procedure UpdateListItem(Item: TListItem);
    procedure UpdateTreeNode(ANode: TTreeNode);
    procedure FillListView(ACollection: TNSCollection);
    procedure FillTreeView(AProject: TNSProject);
    procedure RestoreActions;
    procedure SaveActions;
    procedure LayoutChanged;
    procedure HandlePopupMenu(ASender: TPopupMenu);
    procedure UpdateCaption;
    function ProjectSaved: boolean;
    procedure MarkForRestore(AItem: TNSItem; var ANotExist: integer; var AEmptyPath: boolean;
      const ASmart: boolean);
    procedure MarkForRestoreTo(AItem: TNSItem; var ANotExist: integer; const ADest: string);
    procedure FillVolumesCombo;
    procedure MRUListChange(Sender: TObject);
    procedure InsertMRUList(AAction: TAction);
    procedure DeleteItems(Items: TStrings);
    function FilesCopyToClipBoard(Filenames: TStrings): Boolean;
    procedure FilesPasteFromClipboard(Filenames: TStrings);
  public
    TaskManager: TTaskScheduler;
    CurTask: TTaskItem;
    MRUList: TStringList;

    function OpenProject(const AFileName: string): boolean;
    function CloseProject: boolean;
    procedure CheckApply;
    procedure AddToBackup(const AList: TStringList);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  Winapi.CommCtrl, Winapi.ShellAPI, Winapi.WinInet, Winapi.ShlObj,
  Vcl.Clipbrd, Vcl.Graphics, Vcl.HTMLHelpViewer,
  System.DateUtils, System.SysUtils, System.Win.Registry,
  abBackupWizard, abDeleteWizard, abRestoreWizard, abWizardFrm, cdWrapper,
  nsAboutFrm, nsActions, nsDataObjects, nsFolderFrm, nsImportFrm, nsItemFrm,
  nsLogFrm, nsMultiFrm, nsOptionsFrm, nsProcessFrm, nsProjectFrm, nsProjPwdFrm,
  nsUtils, nsVerifyFrm;

type
  TShellTVHelper = class helper for TShellTreeView
  public
    procedure SimulateKey(Key: Word; Shift: TShiftState);
    procedure SelectedItems(SelItems: TStrings);
  end;

  TShellLVHelper = class helper for TShellListView
  public
    procedure SimulateKey(Key: Word; Shift: TShiftState);
    procedure SelectedItems(SelItems: TStrings);
  end;

const
  DummySubItems = #13#10#13#10#13#10#13#10;

var
  FActive: boolean = False;
  SortOrder: integer = 1;
  LastColumn: integer = 0;

function LVSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
var
  Data1: TNSItem;
  Data2: TNSItem;
begin
  Data1 := TNSItem(Item1.Data);
  Data2 := TNSItem(Item2.Data);
  if Data1.IsFolder xor Data2.IsFolder then
  begin
    Result := SortOrder * (Ord(Data2.IsFolder) - Ord(Data1.IsFolder));
  end
  else
    case ParamSort of
      0: Result := SortOrder * AnsiCompareStr(Data1.DisplayName, Data2.DisplayName);
      1: Result := SortOrder * (Data2.Size - Data1.Size);
      3: Result := SortOrder * CompareDateTime(Data2.Modified, Data1.Modified);
      else
        Result := SortOrder * AnsiCompareStr(Item1.SubItems[ParamSort - 1], Item2.SubItems[ParamSort - 1]);
    end;
end;

procedure ShellMenuExecute(Sender: TObject; Folder: IShellFolder; Count: Integer; AHandle: THandle; FileAction: TFileAction; var Pidl: PItemIDList);
var
  CM: IContextMenu;
  CI: TCmInvokeCommandInfo;
begin
  if Folder <> nil then
  begin
    if (Folder.GetUIObjectOf(AHandle, Count, Pidl,
      IID_IContextMenu, nil, Pointer(CM)) = NOERROR) then
    begin
      ZeroMemory(@CI, SizeOf(CI));
      CI.cbSize := SizeOf(TCmInvokeCommandInfo);
      CI.hwnd := AHandle;
      case FileAction of
        faCut: CI.lpVerb := 'cut';
        faCopy: CI.lpVerb := 'copy';
        faPaste: CI.lpVerb := 'paste';
      end;
      CM.InvokeCommand(CI);
      CM := nil;
    end;
  end;
end;

procedure TfrmMain.acNewProjectExecute(Sender: TObject);
var
  NewProject: TNSProject;
  sFileName:  string;
begin
  if CreateNewProjectWizard(NewProject) then
    try
      sFileName := IncludeTrailingPathDelimiter(g_ProjectsDir) + NewProject.DisplayName;
      case NewProject.Kind of
        pkArchive: sFileName := ChangeFileExt(sFileName, sNsa);
        pkBackup: sFileName  := ChangeFileExt(sFileName, sNsb);
      end;
      if not FileExists(sFileName) then
        NewProject.SaveToFile(sFileName, False)
      else
      begin
        SaveDialog.FileName := sFileName;
        case NewProject.Kind of
          pkArchive: SaveDialog.FilterIndex := 1;
          pkBackup: SaveDialog.FilterIndex  := 2;
        end;
        if SaveDialog.Execute then
        begin
          case SaveDialog.FilterIndex of
            1: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsa);
            2: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsb);
          end;
          NewProject.SaveToFile(SaveDialog.FileName, False);
        end
        else
          Exit;
      end;
      if not CloseProject then
        Exit;
      CurProject := NewProject;
      acConnectExecute(Self);
      FillVolumesCombo;
      FillTreeView(CurProject.ActiveVolume);
      UpdateCaption;
      CheckApply;
    finally
      UpdateStatusBar;
    end;
end;

procedure TfrmMain.FillTreeView(AProject: TNSProject);
var
  OldNode:  TTreeNode;
  OldData:  Pointer;
  RootNode: TTreeNode;

  procedure Fill(AParentNode: TTreeNode; ACollection: TNSCollection);
  var
    I: integer;
    Node: TTreeNode;
  begin
    for I := 0 to ACollection.Count - 1 do
      with ACollection[I] do
      begin
        if IsFolder then
        begin
          Node := tvRemote.Items.AddChildObject(AParentNode, DisplayName, SubItems);
          if SubItems.Count > 0 then
            Fill(Node, SubItems);
          if Node.Text[1] = sBackslash then
            Node.Text := Copy(Node.Text, 3, MaxInt)
          else if Node.Text[2] = sColon then
            Node.Text := Copy(Node.Text, 1, 2);
        end;
      end;
  end;

begin
  OldData := nil;
  if AProject = nil then
    Exit;
  tvRemote.Items.BeginUpdate;
  try

    if (tvRemote.Selected <> nil) and (tvRemote.Selected.Data <> nil) then
      OldData := TNSCollection(tvRemote.Selected.Data);
    if tvRemote.Items.Count > 0 then
      tvRemote.Items.Clear;
    RootNode := tvRemote.Items.AddObject(nil, AProject.DisplayName, AProject.Items);
    Fill(RootNode, AProject.Items);

    if CurProject.Kind = pkArchive then
      lvRemote.Columns[lvRemote.Columns.Count - 1].Caption := sOriginalLocation
    else
      lvRemote.Columns[lvRemote.Columns.Count - 1].Caption := sBackupedItem;

    OldNode := FindTreeNode(tvRemote, OldData);
    if OldNode <> nil then
      tvRemote.Select(OldNode)
    else
      tvRemote.Select(RootNode);

    tvRemote.Selected.Expand(False);

    tvRemote.AlphaSort(True);
  finally
    tvRemote.Items.EndUpdate;
    Self.Update;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  tvLocal := TShellTreeView.Create(Self);
  tvLocal.AutoContextMenus := False;
  tvLocal.Parent := pnlLocalTV;
  tvLocal.Align := alClient;
  tvLocal.BorderStyle := bsNone;

  lvLocal := TShellListView.Create(Self);
  lvLocal.AutoContextMenus := False;
  lvLocal.MultiSelect := True;
  lvLocal.Parent := pnlLocalLV;
  lvLocal.Align := alClient;
  lvLocal.BorderStyle := bsNone;

  tvLocal.ShellListView := lvLocal;
  lvLocal.ShellTreeView := tvLocal;
  lvLocal.ViewStyle := vsReport;

  MRUList := TStringList.Create;
  MRUList.OnChange := MRUListChange;
  CreateImageLists;

  WriteAppPathToRegistry;

  RestoreSettings;

  if Application.ShowMainForm then
  begin
    RestoreFormSettings(Self);
    RestoreActions;
  end;

  TaskManager := TTaskScheduler.CreateEx(Self, True, True, False);

  DiskWriter := TDiskWriter.Create(Self);
  DiskWriter.OnFinish := CDFinish;

  if ForceDirectories(g_ProjectsDir) then
    OpenDialog.InitialDir := g_ProjectsDir;

  SaveDialog.InitialDir := OpenDialog.InitialDir;

  FRemoteTVTarget := TNSDataTarget.Create(tvRemote);
  RegisterDragDrop(tvRemote.Handle, FRemoteTVTarget);

  FRemoteLVTarget := TNSDataTarget.Create(lvRemote);
  RegisterDragDrop(lvRemote.Handle, FRemoteLVTarget);

  Application.OnHint := AppHint;

  FFirstTimeActivated := False;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FRemoteTVTarget._Release;
  FRemoteLVTarget._Release;
  DestroyImageLists;
  if Application.ShowMainForm then
  begin
    SaveActions;
    SaveFormSettings(Self);
  end;
  SaveSettings;

  FreeAndNil(MRUList);
  FreeAndNil(DiskWriter);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  try
    UpdateVistaFonts(Self);
    Application.HelpFile := ExtractFilePath(Application.ExeName) + sID_HelpFile;

    TreeView_SetImageList(tvRemote.Handle, g_himlSysSmall, TVSIL_NORMAL);
    ListView_SetImageList(lvRemote.Handle, g_himlSysSmall, LVSIL_SMALL);

    LayoutChanged;

    PlaySoundEvent(SStartupSound);

    FFirstTimeActivated := True;

    lvLocal.Refresh;

  finally
    tvLocal.Enabled := True;
    lvLocal.Enabled := True;
    Self.Update;
  end;
end;

procedure TfrmMain.acBackupWizardExecute(Sender: TObject);
begin
  AddToBackup(nil);
end;

procedure TfrmMain.acCloseProjectExecute(Sender: TObject);
begin
  CloseProject;
end;

procedure TfrmMain.acOpenProjectExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    if CloseProject then
      OpenProject(OpenDialog.FileName);
  end;
  UpdateStatusBar;
end;

procedure TfrmMain.UpdateActions;
begin

  acCloseProject.Enabled := CurProject <> nil;
  acNewFolder.Enabled := CurProject <> nil;

  acConnect.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.SupportsConnect and not CurProject.ActiveVolume.Connected;
  acDisconnect.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.SupportsConnect and CurProject.ActiveVolume.Connected;

  acReset.Enabled := CurProject <> nil;

  acMarkRestore.Enabled  := (CurProject <> nil)
    {and CurProject.ActiveVolume.Connected} and ((lvRemote.Focused and (lvRemote.Selected <> nil)) or
    (tvRemote.Focused and (tvRemote.Selected <> nil)));
  acMarkRestoreTo.Enabled := acMarkRestore.Enabled;
  acRestoreSmart.Enabled := acMarkRestore.Enabled;

  acBackupWizard.Enabled  := CurProject <> nil;
  acRestoreWizard.Enabled := (CurProject <> nil) and (CurProject.Items.Count > 0);

  acSelectAll.Enabled := lvLocal.Focused or (lvRemote.Focused and (tvRemote.Selected <> nil));

  // save
  acSaveAs.Enabled := CurProject <> nil;
  acSaveProject.Enabled := (CurProject <> nil) and CurProject.WasModified;

  // rename
  acRename.Enabled :=
    (((CurProject <> nil) and not CurProject.ActiveVolume.IsCDMedia) and
    ((lvRemote.Focused and (lvRemote.Selected <> nil)) or (tvRemote.Focused and (tvRemote.Selected <> nil)))) or
    (lvLocal.Focused and (lvLocal.Selected <> nil)) or (tvLocal.Focused and (tvLocal.Selected <> nil));

  // up
  acLocalUp.Enabled := (lvLocal.Focused or tvLocal.Focused) and (tvLocal.Selected.Level > 0);
  acRemoteUp.Enabled := (lvRemote.Focused or tvRemote.Focused) and (tvRemote.Selected <> nil) and
    (tvRemote.Selected.Level > 0);
  acUp.Enabled := acLocalUp.Enabled or acRemoteUp.Enabled;

  // paste
  acPasteLocal.Enabled := Clipboard.HasFormat(CF_HDROP) and ((lvLocal.Focused or tvLocal.Focused) and
    (tvLocal.Selected <> nil));
  acPasteProject.Enabled := Clipboard.HasFormat(CF_HDROP) and ((lvRemote.Focused or tvRemote.Focused) and
    (tvRemote.Selected <> nil));
  acPaste.Enabled := acPasteLocal.Enabled or acPasteProject.Enabled;

  // copy
  acCopy.Enabled := (lvLocal.Focused and (lvLocal.Selected <> nil)) or (tvLocal.Focused and
    (tvLocal.Selected <> nil));

  // properties
  acProjectProperties.Enabled := CurProject <> nil;
  acLocalProperties.Enabled :=
    (lvLocal.Focused or tvLocal.Focused) and (tvLocal.Selected <> nil);
  acRemoteProperties.Enabled :=
    (lvRemote.Focused or tvRemote.Focused) and (tvRemote.Selected <> nil);
  acProperties.Enabled := acLocalProperties.Enabled or acRemoteProperties.Enabled;

  // delete
  acLocalDelete.Enabled := ((lvLocal.Focused and (lvLocal.Selected <> nil)) or
  (tvLocal.Focused and (tvLocal.Selected <> nil)) and CanDeleteLocalFolder);

  acDeleteWizard.Enabled := ((tvRemote.Selected <> nil) or (lvRemote.Selected <> nil)) and
    (CurProject <> nil) and (not CurProject.ActiveVolume.IsCDMedia);

  acDelete.Enabled := acLocalDelete.Enabled or acDeleteWizard.Enabled;

  // view log
  acViewLog.Enabled := (CurProject <> nil) and CurProject.WriteLog;

  // Verify project
  acVerify.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.Connected;

  acMarkBackup.Enabled := (CurProject <> nil) and
    ((lvLocal.Selected <> nil) or (tvLocal.Selected <> nil));

  cbVolumes.Enabled := (CurProject <> nil) and (CurProject.VolumeCount > 1);

  acSynchronize.Enabled := (lvRemote.Focused or tvRemote.Focused) and (tvRemote.Selected <> nil);
end;

procedure TfrmMain.FillListView(ACollection: TNSCollection);
var
  Index:  integer;
  NSItem: TNSItem;
  ListItem: TListItem;
begin
  LockWindowUpdate(lvRemote.Handle);
  Screen.Cursor := crHourGlass;
  try
    Canvas.Lock;
    lvRemote.Items.BeginUpdate;
    try
      ListView_DeleteAllItems(lvRemote.Handle);
      //      if lvRemote.Items.Count > 0 then lvRemote.Items.Clear;
      for Index := 0 to ACollection.Count - 1 do
      begin
        NSItem := ACollection[Index];
        ListItem := lvRemote.Items.Add;
        ListItem.Data := NSItem;
        ListItem.SubItems.Text := DummySubItems;
        UpdateListItem(ListItem);
      end;
      lvRemote.CustomSort(@LVSortProc, LastColumn);
    finally
      lvRemote.Items.EndUpdate;
      Canvas.Unlock;
    end;
  finally
    Screen.Cursor := crDefault;
    LockWindowUpdate(0);
  end;
end;

procedure TfrmMain.UpdateListItem(Item: TListItem);
const
  SHGFI_FOLDER = SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or
    SHGFI_TYPENAME or SHGFI_DISPLAYNAME;
  SHGFI_NORMAL = SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or
    SHGFI_TYPENAME or SHGFI_DISPLAYNAME;
var
  NSItem: TNSItem;
  FileInfo: TSHFileInfo;
begin
  NSItem := TNSItem(Item.Data);

  //  FillChar(FileInfo, SizeOf(FileInfo), 0);
  if NSItem.IsFolder then
  begin
    SHGetFileInfo(PChar(NSItem.DisplayName), FILE_ATTRIBUTE_DIRECTORY,
      FileInfo, SizeOf(FileInfo), SHGFI_FOLDER);
    Item.SubItems[0] := EmptyStr;
  end
  else
  begin
    SHGetFileInfo(PChar(NSItem.DisplayName), FILE_ATTRIBUTE_NORMAL,
      FileInfo, SizeOf(FileInfo), SHGFI_NORMAL);
    if not NSItem.Exists or (NSItem.NotProcessed and (NSItem.State in [isBackup..isBackupNewVersion])) then
      Item.SubItems[0] := FormatSize(NSItem.USize, False)
    else
      Item.SubItems[0] := FormatSize(NSItem.Size, False);
  end;

  Item.Caption := FileInfo.szDisplayName;

  Item.ImageIndex := FileInfo.iIcon;

  Item.SubItems[1] := StrPas(FileInfo.szTypeName);
  if not NSItem.Exists or (NSItem.NotProcessed and (NSItem.State in [isBackup..isBackupNewVersion])) then
  begin
    if NSItem.UModified > 1 then
      Item.SubItems[2] := DateTimeToStr(NSItem.UModified)
    else
      Item.SubItems[2] := sUnknown;
  end
  else
  begin
    if NSItem.Modified > 1 then
      Item.SubItems[2] := DateTimeToStr(NSItem.Modified)
    else if NSItem.Created > 1 then
      Item.SubItems[2] := DateTimeToStr(NSItem.Created)
    else
      Item.SubItems[2] := sUnknown;
  end;

  if CurProject.Kind = pkArchive then
  begin
    if not NSItem.IsFolder then
    begin
      if NSItem.LocalPath <> EmptyStr then
        Item.SubItems[3] := NSItem.LocalPath
      else
        Item.SubItems[3] := sUnknown;
    end;
  end
  else
  begin
    Item.SubItems[3] := YesNoNames[NSItem.BackupItem]^;
  end;
end;

procedure TfrmMain.acNewFolderExecute(Sender: TObject);
var
  ParentNode, Node: TTreeNode;
  NSItem: TNSItem;
  FileInfo: TSHFileInfo;
begin
  if (CurProject <> nil) and (tvRemote.Selected <> nil) then
  begin
    ParentNode := tvRemote.Selected;

    NSItem := TNSCollection(ParentNode.Data).Add;
    NSItem.DisplayName := FindFirstNew(TNSCollection(ParentNode.Data), sNewFolder);
    NSItem.IsFolder := True;
    NSItem.Exists := False;
    NSItem.Created := Now;
    NSItem.Modified := Now;
    NSItem.NotProcessed := True;

    Node := tvRemote.Items.AddChildObject(ParentNode, NSItem.DisplayName, NSItem.SubItems);

    SHGetFileInfo(PChar(NSItem.DisplayName), FILE_ATTRIBUTE_DIRECTORY,
      FileInfo, SizeOf(FileInfo),
      SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or SHGFI_DISPLAYNAME);
    Node.ImageIndex := FileInfo.iIcon;
    Node.Text := FileInfo.szDisplayName;
    SHGetFileInfo(PChar(NSItem.DisplayName), FILE_ATTRIBUTE_DIRECTORY,
      FileInfo, SizeOf(FileInfo),
      SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_OPENICON or SHGFI_USEFILEATTRIBUTES or SHGFI_DISPLAYNAME);
    Node.SelectedIndex := FileInfo.iIcon;

    Node.Selected := True;
    Node.EditText;
    acProcessBackup.Enabled := CurProject.ActiveVolume.Connected;
    acProcessAll.Enabled := CurProject.ActiveVolume.Connected;
  end;
end;

procedure TfrmMain.tvRemoteEdited(Sender: TObject; Node: TTreeNode; var S: string);
var
  NSCollection: TNSCollection;
  Item:  TPersistent;
  Index: integer;
  FNameList: TStringList;
begin
  if Node.Data = nil then
    Exit;

  FNameList := TStringList.Create;
  Item := TNSCollection(Node.Data).GetParentItem;
  if Item = nil then
    Item := CurProject;

  try
    if S = EmptyStr then
    begin
      MessageBox(
        Handle,
        PChar(sNonEmptyRequired),
        PChar(sError),
        $000010);
      S := TNSItem(Item).DisplayName;
      Node.EditText;
      Exit;
    end;
    if Item is TNSItem then
    begin
      NSCollection := TNSCollection(TNSItem(Item).Collection);
      for Index := 0 to NSCollection.Count - 1 do
        if NSCollection[Index].IsFolder and (Index <> TNSItem(Item).Index) then
          FNameList.Add(NSCollection[Index].DisplayName);
      FNameList.Sort;
      if FNameList.IndexOf(S) <> -1 then
      begin
        MessageBox(
          Handle,
          PChar(Format(sCannotRename, [TNSItem(Item).DisplayName])),
          PChar(sErrorRenaming),
          $000010);
        S := TNSItem(Item).DisplayName;
      end
      else
      begin
        if not TNSItem(Item).Exists then
        begin
          TNSItem(Item).DisplayName := S;
          Exit;
        end;
        if TNSItem(Item).Rename(S) then
        begin
          if TNSItem(Item).IsFolder then
            TNSItem(Item).Modified := Now;
        end
        else
        begin
          MessageBox(
            Handle,
            PChar(Format(sErrorRename, [TNSItem(Item).DisplayName])),
            PChar(sErrorRenaming),
            $000010);
          S := TNSItem(Item).DisplayName;
        end;
      end;
    end
    else
    begin
      if not CurProject.Rename(S) then
      begin
        MessageBox(
          Handle,
          PChar(Format(sErrorRename, [CurProject.DisplayName])),
          PChar(sErrorRenProject),
          $000010);
        S := CurProject.DisplayName;
      end;
      UpdateCaption;
    end;
  finally
    FNameList.Free;
  end;
end;

procedure TfrmMain.acRenameExecute(Sender: TObject);
begin
  if tvRemote.Focused then
  begin
    if tvRemote.Selected <> nil then
      tvRemote.Selected.EditText;
  end
  else if tvLocal.Focused then
  begin
    if tvLocal.Selected <> nil then
      tvLocal.Selected.EditText;
  end
  else if lvLocal.Focused then
  begin
    if lvLocal.Selected <> nil then
      lvLocal.Selected.EditCaption;
  end
  else if lvRemote.Focused then
  begin
    if lvRemote.Selected <> nil then
      lvRemote.Selected.EditCaption;
  end;
end;

procedure TfrmMain.acReopenExecute(Sender: TObject);
var
  Idx: integer;
  FileName: String;
begin
  if Sender <> acReopen then
  begin
    if CloseProject then
    begin
      FileName := TAction(Sender).Hint;
      if not OpenProject(FileName) then
      begin
        Idx := MRUList.IndexOf(FileName);
        if Idx <> -1 then
          MRUList.Delete(Idx);
      end;
    end;
  end;
end;

procedure TfrmMain.tvRemoteMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  Node: TTreeNode;
  pt: TPoint;
begin
  if Button = mbRight then
  begin
    pt.X := X;
    pt.Y := Y;
    pt := tvRemote.ClientToScreen(pt);
    Node := tvRemote.GetNodeAt(X, Y);
    if Node <> nil then
    begin
      tvRemote.Selected := Node;
      pmRemoteTV.Popup(pt.X, pt.Y);
    end;
  end;
end;

procedure TfrmMain.tvRemoteChange(Sender: TObject; Node: TTreeNode);
begin
  if (CurProject = nil) or (Node = nil) or (Node.Data = nil) then Exit;
  FillListView(TNSCollection(Node.Data));
end;

procedure TfrmMain.lvRemoteEdited(Sender: TObject; Item: TListItem; var S: string);
var
  NSCollection: TNSCollection;
  NSItem: TNSItem;
  Index: integer;
  Node: TTreeNode;
  FNameList: TStringList;
begin
  FNameList := TStringList.Create;
  NSItem := TNSItem(Item.Data);
  NSCollection := TNSCollection(NSItem.Collection);

  try
    if S = EmptyStr then
    begin
      MessageBox(
        Handle,
        PChar(sNonEmptyRequired),
        PChar(sError),
        $000010);
      S := NSItem.DisplayName;
      Item.EditCaption;
      Exit;
    end;

    if NSItem.IsFolder then
    begin
      for Index := 0 to NSCollection.Count - 1 do
        if NSCollection[Index].IsFolder and (Index <> NSItem.Index) then
          FNameList.Add(NSCollection[Index].DisplayName);
    end
    else
    begin
      for Index := 0 to NSCollection.Count - 1 do
        if not NSCollection[Index].IsFolder and (Index <> NSItem.Index) then
          FNameList.Add(NSCollection[Index].DisplayName);
    end;
    FNameList.Sort;
    if FNameList.IndexOf(S) <> -1 then
    begin
      if NSItem.IsFolder then
        MessageBox(
          Handle,
          PChar(Format(sCannotRename, [NSItem.DisplayName])),
          PChar(sErrorRenaming),
          $000010)
      else
        MessageBox(
          Handle,
          PChar(Format(sCannotRenameFile, [NSItem.DisplayName])),
          PChar(sErrorRenaming),
          $000010);
      S := NSItem.DisplayName;
    end
    else
    begin
      if not NSItem.Exists then
      begin
        NSItem.DisplayName := S;
        UpdateListItem(Item);
        Exit;
      end;
      if NSItem.Rename(S) then
      begin
        //        NSItem.DisplayName := S;
        NSItem.Modified := Now;
        UpdateListItem(Item);
        if NSItem.IsFolder then
        begin
          Node := FindTreeNode(tvRemote, NSItem.SubItems);
          if Node <> nil then
            Node.Text := S;
        end;
      end
      else
      begin
        MessageBox(
          Handle,
          PChar(Format(sErrorRename, [NSItem.DisplayName])),
          PChar(sErrorRenaming),
          $000010);
        S := NSItem.DisplayName;
      end;
    end
  finally
    FNameList.Free;
  end;
end;

procedure TfrmMain.lvRemoteDblClick(Sender: TObject);
var
  Item: TNSitem;
  Collection: TNSCollection;
  Node: TTreeNode;
begin
  if lvRemote.Selected = nil then
    Exit;
  Item := TNSItem(lvRemote.Selected.Data);
  if Item.IsFolder then
  begin
    Collection := Item.SubItems;
    Node := FindTreeNode(tvRemote, Collection);
    if Node <> nil then
      tvRemote.Selected := Node;
  end
  else
  begin
    if DisplayItemPropertiesDialog(Self, Item) then
      UpdateListItem(lvRemote.Selected);
  end;
end;

procedure TfrmMain.acUpExecute(Sender: TObject);
begin
  if lvLocal.Focused or tvLocal.Focused then
    acLocalUp.Execute
  else if lvRemote.Focused or tvRemote.Focused then
    acRemoteUp.Execute;
end;

procedure TfrmMain.UpdateTreeNode(ANode: TTreeNode);
var
  FileInfo: TSHFileInfo;

  procedure Fill(AParentNode: TTreeNode; ACollection: TNSCollection);
  var
    I: integer;
    Node: TTreeNode;
  begin
    for I := 0 to ACollection.Count - 1 do
    begin
      if ACollection[I].IsFolder then
      begin
        Node := TTreeView(AParentNode.TreeView).Items.AddChildObject(AParentNode,
          ACollection[I].DisplayName, ACollection[I].SubItems);

        SHGetFileInfo(PChar(ACollection[I].DisplayName), FILE_ATTRIBUTE_DIRECTORY,
          FileInfo, SizeOf(FileInfo),
          SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or SHGFI_DISPLAYNAME);
        Node.ImageIndex := FileInfo.iIcon;
        Node.Text := FileInfo.szDisplayName;

        SHGetFileInfo(PChar(ACollection[I].DisplayName), FILE_ATTRIBUTE_DIRECTORY,
          FileInfo, SizeOf(FileInfo),
          SHGFI_SMALLICON or SHGFI_SYSICONINDEX or SHGFI_OPENICON or SHGFI_USEFILEATTRIBUTES or
          SHGFI_DISPLAYNAME);
        Node.SelectedIndex := FileInfo.iIcon;
        if ACollection[I].SubItems.Count > 0 then
          Fill(Node, ACollection[I].SubItems);
      end;
    end;
  end;

begin
  ANode.DeleteChildren;
  Fill(ANode, TNSCollection(ANode.Data));
end;

procedure TfrmMain.lvRemoteCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: boolean);
var
  NSItem: TNSItem;
begin
  NSItem := TNSItem(Item.Data);
  with Sender.Canvas.Font do
  begin
    if NSItem.NotProcessed then
    begin
      case NSItem.State of
        isBackup..isBackupNewVersion:
        begin
          Color := g_drBackup.Color;
          Style := g_drBackup.Style;
        end;
        isRestore:
        begin
          Color := g_drRestore.Color;
          Style := g_drRestore.Style;
        end;
      end;
      if NSItem.IsFolder then
        Style := [fsBold];
    end
    else
    begin
      Color := g_drNormal.Color;
      Style := g_drNormal.Style;
    end;
  end;
end;

procedure TfrmMain.tvRemoteCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
  State: TCustomDrawState; var DefaultDraw: boolean);
var
  Item: TNSItem;
begin
  if Node.Data = nil then
    Exit;
  Item := TNSCollection(Node.Data).GetParentItem;
  if (Item <> nil) { and Item.NotProcessed } then
    with Sender.Canvas.Font do
    begin
      if Item.NotProcessed then
        Style := [fsBold];
      if not (cdsSelected in State) then
        case Item.State of
          isBackup..isBackupNewVersion: Color := g_drBackup.Color;
          isRestore: Color := g_drRestore.Color;
        end;
    end;
end;

procedure TfrmMain.lvRemoteCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
  SubItem: integer; State: TCustomDrawState; var DefaultDraw: boolean);
var
  NSItem: TNSItem;
begin
  NSItem := TNSItem(Item.Data);
  with Sender.Canvas.Font do
  begin
    if NSItem.NotProcessed then
    begin
      case NSItem.State of
        isBackup..isBackupNewVersion:
        begin
          Color := g_drBackup.Color;
          Style := g_drBackup.Style;
        end;
        isRestore:
        begin
          Color := g_drRestore.Color;
          Style := g_drRestore.Style;
        end;
      end;
      if NSItem.IsFolder then
        Style := [fsBold];
    end
    else
    begin
      Color := g_drNormal.Color;
      Style := g_drNormal.Style;
    end;
  end;
end;

procedure TfrmMain.acProcessAllExecute(Sender: TObject);
var
  Volume: TNSProject;
  VolNo: integer;
  Rslt: boolean;
  TotRslt: boolean;
  NumberOfProcessed: integer;
  Tick: cardinal;
  IgnoreDeleted: boolean;
begin
  if not ProjectSaved then
    Exit;

  try
    NumberOfProcessed := 0;
    Tick := GetTickCount;
    IgnoreDeleted := False;
    if acProcessDelete.Enabled then
    begin
      if MessageDlg(sConfirmDeletion, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      begin
        IgnoreDeleted := True;
        if acProcessBackup.Enabled then
          NumberOfProcessed := ProcessProject(CurProject, csBackup);
        if acProcessRestore.Enabled then
          NumberOfProcessed := NumberOfProcessed + ProcessProject(CurProject, csRestore);
      end
      else
        NumberOfProcessed := ProcessProject(CurProject, csAll);
    end
    else
    begin
      CurProject.ExecuteExternal(True);
      NumberOfProcessed := ProcessProject(CurProject, csAll);
      CurProject.ExecuteExternal(False);
    end;

    Tick := GetTickCount - Tick;
    tvRemote.Repaint;
    lvRemote.Repaint;

    if CurProject.SyncMode = smIndependent then
    begin
      if IgnoreDeleted then
        Rslt := CurProject.ActiveVolume.CheckProject(csBackup) and
          CurProject.ActiveVolume.CheckProject(csRestore)
      else
        Rslt := CurProject.ActiveVolume.CheckProject(csAll);
      if not Rslt then
      begin
        if not g_AbortProcess then
          if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected), $00000034) = idYes then
            DisplayLogDlg(CurProject.ActiveVolume);
      end
      else if NumberOfProcessed > 0 then
      begin
        MessageBox(
          Handle,
          PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
          PChar(sInformation),
          $00000040);
      end;
    end
    else
    begin
      TotRslt := True;
      for VolNo := 0 to CurProject.VolumeCount - 1 do
      begin
        Volume := CurProject.Volumes[VolNo];
        if IgnoreDeleted then
          Rslt := Volume.CheckProject(csBackup) and Volume.CheckProject(csRestore)
        else
          Rslt := Volume.CheckProject(csAll);
        TotRslt := TotRslt and Rslt;
        if not Rslt then
        begin
          if not g_AbortProcess then
            if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected),
              $00000034) = idYes then
              DisplayLogDlg(Volume);
        end;
      end;
      if TotRslt and (NumberOfProcessed > 0) then
      begin
        MessageBox(
          Handle,
          PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
          PChar(sInformation),
          $00000040);
      end;
    end;

    if tvRemote.Selected <> nil then
      FillListView(TNSCollection(tvRemote.Selected.Data));
    Self.Update;
    CurProject.CheckVolumes(csAll);
    CheckApply;
    tvRemote.Repaint;
    lvRemote.Repaint;
  finally
  end;
end;

procedure TfrmMain.StatusChanged(var Msg: TMessage);
begin
  tvRemote.Repaint;
  lvRemote.Repaint;
end;

procedure TfrmMain.lvRemoteColumnClick(Sender: TObject; Column: TListColumn);
begin
  LastColumn := Column.Index;
  SortOrder  := -SortOrder;
  lvRemote.CustomSort(@LVSortProc, Column.Index);
end;

procedure TfrmMain.acMarkRestoreExecute(Sender: TObject);
var
  Index: integer;
  bEmptyPath: boolean;
  iNotExist: integer;
  IsSmart: boolean;
begin
  bEmptyPath := False;
  iNotExist := 0;
  IsSmart := boolean((Sender as TComponent).Tag);
  sbMain.Panels[0].Text := sWait;
  LockWindowUpdate(Handle);
  Screen.Cursor := crHourGlass;
  try
    if lvRemote.Focused then
    begin
      for Index := 0 to lvRemote.Items.Count - 1 do
        if lvRemote.Items[Index].Selected then
          MarkForRestore(TNSItem(lvRemote.Items[Index].Data), iNotExist,
            bEmptyPath, IsSmart);
      if lvRemote.Selected <> nil then
        CurProject.WasModified := True;
    end
    else if tvRemote.Focused then
    begin
      if tvRemote.Selected <> nil then
      begin
        MarkForRestore(TNSCollection(tvRemote.Selected.Data).GetParentItem,
          iNotExist, bEmptyPath, IsSmart);
        CurProject.WasModified := True;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    LockWindowUpdate(0);
    sbMain.Panels[0].Text := EmptyStr;
    tvRemote.Repaint;
    lvRemote.Repaint;
  end;

  if (CurProject.Kind = pkArchive) and bEmptyPath then
    MessageBox(
      Handle,
      PChar(sSpecifyLocation),
      PChar(sWarning),
      $00000030);
  if iNotExist > 0 then
    MessageBox(
      Handle,
      PChar(Format(sCouldNotMarkForRestore, [iNotExist])),
      PChar(sWarning),
      $00000030);
  if acProcessRestore.Enabled then
  begin
    acProcessAll.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.Connected;
  end;
end;

procedure TfrmMain.UpdateFolder(var Msg: TMessage);
var
  Collection: TNSCollection;
  Node: TTreeNode;
  //  NeedUpdate: Boolean;
begin
  Collection := TNSCollection(Msg.wParam);
  Node := FindTreeNode(tvRemote, Collection);
  if Node <> nil then
  begin
    UpdateTreeNode(Node);
    FillListView(Collection);
    tvRemote.Selected := Node;
    Node.Expand(False);
  end
  else if CurProject <> nil then
  begin
    Self.Update;
    FillTreeView(CurProject.ActiveVolume);
  end;
  acProcessBackup.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.Connected;
  acProcessAll.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.Connected;
  if acProcessRestore.Enabled or acProcessDelete.Enabled then
    CheckApply;
end;

procedure TfrmMain.acDeleteWizardExecute(Sender: TObject);
var
  Index: integer;
  NSItem: TNSItem;
  Lst: TStringList;
begin
  Lst := TStringList.Create;
  try
    if lvRemote.Focused then
    begin
      for Index := 0 to lvRemote.Items.Count - 1 do
        if lvRemote.Items[Index].Selected then
        begin
          NSItem := TNSItem(lvRemote.Items[Index].Data);
          Lst.AddObject(NSItem.DisplayName, NSItem);
        end;
    end
    else if tvRemote.Focused then
    begin
      if (tvRemote.Selected <> nil) and (tvRemote.Selected.Data <> nil) then
      begin
        NSItem := TNSCollection(tvRemote.Selected.Data).GetParentItem;
        if (NSItem = nil) then
        begin
          for Index := 0 to CurProject.Items.Count - 1 do
            Lst.AddObject(CurProject.Items[Index].DisplayName, CurProject.Items[Index])
        end
        else if NSItem.Exists then
          Lst.AddObject(NSItem.DisplayName, NSItem)
        else
          try
            tvRemote.Selected.Free;
            FreeAndNil(NSItem);
            tvRemoteChange(tvRemote, tvRemote.Selected);
          except
          end;
      end;
    end;
    if DeleteWizard(CurProject, Lst) then
    begin
      CurProject.ActiveVolume.CheckProject(csAll);
      CurProject.WasModified := True;
      FillTreeView(CurProject.ActiveVolume);
    end;
  finally
    Lst.Free;
  end;

  CheckApply;
  tvRemote.Repaint;
  lvRemote.Repaint;
end;

procedure TfrmMain.RemoveItem(var Msg: TMessage);
var
  Item: TNSItem;
  Collection: TNSCollection;
  li: TListItem;
begin
  Collection := TNSCollection(Msg.wParam);
  Item := TNSItem(Msg.lParam);
  if (tvRemote.Selected <> nil) and (tvRemote.Selected.Data = Collection) then
  begin
    li := FindListItem(lvRemote, Item);
    if li <> nil then
      lvRemote.Items.Delete(li.Index);
  end;
  Collection.Delete(Item.Index);
end;

procedure TfrmMain.acResetExecute(Sender: TObject);
begin
  if CurProject <> nil then
  begin
    CurProject.Reset;
    FillTreeView(CurProject.ActiveVolume);
    CurProject.WasModified := True;
  end;
  CheckApply;
end;

procedure TfrmMain.acRestoreWizardExecute(Sender: TObject);
begin
  if RestoreWizard(CurProject, nil) then
  begin
    CurProject.CheckVolumes(csAll);
    FillTreeView(CurProject.ActiveVolume);
    tvRemote.Selected.Expand(False);
  end;

  CheckApply;
  tvRemote.Repaint;
  lvRemote.Repaint;
  Update;
end;

procedure TfrmMain.acOptionsExecute(Sender: TObject);
begin
  if DisplayOptionsDialog(Self) then
  begin
    lvRemote.Repaint;
    if g_ShowHidden then
    begin
      tvLocal.ObjectTypes := tvLocal.ObjectTypes + [otHidden];
      lvLocal.ObjectTypes := lvLocal.ObjectTypes + [otHidden];
    end
    else
    begin
      tvLocal.ObjectTypes := tvLocal.ObjectTypes - [otHidden];
      lvLocal.ObjectTypes := lvLocal.ObjectTypes - [otHidden];
    end;
    try
      LockWindowUpdate(Handle);
      lvLocal.Refresh;
      tvLocal.Refresh(tvLocal.Selected);
    finally
      LockWindowUpdate(0);
    end;
  end;
end;

procedure TfrmMain.acMarkRestoreToExecute(Sender: TObject);
var
  Index: integer;
  LastControl: TWinControl;
  iNotExist: integer;
  sDestFolder: String;
begin
  LastControl := Self.ActiveControl;
  sDestFolder := g_LastSelDir;
  if SelectDir(sDestinationToRestore, sDestFolder) then
  begin
    g_LastSelDir := sDestFolder;
    iNotExist := 0;
    if LastControl = lvRemote then
    begin
      if lvRemote.Selected <> nil then
        CurProject.WasModified := True;
      for Index := 0 to lvRemote.Items.Count - 1 do
        if lvRemote.Items[Index].Selected then
          MarkForRestoreTo(TNSItem(lvRemote.Items[Index].Data), iNotExist, g_LastSelDir);
    end
    else if LastControl = tvRemote then
    begin
      if tvRemote.Selected <> nil then
      begin
        MarkForRestoreTo(TNSCollection(tvRemote.Selected.Data).GetParentItem,
          iNotExist, g_LastSelDir);
        CurProject.WasModified := True;
      end;
    end;
    if iNotExist > 0 then
      MessageBox(
        Handle,
        PChar(Format(sCouldNotMarkForRestore, [iNotExist])),
        PChar(sWarning),
        $00000030);
    tvRemote.Repaint;
    lvRemote.Repaint;
  end;
  if acProcessRestore.Enabled then
  begin
    acProcessAll.Enabled := (CurProject <> nil) and CurProject.ActiveVolume.Connected;
  end;
end;

procedure TfrmMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.acPasteProjectExecute(Sender: TObject);
var
  Target: TNSCollection;
begin
  if tvRemote.Selected <> nil then
  begin
    Target := TNSCollection(tvRemote.Selected.Data);
    PasteCommand(Target);
    Self.Update;
    FillTreeView(CurProject.ActiveVolume);
    CheckApply;
  end;
end;

function TfrmMain.OpenProject(const AFileName: string): boolean;
var
  tmpPwd: string;
  tmpRemember: boolean;
  idx: integer;
begin
  idx := MRUList.IndexOf(AFileName);
  if idx <> -1 then
    MRUList.Delete(idx);

  if not FileExists(AFileName) then
  begin
    MessageBox(
      Handle,
      PChar(Format(sCannotFindProjFile, [AFileName])),
      PChar(sError),
      $00000030);
    Result := False;
    Exit;
  end;
  CurProject := TNSProject.Create(frmProcess);
  if not CurProject.LoadFromFile(AFileName) then
  begin
    MessageBox(
      Handle,
      PChar(Format(sCorrupted, [AFileName])),
      PChar(sError),
      $00000030);
    FreeAndNil(CurProject);
    Result := False;
    Exit;
  end;

  if not CurProject.StoreArchivePwd and (CurProject.EncryptionMethod <> tmNone) then
    repeat
      tmpPwd := ProjPassword(Self, sPasswordRequired, CurProject.DisplayName, tmpRemember);
      if Trim(tmpPwd) = EmptyStr then
      begin
        FreeAndNil(CurProject);
        Result := False;
        Exit;
      end;
      Result := CurProject.OpenProject(tmpPwd);
      if not Result then
      begin
        MessageBox(
          Handle,
          PChar(sWrongPassword),
          PChar(sError),
          $00000030);
        //        FreeAndNil(CurProject);
        Result := False;
        //        Exit;
      end;
      if Result then
        CurProject.StoreArchivePwd := tmpRemember;
    until Result;

  CurTask := nil;
  if TaskManager.Active then
  begin
    CurTask := TaskManager.ActivateTask(CurProject.DisplayName);
    if CurTask <> nil then
    begin
      if CurTask.Status = tsRunning then
      begin
        MessageBox(
          Handle,
          PChar(Format(sTaskRunning, [CurProject.DisplayName])),
          PChar(sError),
          $00000030);
        FreeAndNil(CurProject);
        Result := False;
        Exit;
      end
      else
      begin
        CurTask.Flags := CurTask.Flags - [tfEnabled];
        CurTask.SaveTask;
      end;
    end;
  end;

  FillVolumesCombo;

  sbMain.Panels[1].Text := sConnecting;
  Screen.Cursor := crHourGlass;
  try
    CurProject.ConnectToMedia(Handle);
    SynchronizeProject(CurProject, nil);
    CheckApply;
  finally
    sbMain.Panels[1].Text := EmptyStr;
    Screen.Cursor := crDefault;
  end;
  Result := CurProject.Connected;

  UpdateCaption;
  UpdateStatusBar;
  FillTreeView(CurProject.ActiveVolume);
  Self.Update;

  if acProcessAll.Enabled then
    if MessageDlg(sSyncronizationNeeded, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      acProcessAll.Execute;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //  CloseProject;
  if FRefCount > 0 then
  begin
    Action := caNone;
    Self.Hide;
  end;
  PlaySoundEvent(SExitSound);
end;

procedure TfrmMain.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  Msg.Result := 1;
end;

procedure TfrmMain.WMScheduledProcess(var Msg: TMessage);
var
  uCode: UINT;
begin
  case Msg.wParam of
    0: Dec(FRefCount);
    1: Inc(FRefCount);
  end;
  if (FRefCount <= 0) and not Self.Visible then
  begin
    uCode := 0;
    ExitProcess(uCode);
    //    Application.Terminate;
  end;
end;

procedure TfrmMain.LayoutChanged;
begin
  sbMain.Visible := acStatusBar.Checked;
  pnlLocalSystem.Visible := acLocalSystem.Checked;
{$IFDEF USE_ACTIONMENU}
  atLocalSystem.Visible := actToolbarLocal.Checked;
  atBackupProject.Visible := actToolbarRemote.Checked;
{$ELSE}
  tlbLocalSystem.Visible := actToolbarLocal.Checked;
  tlbBackupProject.Visible := actToolbarRemote.Checked;
{$ENDIF}
end;

procedure TfrmMain.acStatusBarExecute(Sender: TObject);
begin
  acStatusBar.Checked := not acStatusBar.Checked;
  LayoutChanged;
end;

procedure TfrmMain.InsertMRUList(AAction: TAction);
var
  ActionItem: TActionClientItem;
  ReopenItem: TActionClientItem;
  ReopenAction: TAction;
  MenuItem: TMenuItem;
  i: Integer;
begin
  miReopen.Clear;

  ReopenItem := amMainmenu.FindItemByAction(AAction);
  if Assigned(ReopenItem) then
  begin
    ReopenItem.Items.Clear;
    for i := 0 to MRUList.Count -1 do
    begin
      ReopenAction := TAction.Create(Self);
      ReopenAction.OnExecute := acReopenExecute;
      ReopenAction.Caption := Format('%d %s', [Succ(i), ExtractFileName(MRUList[i])]);
      ReopenAction.Hint := MRUList[i];
      ActionItem := ReopenItem.Items.Add;
      ActionItem.Action := ReopenAction;

      MenuItem := TMenuItem.Create(Self);
      MenuItem.Action := ReopenAction;
      miReopen.Add(MenuItem);
    end;
    AAction.Enabled := (AAction <> acReopen) or (MRUList.Count > 0);
  end;
end;

procedure TfrmMain.RestoreActions;
var
  Ini: TRegIniFile;
  sStartFolder: string;
begin
  Ini := TRegIniFile.Create(REG_FORMS);
  with Ini do
  begin
    try
      MRUList.Text := ReadString(REG_MAIN, REG_VAL_MRU, EmptyStr);

      acStatusBar.Checked := ReadBool(REG_MAIN, REG_VAL_STATUSBAR, True);
      //    pnlLeftTop.Visible := ReadBool(Section, 'LocalFolders', True);
      //    pnlLeftBottom.Visible := ReadBool(Section, 'RemoteFolders', True);

      //    acProjectMaximize.Tag := ReadInteger(Section, 'ProjectViewMax', 0);
      //    pnlLeftTop.Width := ReadInteger(Section, 'LFoldersWidth', 200);
      //    pnlLeftBottom.Width := ReadInteger(Section, 'RFoldersWidth', 200);
      sStartFolder := ReadString(REG_MAIN, REG_VAL_STARTFOLDER, sDefaultFolder);
      try
        tvLocal.Path := sStartFolder;
      except
        tvLocal.Path := sDefaultFolder;
      end;
      if g_ShowHidden then
      begin
        tvLocal.ObjectTypes := tvLocal.ObjectTypes + [otHidden];
        lvLocal.ObjectTypes := lvLocal.ObjectTypes + [otHidden];
      end else
      begin
        tvLocal.ObjectTypes := tvLocal.ObjectTypes - [otHidden];
        lvLocal.ObjectTypes := lvLocal.ObjectTypes - [otHidden];
      end;
    finally
      Free;
    end;
  end;
  LayoutChanged;
end;

{$IFNDEF LITE}

procedure TfrmMain.SaveActions;
var
  Ini: TRegIniFile;
begin
  Ini := TRegIniFile.Create(REG_FORMS);
  with Ini do
    try
      WriteBool(REG_MAIN, REG_VAL_STATUSBAR, acStatusBar.Checked);
      //    WriteBool(Section, 'LocalFolders', pnlLeftTop.Visible);
      //    WriteBool(Section, 'RemoteFolders', pnlLeftBottom.Visible);
      if tvLocal.SelectedFolder <> nil then
        WriteString(REG_MAIN, REG_VAL_STARTFOLDER, tvLocal.Path);
      //    WriteInteger(Section, 'LFoldersHeight', FOldHeight);
      //    WriteInteger(Section, 'LFoldersWidth', pnlLeftTop.Width);
      //    WriteInteger(Section, 'RFoldersWidth', pnlLeftBottom.Width);
      //    WriteBool(Section, 'ProjectBar', TBXToolbarProject.Visible);
      WriteString(REG_MAIN, REG_VAL_MRU, MRUList.Text);
     finally
      Free;
    end;
end;

{$ENDIF}

procedure TfrmMain.DeleteItems(Items: TStrings);
var
  FileItem: string;
  FilePaths: string;
  SHFileOpStruct: TSHFileOpStruct;
begin
  FilePaths := EmptyStr;
  for FileItem in Items do
    FilePaths := FilePaths + FileItem + #0;
  FilePaths := FilePaths + #0;

  with SHFileOpStruct do
  begin
    Wnd := Handle;
    wFunc := FO_DELETE;
    pFrom := PChar(FilePaths);
    pTo := nil;
    fFlags := FOF_ALLOWUNDO;
  end; // structure
  SHFileOperation(SHFileOpStruct);
end;

procedure TfrmMain.acRefreshExecute(Sender: TObject);
begin
  if lvLocal.Focused or tvLocal.Focused then
  begin
    lvLocal.Refresh;
    tvLocal.Refresh(tvLocal.Selected);
  end
  else
  if ((tvRemote.Focused or lvRemote.Focused) and (tvRemote.Selected <> nil)) then
  begin
    if CurProject <> nil then
      FillTreeView(CurProject.ActiveVolume);
    CheckApply;
  end;
end;

procedure TfrmMain.acCopyExecute(Sender: TObject);
var
  Selected: TStrings;
begin
  Selected := TStringList.Create;
  try
    if lvLocal.Focused then
      lvLocal.SelectedItems(Selected)
    else
    if tvLocal.Focused then
      tvLocal.SelectedItems(Selected);

    FilesCopyToClipBoard(Selected);
  finally
    FreeAndNil(Selected);
  end;
end;

procedure TfrmMain.acSelectAllExecute(Sender: TObject);
begin
  if lvLocal.Focused or tvLocal.Focused then
    lvLocal.SelectAll
  else if lvRemote.Focused or tvRemote.Focused then
    ListView_SetItemState(lvRemote.Handle, -1, LVIS_SELECTED, LVIS_SELECTED);
end;

procedure TfrmMain.acLocalDeleteExecute(Sender: TObject);
var
  pItem: TListItem;
  pNode: TTreeNode;
  Items: TStringList;
begin
  Items := TStringList.Create;
  try
    pNode := tvLocal.Selected.Parent;
    if lvLocal.Focused then
    begin
      if lvLocal.Selected <> nil then
      begin
        for pItem in lvLocal.Items do
        begin
          if pItem.Selected then
            Items.Add(lvLocal.Folders[pItem.Index].PathName);
        end;
        DeleteItems(Items);
      end;
    end
    else if tvLocal.Focused then
    begin
      if tvLocal.Selected <> nil then
      begin
        Items.Add(tvLocal.SelectedFolder.PathName);
        DeleteItems(Items);
      end;
    end;
    tvLocal.Selected := pNode;
    tvLocal.Refresh(pNode);
  finally
    FreeAndNil(Items);
  end;
end;

procedure TfrmMain.AppHint(Sender: TObject);
begin
  sbMain.Panels[0].Text := Application.Hint;
  if sbMain.Panels[0].Text = EmptyStr then
  begin
    if (CurProject <> nil) and (CurProject.FileName <> EmptyStr) then
      sbMain.Panels[0].Text := CurProject.FileName;
  end;
end;

procedure TfrmMain.acPasteExecute(Sender: TObject);
begin
  if lvLocal.Focused or tvLocal.Focused then
    acPasteLocal.Execute
  else if lvRemote.Focused or tvRemote.Focused then
    acPasteProject.Execute;
end;

procedure TfrmMain.acPasteLocalExecute(Sender: TObject);
var
  Selected: TStrings;
  sTarget, sDestin: String;
begin
  Selected := TStringList.Create;
  try
    if (lvLocal.Focused or tvLocal.Focused) and (tvLocal.Selected <> nil) then
      FilesPasteFromClipboard(Selected);

    for sTarget in Selected do
    begin
      sDestin := IncludeTrailingPathDelimiter(tvLocal.SelectedFolder.PathName) + ExtractFileName(sTarget);
      CopyFile(PChar(sTarget), PChar(sDestin), False);
    end;

    tvLocal.Refresh(tvLocal.Selected);
    lvLocal.Refresh;
  finally
    FreeAndNil(Selected);
  end;
end;

procedure TfrmMain.acAboutExecute(Sender: TObject);
begin
  with TfrmAbout.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmMain.acProjectPropertiesExecute(Sender: TObject);
var
  OldIndex: integer;
begin
  if CurProject <> nil then
  begin
    if DisplayProjectPropertiesDialog(CurProject) then
    begin
      tvRemote.Items[0].Text := CurProject.DisplayName;
      OldIndex := CurProject.ActiveVolumeIndex;
      FillVolumesCombo;
      if OldIndex <> CurProject.ActiveVolumeIndex then
        FillTreeView(CurProject.ActiveVolume);

      CurProject.WasModified := True;
      FillTreeView(CurProject.ActiveVolume);
      UpdateCaption;
    end;
  end;
end;

procedure TfrmMain.acPropertiesExecute(Sender: TObject);
begin
  if lvRemote.Focused or tvRemote.Focused then
    acRemoteProperties.Execute
  else if lvLocal.Focused or tvLocal.Focused then
    acLocalProperties.Execute;
end;

procedure TfrmMain.acLocalPropertiesExecute(Sender: TObject);
begin
  if lvLocal.Focused then
    lvLocal.SimulateKey(VK_RETURN, [ssAlt])
  else
  if tvLocal.Focused then
    tvLocal.SimulateKey(VK_RETURN, [ssAlt])
end;

procedure TfrmMain.acLocalSystemExecute(Sender: TObject);
begin
  acLocalSystem.Checked := not acLocalSystem.Checked;
  LayoutChanged;
end;

procedure TfrmMain.acRemotePropertiesExecute(Sender: TObject);
var
  Index: integer;
  iArr:  integer;
  MultiItems: TItemArray;
  Item:  TNSItem;
  Coll:  TNSCollection;
begin
  if lvRemote.Focused then
  begin
    if lvRemote.Selected <> nil then
    begin
      if lvRemote.SelCount = 1 then
      begin
        Item := TNSItem(lvRemote.Selected.Data);
        if Item.IsFolder then
        begin
          DisplayFolderPropertiesDialog(Self, Item);
          CurProject.WasModified := True;
        end
        else
        begin
          if DisplayItemPropertiesDialog(Self, Item) then
          begin
            UpdateListItem(lvRemote.Selected);
            CurProject.WasModified := True;
          end;
        end;
      end
      else
      begin
        SetLength(MultiItems, lvRemote.SelCount);
        try
          iArr := 0;
          for Index := 0 to lvRemote.Items.Count - 1 do
            if lvRemote.Items[Index].Selected then
            begin
              MultiItems[iArr] := TNSItem(lvRemote.Items[Index].Data);
              Inc(iArr);
            end;
          if DisplayMultiPropertiesDialog(Self, MultiItems) then
          begin
            FillListView(TNSCollection(tvRemote.Selected.Data));
            CurProject.WasModified := True;
          end;
        finally
          Finalize(MultiItems);
        end;
      end;
    end
    else if (tvRemote.Selected <> nil) then
    begin
      Coll := TNSCollection(tvRemote.Selected.Data);
      Item := Coll.GetParentItem;
      if Item = nil then
      begin
        acProjectPropertiesExecute(Self);
      end
      else
      begin
        if DisplayFolderPropertiesDialog(Self, Item) then
        begin
          tvRemote.Items[0].Text := CurProject.DisplayName;
          CurProject.WasModified := True;
        end;
      end;
    end;
  end
  else if tvRemote.Focused then
  begin
    if (tvRemote.Selected <> nil) then
    begin
      Coll := TNSCollection(tvRemote.Selected.Data);
      Item := Coll.GetParentItem;
      if Item = nil then
      begin
        acProjectPropertiesExecute(Self);
      end
      else
      begin
        if DisplayFolderPropertiesDialog(Self, Item) then
          CurProject.WasModified := True;
      end;
    end;
  end;
end;

procedure TfrmMain.acDeleteExecute(Sender: TObject);
begin
  if lvLocal.Focused or tvLocal.Focused then
    acLocalDelete.Execute
  else if lvRemote.Focused or tvRemote.Focused then
    acDeleteWizard.Execute;
end;

procedure TfrmMain.acLocalUpExecute(Sender: TObject);
begin
  if (lvLocal.Focused or tvLocal.Focused) and (tvLocal.Selected.Parent <> nil) then
    tvLocal.Select(tvLocal.Selected.Parent);
end;

procedure TfrmMain.acRemoteUpExecute(Sender: TObject);
begin
  if (lvRemote.Focused or tvRemote.Focused) and (tvRemote.Selected.Parent <> nil) then
    tvRemote.Select(tvRemote.Selected.Parent);
end;

procedure TfrmMain.AddToBackup(const AList: TStringList);
begin
  if BackupWizard(CurProject, AList) then
  begin
    CurProject.CheckVolumes(csAll);
    CurProject.WasModified := True;
    FillTreeView(CurProject.ActiveVolume);
    tvRemote.Selected.Expand(False);
  end;

  CheckApply;
  tvRemote.Repaint;
  lvRemote.Repaint;
end;

procedure TfrmMain.acImportExecute(Sender: TObject);
var
  tmp:  TNSProject;
  tmpPwd: string;
  tmpRemember: boolean;
  Rslt: boolean;
begin
  if not CloseProject then
    Exit;
  if ImportExistingProject(Self, tmp) then
  begin
    CurProject := tmp;
    if not CurProject.StoreArchivePwd and (CurProject.EncryptionMethod <> tmNone) then
      repeat
        tmpPwd := ProjPassword(Self, sPasswordRequired, CurProject.DisplayName, tmpRemember);
        if Trim(tmpPwd) = EmptyStr then
        begin
          FreeAndNil(CurProject);
          Exit;
        end;
        Rslt := CurProject.OpenProject(tmpPwd);
        if not Rslt then
          MessageBox(
            Handle,
            PChar(sWrongPassword),
            PChar(sError),
            $00000030);
        if Rslt then
          CurProject.StoreArchivePwd := tmpRemember;
      until Rslt;
    FillVolumesCombo;
    FillTreeView(CurProject.ActiveVolume);
    UpdateCaption;
    CheckApply;
  end;
end;

procedure TfrmMain.RemoveFolder(var Msg: TMessage);
var
  Item: TNSItem;
  Collection: TNSCollection;
  Node: TTreeNode;
begin
  Collection := TNSCollection(Msg.wParam);
  Item := TNSItem(Msg.lParam);

  Node := FindTreeNode(tvRemote, Collection);
  if Node <> nil then
    tvRemote.Items.Delete(Node);
  if (tvRemote.Selected <> nil) and (tvRemote.Selected.Data = Item.Collection) then
    FillListView(TNSCollection(tvRemote.Selected.Data));

  Item.Collection.Delete(Item.Index);
end;

procedure TfrmMain.acViewLogExecute(Sender: TObject);
var
  FN: string;
begin
  FN := IncludeTrailingPathDelimiter(g_LogDir) + CurProject.DisplayName + sLog;
  if FileExists(FN) then
    DisplayLogDlg(CurProject, FN, True)
  else
    MessageBox(
      Handle,
      PChar(Format(sCannotFindLogFile, [FN])),
      PChar(sError),
      $00000030);
end;

procedure TfrmMain.acVolumeExecute(Sender: TObject);
begin
  // do nothing here
end;

procedure TfrmMain.popRemoteTVPopup(Sender: TObject);
begin
  HandlePopupMenu(TPopupMenu(Sender));
end;

procedure TfrmMain.lvRemoteContextPopup(Sender: TObject; MousePos: TPoint; var Handled: boolean);
var
  Item: TListItem;
  pt: TPoint;
begin
  if tvRemote.Selected = nil then
    Exit;
  Item := lvRemote.GetItemAt(MousePos.X, MousePos.Y);
  if Item <> nil then
    Item.Selected := True;
  pt := lvRemote.ClientToScreen(MousePos);
  UpdateActions;
  if lvRemote.Selected <> nil then
    pmRemoteLV1.Popup(pt.X, pt.Y)
  else
    pmRemoteLV2.Popup(pt.X, pt.Y);
  Handled := True;
end;

procedure TfrmMain.PopSortClick(Sender: TObject);
begin
  with Sender as TComponent do
  begin
    LastColumn := Tag;
    SortOrder  := 1;
    lvRemote.CustomSort(@LVSortProc, Tag);
  end;
end;

procedure TfrmMain.acDisconnectExecute(Sender: TObject);
begin
  sbMain.Panels[1].Text := sDisconnecting;
  try
    if CurProject <> nil then
      CurProject.ActiveVolume.Disconnect;
    //    tbxConnect.Action := acConnect;
  finally
    sbMain.Panels[1].Text := EmptyStr;
  end;
  CheckApply;
  UpdateStatusBar;
end;

procedure TfrmMain.acConnectExecute(Sender: TObject);
begin
  if CurProject <> nil then
  begin
    sbMain.Panels[1].Text := sConnecting;
    Screen.Cursor := crHourGlass;
    try
      if CurProject.Connected then
        CurProject.Disconnect;
      CurProject.ActiveVolume.ConnectToMedia(Handle);
      //      if CurProject.ActiveVolume.Connected then
      //        tbxConnect.Action := acDisconnect;
    finally
      Screen.Cursor := crDefault;
      sbMain.Panels[1].Text := EmptyStr;
    end;
    CheckApply;
  end;
  UpdateStatusBar;
end;

function TfrmMain.CloseProject: boolean;
var
  Count: integer;
  tmpSize: int64;
begin
  Result := True;
  if CurProject = nil then
    Exit;

  if (CurProject.FileName = EmptyStr) then
  begin
    case MessageBox(Handle, PChar(sSaveProj), PChar(sConfirm), $00000023) of
      idYes:
      begin
        case CurProject.Kind of
          pkArchive:
          begin
            SaveDialog.FilterIndex := 1;
            SaveDialog.FileName := CurProject.DisplayName + sNsa;
          end;
          pkBackup:
          begin
            SaveDialog.FilterIndex := 2;
            SaveDialog.FileName := CurProject.DisplayName + sNsb;
          end;
        end;
        if SaveDialog.Execute then
        begin
          case SaveDialog.FilterIndex of
            1: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsa);
            2: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsb);
          end;
          CurProject.FileName := SaveDialog.FileName;
          CurProject.WasModified := False;
          Result := True;
        end
        else
        begin
          Result := False;
          Exit;
        end;
      end;
      idNo:
        try
          Screen.Cursor := crHourGlass;
          CurProject.CleanProject;
        finally
          Screen.Cursor := crDefault;
          Result := False;
        end;
      idCancel:
      begin
        Result := False;
        Exit;
      end;
    end;
  end;

  if Result and CurProject.WasModified then
  begin
    Count := CurProject.GetNonProcCount(tmpSize);
    if Count > 0 then
      case MessageBox(Handle, PChar(sConfirmSave), PChar(sConfirm), $00000023)
        of
        idNo:
        begin
          tvRemote.Items[0].Collapse(True);
          CurProject.Reset;
          Result := True;
        end;
        idCancel:
        begin
          Result := False;
          Exit;
        end;
      end
    else
      Result := True;
  end;

  if (CurProject.FileName <> EmptyStr) and FileExists(CurProject.FileName) then
    MRUList.Add(CurProject.FileName);

  sbMain.Panels[1].Text := sClosing;
  Screen.Cursor := crHourGlass;
  try
    if Result then
      CurProject.CloseProject
    else if CurProject.HangUpOnCompleted then
      InternetAutodialHangup(0);

    if TaskManager.Active then
    begin
      CurTask := TaskManager.ActivateTask(CurProject.DisplayName);
      if CurTask <> nil then
      begin
        if not Result then
          FreeAndNil(CurTask)
        else
        begin
          CurTask.Flags := CurTask.Flags + [tfEnabled];
          CurTask.SaveTask;
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    sbMain.Panels[1].Text := EmptyStr;
    CurProject.Free;
    CurProject := nil;
  end;

  cbVolumes.Items.Clear;
  cbVolumes.Text := EmptyStr;
  tvRemote.Items.Clear;
  lvRemote.Items.Clear;

  UpdateCaption;
  UpdateStatusBar;

  //  tbxConnect.Action := acConnect;

  CheckApply;
  LVTarget := nil;
  Result := True;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if CurProject = nil then
    CanClose := True
  else
    CanClose := CloseProject;
end;

procedure TfrmMain.acVerifyExecute(Sender: TObject);
var
  tmpProject: TNSProject;
  Index: integer;
  //  CurVolume: TNSProject;
  OldVolumeIndex: integer;
  OldVolume: TNSProject;
begin
  if (CurProject = nil) or not CurProject.ActiveVolume.Connected then Exit;
  OldVolumeIndex := CurProject.ActiveVolumeIndex;
  if VerifyProject(Self, CurProject.ActiveVolume, tmpProject) then
  begin
    if OldVolumeIndex = 0 then
    begin
      for Index := CurProject.ComponentCount - 1 downto 0 do
      begin
        OldVolume := TNSProject(CurProject.Components[Index]);
        CurProject.RemoveComponent(OlDVolume);
        tmpProject.InsertComponent(OldVolume);
      end;
      FreeAndNil(CurProject);
      CurProject := tmpProject;
      CurProject.ActiveVolumeIndex := OldVolumeIndex;
    end
    else
    begin
      OldVolume := CurProject.ActiveVolume;
      FreeAndNil(OldVolume);
      for Index := OldVolumeIndex - 1 to CurProject.ComponentCount - 2 do
      begin
        OldVolume := TNSProject(CurProject.Components[OldVolumeIndex - 1]);
        CurProject.RemoveComponent(OldVolume);
        CurProject.InsertComponent(OldVolume);
      end;
      CurProject.ActiveVolumeIndex := OldVolumeIndex;
    end;

    CurProject.WasModified := True;
    FillTreeView(CurProject.ActiveVolume);
    CheckApply;
  end;
end;

procedure TfrmMain.popRemoteLV1Popup(Sender: TObject);
begin
  HandlePopupMenu(TPopupMenu(Sender));
end;

procedure TfrmMain.HandlePopupMenu(ASender: TPopupMenu);
var
  I: integer;
begin
  UpdateActions;
  for I := 0 to ASender.Items.Count - 1 do
  begin
    ASender.Items[I].ShortCut := 0;
    ASender.Items[I].Visible  := ASender.Items[I].Enabled;
  end;
end;

procedure TfrmMain.popRemoteLV2Popup(Sender: TObject);
begin
  HandlePopupMenu(TPopupMenu(Sender));
end;

procedure TfrmMain.acSaveProjectExecute(Sender: TObject);
begin
  if CurProject <> nil then
  begin
    if CurProject.FileName = EmptyStr then
      acSaveAs.Execute
    else
    begin
      CurProject.SaveToFile(True);
      CurProject.WasModified := False;
    end;
  end;
end;

procedure TfrmMain.acSaveAsExecute(Sender: TObject);
begin
  if CurProject <> nil then
  begin
    if CurProject.FileName = EmptyStr then
      case CurProject.Kind of
        pkArchive:
        begin
          SaveDialog.FilterIndex := 1;
          SaveDialog.FileName := CurProject.DisplayName + sNsa;
        end;
        pkBackup:
        begin
          SaveDialog.FilterIndex := 2;
          SaveDialog.FileName := CurProject.DisplayName + sNsb;
        end;
      end
    else
      SaveDialog.FileName := CurProject.FileName;
    if SaveDialog.Execute then
    begin
      case SaveDialog.FilterIndex of
        1: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsa);
        2: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsb);
      end;
      CurProject.SaveToFile(SaveDialog.FileName, True);
      CurProject.WasModified := False;
      UpdateCaption;
    end;
  end;
end;

procedure TfrmMain.tvRemoteCompare(Sender: TObject; Node1, Node2: TTreeNode; Data: integer; var Compare: integer);
var
  Item1: TNSItem;
  Item2: TNSItem;
begin
  if (Node1.Data = nil) or (Node2.Data = nil) then
    Exit;
  Item1 := TNSCollection(Node1.Data).GetParentItem;
  Item2 := TNSCollection(Node2.Data).GetParentItem;
  if (Item1 = nil) or (Item2 = nil) then
    Exit;
  if (Node1.Level = 1) and (Node2.Level = 1) then
  begin
    if AnsiPos(sDrive, Item1.DisplayName) > 0 then
    begin
      if AnsiPos(sDrive, Item2.DisplayName) > 0 then
        Compare := AnsiCompareStr(Item1.DisplayName, Item2.DisplayName)
      else
        Compare := -1;
    end
    else if AnsiPos(sMachine, Item1.DisplayName) > 0 then
    begin
      if AnsiPos(sMachine, Item2.DisplayName) > 0 then
        Compare := AnsiCompareStr(Item1.DisplayName, Item2.DisplayName)
      else
        Compare := 1;
    end
    else
      Compare := AnsiCompareStr(Node1.Text, Node2.Text);
  end
  else
    Compare := AnsiCompareStr(Node1.Text, Node2.Text);
end;

procedure TfrmMain.acMarkBackupExecute(Sender: TObject);
var
  //  dir: string;
  st: TStringList;
  I:  integer;
begin
  if lvLocal.Focused then
  begin
    if lvLocal.Selected <> nil then
    begin
      st := TStringList.Create;
      try
        for I := 0 to lvLocal.Items.Count - 1 do
        begin
          if lvLocal.Items[i].Selected then
            st.Add(lvLocal.Folders[I].PathName);
        end;
        AddToBackup(st);
      finally
        st.Free;
      end;
    end;
  end
  else if tvLocal.Focused then
  begin
    if tvLocal.Selected <> nil then
    begin
      st := TStringList.Create;
      try
        st.Add(tvLocal.SelectedFolder.PathName);
        AddToBackup(st);
      finally
        st.Free;
      end;
    end;
  end;
end;

procedure TfrmMain.acOpenExecute(Sender: TObject);
var
  Item: TNSItem;
  tmpName: string;
  //  tmpFolder: string;
  dwError: DWORD;
begin

  if (lvRemote.Selected <> nil) and (lvRemote.Selected.Data <> nil) then
  begin
    Item := TNSItem(lvRemote.Selected.Data);
    if not Item.IsFolder then
      try
        Screen.Cursor := crHourGlass;
        CurProject.ReInitCrypting;
        tmpName := IncludeTrailingPathDelimiter(g_TempDir) + Item.DisplayName;
        if FileExists(tmpName) then
        begin
          if not DeleteFile(PChar(tmpName)) then
          begin
            dwError := GetLastError;
            MessageBox(
              Handle,
              PChar(Format(sCouldNotOpenFile, [Item.DisplayName, SysErrorMessage(dwError)])),
              PChar(sErrorOpening),
              $00000030);
            Exit;
          end;
        end;
        if Item.RestoreVersion(g_TempDir, Item.VersionNumber) then
          ShellExecute(Handle, pOpen, PChar(tmpName), nil, nil, SW_SHOWNORMAL);
      finally
        Screen.Cursor := crDefault;
      end
    else
      try
        lvRemoteDblClick(lvRemote);
      except
      end;
  end;
end;

procedure TfrmMain.UpdateCaption;
begin
  if CurProject = nil then
    Caption := Application.Title
  else
    Caption := CurProject.GetCaption;
  AppHint(Self);
end;

function TfrmMain.ProjectSaved: boolean;
begin
  if CurProject.FileName <> EmptyStr then
    Result := True
  else
  begin
    if MessageBox(Handle, PChar(sMustSave), PChar(sInformation), $00000041) = idOk then
    begin
      case CurProject.Kind of
        pkArchive:
        begin
          SaveDialog.FilterIndex := 1;
          SaveDialog.FileName := CurProject.DisplayName + sNsa;
        end;
        pkBackup:
        begin
          SaveDialog.FilterIndex := 2;
          SaveDialog.FileName := CurProject.DisplayName + sNsb;
        end;
      end;
      if SaveDialog.Execute then
      begin
        case SaveDialog.FilterIndex of
          1: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsa);
          2: SaveDialog.FileName := ChangeFileExt(SaveDialog.FileName, sNsb);
        end;
        CurProject.SaveToFile(SaveDialog.FileName, True);
        UpdateCaption;
        CurProject.WasModified := False;
        Result := True;
      end
      else
        Result := False;
    end
    else
      Result := False;
  end;
end;

procedure TfrmMain.acProcessBackupExecute(Sender: TObject);
var
  Rslt:  boolean;
  Volume: TNSProject;
  VolNo: integer;
  TotRslt: boolean;
  NumberOfProcessed: integer;
  Tick:  cardinal;
begin
  if not ProjectSaved then
    Exit;
  try
    Tick := GetTickCount;
    NumberOfProcessed := ProcessProject(CurProject, csBackup);
    Tick := GetTickCount - Tick;
    tvRemote.Repaint;
    lvRemote.Repaint;

    if CurProject.SyncMode = smIndependent then
    begin
      Rslt := CurProject.ActiveVolume.CheckProject(csBackup);
      if not Rslt then
      begin
        if not g_AbortProcess then
          if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected), $00000034) = idYes then
            DisplayLogDlg(CurProject.ActiveVolume);
      end
      else if NumberOfProcessed > 0 then
      begin
        MessageBox(
          Handle,
          PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
          PChar(sInformation),
          $00000040);
      end;
    end
    else
    begin
      TotRslt := True;
      for VolNo := 0 to CurProject.VolumeCount - 1 do
      begin
        Volume := CurProject.Volumes[VolNo];
        Rslt := Volume.CheckProject(csBackup);
        TotRslt := TotRslt and Rslt;
        if not Rslt then
        begin
          if not g_AbortProcess then
            if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected),
              $00000034) = idYes then
              DisplayLogDlg(Volume);
        end;
      end;
      if TotRslt and (NumberOfProcessed > 0) then
      begin
        MessageBox(
          Handle,
          PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
          PChar(sInformation),
          $00000040);
      end;
    end;
    CurProject.CheckVolumes(csBackup);
  finally
    tvRemote.Repaint;
    lvRemote.Repaint;
  end;
  CheckApply;
end;

procedure TfrmMain.acProcessDeleteExecute(Sender: TObject);
var
  Rslt:  boolean;
  Volume: TNSProject;
  VolNo: integer;
  TotRslt: boolean;
  NumberOfProcessed: integer;
  Tick:  cardinal;
begin
  if not ProjectSaved then
    Exit;

  if MessageDlg(sConfirmDeletion, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  try
    Tick := GetTickCount;
    NumberOfProcessed := ProcessProject(CurProject, csDelete);
    Tick := GetTickCount - Tick;

    tvRemote.Repaint;
    lvRemote.Repaint;

    if CurProject.SyncMode = smIndependent then
    begin
      Rslt := CurProject.ActiveVolume.CheckProject(csDelete);
      if not Rslt then
      begin
        if not g_AbortProcess then
          if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected), $00000034) = idYes then
            DisplayLogDlg(CurProject.ActiveVolume);
      end
      else if NumberOfProcessed > 0 then
      begin
        MessageBox(
          Handle,
          PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
          PChar(sInformation),
          $00000040);
      end;
    end
    else
    begin
      TotRslt := True;
      for VolNo := 0 to CurProject.VolumeCount - 1 do
      begin
        Volume := CurProject.Volumes[VolNo];
        Rslt := Volume.CheckProject(csDelete);
        TotRslt := TotRslt and Rslt;
        if not Rslt then
        begin
          if not g_AbortProcess then
            if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected),
              $00000034) = idYes then
              DisplayLogDlg(Volume);
        end;
      end;
      if TotRslt and (NumberOfProcessed > 0) then
      begin
        MessageBox(
          Handle,
          PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
          PChar(sInformation),
          $00000040);
      end;
    end;
    CurProject.CheckVolumes(csDelete);
  finally
    tvRemote.Repaint;
    lvRemote.Repaint;
  end;
  CheckApply;
end;

procedure TfrmMain.acProcessRestoreExecute(Sender: TObject);
var
  Rslt: boolean;
  NumberOfProcessed: integer;
  Tick: cardinal;
begin
  if not ProjectSaved then
    Exit;
  try
    Tick := GetTickCount;
    NumberOfProcessed := ProcessProject(CurProject, csRestore);
    Tick := GetTickCount - Tick;
    tvRemote.Repaint;
    lvRemote.Repaint;

    Rslt := CurProject.ActiveVolume.CheckProject(csRestore);
    if not Rslt then
    begin
      if not g_AbortProcess then
        if MessageBox(Handle, PChar(sEncounteredProblems), PChar(sErrorsDetected), $00000034) = idYes then
          DisplayLogDlg(CurProject.ActiveVolume);
    end
    else if NumberOfProcessed > 0 then
    begin
      MessageBox(
        Handle,
        PChar(Format(SItemsProcessed, [NumberOfProcessed, TicksToTime(Tick)])),
        PChar(sInformation),
        $00000040);
    end;
    CurProject.CheckVolumes(csRestore);
  finally
    tvRemote.Repaint;
    lvRemote.Repaint;
  end;
  CheckApply;
end;

procedure TfrmMain.tvRemoteGetImageIndex(Sender: TObject; Node: TTreeNode);
var
  FileInfo: TSHFileInfo;
  pszName:  PChar;
begin
  if Node.Parent = nil then
  begin
    SHGetFileInfo(PChar(Application.ExeName), FILE_ATTRIBUTE_NORMAL,
      FileInfo, SizeOf(FileInfo),
      SHGFI_SMALLICON or SHGFI_SYSICONINDEX);
    Node.ImageIndex := FileInfo.iIcon;
  end
  else
  begin
    if Node.Data = nil then Exit;

    pszName := PChar(TNSCollection(Node.Data).GetParentItem.DisplayName);

    SHGetFileInfo(pszName, FILE_ATTRIBUTE_DIRECTORY, FileInfo,
      SizeOf(FileInfo), SHGFI_FOLDER);
    Node.ImageIndex := FileInfo.iIcon;
  end;
end;

procedure TfrmMain.tvRemoteGetSelectedIndex(Sender: TObject; Node: TTreeNode);
var
  FileInfo: TSHFileInfo;
  pszName:  PChar;
begin

  if Node.Data = nil then
    Exit;
  if Node.Parent = nil then
  begin
    SHGetFileInfo(PChar(Application.ExeName), FILE_ATTRIBUTE_NORMAL,
      FileInfo, SizeOf(FileInfo),
      SHGFI_SMALLICON or SHGFI_SYSICONINDEX);
    Node.SelectedIndex := FileInfo.iIcon;
  end
  else
  begin
    if Node.Data = nil then
      Exit;
    pszName := PChar(TNSCollection(Node.Data).GetParentItem.DisplayName);
    SHGetFileInfo(pszName, FILE_ATTRIBUTE_DIRECTORY, FileInfo,
      SizeOf(FileInfo), SHGFI_FOLDEROPEN);
    Node.SelectedIndex := FileInfo.iIcon;
  end;
end;

procedure TfrmMain.acNewLocalFolderExecute(Sender: TObject);
var
  sBaseName: string;

  function FindNewName: string;
  var
    Index: integer;
    List:  TStringList;
  begin
    List := TStringList.Create;
    try
      for Index := 0 to lvLocal.Items.Count - 1 do
        List.Add(lvLocal.Items[Index].Caption);
      List.Sorted := True;
      if List.IndexOf(sBaseName) = -1 then
        Result := sBaseName
      else
      begin
        Index := 2;
        repeat
          Result := Format('%s (%d)', [sBaseName, Index]);
          Inc(Index);
        until List.IndexOf(Result) = -1;
      end;
    finally
      List.Free;
    end;
  end;

begin
  sBaseName := sNewFolder;
  if DirectoryExists(tvLocal.SelectedFolder.PathName) then
    //lvLocal.AddFolder(FindNewName);
    CreateDir(FindNewName);
end;

procedure TfrmMain.popLocalSystemPopup(Sender: TObject);
begin
  UpdateActions;
end;

procedure TfrmMain.popProcessPopup(Sender: TObject);
begin
  UpdateActions;
  HandlePopupMenu(TPopupMenu(Sender));
end;

procedure TfrmMain.acMarkNormalExecute(Sender: TObject);
var
  Index: integer;
  Rslt:  boolean;
begin
{$B+}
  if lvRemote.Focused then
  begin
    if lvRemote.Selected = nil then
      Exit;
    CurProject.WasModified := True;
    Rslt := True;
    for Index := 0 to lvRemote.Items.Count - 1 do
      if lvRemote.Items[Index].Selected then
        Rslt := MarkNormal(TNSItem(lvRemote.Items[Index].Data)) and Rslt;
    if not Rslt then
    begin
    end;
  end
  else if tvRemote.Focused then
  begin
    if tvRemote.Selected <> nil then
    begin
      Rslt := MarkNormal(TNSCollection(tvRemote.Selected.Data).GetParentItem);
      CurProject.WasModified := True;
      if not Rslt then
      begin
      end;
    end;
  end;
  CurProject.ActiveVolume.CheckProject(csAll);
  tvRemote.Repaint;
  lvRemote.Repaint;
  CheckApply;
{$B-}
end;

procedure TfrmMain.CDFinish(Sender: TObject);
begin
  if (CurProject <> nil) and (CurProject.FProgress <> nil) then
    CurProject.SetProgress(EmptyStr, sFinalizingTrack, 0, 0);
end;

procedure TfrmMain.CheckApply;
var
  needbreak: boolean;
  mode: TCheckState;
  bAll: boolean;
  bDel: boolean;
  bBac: boolean;
  bRes: boolean;

  procedure ScanSubItems(ASubItems: TNSCollection);
  var
    Index: integer;
    CurItem: TNSItem;
  begin
    for Index := 0 to ASubItems.Count - 1 do
    begin
      Application.ProcessMessages;
      if needbreak then Exit;

      CurItem := ASubItems.Items[Index];
      if CurItem.NotProcessed then
        case mode of
          csDelete:
            if CurItem.State = isDelete then
            begin
              bDel := True;
              needbreak := True;
            end;
          csBackup:
            if CurItem.State in [isBackup..isBackupNewVersion] then
            begin
              bBac := True;
              needbreak := True;
            end;
          csRestore:
            if CurItem.State = isRestore then
            begin
              bRes := True;
              needbreak := True;
            end;
        end;
      if CurItem.IsFolder then
        ScanSubItems(CurItem.SubItems);
    end;
  end;

begin
  if (CurProject = nil) or not CurProject.ActiveVolume.Connected then
  begin
    acProcessAll.Enabled := False;
    acProcessBackup.Enabled := False;
    acProcessDelete.Enabled := False;
    acProcessRestore.Enabled := False;
  end
  else
    try
      Screen.Cursor := crHourGlass;
      Self.Update;
      Application.ProcessMessages;
      needbreak := False;
      bDel := False;
      mode := csDelete;
      ScanSubItems(CurProject.ActiveVolume.Items);
      acProcessDelete.Enabled := bDel and CurProject.ActiveVolume.Connected;

      Self.Update;
      Application.ProcessMessages;
      bBac := False;
      mode := csBackup;
      needbreak := False;
      ScanSubItems(CurProject.ActiveVolume.Items);
      acProcessBackup.Enabled := bBac and CurProject.ActiveVolume.Connected;

      Self.Update;
      Application.ProcessMessages;
      bRes := False;
      mode := csRestore;
      needbreak := False;
      ScanSubItems(CurProject.ActiveVolume.Items);
      acProcessRestore.Enabled := bRes and CurProject.ActiveVolume.Connected;

      bAll := bDel or bBac or bRes;
      acProcessAll.Enabled := bAll;
    finally
      Screen.Cursor := crDefault;
    end;
end;

procedure TfrmMain.MarkForRestore(AItem: TNSItem; var ANotExist: integer; var AEmptyPath: boolean;
  const ASmart: boolean);
var
  Modified: boolean;

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
          if LocalPath = EmptyStr then
            AEmptyPath := True
          else
            SetState(Item);
        end;
        DestFolder := EmptyStr;
      end;
    end;
  end;

begin
  Modified := acProcessRestore.Enabled;
  if AItem = nil then
  begin
    ScanSubItems(CurProject.ActiveVolume.Items);
    if CurProject.ActiveVolume.Items.Count > 0 then
      acProcessRestore.Enabled := CurProject.Connected and Modified;
  end
  else
  begin
    if AItem.Exists then
    begin
      if AItem.IsFolder then
        ScanSubItems(AItem.SubItems)
      else
      begin
        if AItem.LocalPath = EmptyStr then
          AEmptyPath := True
        else
          SetState(AItem);
      end;
      acProcessRestore.Enabled := CurProject.ActiveVolume.Connected and Modified;
    end
    else
      Inc(ANotExist);
  end;
  if acProcessBackup.Enabled or acProcessDelete.Enabled then
    CheckApply;
end;

procedure TfrmMain.MarkForRestoreTo(AItem: TNSItem; var ANotExist: integer; const ADest: string);
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
    ScanSubItems(CurProject.ActiveVolume.Items, tmpDest);
    if CurProject.ActiveVolume.Items.Count > 0 then
      acProcessRestore.Enabled := CurProject.Connected;
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
      acProcessRestore.Enabled := CurProject.ActiveVolume.Connected;
    end;
  end;
  if acProcessBackup.Enabled or acProcessDelete.Enabled then
    CheckApply;
end;

procedure TfrmMain.MRUListChange(Sender: TObject);
begin
  if MRUList.Count > 6 then
    MRUList.Delete(0);
  InsertMRUList(acReopen);
  InsertMRUList(acOpenRemote);
end;

procedure TfrmMain.WMActivateInstance(var Msg: TMessage);
begin
  Application.Restore;
  Application.BringToFront;
  Application.RestoreTopMosts;
end;

procedure TfrmMain.acHelpContentsExecute(Sender: TObject);
begin
  Application.HelpSystem.ShowTableOfContents;
end;

procedure TfrmMain.sbMainDblClick(Sender: TObject);
begin
  if acConnect.Enabled then
    acConnect.Execute
  else if acDisconnect.Enabled then
    acDisconnect.Execute;
end;

procedure TfrmMain.sbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  if Panel.Index = 2 then
  begin
    if (CurProject <> nil) and (CurProject.EncryptionMethod <> tmNone) then
      imlStatusBar.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, 0);
  end else
  if Panel.Index = 3 then
  begin
    if (CurProject <> nil) and CurProject.ActiveVolume.SupportsConnect then
    begin
      if CurProject.ActiveVolume.Connected then
      begin
        imlStatusBar.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, 1);
        StatusBar.Canvas.TextOut(Rect.left + 30, Rect.top + 2, sMediaOnline);
      end
      else
      begin
        imlStatusBar.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, 2);
        StatusBar.Canvas.TextOut(Rect.left + 30, Rect.top + 2, sMediaOffline);
      end;
    end;
  end;
end;

procedure TfrmMain.UpdateStatusBar;
begin
  sbMain.Refresh;
end;

procedure TfrmMain.ClickMoreProducts(Sender: TObject);
var
  strURL: string;
begin
  case (Sender as TComponent).tag of
    1: strURL := sID_Wiseftp;
    2: strURL := sID_HelloEngines;
    3: strURL := sID_RankingToolbox;
    4: strURL := sID_WinSurvey;
    5: strURL := sID_PasswordDepot;
  end;
  ShellExecute(0, pOpen, PChar(strUrl), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.FillVolumesCombo;
var
  Index: integer;
begin
  cbVolumes.Items.Clear;
  cbVolumes.Text := EmptyStr;
  if CurProject = nil then
    Exit;
  for Index := 0 to CurProject.VolumeCount - 1 do
    cbVolumes.Items.Add(CurProject.Volumes[Index].GetVolumeString);
  if CurProject.ActiveVolumeIndex > CurProject.VolumeCount - 1 then
    CurProject.ActiveVolumeIndex := CurProject.VolumeCount - 1;
  cbVolumes.ItemIndex := CurProject.ActiveVolumeIndex;
end;

procedure TfrmMain.tvRemoteEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: boolean);
begin
  if Node.Data = nil then
    Exit;
  if TNSCollection(Node.Data).GetParentItem = nil then
    AllowEdit := CurProject.VolumeCount = 1;
end;

procedure TfrmMain.acSynchronizeExecute(Sender: TObject);
begin
  tvRemote.Items.BeginUpdate;
  lvRemote.Items.BeginUpdate;
  try
    if lvRemote.Focused then
    begin
      if tvRemote.Selected <> nil then
      begin
        SynchronizeProject(CurProject, TNSCollection(tvRemote.Selected.Data));
        CurProject.WasModified := True;
      end;
    end
    else if tvRemote.Focused then
    begin
      if tvRemote.Selected <> nil then
      begin
        SynchronizeProject(CurProject, TNSCollection(tvRemote.Selected.Data));
        CurProject.WasModified := True;
      end;
    end;

    if tvRemote.Selected <> nil then
    begin
      if tvRemote.Selected.Parent <> nil then
        UpdateTreeNode(tvRemote.Selected)
      else // root
        FillTreeView(CurProject.ActiveVolume);
      tvRemote.Selected.Expand(False);
      FillListView(TNSCollection(tvRemote.Selected.Data));
    end;
    CheckApply;
  finally
    tvRemote.Items.EndUpdate;
    lvRemote.Items.EndUpdate;
  end;
end;

procedure TfrmMain.actToolbarLocalExecute(Sender: TObject);
begin
  actToolbarLocal.Checked := not actToolbarLocal.Checked;
  LayoutChanged;
end;

procedure TfrmMain.actToolbarRemoteExecute(Sender: TObject);
begin
  actToolbarRemote.Checked := not actToolbarRemote.Checked;
  LayoutChanged;
end;

procedure TfrmMain.cbVolumesSelect(Sender: TObject);
begin
  if (CurProject <> nil) and (CurProject.ActiveVolumeIndex <> cbVolumes.ItemIndex) then
  begin
    acDisconnectExecute(Self);
    CurProject.ActiveVolumeIndex := cbVolumes.ItemIndex;
    CurProject.ActiveVolume.ReInitCrypting;
    acConnectExecute(Self);
    FillTreeView(CurProject.ActiveVolume);
  end;
end;

procedure TfrmMain.acTutorialExecute(Sender: TObject);
begin
  ShellExecute(0, pOpen, PChar(extractfilepath(application.ExeName) + sID_Tutorial), nil, nil, SW_SHOWNORMAL);
end;

function TfrmMain.CanDeleteLocalFolder: boolean;
begin
  Result := fcCanDelete in tvLocal.SelectedFolder.Capabilities;
end;

function TfrmMain.FilesCopyToClipBoard(Filenames: TStrings): Boolean;
var
  sFilenames: AnsiString;
  iIndex: Integer;
  hBuffer: HGLOBAL;
  pBuffer: PDropFiles;
begin
  Result := (Filenames <> nil) and (Filenames.Count > 0);
  if (not Result) then
    Exit;

  sFilenames := '';
  for iIndex := 0 to Filenames.Count - 1 do
    sFilenames := sFilenames + AnsiString(Filenames[iIndex]) + #0;
  sFilenames := sFilenames + #0;

  hBuffer := GlobalAlloc(GMEM_SHARE or GMEM_MOVEABLE or GMEM_ZEROINIT, SizeOf(TDropFiles) + Length(sFilenames));
  try
    Result := (hBuffer <> 0);
    if Result then
    begin
      pBuffer := GlobalLock(hBuffer);
      try
        pBuffer^.pFiles := SizeOf(TDropFiles);
        pBuffer := Pointer(Integer(pBuffer) + SizeOf(TDropFiles));
        CopyMemory(pBuffer, PAnsiChar(sFilenames), Length(sFilenames));
      finally
        GlobalUnlock(hBuffer);
      end;

      Clipboard.Open;
      try
        Clipboard.SetAsHandle(CF_HDROP, hBuffer);
      finally
        Clipboard.Close;
      end;
    end;
  except
    Result := False;
    GlobalFree(hBuffer);
  end;
end;

procedure TfrmMain.FilesPasteFromClipboard(Filenames: TStrings);
var
  hDropHandle: HDROP;
  szBuffer: PChar;
  iCount, iIndex: Integer;
  iLength: Integer;
begin
  if not Assigned(Filenames) then
    Exit;

  Clipboard.Open;
  try
    if Clipboard.HasFormat(CF_HDROP) then
    begin
      hDropHandle := Clipboard.GetAsHandle(CF_HDROP);
      iCount := DragQueryFile(hDropHandle, $FFFFFFFF, nil, 0);
      for iIndex := 0 to iCount - 1 do
      begin
        iLength := DragQueryFile(hDropHandle, iIndex, nil, 0);
        szBuffer := StrAlloc(iLength + 1);
        try
          DragQueryFile(hDropHandle, iIndex, szBuffer, iLength + 1);
          Filenames.Add(szBuffer);
        finally
          StrDispose(szBuffer);
        end;
      end;
    end;
  finally
    Clipboard.Close;
  end;
end;

{ TShellTVHelper }

procedure TShellTVHelper.SelectedItems(SelItems: TStrings);
var
  each: TTreeNode;
begin
  if not Assigned(Items) then
    Exit;

  for each in Items do
  begin
    if each.Selected then
      SelItems.Add(Folders[each.Index].PathName);
  end;
end;

procedure TShellTVHelper.SimulateKey(Key: Word; Shift: TShiftState);
begin
  KeyDown(Key, Shift)
end;

{ TShellLVHelper }

procedure TShellLVHelper.SelectedItems(SelItems: TStrings);
var
  each: TListItem;
begin
  if not Assigned(Items) then
    Exit;

  for each in Items do
  begin
    if each.Selected then
      SelItems.Add(Folders[each.Index].PathName);
  end;
end;

procedure TShellLVHelper.SimulateKey(Key: Word; Shift: TShiftState);
begin
  KeyDown(Key, Shift)
end;

end.



