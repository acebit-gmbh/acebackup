object frmMasks: TfrmMasks
  Left = 312
  Top = 186
  ActiveControl = chklMasks
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'frmMasks'
  ClientHeight = 274
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    390
    274)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 225
    Top = 248
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 309
    Top = 248
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 390
    Height = 239
    Align = alTop
    TabOrder = 0
    DesignSize = (
      390
      239)
    object chklMasks: TCheckListBox
      Left = 12
      Top = 16
      Width = 367
      Height = 184
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = 4
      ItemHeight = 13
      Items.Strings = (
        '*.*'
        '*.htm*')
      PopupMenu = pmContext
      Sorted = True
      TabOrder = 0
      OnClick = chklMasksClick
    end
    object edtNew: TEdit
      Left = 12
      Top = 209
      Width = 99
      Height = 21
      TabOrder = 1
    end
    object btnAdd: TButton
      Left = 120
      Top = 208
      Width = 80
      Height = 24
      Caption = '&Add'
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnDelete: TButton
      Left = 288
      Top = 208
      Width = 80
      Height = 24
      Caption = '&Delete'
      TabOrder = 4
      OnClick = btnDeleteClick
    end
    object btnReplace: TButton
      Left = 204
      Top = 208
      Width = 80
      Height = 24
      Caption = '&Replace'
      TabOrder = 3
      OnClick = btnReplaceClick
    end
  end
  object pmContext: TPopupActionBar
    Left = 145
    Top = 141
    object CheckAll2: TMenuItem
      Action = acCheckAll
    end
    object UncheckAll2: TMenuItem
      Action = acUncheckAll
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Delete2: TMenuItem
      Action = acDelete
    end
  end
  object acContext: TActionList
    Left = 205
    Top = 139
    object acDelete: TAction
      Caption = '&Delete'
      OnExecute = tbxClearClick
    end
    object acCheckAll: TAction
      Caption = 'Check All'
      OnExecute = tbxCheckAllClick
    end
    object acUncheckAll: TAction
      Caption = 'Uncheck All'
      OnExecute = tbxUnCheckAllClick
    end
  end
end
