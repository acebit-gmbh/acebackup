unit nsMultiFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ShellAPI, ShlObj,
  nsTypes, nsGlobals;

type
  TItemArray = array of TNSItem;

type
  TfrmMultiItems = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PageControl: TPageControl;
    TS1: TTabSheet;
    Image1: TImage;
    lblContains: TLabel;
    lblSizeOnMedia: TLabel;
    Label6: TLabel;
    lblType: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    edtOriginalLocation: TEdit;
    btnChange: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure btnChangeClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FItems: TItemArray;
    FThread: TThread;
    FLocationChanged: Boolean;
    FNewLocation: string;
    procedure GetProperties(const AItems: TItemArray);
    procedure SetProperties(const AItems: TItemArray);
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
  end;

  TScanThread = class(TThread)
  private
    FSize: int64;
    FFolderCount: integer;
    FFileCount: integer;
    FForm: TfrmMultiItems;
    FItems: TItemArray;
    procedure Update;
  public
    constructor Create(AForm: TfrmMultiItems; AItems: TItemArray);
    destructor Destroy; override;
    procedure Execute; override;
  end;


function DisplayMultiPropertiesDialog(AOwner: TForm; AItems: TItemArray): Boolean;

implementation

uses nsUtils;

{$R *.dfm}

function DisplayMultiPropertiesDialog(AOwner: TForm; AItems: TItemArray): Boolean;
begin
  Result := False;
  with TfrmMultiItems.Create(AOwner) do
    try
      FItems := AItems;
      GetProperties(AItems);
      if ShowModal = mrOk then
      begin
        SetProperties(AItems);
        Result := True;
      end;
    finally
      Free;
    end;
end;


procedure TfrmMultiItems.GetProperties(const AItems: TItemArray);
var
  //  Location: string;
  FileInfo: TSHFileInfo;
  FirstType: string;
  NextType: string;
  iArr: integer;
  SameType: Boolean;
  dwAttr: DWORD;
  FirstLocation: string;
  NextLocation: string;
  FirstLocationNotInit: Boolean;
begin
  Caption := Format(sMultiProperties, [AItems[0].DisplayName]);
  Image1.Picture.Icon.Handle := LoadIcon(g_hmShell, PChar(133));

  if AItems[0].IsFolder then
    dwAttr := FILE_ATTRIBUTE_DIRECTORY
  else
    dwAttr := FILE_ATTRIBUTE_NORMAL;
  SHGetFileInfo(PChar(AItems[0].DisplayName),
    dwAttr,
    FileInfo,
    SizeOf(FileInfo),
    SHGFI_USEFILEATTRIBUTES or SHGFI_TYPENAME);
  FirstType := StrPas(FileInfo.szTypeName);
  SameType  := True;
  for iArr := 1 to High(AItems) do
  begin
    if AItems[iArr].IsFolder then
      dwAttr := FILE_ATTRIBUTE_DIRECTORY
    else
      dwAttr := FILE_ATTRIBUTE_NORMAL;
    SHGetFileInfo(PChar(AItems[iArr].DisplayName),
      dwAttr,
      FileInfo,
      SizeOf(FileInfo),
      SHGFI_USEFILEATTRIBUTES or SHGFI_TYPENAME);
    NextType := StrPas(FileInfo.szTypeName);
    if not AnsiSameText(FirstType, NextType) then
    begin
      SameType := False;
      Break;
    end;
  end;
  if SameType then
    lblType.Caption := Format(sAllOfType, [FirstType])
  else
    lblType.Caption := sMultipleTypes;

  SameType := True;
  FirstLocationNotInit := True;
  for iArr := 0 to High(AItems) do
  begin
    if AItems[iArr].IsFolder then
      Continue;
    if FirstLocationNotInit then
    begin
      FirstLocation := AItems[iArr].LocalPath;
      FirstLocationNotInit := False;
      Continue;
    end;
    NextLocation := AItems[iArr].LocalPath;
    if not AnsiSameText(FirstLocation, NextLocation) then
    begin
      SameType := False;
      Break;
    end;
  end;

  if SameType then
  begin
    if FirstLocation <> EmptyStr then
      edtOriginalLocation.Text := Format(sAllIn, [FirstLocation])
    else
      edtOriginalLocation.Text := sUnknown;
  end
  else
  begin
    if FirstLocation <> EmptyStr then
      edtOriginalLocation.Text := sMultipleLocations
    else
      edtOriginalLocation.Text := sUnknown;
  end;
  FThread := TScanThread.Create(Self, AItems);
