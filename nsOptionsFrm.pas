unit nsOptionsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ShellAPI, nsGlobals, nsUtils,
  IdSMTP, ImgList, IdIOHandler, IdIOHandlerSocket, System.UITypes,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdMessage, System.ImageList;

type

  TColorBox = class(ExtCtrls.TColorBox)
  protected
    procedure DrawItem(Index: integer; Rect: TRect; State: TOwnerDrawState); override;
    function PickCustomColor: Boolean; override;
  end;


  TfrmOptions = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    rbDefaultProxy: TRadioButton;
    rbManualProxy: TRadioButton;
    rbNoProxy: TRadioButton;
    edtProxyName: TEdit;
    lblProxyName: TLabel;
    edtProxyPort: TEdit;
    lblProxyPort: TLabel;
    btnViewProxySettings: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lbElements: TListBox;
    cbColors: TColorBox;
    chkBold: TCheckBox;
    chkItalic: TCheckBox;
    chkUnderline: TCheckBox;
    chkStrikeOut: TCheckBox;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox5: TGroupBox;
    rbDefaultUseLast: TRadioButton;
    rbDefaultUseDefault: TRadioButton;
    Label9: TLabel;
    pnlFTP: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtHost: TEdit;
    edtPort: TEdit;
    edtUser: TEdit;
    edtHostPwd: TEdit;
    edtHostDir: TEdit;
    chkPassive: TCheckBox;
    ckbDialup: TCheckBox;
    ckbDialupHangup: TCheckBox;
    pnlLocal: TPanel;
    Label16: TLabel;
    edtLocalFolder: TEdit;
    btnBrowseForLocalFolder: TButton;
    cbMediaType: TComboBox;
    ilOptions1: TImageList;
    GroupBox3: TGroupBox;
    trReadSpeed: TTrackBar;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label24: TLabel;
    chkShowHidden: TCheckBox;
    Bevel5: TBevel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    edtSMTPServer: TEdit;
    Label7: TLabel;
    edtSMTPPort: TEdit;
    chkSMTP: TCheckBox;
    edtSMTPAccount: TEdit;
    edtSMTPPassword: TEdit;
    lblSMTPAccount: TLabel;
    lblSMTPPassword: TLabel;
    GroupBox7: TGroupBox;
    Label10: TLabel;
    Label8: TLabel;
    edtSenderEMail: TEdit;
    GroupBox8: TGroupBox;
    Label5: TLabel;
    cbLanguages: TComboBox;
    GroupBox9: TGroupBox;
    ckbPlaySounds: TCheckBox;
    btSounds: TButton;
    GroupBox10: TGroupBox;
    Label4: TLabel;
    edtProjectDir: TEdit;
    Label17: TLabel;
    edtLogDir: TEdit;
    btnBrowseProjectDir: TButton;
    btnBrowseLogDir: TButton;
    chkUseSSL: TCheckBox;
    cbUseTLS: TComboBox;
    lblUseTLS: TLabel;
    GroupBox11: TGroupBox;
    Label25: TLabel;
    edtRecipEMail: TEdit;
    edtSenderName: TEdit;
    Label27: TLabel;
    edtRecipName: TEdit;
    trWriteSpeed: TTrackBar;
    EmailSender: TIdSMTP;
    Msg: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    btnTestSMTP: TButton;
    lblUseTLS2: TLabel;
    cbUseTLS2: TComboBox;
    procedure btnViewProxySettingsClick(Sender: TObject);
    procedure ConnectTypeClick(Sender: TObject);
    procedure lbElementsClick(Sender: TObject);
    procedure cbColorsSelect(Sender: TObject);
    procedure chkBoldClick(Sender: TObject);
    procedure chkItalicClick(Sender: TObject);
    procedure chkUnderlineClick(Sender: TObject);
    procedure chkStrikeOutClick(Sender: TObject);
    procedure chkSMTPClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btSoundsClick(Sender: TObject);
    procedure ckbPlaySoundsClick(Sender: TObject);
    procedure btnBrowseForLocalFolderClick(Sender: TObject);
    procedure cbMediaTypeChange(Sender: TObject);
    procedure btnBrowseProjectDirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTestSMTPClick(Sender: TObject);
  private
    { Private declarations }
    FdrNormal: TItemDrawRec;
    FdrBackup: TItemDrawRec;
    FdrRestore: TItemDrawRec;
    //    FdrDelete: TItemDrawRec;
    procedure GetOptions;
    procedure SetOptions;
  public
    { Public declarations }
  end;

