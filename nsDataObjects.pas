unit nsDataObjects;

interface

uses
  Windows, Classes, Controls, ComCtrls, Forms, ExtCtrls, StdCtrls, Graphics,
  ShlObj, SysUtils, ImgList, Menus, nsGlobals, nsTypes, ActiveX, Messages,
  Clipbrd, DateUtils, CommCtrl, Dialogs;

const
  MAX_FORMATCOUNT = 3;

type
  PFormatList = ^TFormatList;
  TFormatList = array[0..MAX_FORMATCOUNT] of TFormatEtc;

  TTargetMode = (tmTreeView, tmListView);

  TEnumFormatEtc = class(TInterfacedObject, IEnumFormatEtc)
  private
    FFormatList: PFormatList;
    FFormatCount: integer;
    FIndex: integer;
  public
    constructor Create(FormatList: PFormatList; FormatCount, Index: integer);
    {IEnumFormatEtc Implementation}
    function Next(celt: longint; out elt; pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumFormatEtc): HResult; stdcall;
  end;

  TnsDataTarget = class(TInterfacedObject, IDropTarget)
  private
    FOwner: TWinControl;
    FDataObject: IDataObject;
    FTarget: TNSCollection;
    FTargetMode: TTargetMode;
    FScrollTimer: TTimer;
    FLastPoint: TPoint;
    FFileList: TStringList;

//    HDragImgList: HIMAGELIST;

  protected
    procedure DoAutoScroll(Sender: TObject);
  public
    {Proper stuff}
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    {IDropTarget implementation}
    function DragEnter(const dataObj: IDataObject; grfKeyState: longint; pt: TPoint;
      var dwEffect: longint): HResult; stdcall;
    function DragOver(grfKeyState: longint; pt: TPoint; var dwEffect: longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: longint; pt: TPoint;
      var dwEffect: longint): HResult; stdcall;
  end;

var
  LVTarget: TNSCollection = nil;

function PasteCommand(const ATarget: TNSCollection): HRESULT;
 //function BackupCommand: Boolean;
 //function DoBackupFiles(const AFiles: TStrings; const AProject: TNSProject): Boolean;
 //function DoPasteFiles(AFiles: TStrings; AProject: TNSProject; ATarget: TNSCollection): HRESULT;


function ThereIsCollision(AName: string; AIsFolder: Boolean; ACollection: TNSCollection; out Index: integer): Boolean;
procedure ActionOnCollision(ASR: TSearchRec; AIndex: integer; ACollection: TNSCollection; out AItem: TNSItem);

implementation

uses
  nsUtils, nsMainFrm, nsConfirmReplaceFrm, nsActions;

{ TEnumFormatEtc }

function MakeFileListFromHGlobal(hGlob: HGLOBAL; AList: TStrings): HRESULT;
var
  DropFiles: PDropFiles;
  FileName:  PChar;
