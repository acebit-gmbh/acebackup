object frmWizardTemplate: TfrmWizardTemplate
  Left = 375
  Top = 227
  ActiveControl = btnNext
  BorderStyle = bsDialog
  Caption = 'frmWizardTemplate'
  ClientHeight = 440
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    640
    440)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel5: TBevel
    Left = 0
    Top = 396
    Width = 640
    Height = 44
    Align = alBottom
    Shape = bsTopLine
  end
  object btnBack: TButton
    Left = 376
    Top = 408
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '< &Back'
    Enabled = False
    TabOrder = 1
    OnClick = btnBackClick
  end
  object btnNext: TButton
    Left = 460
    Top = 408
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Next >'
    Default = True
    TabOrder = 2
    OnClick = btnNextClick
  end
  object btnCancel: TButton
    Left = 552
    Top = 408
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 640
    Height = 396
    Align = alClient
    TabOrder = 0
  end
end