function DisplayOptionsDialog(AOwner: TForm; APage: integer = 0): Boolean;

implementation

{$R *.dfm}



function DisplayOptionsDialog(AOwner: TForm; APage: integer = 0): Boolean;
begin
  Result := False;
  with TfrmOptions.Create(AOwner) do
    try
      PageControl.ActivePageIndex := APage;
      GetOptions;
      if ShowModal = mrOk then
      begin
        SetOptions;
        Result := True;
      end;
    finally
      Free;
    end;
end;

{ TOptionsForm }

procedure TfrmOptions.GetOptions;
var
  Media: TBackupMedia;
begin
  edtProxyName.Text := g_ProxyName;
  edtProxyPort.Text := g_ProxyPort;
  case g_ConnectType of
    ftpcDefault: rbDefaultProxy.Checked := True;
    ftpcDirect: rbNoProxy.Checked := True;
    ftpcUseProxy: rbManualProxy.Checked := True;
  end;

  FdrNormal  := g_drNormal;
  FdrRestore := g_drRestore;
  FdrBackup  := g_drBackup;
  //  FdrDelete  := g_drDelete;
  lbElements.ItemIndex := 0;
  lbElements.OnClick(Self);

  //  cbTextOptions.ItemIndex := Ord(g_NoTextLabels);
  //  cbIconOptions.ItemIndex := Ord(g_LargeIcons);

  edtSMTPServer.Text := g_SMTPServer;
  edtSMTPPort.Text := IntToStr(g_SMTPPort);
  edtSMTPAccount.Text := g_SMTPAccount;
  edtSMTPPassword.Text := g_SMTPPassword;
  //  edtCollisionFolder.Text := g_CollisionFolder;

  edtRecipEMail.Text := g_RecipEMail;
  edtRecipName.Text  := g_RecipName;

  edtSenderEMail.Text := g_SenderEMail;
  edtSenderName.Text  := g_SenderName;

  chkSMTP.Checked := g_AuthenticationType <> satNone;
  chkUseSSL.Checked := g_UseSSL;
  cbUseTLS.ItemIndex := Ord(g_UseTLS);


  chkSMTPClick(Self);
  ckbPlaySounds.Checked := g_PlaySounds;

  for Media := Low(TBackupMedia) to High(TBackupMedia) do
    cbMediaType.Items.Add(BackupMediaNames[Media]^);
  cbMediaType.ItemIndex := g_DefaultBackupMedia;
  cbMediaType.OnChange(Self);

  rbDefaultUseLast.Checked := g_DefaultBackupLast;
  rbDefaultUseDefault.Checked := g_DefaultBackupDefined;
  edtLocalFolder.Text := g_DefaultLocalFolder;
  edtHost.Text := g_DefaultHostName;
  edtPort.Text := g_DefaultPort;
  edtUser.Text := g_DefaultUserName;
  edtHostPwd.Text := g_DefaultPassword;
  edtHostDir.Text := g_DefaultHostDirName;
  chkPassive.Checked := g_DefaultUsePassive;

  ckbDialupHangup.Checked := g_DefaultHangUpOnCompleted;

  // 2.1
  edtProjectDir.Text := g_ProjectsDir;
  edtLogDir.Text := g_LogDir;
  trReadSpeed.Position := g_ReadSpeed;
  trWriteSpeed.Position := g_WriteSpeed;

  chkShowHidden.Checked := g_ShowHidden;
  cbUseTLS2.ItemIndex := Ord(g_SSLVersion);

end;

