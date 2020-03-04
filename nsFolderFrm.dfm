object frmFolderProperties: TfrmFolderProperties
  Left = 405
  Top = 144
  HelpContext = 200
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'frmFolderProperties'
  ClientHeight = 418
  ClientWidth = 348
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
    348
    418)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel4: TBevel
    Left = 0
    Top = 384
    Width = 348
    Height = 34
    Align = alBottom
    Shape = bsSpacer
  end
  object btnOK: TButton
    Left = 100
    Top = 392
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 184
    Top = 392
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 268
    Top = 392
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 348
    Height = 384
    ActivePage = TS1
    Align = alClient
    TabOrder = 0
    object TS1: TTabSheet
      Caption = 'General'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        340
        356)
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 173
        Width = 316
        Height = 84
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Shape = bsBottomLine
      end
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 69
        Width = 316
        Height = 96
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Shape = bsBottomLine
      end
      object Image1: TImage
        Left = 12
        Top = 12
        Width = 32
        Height = 32
        AutoSize = True
      end
      object Label3: TLabel
        Left = 12
        Top = 176
        Width = 44
        Height = 13
        Caption = 'Location:'
        Transparent = True
      end
      object Label5: TLabel
        Left = 12
        Top = 200
        Width = 23
        Height = 13
        Caption = 'Size:'
        Transparent = True
      end
      object lblSizeOnMedia: TLabel
        Left = 92
        Top = 200
        Width = 54
        Height = 13
        Caption = 'Evaluate...'
        Transparent = True
      end
      object Label8: TLabel
        Left = 12
        Top = 224
        Width = 43
        Height = 13
        Caption = 'Content:'
        Transparent = True
      end
      object lblContains: TLabel
        Left = 92
        Top = 224
        Width = 54
        Height = 13
        Caption = 'Evaluate...'
        Transparent = True
      end
      object Label6: TLabel
        Left = 12
        Top = 76
        Width = 28
        Height = 13
        Caption = 'Type:'
        Transparent = True
      end
      object lblType: TLabel
        Left = 92
        Top = 76
        Width = 34
        Height = 13
        Caption = 'lblType'
        Transparent = True
      end
      object Label2: TLabel
        Left = 12
        Top = 100
        Width = 35
        Height = 13
        Caption = 'Added:'
        Transparent = True
      end
      object lblCreated: TLabel
        Left = 92
        Top = 100
        Width = 49
        Height = 13
        Caption = 'lblCreated'
        Transparent = True
      end
      object Label1: TLabel
        Left = 12
        Top = 128
        Width = 42
        Height = 13
        Caption = '&Collision:'
        FocusControl = cbDefAction
        Transparent = True
      end
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 4
        Width = 316
        Height = 57
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Shape = bsBottomLine
      end
      object lblLocation: TLabel
        Left = 92
        Top = 176
        Width = 238
        Height = 20
        AutoSize = False
        EllipsisPosition = epPathEllipsis
      end
      object edtName: TEdit
        Left = 92
        Top = 20
        Width = 236
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
      object cbDefAction: TComboBox
        Left = 92
        Top = 124
        Width = 236
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        OnChange = cbDefActionChange
      end
      object chkBackupItem: TCheckBox
        Left = 12
        Top = 276
        Width = 177
        Height = 17
        Caption = '&Backup Item'
        TabOrder = 1
      end
    end
  end
end
