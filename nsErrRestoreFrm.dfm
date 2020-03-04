object frmErrorRestore: TfrmErrorRestore
  Left = 325
  Top = 273
  HelpContext = 150
  ActiveControl = cbEncryption
  BorderStyle = bsDialog
  Caption = 'Restore file'
  ClientHeight = 236
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    424
    236)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 12
    Top = 12
    Width = 32
    Height = 32
  end
  object Label1: TLabel
    Left = 56
    Top = 8
    Width = 357
    Height = 13
    AutoSize = False
    Caption = 'An error occurred while restoring the file'
  end
  object Label6: TLabel
    Left = 56
    Top = 52
    Width = 357
    Height = 44
    AutoSize = False
    Caption = 
      'The file is either corrupted or packed with a different encrypti' +
      'on method or password. Do you wish to use another algorithm and ' +
      'password?'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 56
    Top = 120
    Width = 55
    Height = 13
    Caption = '&Encryption:'
    FocusControl = cbEncryption
  end
  object lblPassword: TLabel
    Left = 56
    Top = 156
    Width = 50
    Height = 13
    Caption = '&Password:'
  end
  object pbFile: TLabel
    Left = 59
    Top = 28
    Width = 354
    Height = 17
    AutoSize = False
    EllipsisPosition = epPathEllipsis
  end
  object btnYes: TButton
    Left = 80
    Top = 200
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Yes'
    ModalResult = 6
    TabOrder = 3
  end
  object cbEncryption: TComboBox
    Left = 142
    Top = 116
    Width = 223
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 142
    Top = 151
    Width = 127
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object chkMask1: TCheckBox
    Left = 285
    Top = 154
    Width = 78
    Height = 17
    Caption = '&Hide'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = chkMask1Click
  end
  object btnYesToAll: TButton
    Left = 164
    Top = 200
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Yes to &all'
    ModalResult = 10
    TabOrder = 4
  end
  object btnIgnore: TButton
    Left = 248
    Top = 200
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Ignore'
    ModalResult = 5
    TabOrder = 5
  end
  object btnAbort: TButton
    Left = 332
    Top = 200
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'A&bort'
    ModalResult = 3
    TabOrder = 6
  end
end