begin
  AList.Clear;
  DropFiles := PDropFiles(GlobalLock(hGlob));
  try
    FileName := PChar(DropFiles) + DropFiles^.pFiles;
    while (FileName^ <> #0) do
    begin
      if (DropFiles^.fWide) then
      begin
        AList.Add(PWideChar(FileName));
        Inc(FileName, (Length(PWideChar(FileName)) + 1) * 2);
      end
      else
      begin
        AList.Add(FileName);
        Inc(FileName, Length(FileName) + 1);
      end;
    end;
  finally
    GlobalUnlock(hGlob);
  end;
  Result := S_OK;
end;


function GetLastPIDL(apidl: PItemIDList): PItemIDList;
var
  Marker: PItemIDList;
begin
  Result := apidl;
  Marker := apidl;
  while Marker.mkid.cb <> 0 do
  begin
    Result := Marker;
    Inc(PChar(Marker), Marker^.mkid.cb);
  end;
end;

function MakeFileListFromPIDLHGlobal(hGlob: HGLOBAL; AList: TStrings): Boolean;
var
  I: integer;
  pCIDA: PIDA;
  pOffset: ^UINT;
  PIDL: PItemIDList;
  //  Size: Integer;
  Path: array[0..MAX_PATH] of char;
  //  SHD: TSHDescriptionID;
  //  psf: IShellFolder;
  //  ppvOut: IShellFolder;
  //  lpName: TStrRet;
  //  sName: string;
  sDir: string;
  //  FindData: TWin32FindData;
begin
  AList.Clear;
  //  SHGetDesktopFolder(psf);
  pCIDA := PIDA(GlobalLock(HGlob));
  try
    //    Size := GlobalSize(HGlob);
    I := pCIDA^.cidl;

    pOffset := @(pCIDA^.aoffset[0]);
    PIDL := PItemIDList(UINT(pCIDA) + pOffset^);
    {    psf.BindToObject(PIDL, nil, IID_IShellFolder, ppvOut);

          FillChar(FindData, SizeOf(TWin32FindData), #0);
          PIDL := PItemIDList(UINT(pCIDA) + pOffset^);
          SHGetDataFromIDList(ppvOut, GetLastPIDL(PIDL), SHGDFIL_FINDDATA, @FindData,
            SizeOf(TWin32FindData));
    }
    if SHGetPathFromIDList(PIDL, Path) then
      sDir := IncludeTrailingPathDelimiter(String(@Path));

    Inc(pOffset);

    while (I >= 1) do
    begin
      PIDL := PItemIDList(UINT(pCIDA) + pOffset^);
      {      psf.GetDisplayNameOf(PIDL, SHGDN_NORMAL or SHGDN_FORPARSING, lpName);
        case lpName.uType of
          STRRET_CSTR: sName := StrPas(lpName.cStr);
          STRRET_WSTR: sName := lpName.pOleStr;
        end;
        ShowMessage(sName);
      }
      if SHGetPathFromIDList(PIDL, Path) then
        AList.Add(sDir + ExtractFileName(String(@Path)));
      Inc(pOffset);
      Dec(I);
    end;
    //ShowMessage(AList.Text);
    //AList.Clear;
    Result := (AList.Count > 0);
  finally
    GlobalUnlock(HGlob);
  end;
end;


function ThereIsCollision(AName: string; AIsFolder: Boolean; ACollection: TNSCollection; out Index: integer): Boolean;
var
  j: integer;
begin
  Result := False;
  for j := 0 to ACollection.Count - 1 do
    if AnsiSameText(AName, ACollection.Items[j].DisplayName) and not (AIsFolder xor
      ACollection.Items[j].IsFolder) then
    begin
      Index  := j;
      Result := True;
      Break;
    end;
end;

function ActionOnPathCollision(var ApplyToAll: Boolean; var ABreak: Boolean; ASR: TSearchRec;
  AIndex: integer; ACollection: TNSCollection; const ADirectory: string): TCollisionAction;
var
  Action:  TCollisionAction;
  Location: string;
  tmpDate: TDateTime;
begin
  if g_DontAskCollision or ApplyToAll then
    Result := g_LastCollisionAction
  else
  begin
    Location := ACollection.Items[AIndex].GetPathOnMedia;
    if AnsiPos(sArchives, Location) > 0 then
      Delete(Location, 1, AnsiPos(sArchives, Location) + Length(sArchives));
    if Location = EmptyStr then
      Location := sRoot;
    tmpDate := FileGetModified(ASR);

    case
      ConfirmReplaceDlg(ASR.Name, Location, ACollection.Items[AIndex].Size,
        ACollection.Items[AIndex].Modified, ACollection.Items[AIndex].LocalPath, FileGetSize(ASR),
        tmpDate, ADirectory, Action)
      of
      mrOk: Result := Action;
      mrYesToAll:
      begin
        Result := Action;
        ApplyToAll := True;
      end;
      else
      begin
        Result := g_LastCollisionAction;
        ABreak := True;
      end;
    end;
  end;
end;

procedure ActionOnCollision(ASR: TSearchRec; AIndex: integer; ACollection: TNSCollection; out AItem: TNSItem);
var
  dt: TDateTime;
begin
  AItem := ACollection.Items[AIndex];
  if (ASR.Attr and faDirectory = faDirectory) then
  begin
    AItem.State := isBackup;
    AItem.NotProcessed := True;
  end
  else
  begin
    AItem := ACollection.Items[AIndex];
    dt := FileGetModified(ASR);

    case AItem.DefAction of
      daReplace:
      begin
        AItem.State := isBackupReplace;
        AItem.NotProcessed := True;
        AItem.UModified := dt;
        AItem.USize := FileGetSize(ASR);
      end;
      daUpdate:
      begin
        if CompareDateTime(AItem.Modified, dt) < 0 then
        begin
          AItem.State := isBackupUpdate;
          AItem.NotProcessed := True;
          AItem.UModified := dt;
          AItem.USize := FileGetSize(ASR);
        end;
      end;
      daNewVersion:
      begin
        AItem.State := isBackupNewVersion;
        AItem.NotProcessed := True;
        //          AItem.Versions.Add;
        AItem.UModified := dt;
        AItem.USize := FileGetSize(ASR);
      end;
    end;
  end;
end;

(*
function DoBackupFiles(const AFiles: TStrings; const AProject: TNSProject): Boolean;
var
  I: Integer;
  NewItem: TNSItem;
  SearchRec: TSearchRec;
  fAttr: Integer;
  tmpFolder: Boolean;
  Index: Integer;
  Volume: TNSProject;

  procedure ScanDir(const ANewTarget: TNSCollection; const ADir: string; const AFilter: string);
  var
    sr: TSearchRec;
    mFolder: Boolean;
  begin
    FillChar(sr, SizeOf(TSearchRec), #0);
    if FindFirst(IncludeTrailingPathDelimiter(ADir) + sFileMask, faAnyFile, sr) <> 0 then Exit;
    repeat
      if AbortScan then Abort;
      if (sr.Name = sDot) or (sr.Name = sDoubleDot) then Continue;
      mFolder := (sr.Attr and faDirectory = faDirectory);
      if not mFolder then
        if not AProject.IsValidExt(sr.Name) then Continue;

      Application.MainForm.Update;
      NSScanForm.CurFile := IncludeTrailingPathDelimiter(ADir) + sr.Name;
      Application.ProcessMessages;

      if mFolder then
      begin
        NewItem := AProject.AddBackupFolder(IncludeTrailingPathDelimiter(ADir) + sr.Name);
        ScanDir(NewItem.SubItems, IncludeTrailingPathDelimiter(ADir) + NewItem.DisplayName, AFilter);
      end
      else
      begin
        NewItem := AProject.AddBackupFile(IncludeTrailingPathDelimiter(ADir) + sr.Name, sr);
        NewItem.NotProcessed := True;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

begin
  try
    ShowScanSplash;
    for i := 0 to AFiles.Count - 1 do
    begin
      NSScanForm.CurFile := AFiles[i];
      if AbortScan then Abort;
      fAttr := faAnyFile;
      if (FileGetAttr(AFiles[i]) and faDirectory = faDirectory) then
      begin
        case AProject.SyncMode of
          smIndependent:
          begin
            NewItem := AProject.AddBackupFolder(AFiles[i]);
          end;
          smSynchronized:
          begin
            NewItem := AProject.AddBackupFolder(AFiles[i]);
          end;
        end;
        ScanDir(NewItem.SubItems, AFiles[i], sFileMask);
      end
      else
      begin
        if FindFirst(AFiles[i], fAttr, SearchRec) = 0 then
        begin
          Application.MainForm.Update;
          Application.ProcessMessages;
          tmpFolder := (SearchRec.Attr and faDirectory = faDirectory);
          if not tmpFolder then
            if not AProject.IsValidExt(SearchRec.Name) then Continue;
          if tmpFolder then
          begin
            NewItem := AProject.AddBackupFolder(AFiles[i]);
            ScanDir(NewItem.SubItems, AFiles[i], sFileMask);
          end
          else
          begin
            NewItem := AProject.AddBackupFile(AFiles[i], SearchRec);
            NewItem.NotProcessed := True;
          end;
        end;
        FindClose(SearchRec);
      end;
    end;
    AProject.WasModified := True;
    Result := True;
  finally
    HideScanSplash;
    NSChangeNotify(0, NSN_STATUSCHANGED, NSN_FLUSHNOWAIT, nil, nil);
  end;
end;
*)


function PasteCommand(const ATarget: TNSCollection): HRESULT;
var
  FileList: TStringList;
  HG: HGLOBAL;
begin
  Clipboard.Open;
  HG := Clipboard.GetAsHandle(CF_HDROP);
  FileList := TStringList.Create;
  Result := S_FALSE;
  try
    if HG <> 0 then
    begin
      Result := MakeFileListFromHGlobal(HG, FileList);
      InsertItemsToProject(CurProject, FileList, ATarget);
    end;
  finally
    Clipboard.Clear;
    Clipboard.Close;
    FileList.Free;
  end;
end;

function BackupCommand: Boolean;
var
  FileList: TStringList;
  HG: HGLOBAL;
begin
  Clipboard.Open;
  HG := Clipboard.GetAsHandle(CF_HDROP);
  FileList := TStringList.Create;
  Result := False;
  try
    if HG <> 0 then
    begin
      if MakeFileListFromHGlobal(HG, FileList) <> S_OK then
        Exit;
      if CurProject <> nil then
        frmMain.AddToBackup(FileList);
      //        InsertItemsToProject(CurProject, FileList, nil);
      Result := True;
    end;
  finally
    Clipboard.Clear;
    Clipboard.Close;
    FileList.Free;
  end;
end;


function TEnumFormatEtc.Clone(out Enum: IEnumFormatEtc): HResult;
begin
  try
    Enum := TEnumFormatEtc.Create(FFormatList, FFormatCount, FIndex);
    Result := S_OK;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

constructor TEnumFormatEtc.Create(FormatList: PFormatList; FormatCount, Index: integer);
begin
  inherited Create;
  FFormatList := FormatList;
  FFormatCount := FormatCount;
  FIndex := Index;
end;

function TEnumFormatEtc.Next(celt: integer; out elt; pceltFetched: PLongint): HResult;
var
  i: integer;
begin
  try
    i := 0;
    while (i < Celt) and (FIndex < FFormatCount) do
    begin
      TFormatList(elt)[i] := FFormatList[FIndex];
      Inc(FIndex);
      Inc(i);
    end;
    if pceltFetched <> nil then
      pceltFetched^ := i;
    if i = celt then
      Result := S_OK
    else
      Result := S_FALSE;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

function TEnumFormatEtc.Reset: HResult;
begin
  try
    FIndex := 0;
    Result := S_OK;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

function TEnumFormatEtc.Skip(celt: integer): HResult;
begin
  try
    if celt <= FFormatCount - FIndex then
    begin
      FIndex := FIndex + celt;
      Result := S_OK;
    end
    else
    begin
      FIndex := FFormatCount;
      Result := S_FALSE;
    end;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

{ TnsDataTarget }


constructor TnsDataTarget.Create(AOwner: TWinControl);
begin
  inherited Create;
  FOwner := AOwner;
  if FOwner is TTreeView then
    FTargetMode := tmTreeView
  else
    FTargetMode := tmListView;
  FScrollTimer := TTimer.Create(FOwner);
  FScrollTimer.Interval := DD_DEFSCROLLINTERVAL;
  FScrollTimer.Enabled := False;
  FScrollTimer.OnTimer := DoAutoScroll;
  FFileList := TStringList.Create;
end;

destructor TnsDataTarget.Destroy;
begin
  FFileList.Free;
  inherited Destroy;
end;

procedure TnsDataTarget.DoAutoScroll(Sender: TObject);
begin
  FScrollTimer.Enabled := False;
  if FLastPoint.Y > FOwner.Height - 12 then
    FOwner.Perform(WM_VSCROLL, SB_LINEDOWN, 0)
  else if FLastPoint.Y < 12 then
    FOwner.Perform(WM_VSCROLL, SB_LINEUP, 0);
  if FLastPoint.X > FOwner.Width - 12 then
    FOwner.Perform(WM_HSCROLL, SB_LINEDOWN, 0)
  else if FLastPoint.X < 12 then
    FOwner.Perform(WM_HSCROLL, SB_LINEUP, 0);
  FScrollTimer.Enabled := True;
end;

function TnsDataTarget.DragEnter(const dataObj: IDataObject; grfKeyState: integer; pt: TPoint;
  var dwEffect: integer): HResult;
var
  medium: TStgMedium;
begin
  if (CurProject = nil) or (frmMain.tvRemote.Selected = nil) then
  begin
    Result := S_FALSE;
    Exit;
  end;
  try
    FDataObject := dataObj;
    if Succeeded(dataObj.QueryGetData(CF_HDROP_FormatEtc)) then
    begin
      dwEffect := DROPEFFECT_COPY;
      Result := dataObj.GetData(CF_HDROP_FormatEtc, medium);
      if Succeeded(Result) then
      begin
        MakeFileListFromHGlobal(medium.hGlobal, FFileList);
        ReleaseStgMedium(medium);
      end;
    end
    else if Succeeded(dataObj.QueryGetData(CF_IDLIST_FormatEtc)) then
    begin
      dwEffect := DROPEFFECT_COPY;
      Result := dataObj.GetData(CF_IDLIST_FormatEtc, medium);
      if Succeeded(Result) then
      begin
        MakeFileListFromPIDLHGlobal(medium.hGlobal, FFileList);
        ReleaseStgMedium(medium);
      end;
    end
    else
      Result := S_FALSE;

  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;

end;

function TnsDataTarget.DragLeave: HResult;
begin
  try
    FDataObject := nil;
    Result := S_OK;
    FScrollTimer.Enabled := False;
    if FTargetMode = tmTreeView then
      TTreeView(FOwner).DropTarget := nil
    else
      TListView(FOwner).DropTarget := nil;
    FFileList.Clear;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

function TnsDataTarget.DragOver(grfKeyState: integer; pt: TPoint; var dwEffect: longint): HResult;
var
  Node: TTreeNode;
  Item: TListItem;
begin

  try
    Result := S_OK;
    dwEffect := dwEffect and not DROPEFFECT_LINK;

{    if (MK_CONTROL and grfKeyState = 0) then
      dwEffect := dwEffect and not DROPEFFECT_COPY;
}
    if (MK_LBUTTON and grfKeyState = 0) then
      dwEffect := dwEffect and not DROPEFFECT_MOVE;

    if CurProject.Kind = pkBackup then
      Exit;

    ScreenToClient(FOwner.Handle, pt);
    FLastPoint := pt;
    if not FScrollTimer.Enabled then
      FScrollTimer.Enabled := True;

    if FTargetMode = tmTreeView then
    begin
      FTarget := nil;
      Node := TTreeView(FOwner).GetNodeAt(pt.X, pt.Y);
      if (Node = nil) or (Node.Data = nil) then
      begin
        DWORD(dwEffect) := DROPEFFECT_NONE or DROPEFFECT_SCROLL;
        Exit;
      end;
      TTreeView(FOwner).DropTarget := Node;
      FTarget := TNSCollection(Node.Data);
      //    if not IsValidTarget(FTarget, FItems[0]) then
      //      dwEffect := DROPEFFECT_NONE or DROPEFFECT_SCROLL;
    end
    else
    begin
      FTarget := LVTarget;
      TListView(FOwner).DropTarget := nil;
      Item := TListView(FOwner).GetItemAt(pt.X, pt.Y);
      if (Item <> nil) and TNSItem(Item.Data).IsFolder then
      begin
        TListView(FOwner).DropTarget := Item;
        FTarget := TNSItem(Item.Data).SubItems;
      end;
    end;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

function TnsDataTarget.Drop(const dataObj: IDataObject; grfKeyState: integer; pt: TPoint;
  var dwEffect: longint): HResult;
var
  Node: TTreeNode;
  Item: TListItem;
begin
  try
    Result := S_OK;
    dwEffect := dwEffect and not DROPEFFECT_LINK;

    if (MK_CONTROL and grfKeyState = 0) then
      dwEffect := dwEffect and not DROPEFFECT_COPY;
    if (MK_LBUTTON and grfKeyState = 0) then
      dwEffect := dwEffect and not DROPEFFECT_MOVE;

    if CurProject.Kind = pkBackup then
    begin
      frmMain.AddToBackup(FFileList);
      //      InsertItemsToProject(CurProject, FFileList, nil);
      NSChangeNotify(
        0,
        NSN_UPDATEFOLDER,
        NSN_FLUSHNOWAIT,
        nil,
        nil);
      Exit;
    end;

    ScreenToClient(FOwner.Handle, pt);
    FLastPoint := pt;
    if not FScrollTimer.Enabled then
      FScrollTimer.Enabled := True;

    if FTargetMode = tmTreeView then
    begin
      FTarget := nil;
      Node := TTreeView(FOwner).GetNodeAt(pt.X, pt.Y);
      if (Node = nil) or (Node.Data = nil) then
      begin
        DWORD(dwEffect) := DROPEFFECT_NONE or DROPEFFECT_SCROLL;
        Exit;
      end;
      TTreeView(FOwner).DropTarget := Node;
      FTarget := TNSCollection(Node.Data);
      frmMain.AddToBackup(FFileList);
      //      InsertItemsToProject(CurProject, FFileList, FTarget);

      NSChangeNotify(
        0,
        NSN_UPDATEFOLDER,
        NSN_FLUSHNOWAIT,
        FTarget,
        nil);
      TTreeView(FOwner).DropTarget := nil;
    end
    else
    begin
      FTarget := LVTarget;
      TListView(FOwner).DropTarget := nil;
      Item := TListView(FOwner).GetItemAt(pt.X, pt.Y);
      if (Item <> nil) and TNSItem(Item.Data).IsFolder then
      begin
        TListView(FOwner).DropTarget := Item;
        FTarget := TNSItem(Item.Data).SubItems;
      end;
      frmMain.AddToBackup(FFileList);
      //      InsertItemsToProject(CurProject, FFileList, FTarget);
      TListView(FOwner).DropTarget := nil;
      NSChangeNotify(
        0,
        NSN_UPDATEFOLDER,
        NSN_FLUSHNOWAIT,
        FTarget,
        nil);
    end;
  except
    on E: TObject do
      Result := SafeCallException(E, ExceptAddr);
  end;
end;

initialization


end.