procedure TfrmOptions.SetOptions;
begin
  if rbDefaultProxy.Checked then
    g_ConnectType := ftpcDefault
  else if rbNoProxy.Checked then
    g_ConnectType := ftpcDirect
  else
  begin
    g_ConnectType := ftpcUseProxy;
    g_ProxyName := edtProxyName.Text;
    g_ProxyPort := edtProxyPort.Text;
  end;

  g_drNormal  := FdrNormal;
  g_drRestore := FdrRestore;
  g_drBackup  := FdrBackup;

  //  g_NoTextLabels := Boolean(cbTextOptions.ItemIndex);
  //  g_LargeIcons := Boolean(cbIconOptions.ItemIndex);

  g_SMTPServer := edtSMTPServer.Text;
  g_SMTPPort := StrToIntDef(edtSMTPPort.Text, 25);
  g_SMTPAccount := edtSMTPAccount.Text;
  g_SMTPPassword := edtSMTPPassword.Text;


  g_RecipEMail := edtRecipEMail.Text;
  g_RecipName  := edtRecipName.Text;

  g_SenderEMail := edtSenderEMail.Text;
  g_SenderName  := edtSenderName.Text;

  g_AuthenticationType := TIdSMTPAuthenticationType(chkSMTP.Checked);
  g_UseSSL := chkUseSSL.Checked;
  g_UseTLS := TIdUseTLS(cbUseTLS.ItemIndex);

  //  g_CollisionFolder := edtCollisionFolder.Text;

  g_PlaySounds := ckbPlaySounds.Checked;

  g_DefaultBackupLast := rbDefaultUseLast.Checked;
  g_DefaultBackupDefined := rbDefaultUseDefault.Checked;
  g_DefaultBackupMedia := cbMediaType.ItemIndex;
  g_DefaultLocalFolder := edtLocalFolder.Text;
  g_DefaultHostName := edtHost.Text;
  g_DefaultPort := edtPort.Text;
  g_DefaultUserName := edtUser.Text;
  g_DefaultPassword := edtHostPwd.Text;
  g_DefaultHostDirName := edtHostDir.Text;
  g_DefaultUsePassive := chkPassive.Checked;

  g_DefaultHangUpOnCompleted := ckbDialupHangup.Checked;

  // 2.1
  if DirectoryExists(edtProjectDir.Text) then
    g_ProjectsDir := IncludeTrailingPathDelimiter(edtProjectDir.Text);
  if DirectoryExists(edtLogDir.Text) then
    g_LogDir := IncludeTrailingPathDelimiter(edtLogDir.Text);
  g_ReadSpeed := trReadSpeed.Position;
  g_WriteSpeed := trWriteSpeed.Position;
  g_ShowHidden := chkShowHidden.Checked;

  g_SSLVersion := TIdSSLVersion(cbUseTLS2.ItemIndex);


end;

procedure TfrmOptions.btnViewProxySettingsClick(Sender: TObject);
begin
  ShellExecute(Handle, pOpen, 'control.exe', 'inetcpl.cpl,@0,0', nil, SW_SHOWNORMAL);
  GetDefaultProxySettings(g_ProxyName, g_ProxyPort);
end;

procedure TfrmOptions.ConnectTypeClick(Sender: TObject);
begin
  lblProxyName.Enabled := rbManualProxy.Checked;
  edtProxyName.Enabled := rbManualProxy.Checked;
  lblProxyPort.Enabled := rbManualProxy.Checked;
  edtProxyPort.Enabled := rbManualProxy.Checked;
end;