end;

procedure TfrmMultiItems.SetProperties(const AItems: TItemArray);
var
  iArr: integer;
  Item: TNSItem;

  procedure ScanSubItems(const ASubItems: TNSCollection; const ANewPath: string);
  var
    Index: integer;
    CurItem: TNSItem;
  begin
    for Index := 0 to ASubItems.Count - 1 do
    begin
      CurItem := ASubItems[Index];
      if CurItem.IsFolder then
        ScanSubItems(CurItem.SubItems, IncludeTrailingPathDelimiter(ANewPath) + CurItem.DisplayName)
      else
      begin
        //        CurItem.OldLocalPath := CurItem.LocalPath;
        CurItem.LocalPath := ANewPath;
      end;
    end;
  end;

begin
  if FLocationChanged then
  begin
    for iArr := 0 to High(FItems) do
    begin
      Item := FItems[iArr];
      if Item.IsFolder then
        ScanSubItems(Item.SubItems, IncludeTrailingPathDelimiter(FNewLocation) + Item.DisplayName)
      else
      begin
        //        Item.OldLocalPath := Item.LocalPath;
        Item.LocalPath := FNewLocation;
      end;
    end;
  end;
end;


procedure TfrmMultiItems.UpdateActions;
begin
end;

{ TScanThread }

constructor TScanThread.Create(AForm: TfrmMultiItems; AItems: TItemArray);
begin
  inherited Create(True);
  FForm  := AForm;
  FItems := AItems;
  Priority := tpLower;
  FreeOnTerminate := True;
  Execute; // FIX // Resume;
end;

destructor TScanThread.Destroy;
begin
  FForm.FThread := nil;
  inherited Destroy;
end;

procedure TScanThread.Execute;
var
  iArr: integer;
  Item: TNSItem;

  procedure ScanSubItems(const ACollection: TNSCollection);
  var
    Index: integer;
    CurItem: TNSItem;
  begin
    Synchronize(Update);
    for Index := 0 to ACollection.Count - 1 do
    begin
      CurItem := ACollection[Index];
      if CurItem.IsFolder then
      begin
        Inc(FFolderCount);
        ScanSubItems(CurItem.SubItems);
      end
      else
      begin
        Inc(FFileCount);
        FSize := FSize + CurItem.SizeOnMedia;
      end;
    end;
  end;

begin
  FSize := 0;
  FFolderCount := 0;
  FFileCount := 0;
  for iArr := 0 to High(FItems) do
  begin
    Item := FItems[iArr];
    if Item.IsFolder then
    begin
      Inc(FFolderCount);
      ScanSubItems(Item.SubItems);
    end
    else
    begin
      Inc(FFileCount);
      FSize := FSize + Item.SizeOnMedia;
    end;
  end;
  Synchronize(Update);
end;

procedure TScanThread.Update;
begin
  with FForm do
  begin
    lblSizeOnMedia.Caption := FormatSize(FSize, True);
    lblContains.Caption := Format(sFFInfo, [FFileCount, FFolderCount]);
  end;
end;

procedure TfrmMultiItems.btnChangeClick(Sender: TObject);
var
  sFolder: string;
begin
  if SelectDir(sSelectDefaultLocItems, sFolder) and DirectoryExists(sFolder) then
  begin
    edtOriginalLocation.Text := Format(sAllIn, [sFolder]);
    FLocationChanged := True;
    FNewLocation := sFolder;
  end;
end;

procedure TfrmMultiItems.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(HelpContext, Application.HelpFile);
end;

end.
