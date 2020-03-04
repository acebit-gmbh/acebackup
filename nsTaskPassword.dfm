object frmTaskPassword: TfrmTaskPassword
  Left = 386
  Top = 178
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Run task as'
  ClientHeight = 168
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 43
    Height = 13
    Caption = '&Account:'
    FocusControl = edtAccount
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 50
    Height = 13
    Caption = '&Password:'
    FocusControl = edtPass1
  end
  object Label3: TLabel
    Left = 16
    Top = 92
    Width = 90
    Height = 13
    Caption = '&Confirm password:'
    FocusControl = edtPass2
  end
  object edtAccount: TEdit
    Left = 132
    Top = 16
    Width = 164
    Height = 21
    TabOrder = 0
  end
  object edtPass1: TEdit
    Left = 132
    Top = 52
    Width = 164
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnChange = PassChange
  end
  object edtPass2: TEdit
    Left = 132
    Top = 88
    Width = 164
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    OnChange = PassChange
  end
  object btnOK: TButton
    Left = 132
    Top = 132
    Width = 80
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 216
    Top = 132
    Width = 80
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
