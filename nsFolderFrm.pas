unit nsFolderFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ShellAPI, ShlObj, System.UITypes,
  nsTypes, nsGlobals;

type

  TfrmFolderProperties = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PageControl: TPageControl;
    TS1: TTabSheet;
    Image1: TImage;
    edtName: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    lblSizeOnMedia: TLabel;
    lblLocation: TLabel;
    Label8: TLabel;
    lblContains: TLabel;
    Label6: TLabel;
    lblType: TLabel;
    Label2: TLabel;
    lblCreated: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    cbDefAction: TComboBox;
    chkBackupItem: TCheckBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel2: TBevel;
    procedure btnHelpClick(Sender: TObject);
    procedure cbDefActionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FItem: TNSItem;
    FThread: TThread;
    procedure GetProperties(AItem: TNSItem);
    procedure SetProperties(AItem: TNSItem);
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
    FForm: TfrmFolderProperties;
    FFolder: TNSItem;
    procedure Update;
  public
    constructor Create(AForm: TfrmFolderProperties; AFolder: TNSItem);
    destructor Destroy; override;
    procedure Execute; override;
  end;


function DisplayFolderPropertiesDialog(AOwner: TForm; AItem: TNSItem): Boolean;

implementation

uses nsUtils, nsActions;


{$R *.dfm}

function DisplayFolderPropertiesDialog(AOwner: TForm; AItem: TNSItem): Boolean;
begin
  Result := False;
  with TfrmFolderProperties.Create(AOwner) do
    try
      GetProperties(AItem);
      if ShowModal = mrOk then
      begin
        SetProperties(AItem);
        Result := True;
      end;
    finally
      Free;
    end;
end;


procedure TfrmFolderProperties.GetProperties(AItem: TNSItem);
var
  FileInfo: TSHFileInfo;
  da: TDefaultAction;
begin
  FItem := AItem;
  FThread := TScanThread.Create(Self, AItem);
  edtName.Text := AItem.DisplayName;
  Caption := Format(sProperties, [AItem.DisplayName]);
  SHGetFileInfo(PChar(AItem.DisplayName),
    FILE_ATTRIBUTE_DIRECTORY,
    FileInfo,
    SizeOf(FileInfo),
    SHGFI_USEFILEATTRIBUTES or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_LARGEICON or SHGFI_TYPENAME);
  Image1.Picture.Icon.Handle := FileInfo.hIcon;
  lblType.Caption := StrPas(FileInfo.szTypeName);


  lblLocation.Caption := AItem.GetLocation;
  lblCreated.Caption  := DateTimeToStr(AItem.Created);

  for da := Low(TDefaultAction) to High(TDefaultAction) do
    cbDefAction.Items.Add(ActionNames[da]^);

  cbDefAction.ItemIndex := Ord(AItem.DefAction);

  if CurProject.Kind = pkBackup then
    chkBackupItem.Checked := AItem.BackupItem
  else
    chkBackupItem.Enabled := False;

end;

procedure TfrmFolderProperties.SetProperties(AItem: TNSItem);
begin
  if AItem.SubItems.Count = 0 then
    AItem.DefAction := TDefaultAction(cbDefAction.ItemIndex)
  else if AItem.DefAction <> TDefaultAction(cbDefAction.ItemIndex) then
  begin
    if MessageDlg(Format(sConfirmApplyDefAction, [ActionNames[TDefaultAction(cbDefAction.ItemIndex)]^]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      AItem.DefAction := TDefaultAction(cbDefAction.ItemIndex);
      ChangeDefAction(AItem, AItem.DefAction);
    end;
  end;

  if CurProject.Kind = pkBackup then
    AItem.BackupItem := chkBackupItem.Checked;
end;


procedure TfrmFolderProperties.UpdateActions;
begin
end;

{ TScanThread }

constructor TScanThread.Create(AForm: TfrmFolderProperties; AFolder: TNSItem);
begin
  inherited Create(True);
  FForm := AForm;
  FFolder := AFolder;
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
  ScanSubItems(FFolder.SubItems);
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

procedure TfrmFolderProperties.btnHelpClick(Sender: TObject);
begin
  Application.HelpSystem.ShowContextHelp(HelpContext, Application.HelpFile);
end;

procedure TfrmFolderProperties.cbDefActionChange(Sender: TObject);
begin
  if CurProject.FileFormat = fmAsIs then // As Is
    if cbDefAction.ItemIndex = 2 then
      cbDefAction.ItemIndex := 1;
end;

procedure TfrmFolderProperties.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
