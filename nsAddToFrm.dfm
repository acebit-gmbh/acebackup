object frmAddToForm: TfrmAddToForm
  Left = 267
  Top = 162
  HelpContext = 2000
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'Add file/folder to AceBackup project'
  ClientHeight = 509
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    510
    509)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 476
    Width = 510
    Height = 33
    Align = alBottom
    Shape = bsSpacer
  end
  object btnOk: TButton
    Left = 260
    Top = 484
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 344
    Top = 484
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnHelp: TButton
    Left = 428
    Top = 484
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 2
    OnClick = btnHelpClick
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 510
    Height = 476
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Project'
      DesignSize = (
        502
        448)
      object lblError: TLabel
        Tag = 1
        AlignWithMargins = True
        Left = 12
        Top = 192
        Width = 478
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = 'lblProjectInfo'
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 68
        Width = 478
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = '&Project Name:'
        FocusControl = cbProject
        Transparent = True
      end
      object lblVolume: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 146
        Width = 478
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = '&Volume:'
        FocusControl = cbVolumes
        Transparent = True
      end
      object lblEncryption: TLabel
        Tag = 2
        AlignWithMargins = True
        Left = 12
        Top = 234
        Width = 478
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = 'lblEncryption'
        Transparent = True
        WordWrap = True
      end
      object lblSchedule: TLabel
        Tag = 2
        AlignWithMargins = True
        Left = 12
        Top = 255
        Width = 478
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = 'lblSchedule'
        Transparent = True
        WordWrap = True
      end
      object lblCompression: TLabel
        Tag = 2
        AlignWithMargins = True
        Left = 12
        Top = 213
        Width = 478
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = 'lblCompression'
        Transparent = True
        WordWrap = True
      end
      object btnOpen: TButton
        Left = 204
        Top = 120
        Width = 92
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&Open...'
        TabOrder = 1
        OnClick = btnOpenClick
      end
      object btnNew: TButton
        Left = 300
        Top = 120
        Width = 92
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&New...'
        TabOrder = 2
        OnClick = btnNewClick
      end
      object btnSettings: TButton
        Left = 396
        Top = 120
        Width = 92
        Height = 24
        Anchors = [akTop, akRight]
        Caption = '&Settings...'
        TabOrder = 3
        OnClick = btnSettingsClick
      end
      object cbProject: TComboBox
        AlignWithMargins = True
        Left = 12
        Top = 85
        Width = 478
        Height = 21
        Margins.Left = 12
        Margins.Top = 0
        Margins.Right = 12
        Margins.Bottom = 36
        Align = alTop
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbProjectChange
      end
      object chkProcessNow: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 423
        Width = 478
        Height = 17
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 8
        Align = alBottom
        Caption = 'Process project immediately'
        TabOrder = 5
      end
      object cbVolumes: TComboBox
        AlignWithMargins = True
        Left = 12
        Top = 163
        Width = 478
        Height = 21
        Margins.Left = 12
        Margins.Top = 0
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Style = csDropDownList
        TabOrder = 4
        OnChange = cbVolumesChange
      end
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 478
        Height = 48
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 6
        object Image1: TImage
          Left = 0
          Top = 0
          Width = 32
          Height = 48
          Align = alLeft
          AutoSize = True
          Center = True
        end
        object lblFileName: TLabel
          AlignWithMargins = True
          Left = 52
          Top = 4
          Width = 422
          Height = 40
          Margins.Left = 20
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          AutoSize = False
          Caption = '........'
          EllipsisPosition = epPathEllipsis
          Layout = tlCenter
        end
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'AceBackup projects (*.nsb)|*.nsb|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 140
    Top = 304
  end
end