procedure TfrmOptions.lbElementsClick(Sender: TObject);
begin
  case lbElements.ItemIndex of
    0:
    begin
      cbColors.Selected := FdrNormal.Color;
      chkBold.Checked := fsBold in FdrNormal.Style;
      chkUnderline.Checked := fsUnderline in FdrNormal.Style;
      chkItalic.Checked := fsItalic in FdrNormal.Style;
      chkStrikeOut.Checked := fsStrikeOut in FdrNormal.Style;
    end;
    1:
    begin
      cbColors.Selected := FdrBackup.Color;
      chkBold.Checked := fsBold in FdrBackup.Style;
      chkUnderline.Checked := fsUnderline in FdrBackup.Style;
      chkItalic.Checked := fsItalic in FdrBackup.Style;
      chkStrikeOut.Checked := fsStrikeOut in FdrBackup.Style;
    end;
    2:
    begin
      cbColors.Selected := FdrRestore.Color;
      chkBold.Checked := fsBold in FdrRestore.Style;
      chkUnderline.Checked := fsUnderline in FdrRestore.Style;
      chkItalic.Checked := fsItalic in FdrRestore.Style;
      chkStrikeOut.Checked := fsStrikeOut in FdrRestore.Style;
    end;
(*
    3:
    begin
      cbColors.Selected := FdrDelete.Color;
      chkBold.Checked := fsBold in FdrDelete.Style;
      chkUnderline.Checked := fsUnderline in FdrDelete.Style;
      chkItalic.Checked := fsItalic in FdrDelete.Style;
      chkStrikeOut.Checked := fsStrikeOut in FdrDelete.Style;
    end;
*)
  end;
end;

procedure TfrmOptions.cbColorsSelect(Sender: TObject);
begin
  case lbElements.ItemIndex of
    0: FdrNormal.Color  := cbColors.Selected;
    1: FdrBackup.Color  := cbColors.Selected;
    2: FdrRestore.Color := cbColors.Selected;
    //    3: FdrDelete.Color  := cbColors.Selected;
  end;
end;

procedure TfrmOptions.chkBoldClick(Sender: TObject);
begin
  case lbElements.ItemIndex of
    0: if chkBold.Checked then
        FdrNormal.Style := FdrNormal.Style + [fsBold]
      else
        FdrNormal.Style := FdrNormal.Style - [fsBold];
    1: if chkBold.Checked then
        FdrBackup.Style := FdrBackup.Style + [fsBold]
      else
        FdrBackup.Style := FdrBackup.Style - [fsBold];
    2: if chkBold.Checked then
        FdrRestore.Style := FdrRestore.Style + [fsBold]
      else
        FdrRestore.Style := FdrRestore.Style - [fsBold];
(*
    3: if chkBold.Checked then
        FdrDelete.Style := FdrDelete.Style + [fsBold]
      else
        FdrDelete.Style := FdrDelete.Style - [fsBold];
*)
  end;
end;

procedure TfrmOptions.chkItalicClick(Sender: TObject);
begin
  case lbElements.ItemIndex of
    0: if chkItalic.Checked then
        FdrNormal.Style := FdrNormal.Style + [fsItalic]
      else
        FdrNormal.Style := FdrNormal.Style - [fsItalic];
    1: if chkItalic.Checked then
        FdrBackup.Style := FdrBackup.Style + [fsItalic]
      else
        FdrBackup.Style := FdrBackup.Style - [fsItalic];
    2: if chkItalic.Checked then
        FdrRestore.Style := FdrRestore.Style + [fsItalic]
      else
        FdrRestore.Style := FdrRestore.Style - [fsItalic];
(*
    3: if chkItalic.Checked then
        FdrDelete.Style := FdrDelete.Style + [fsItalic]
      else
        FdrDelete.Style := FdrDelete.Style - [fsItalic];
*)
  end;
end;

procedure TfrmOptions.chkUnderlineClick(Sender: TObject);
begin
  case lbElements.ItemIndex of
    0: if chkUnderline.Checked then
        FdrNormal.Style := FdrNormal.Style + [fsUnderline]
      else
        FdrNormal.Style := FdrNormal.Style - [fsUnderline];
    1: if chkUnderline.Checked then
        FdrBackup.Style := FdrBackup.Style + [fsUnderline]
      else
        FdrBackup.Style := FdrBackup.Style - [fsUnderline];
    2: if chkUnderline.Checked then
        FdrRestore.Style := FdrRestore.Style + [fsUnderline]
      else
        FdrRestore.Style := FdrRestore.Style - [fsUnderline];
