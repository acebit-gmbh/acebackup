object frmItemProperties: TfrmItemProperties
  Left = 621
  Top = 255
  HelpContext = 200
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'frmItemProperties'
  ClientHeight = 477
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    385
    477)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel4: TBevel
    Left = 0
    Top = 444
    Width = 385
    Height = 33
    Align = alBottom
    Shape = bsSpacer
  end
  object btnOK: TButton
    Left = 136
    Top = 452
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 220
    Top = 452
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 304
    Top = 452
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
    Width = 385
    Height = 444
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
        377
        416)
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 69
        Width = 353
        Height = 76
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Shape = bsBottomLine
      end
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 153
        Width = 353
        Height = 76
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
        Top = 180
        Width = 44
        Height = 13
        Caption = 'Location:'
        Transparent = True
      end
      object Label4: TLabel
        Left = 12
        Top = 204
        Width = 61
        Height = 13
        Caption = 'Original size:'
        Transparent = True
      end
      object Label5: TLabel
        Left = 12
        Top = 156
        Width = 23
        Height = 13
        Caption = 'Size:'
        Transparent = True
      end
      object lblSize: TLabel
        Left = 96
        Top = 204
        Width = 29
        Height = 13
        Caption = 'lblSize'
        Transparent = True
      end
      object lblSizeOnMedia: TLabel
        Left = 96
        Top = 156
        Width = 71
        Height = 13
        Caption = 'lblSizeOnMedia'
        Transparent = True
      end
      object Label6: TLabel
        Left = 12
        Top = 68
        Width = 28
        Height = 13
        Caption = 'Type:'
        Transparent = True
      end
      object lblType: TLabel
        Left = 96
        Top = 68
        Width = 34
        Height = 13
        Caption = 'lblType'
        Transparent = True
      end
      object Label8: TLabel
        Left = 12
        Top = 92
        Width = 35
        Height = 13
        Caption = 'Added:'
        Transparent = True
      end
      object Label9: TLabel
        Left = 12
        Top = 116
        Width = 44
        Height = 13
        Caption = 'Modified:'
        Transparent = True
      end
      object lblCreated: TLabel
        Left = 96
        Top = 92
        Width = 49
        Height = 13
        Caption = 'lblCreated'
        Transparent = True
      end
      object lblModified: TLabel
        Left = 96
        Top = 116
        Width = 50
        Height = 13
        Caption = 'lblModified'
        Transparent = True
      end
      object lblOriginal: TLabel
        Left = 12
        Top = 328
        Width = 80
        Height = 13
        Caption = '&Original location:'
        FocusControl = edtOriginalLocation
        Transparent = True
      end
      object Label1: TLabel
        Left = 12
        Top = 248
        Width = 42
        Height = 13
        Caption = '&Collision:'
        FocusControl = cbDefAction
        Transparent = True
      end
      object lblRemoteName: TLabel
        Left = 12
        Top = 280
        Width = 70
        Height = 13
        Caption = '&Remote name:'
        FocusControl = edtRemoteName
        Transparent = True
      end
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 4
        Width = 353
        Height = 57
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Shape = bsBottomLine
      end
      object lblLocation: TLabel
        Left = 96
        Top = 180
        Width = 269
        Height = 18
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        EllipsisPosition = epPathEllipsis
      end
      object edtName: TEdit
        Left = 96
        Top = 24
        Width = 269
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
      object edtOriginalLocation: TEdit
        Left = 12
        Top = 344
        Width = 245
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
      end
      object btnChange: TButton
        Left = 260
        Top = 344
        Width = 105
        Height = 24
        Anchors = [akTop, akRight]
        Caption = 'C&hange'
        TabOrder = 6
        OnClick = btnChangeClick
      end
      object cbDefAction: TComboBox
        Left = 96
        Top = 244
        Width = 269
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        OnChange = cbDefActionChange
      end
      object edtRemoteName: TEdit
        Left = 12
        Top = 296
        Width = 245
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 2
      end
      object btnMangle: TButton
        Left = 260
        Top = 296
        Width = 105
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&Make anonymous'
        TabOrder = 3
        OnClick = btnMangleClick
      end
      object chkBackupItem: TCheckBox
        Left = 12
        Top = 384
        Width = 189
        Height = 17
        Caption = '&Backup Item'
        TabOrder = 5
      end
    end
    object TS2: TTabSheet
      Caption = 'Versions'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        377
        416)
      object Label2: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 353
        Height = 13
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = '&Available versions:'
        Transparent = True
        ExplicitWidth = 90
      end
      object lvVersions: TListView
        AlignWithMargins = True
        Left = 12
        Top = 29
        Width = 353
        Height = 344
        Margins.Left = 12
        Margins.Top = 0
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Columns = <
          item
            Caption = 'No'
            Width = 40
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            Caption = 'Size'
          end
          item
            Caption = 'Modified'
            Width = 185
          end>
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = lvVersionsColumnClick
      end
      object btnDelete: TButton
        Left = 272
        Top = 384
        Width = 93
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&Delete'
        TabOrder = 2
        OnClick = btnDeleteClick
      end
      object btnRestore: TButton
        Left = 80
        Top = 384
        Width = 92
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&Restore'
        TabOrder = 1
        OnClick = btnRestoreClick
      end
      object btnOpen: TButton
        Left = 176
        Top = 384
        Width = 92
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&Open'
        TabOrder = 3
        OnClick = btnOpenClick
      end
    end
  end
end
