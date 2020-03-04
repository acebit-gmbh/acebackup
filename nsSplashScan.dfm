object frmScanner: TfrmScanner
  Left = 465
  Top = 312
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'Scanning local system'
  ClientHeight = 143
  ClientWidth = 641
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    641
    143)
  PixelsPerInch = 96
  TextHeight = 13
  object pbxFileName: TLabel
    AlignWithMargins = True
    Left = 4
    Top = 78
    Width = 633
    Height = 23
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    AutoSize = False
    Caption = 'AAAAAAAAAAAAA'
    EllipsisPosition = epPathEllipsis
  end
  object Label1: TLabel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 633
    Height = 66
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    AutoSize = False
    Caption = 
      'AceBackup scans the local system and adds matching files and fol' +
      'ders to the project. '#13#10'This process can take a few minutes. '#13#10#13#10 +
      'Please wait...'
    WordWrap = True
  end
  object btnCancel: TButton
    Left = 552
    Top = 112
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    Default = True
    ModalResult = 2
    TabOrder = 0
    OnClick = btnCancelClick
  end
end
