object frmConfirmUpdateDlg: TfrmConfirmUpdateDlg
  Left = 329
  Top = 184
  BorderStyle = bsDialog
  Caption = 'frmConfirmUpdateDlg'
  ClientHeight = 263
  ClientWidth = 456
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
    456
    263)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 219
    Width = 456
    Height = 44
    Align = alBottom
    Shape = bsTopLine
  end
  object Image1: TImage
    Left = 12
    Top = 12
    Width = 32
    Height = 32
  end
  object lblCaption: TLabel
    Left = 60
    Top = 12
    Width = 381
    Height = 29
    AutoSize = False
  end
  object Label2: TLabel
    Left = 60
    Top = 48
    Width = 55
    Height = 13
    Caption = 'Project file:'
  end
  object Image2: TImage
    Left = 80
    Top = 76
    Width = 32
    Height = 32
  end
  object Label3: TLabel
    Left = 60
    Top = 124
    Width = 45
    Height = 13
    Caption = 'Local file:'
  end
  object Image3: TImage
    Left = 80
    Top = 148
    Width = 32
    Height = 32
  end
  object Label1: TLabel
    Left = 60
    Top = 196
    Width = 249
    Height = 13
    Caption = 'Do you wish to select this file for immediate backup?'
  end
  object Label4: TLabel
    Left = 124
    Top = 76
    Width = 67
    Height = 13
    Caption = 'Last modified:'
  end
  object Label5: TLabel
    Left = 124
    Top = 148
    Width = 67
    Height = 13
    Caption = 'Last modified:'
  end
  object Label6: TLabel
    Left = 124
    Top = 96
    Width = 23
    Height = 13
    Caption = 'Size:'
  end
  object Label7: TLabel
    Left = 124
    Top = 168
    Width = 23
    Height = 13
    Caption = 'Size:'
  end
  object Modified1: TLabel
    Left = 228
    Top = 76
    Width = 46
    Height = 13
    Caption = 'Modified1'
  end
  object Modified2: TLabel
    Left = 228
    Top = 148
    Width = 46
    Height = 13
    Caption = 'Modified2'
  end
  object Size1: TLabel
    Left = 228
    Top = 96
    Width = 25
    Height = 13
    Caption = 'Size1'
  end
  object Size2: TLabel
    Left = 228
    Top = 168
    Width = 25
    Height = 13
    Caption = 'Size2'
  end
  object btnYes: TButton
    Left = 116
    Top = 232
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Yes'
    Default = True
    ModalResult = 6
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 368
    Top = 232
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnNo: TButton
    Left = 284
    Top = 232
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'No'
    ModalResult = 7
    TabOrder = 2
  end
  object btnYesToAll: TButton
    Left = 200
    Top = 232
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Yes to all'
    ModalResult = 10
    TabOrder = 3
  end
end
