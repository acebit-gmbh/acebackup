object frmReplaceDlg: TfrmReplaceDlg
  Left = 340
  Top = 264
  HelpContext = 800
  BorderStyle = bsDialog
  Caption = 'Confirm local file replacement'
  ClientHeight = 249
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    447
    249)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 12
    Top = 12
    Width = 32
    Height = 32
  end
  object lblCaption: TLabel
    Left = 56
    Top = 12
    Width = 355
    Height = 32
    AutoSize = False
  end
  object Label2: TLabel
    Left = 60
    Top = 52
    Width = 192
    Height = 13
    Caption = 'Do you want to replace the existing file:'
  end
  object Image2: TImage
    Left = 80
    Top = 76
    Width = 32
    Height = 32
  end
  object lblSize1: TLabel
    Left = 128
    Top = 76
    Width = 35
    Height = 13
    Caption = 'lblSize1'
  end
  object Label3: TLabel
    Left = 60
    Top = 120
    Width = 66
    Height = 13
    Caption = 'with this one?'
  end
  object Image3: TImage
    Left = 80
    Top = 148
    Width = 32
    Height = 32
  end
  object lblSize2: TLabel
    Left = 128
    Top = 148
    Width = 35
    Height = 13
    Caption = 'lblSize2'
  end
  object lblMod1: TLabel
    Left = 128
    Top = 92
    Width = 36
    Height = 13
    Caption = 'lblMod1'
  end
  object lblMod2: TLabel
    Left = 128
    Top = 168
    Width = 36
    Height = 13
    Caption = 'lblMod2'
  end
  object Button1: TButton
    Left = 92
    Top = 212
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Yes'
    ModalResult = 6
    TabOrder = 0
  end
  object Button2: TButton
    Left = 180
    Top = 212
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Yes to &all'
    ModalResult = 10
    TabOrder = 1
  end
  object Button3: TButton
    Left = 268
    Top = 212
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&No'
    ModalResult = 7
    TabOrder = 2
  end
  object Button4: TButton
    Left = 356
    Top = 212
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