(*
    3: if chkUnderline.Checked then
        FdrDelete.Style := FdrDelete.Style + [fsUnderline]
      else
        FdrDelete.Style := FdrDelete.Style - [fsUnderline];
*)
  end;
end;

procedure TfrmOptions.chkStrikeOutClick(Sender: TObject);
begin
  case lbElements.ItemIndex of
    0: if chkStrikeOut.Checked then
        FdrNormal.Style := FdrNormal.Style + [fsStrikeOut]
      else
        FdrNormal.Style := FdrNormal.Style - [fsStrikeOut];
    1: if chkStrikeOut.Checked then
        FdrBackup.Style := FdrBackup.Style + [fsStrikeOut]
      else
        FdrBackup.Style := FdrBackup.Style - [fsStrikeOut];
    2: if chkStrikeOut.Checked then
        FdrRestore.Style := FdrRestore.Style + [fsStrikeOut]
      else
        FdrRestore.Style := FdrRestore.Style - [fsStrikeOut];
(*
    3: if chkStrikeOut.Checked then
        FdrDelete.Style := FdrDelete.Style + [fsStrikeOut]
      else
        FdrDelete.Style := FdrDelete.Style - [fsStrikeOut];
*)
  end;
end;

procedure TfrmOptions.chkSMTPClick(Sender: TObject);
const
  DisArray: array[Boolean] of TColor = (clBtnFace, clWindow);
begin
  edtSMTPAccount.Enabled := chkSMTP.Checked;
  edtSMTPAccount.Color  := DisArray[chkSMTP.Checked];
  lblSMTPAccount.Enabled := chkSMTP.Checked;
  edtSMTPPassword.Enabled := chkSMTP.Checked;
  edtSMTPPassword.Color := DisArray[chkSMTP.Checked];
  lblSMTPPassword.Enabled := chkSMTP.Checked;

  cbUseTLS.Enabled  := chkUseSSL.Checked;
  lblUseTLS.Enabled := chkUseSSL.Checked;

  cbUseTLS2.Enabled  := chkUseSSL.Checked;
  lblUseTLS2.Enabled := chkUseSSL.Checked;
end;

procedure TfrmOptions.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(PageControl.ActivePage.HelpContext);
end;


