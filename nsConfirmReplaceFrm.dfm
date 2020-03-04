object frmConfirmReplaceDlg: TfrmConfirmReplaceDlg
  Left = 333
  Top = 170
  BorderStyle = bsDialog
  Caption = 'Confirm file replacement'
  ClientHeight = 315
  ClientWidth = 476
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
    476
    315)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 12
    Top = 12
    Width = 32
    Height = 32
  end
  object lblCaption: TLabel
    Left = 52
    Top = 12
    Width = 413
    Height = 29
    AutoSize = False
    Caption = 'The project folder already contains a file named "%s".'
  end
  object Label2: TLabel
    Left = 52
    Top = 48
    Width = 58
    Height = 13
    Caption = 'Existing file:'
  end
  object Image2: TImage
    Left = 68
    Top = 72
    Width = 32
    Height = 32
  end
  object Label4: TLabel
    Left = 116
    Top = 72
    Width = 26
    Height = 13
    Caption = 'Path:'
  end
  object lblSM1: TLabel
    Left = 116
    Top = 92
    Width = 30
    Height = 13
    Caption = 'lblSM1'
  end
  object Label3: TLabel
    Left = 52
    Top = 116
    Width = 42
    Height = 13
    Caption = 'New file:'
  end
  object Image3: TImage
    Left = 68
    Top = 136
    Width = 32
    Height = 32
  end
  object lblSM2: TLabel
    Left = 116
    Top = 156
    Width = 30
    Height = 13
    Caption = 'lblSM2'
  end
  object Label6: TLabel
    Left = 116
    Top = 136
    Width = 26
    Height = 13
    Caption = 'Path:'
  end
  object Label1: TLabel
    Left = 52
    Top = 184
    Width = 168
    Height = 13
    Caption = 'Which action should be performed?'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 272
    Width = 476
    Height = 43
    Align = alBottom
    Shape = bsTopLine
  end
  object rbOverwrite: TRadioButton
    Left = 68
    Top = 208
    Width = 154
    Height = 17
    Caption = 'Overwrite existing'
    TabOrder = 0
  end
  object rbNewFolder: TRadioButton
    Left = 68
    Top = 228
    Width = 203
    Height = 17
    Caption = 'Move to new folder'
    TabOrder = 1
  end
  object rbPreserve: TRadioButton
    Left = 68
    Top = 248
    Width = 125
    Height = 17
    Caption = 'Preserve existing'
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 156
    Top = 284
    Width = 100
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnApply: TButton
    Left = 260
    Top = 284
    Width = 100
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Apply to all'
    ModalResult = 10
    TabOrder = 5
  end
  object btnCancel: TButton
    Left = 364
    Top = 284
    Width = 100
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object chkDontAsk: TCheckBox
    Left = 16
    Top = 288
    Width = 116
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Don'#39't ask me again'
    TabOrder = 3
  end
  object lblOrigin1: TEdit
    Left = 160
    Top = 72
    Width = 307
    Height = 19
    TabStop = False
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvSpace
    BorderStyle = bsNone
    ParentColor = True
    TabOrder = 7
  end
  object lblOrigin2: TEdit
    Left = 160
    Top = 136
    Width = 307
    Height = 19
    TabStop = False
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvSpace
    BorderStyle = bsNone
    ParentColor = True
    TabOrder = 8
  end
end
