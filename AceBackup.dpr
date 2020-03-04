program AceBackup;

uses
  Windows,
  Messages,
  Dialogs,
  Forms,
  SysUtils,
  nsTypes in 'nsTypes.pas',
  nsMainFrm in 'nsMainFrm.pas' {frmMain},
  nsUtils in 'nsUtils.pas',
  nsProjectFrm in 'nsProjectFrm.pas' {frmProjectProperties},
  nsSecSettingsFrm in 'nsSecSettingsFrm.pas' {frmSecSettings},
  nsDataObjects in 'nsDataObjects.pas',
  nsProcessFrm in 'nsProcessFrm.pas' {frmProcess},
  nsItemFrm in 'nsItemFrm.pas' {frmItemProperties},
  nsErrRestoreFrm in 'nsErrRestoreFrm.pas' {frmErrorRestore},
  nsActions in 'nsActions.pas',
  nsProjPwdFrm in 'nsProjPwdFrm.pas' {frmProjectPwd},
  nsOptionsFrm in 'nsOptionsFrm.pas' {frmOptions},
  nsScheduledThread in 'nsScheduledThread.pas',
  nsAboutFrm in 'nsAboutFrm.pas' {frmAbout},
  nsImportFrm in 'nsImportFrm.pas' {frmImportWizard},
  nsMultiFrm in 'nsMultiFrm.pas' {frmMultiItems},
  nsFolderFrm in 'nsFolderFrm.pas' {frmFolderProperties},
  nsConfirmReplaceFrm in 'nsConfirmReplaceFrm.pas' {frmConfirmReplaceDlg},
  nsConfirmUpdateFrm in 'nsConfirmUpdateFrm.pas' {frmConfirmUpdateDlg},
  nsLogFrm in 'nsLogFrm.pas' {frmLogView},
  nsSplashScan in 'nsSplashScan.pas' {frmScanner},
  nsReplaceForm in 'nsReplaceForm.pas' {frmReplaceDlg},
  nsMasks in 'nsMasks.pas',
  abSplash in 'abSplash.pas' {frmSplashMain},
  nsTaskPassword in 'nsTaskPassword.pas' {frmTaskPassword},
  nsAddToFrm in 'nsAddToFrm.pas' {frmAddToForm},
  nsMediaSettings in 'nsMediaSettings.pas' {frmMediaSettings},
  abWizardTemplate in 'abWizardTemplate.pas' {frmWizardTemplate},
  abWizardFrm in 'abWizardFrm.pas' {frmNewProjectWizard},
  abMasksDlg in 'abMasksDlg.pas' {frmMasks},
  _balloonform in '_balloonform.pas' {BalloonForm},
  nsCrypt in 'nsCrypt.pas',
  ziptools in 'ziptools.pas',
  nsVerifyFrm in 'nsVerifyFrm.pas' {frmVerifyWizard},
  abWaitDlg in 'abWaitDlg.pas' {frmWaitDlg},
  nsGlobals in 'nsGlobals.pas',
  abBackupWizard in 'abBackupWizard.pas' {frmBackupWizard},
  abRestoreWizard in 'abRestoreWizard.pas' {frmRestoreWizard},
  abDeleteWizard in 'abDeleteWizard.pas' {frmDeleteWizard},
  intTask,
  intIMAPI2,
  winftp in 'winftp.pas',
  cdWriter in 'cdWriter.pas',
  cdWrapper in 'cdWrapper.pas',
  tsTaskman in 'tsTaskman.pas',
  tsSettings in 'tsSettings.pas' {frmTaskSettings};

{$R *.res}

var
  Wnd: HWND;
  ModuleName: array[0..255] of Char;
  FileName: string;
  lMutex: THandle;

function EnumWndProc(hWnd: HWND; lParam: LPARAM): BOOL; stdcall;
var
  ClassBuf, ModuleBuf: array[0..255] of Char;
  Inst: HINST;
begin
  Result := True;
  GetClassName(hWnd, ClassBuf, 255);
  if lstrcmp(@ClassBuf, PChar(string(TfrmMain.ClassName))) = 0 then
  begin
    Inst := GetWindowLong(hWnd, GWL_HINSTANCE);
    GetModuleFileName(Inst, ModuleBuf, 255);
    if lstrcmp(@ModuleBuf, @ModuleName) = 0 then
    begin
      Wnd := hWnd;
      Result := False;
    end;
  end;
end;

procedure ExecuteApplication;
begin
  if ParamStr(1) = '-update' then
    g_RunMode := rmScheduled
  else if ParamStr(1) = '-as' then
    g_RunMode := rmContextMenu
  else
    g_RunMode := rmNormal;

   Application.Title := 'AceBackup 3';
  case g_RunMode of
    rmScheduled:
      begin
        Application.Initialize;
        Application.ShowMainForm := False;
        Application.CreateForm(TfrmMain, frmMain);
  FileName := ParamStr(2);
        if FileExists(FileName) then
          TScheduledThread.Create(frmMain.Handle, FileName)
        else
          frmMain.Close;
        Application.Run;
      end;
    rmContextMenu:
      begin
        Application.Initialize;
        Application.ShowMainForm := False;
        Application.CreateForm(TfrmMain, frmMain);
        FileName := ParamStr(2);
        if FileExists(FileName) or DirectoryExists(FileName) then
          AddFilesToDlg(FileName)
        else
          frmMain.Close;
        Application.Run;
      end;
    rmNormal:
      begin
        lMutex := CreateMutex(nil, True, PChar('AceBackup Tool'));
        if (lMutex <> 0) and (GetLastError = 0) then
        begin
          frmSplashMain := TfrmSplashMain.Create(Application);
          try
            frmSplashMain.Show;
            frmSplashMain.Update;
            Application.Initialize;
            Application.CreateForm(TfrmMain, frmMain);
            Application.CreateForm(TfrmProcess, frmProcess);
          finally
            frmSplashMain.Free;
          end;
          Application.Run;
          if (lMutex <> 0) then CloseHandle(lMutex);
        end
        else
        begin
          GetModuleFileName(HInstance, ModuleName, 255);
          EnumWindows(@EnumWndProc, 0);
          if Wnd <> 0 then
          begin
            PostMessage(Wnd, WM_ACTIVATEINSTANCE, 0, 0);
          end;
        end;
      end;
  end;
end;


begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  ExecuteApplication;
end.