procedure TfrmOptions.btnTestSMTPClick(Sender: TObject);
begin
  if not IsValidEmail(edtRecipEMail.Text) then
  begin
    MessageDlg(sEnterValidEmail, mtWarning, [mbOK], 0);
    if edtRecipEMail.CanFocus then
      edtRecipEMail.SetFocus;
    Exit;
  end;

  if chkUseSSL.Checked then
  begin
    EmailSender.IOHandler := IdSSLIOHandlerSocketOpenSSL;
    EmailSender.UseTLS := TIdUseTLS(cbUseTLS.ItemIndex);
    IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := TIdSSLVersion(cbUseTLS2.ItemIndex);
  end
  else
  begin
    EmailSender.IOHandler := nil;
    EmailSender.UseTLS := utNoTLSSupport;
  end;


  EmailSender.Host := edtSMTPServer.Text;
  EmailSender.Port := StrToIntDef(edtSMTPPort.Text, 25);
  if chkSMTP.Checked then
  begin
    EmailSender.Username := edtSMTPAccount.Text;
    EmailSender.Password := edtSMTPPassword.Text;
  end
  else
  begin
    EmailSender.Username := EmptyStr;
    EmailSender.Password := EmptyStr;
  end;
  try
    Screen.Cursor := crHourGlass;
    btnTestSMTP.Enabled := False;
    try
      EmailSender.Connect;

      Msg.From.Address := edtSenderEMail.Text;
      Msg.From.Name := edtSenderName.Text;

      Msg.Recipients.EMailAddresses := edtRecipEMail.Text;

      Msg.Subject := sEmailTestSubject;
      Msg.Body.Text := sEmailTestBody;

      EmailSender.Send(Msg);

      MessageDlg(Format(sEmailTestSend, [edtRecipEMail.Text]),
        mtInformation, [mbOK], 0);
    finally
      Screen.Cursor := crDefault;
      btnTestSMTP.Enabled := True;
      if EmailSender.Connected then
        EmailSender.Disconnect;
    end;
  except
    on E: Exception do
      MessageDlg(Format(sErrorConnecting, [E.Message]), mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmOptions.btSoundsClick(Sender: TObject);
begin
  ShellExecute(0, pOpen, 'rundll32.exe', 'shell32.dll,Control_RunDLL mmsys.cpl', '', SW_SHOWNORMAL);
end;

procedure TfrmOptions.ckbPlaySoundsClick(Sender: TObject);
begin
  btSounds.Enabled := ckbPlaySounds.Checked;
end;

procedure TfrmOptions.btnBrowseForLocalFolderClick(Sender: TObject);
var
  sFolder: string;
begin
  sFolder := edtLocalFolder.Text;
  if SelectDir(sSelectBackupPath, sFolder) then
    edtLocalFolder.Text := sFolder;
end;

procedure TfrmOptions.cbMediaTypeChange(Sender: TObject);
begin
  pnlLocal.Visible := cbMediaType.ItemIndex = 0;
  pnlFTP.Visible := cbMediaType.ItemIndex = 1;
end;

procedure TfrmOptions.btnBrowseProjectDirClick(Sender: TObject);
var
  Edt: TEdit;
  sFolder: String;
begin
  case (Sender as TButton).Tag of
    1: Edt := edtProjectDir;
    2: Edt := edtLogDir;
    else
      Exit;
  end;
  sFolder := Edt.Text;
  if SelectDir(sSelectFolder, sFolder) then
    Edt.Text := sFolder;
end;

{ TColorBox }


procedure TColorBox.DrawItem(Index: integer; Rect: TRect; State: TOwnerDrawState);

  function ColorToBorderColor(AColor: TColor): TColor;
  type
    TColorQuad = record
      Red,
      Green,
      Blue,
      Alpha: byte;
    end;
  begin
    if (TColorQuad(AColor).Red > 192) or (TColorQuad(AColor).Green > 192) or (TColorQuad(AColor).Blue > 192) then
      Result := clBlack
    else if odSelected in State then
      Result := clWhite
    else
      Result := AColor;
  end;

var
  LRect: TRect;
  LBackground: TColor;
begin
  with Canvas do
  begin
    FillRect(Rect);
    LBackground := Brush.Color;

    LRect := Rect;
    //    LRect.Right := LRect.Bottom - LRect.Top + LRect.Left;
    InflateRect(LRect, -1, -1);

    if Index = 0 then
    begin
      DrawText(Handle, PChar(SCustom), -1, LRect, DT_CENTER);
      Exit;
    end;

    Brush.Color := Colors[Index];
    if Brush.Color = clDefault then
      Brush.Color := DefaultColorColor
    else if Brush.Color = clNone then
      Brush.Color := NoneColorColor;
    FillRect(LRect);
    Brush.Color := ColorToBorderColor(ColorToRGB(Brush.Color));
    FrameRect(LRect);

    Brush.Color := LBackground;
    //    Rect.Left := LRect.Right + 5;

    //    TextRect(Rect, Rect.Left,         Rect.Top + (Rect.Bottom - Rect.Top - TextHeight(Items[Index])) div 2,      Items[Index]);
  end;
end;

function TColorBox.PickCustomColor: Boolean;
var
  LColor: TColor;
  dlgColor: TColorDialog;
begin
  dlgColor := TColorDialog.Create(Self);
  try
    LColor := ColorToRGB(TColor(Items.Objects[0]));
    Color  := LColor;
    dlgColor.CustomColors.Text := Format('ColorA=%.8x', [LColor]);
    Result := dlgColor.Execute;
    if Result then
    begin
      Items.Objects[0] := TObject(Color);
      Self.Invalidate;
    end;
  finally
    FreeAndNil(dlgColor);
  end;
end;

procedure TfrmOptions.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
