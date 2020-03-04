object frmWaitDlg: TfrmWaitDlg
  Left = 556
  Top = 308
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'frmWaitDlg'
  ClientHeight = 74
  ClientWidth = 435
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 12
    Top = 12
    Width = 411
    Height = 13
    Margins.Left = 12
    Margins.Top = 12
    Margins.Right = 12
    Align = alTop
    Caption = 'Please wait...'
  end
  object ProgressBar1: TProgressBar
    AlignWithMargins = True
    Left = 12
    Top = 29
    Width = 411
    Height = 17
    Margins.Left = 12
    Margins.Top = 4
    Margins.Right = 12
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 0
  end
end
