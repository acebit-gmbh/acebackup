object frmOptions: TfrmOptions
  Left = 288
  Top = 157
  HelpContext = 510
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'AceBackup Options'
  ClientHeight = 521
  ClientWidth = 480
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
    480
    521)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel5: TBevel
    Left = 0
    Top = 485
    Width = 480
    Height = 36
    Align = alBottom
    Shape = bsSpacer
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 480
    Height = 485
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      HelpContext = 510
      Caption = 'Appearance'
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 75
        Width = 448
        Height = 174
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' Highlighting project items: '
        TabOrder = 0
        object Label1: TLabel
          Left = 20
          Top = 20
          Width = 54
          Height = 13
          Caption = '&Item state:'
          FocusControl = lbElements
        end
        object Label2: TLabel
          Left = 204
          Top = 20
          Width = 29
          Height = 13
          Caption = '&Color:'
          FocusControl = cbColors
        end
        object lbElements: TListBox
          Left = 20
          Top = 36
          Width = 157
          Height = 123
          ItemHeight = 13
          Items.Strings = (
            'Not marked'
            'Back up'
            'Restore')
          TabOrder = 0
          OnClick = lbElementsClick
        end
        object cbColors: TColorBox
          Left = 204
          Top = 36
          Width = 157
          Height = 22
          NoneColorColor = clWindow
          Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
          TabOrder = 1
          OnSelect = cbColorsSelect
        end
        object chkBold: TCheckBox
          Left = 204
          Top = 72
          Width = 104
          Height = 17
          Caption = '&Bold'
          TabOrder = 2
          OnClick = chkBoldClick
        end
        object chkItalic: TCheckBox
          Left = 204
          Top = 96
          Width = 104
          Height = 17
          Caption = '&Italic'
          TabOrder = 3
          OnClick = chkItalicClick
        end
        object chkUnderline: TCheckBox
          Left = 204
          Top = 120
          Width = 104
          Height = 17
          Caption = '&Underline'
          TabOrder = 4
          OnClick = chkUnderlineClick
        end
        object chkStrikeOut: TCheckBox
          Left = 204
          Top = 144
          Width = 104
          Height = 17
          Caption = '&Strikethrough'
          TabOrder = 5
          OnClick = chkStrikeOutClick
        end
      end
      object chkShowHidden: TCheckBox
        Left = 32
        Top = 333
        Width = 249
        Height = 17
        Caption = 'Show hidden files and folders'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object GroupBox8: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 448
        Height = 55
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' User Interface: '
        TabOrder = 2
        object Label5: TLabel
          Left = 24
          Top = 26
          Width = 119
          Height = 13
          Caption = 'User interface &language:'
          FocusControl = cbLanguages
        end
        object cbLanguages: TComboBox
          Left = 204
          Top = 22
          Width = 157
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'English'
          Items.Strings = (
            'English'
            'German')
        end
      end
      object GroupBox9: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 257
        Width = 448
        Height = 62
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' Sounds: '
        TabOrder = 3
        object ckbPlaySounds: TCheckBox
          Left = 20
          Top = 25
          Width = 109
          Height = 17
          Caption = '&Play Sounds'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = ckbPlaySoundsClick
        end
        object btSounds: TButton
          Left = 204
          Top = 24
          Width = 121
          Height = 24
          Caption = 'Configure Sounds'
          TabOrder = 1
          OnClick = btSoundsClick
        end
      end
    end
    object TabSheet2: TTabSheet
      HelpContext = 8
      Caption = 'Internet Settings'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 448
        Height = 149
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' &Proxy/Firewall: '
        TabOrder = 0
        object lblProxyName: TLabel
          Left = 31
          Top = 96
          Width = 104
          Height = 13
          Caption = '&Address / Host name:'
          FocusControl = edtProxyName
        end
        object lblProxyPort: TLabel
          Left = 240
          Top = 96
          Width = 24
          Height = 13
          Caption = '&Port:'
          FocusControl = edtProxyPort
        end
        object rbDefaultProxy: TRadioButton
          Left = 12
          Top = 22
          Width = 217
          Height = 17
          Caption = 'Use default proxy settings'
          TabOrder = 0
          OnClick = ConnectTypeClick
        end
        object rbManualProxy: TRadioButton
          Left = 12
          Top = 76
          Width = 145
          Height = 17
          Caption = 'Manual configuration'
          TabOrder = 2
          OnClick = ConnectTypeClick
        end
        object rbNoProxy: TRadioButton
          Left = 12
          Top = 49
          Width = 268
          Height = 17
          Caption = 'Direct connection (no proxy)'
          TabOrder = 1
          OnClick = ConnectTypeClick
        end
        object edtProxyName: TEdit
          Left = 31
          Top = 112
          Width = 201
          Height = 21
          TabOrder = 3
        end
        object edtProxyPort: TEdit
          Left = 240
          Top = 112
          Width = 65
          Height = 21
          TabOrder = 4
        end
        object btnViewProxySettings: TButton
          Left = 240
          Top = 19
          Width = 92
          Height = 24
          Caption = '&Modify'
          TabOrder = 5
          OnClick = btnViewProxySettingsClick
        end
      end
    end
    object TabSheet4: TTabSheet
      HelpContext = 540
      Caption = 'E-Mail Settings'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox6: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 228
        Width = 448
        Height = 215
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' Outgoing Server: '
        TabOrder = 0
        DesignSize = (
          448
          215)
        object Label6: TLabel
          Left = 24
          Top = 32
          Width = 43
          Height = 13
          Caption = '&Address:'
          FocusControl = edtSMTPServer
        end
        object Label7: TLabel
          Left = 288
          Top = 32
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'P&ort:'
          FocusControl = edtSMTPPort
        end
        object lblSMTPAccount: TLabel
          Left = 68
          Top = 92
          Width = 43
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'A&ccount:'
          Enabled = False
        end
        object lblSMTPPassword: TLabel
          Left = 61
          Top = 120
          Width = 50
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Pass&word:'
          Enabled = False
        end
        object lblUseTLS: TLabel
          Left = 62
          Top = 184
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = '&TLS Level:'
          Enabled = False
        end
        object lblUseTLS2: TLabel
          Left = 288
          Top = 182
          Width = 43
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = '&Protocol:'
          Enabled = False
        end
        object edtSMTPServer: TEdit
          Left = 124
          Top = 28
          Width = 140
          Height = 21
          TabOrder = 0
        end
        object edtSMTPPort: TEdit
          Left = 316
          Top = 28
          Width = 64
          Height = 21
          TabOrder = 1
          Text = '25'
        end
        object chkSMTP: TCheckBox
          Left = 24
          Top = 60
          Width = 179
          Height = 17
          Caption = 'A&uthentication required:'
          TabOrder = 2
          OnClick = chkSMTPClick
        end
        object edtSMTPAccount: TEdit
          Left = 124
          Top = 84
          Width = 140
          Height = 21
          Enabled = False
          TabOrder = 3
        end
        object edtSMTPPassword: TEdit
          Left = 124
          Top = 120
          Width = 140
          Height = 21
          Enabled = False
          PasswordChar = '*'
          TabOrder = 4
        end
        object chkUseSSL: TCheckBox
          Left = 24
          Top = 152
          Width = 356
          Height = 17
          Caption = 'Server requires &encrypted connection (SSL)'
          TabOrder = 5
          OnClick = chkSMTPClick
        end
        object cbUseTLS: TComboBox
          Left = 124
          Top = 180
          Width = 140
          Height = 21
          Style = csDropDownList
          TabOrder = 6
          Items.Strings = (
            'No TLS Support'
            'Implicit TLS'
            'Require TLS '
            'Explicit TLS')
        end
        object btnTestSMTP: TButton
          Left = 316
          Top = 84
          Width = 116
          Height = 23
          Caption = 'Test Connection'
          TabOrder = 7
          OnClick = btnTestSMTPClick
        end
        object cbUseTLS2: TComboBox
          Left = 337
          Top = 180
          Width = 95
          Height = 21
          Style = csDropDownList
          ItemIndex = 3
          TabOrder = 8
          Text = 'TLS 1'
          Items.Strings = (
            'SSL 2'
            'SSL 2.3'
            'SSL 3'
            'TLS 1')
        end
      end
      object GroupBox7: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 120
        Width = 448
        Height = 92
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' Sender: '
        TabOrder = 1
        DesignSize = (
          448
          92)
        object Label10: TLabel
          Left = 24
          Top = 29
          Width = 74
          Height = 13
          Caption = 'E-Mail A&ddress:'
        end
        object Label8: TLabel
          Left = 24
          Top = 61
          Width = 68
          Height = 13
          Caption = '&Sender Name:'
          FocusControl = edtSenderEMail
        end
        object edtSenderEMail: TEdit
          Left = 122
          Top = 27
          Width = 258
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object edtSenderName: TEdit
          Left = 122
          Top = 58
          Width = 258
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
      object GroupBox11: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 448
        Height = 92
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' Recipient: '
        TabOrder = 2
        DesignSize = (
          448
          92)
        object Label25: TLabel
          Left = 24
          Top = 29
          Width = 74
          Height = 13
          Caption = 'E-Mail &Address:'
        end
        object Label27: TLabel
          Left = 24
          Top = 61
          Width = 78
          Height = 13
          Caption = '&Recipient Name:'
          FocusControl = edtSenderEMail
        end
        object edtRecipEMail: TEdit
          Left = 122
          Top = 25
          Width = 258
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object edtRecipName: TEdit
          Left = 122
          Top = 58
          Width = 258
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
    end
    object TabSheet3: TTabSheet
      HelpContext = 530
      Caption = 'Advanced'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 157
        Width = 448
        Height = 138
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' CD/DVD drive: '
        TabOrder = 0
        object Label18: TLabel
          Left = 20
          Top = 16
          Width = 62
          Height = 13
          Caption = '&Read Speed:'
          FocusControl = trReadSpeed
        end
        object Label19: TLabel
          Left = 20
          Top = 76
          Width = 63
          Height = 13
          Caption = '&Write Speed:'
        end
        object Label20: TLabel
          Left = 404
          Top = 60
          Width = 29
          Height = 13
          Caption = '100%'
        end
        object Label22: TLabel
          Left = 20
          Top = 56
          Width = 17
          Height = 13
          Caption = '0%'
        end
        object Label26: TLabel
          Left = 20
          Top = 116
          Width = 17
          Height = 13
          Caption = '0%'
        end
        object Label24: TLabel
          Left = 400
          Top = 116
          Width = 29
          Height = 13
          Caption = '100%'
        end
        object trReadSpeed: TTrackBar
          Left = 12
          Top = 28
          Width = 416
          Height = 30
          LineSize = 5
          Max = 100
          Min = 1
          PageSize = 25
          Frequency = 25
          Position = 100
          TabOrder = 0
          ThumbLength = 18
        end
        object trWriteSpeed: TTrackBar
          Left = 12
          Top = 88
          Width = 416
          Height = 30
          LineSize = 5
          Max = 100
          Min = 1
          PageSize = 25
          Frequency = 25
          Position = 100
          TabOrder = 1
          ThumbLength = 18
        end
      end
      object GroupBox10: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 448
        Height = 129
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' Folders: '
        TabOrder = 1
        DesignSize = (
          448
          129)
        object Label4: TLabel
          Left = 16
          Top = 72
          Width = 106
          Height = 13
          Caption = '&Project files directory:'
          FocusControl = edtProjectDir
        end
        object Label17: TLabel
          Left = 16
          Top = 20
          Width = 89
          Height = 13
          Caption = '&Log files directory:'
          FocusControl = edtLogDir
        end
        object edtProjectDir: TEdit
          Left = 16
          Top = 88
          Width = 384
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object edtLogDir: TEdit
          Left = 16
          Top = 36
          Width = 384
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object btnBrowseProjectDir: TButton
          Tag = 1
          Left = 404
          Top = 88
          Width = 24
          Height = 23
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 2
          OnClick = btnBrowseProjectDirClick
        end
        object btnBrowseLogDir: TButton
          Tag = 2
          Left = 404
          Top = 36
          Width = 24
          Height = 23
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 3
          OnClick = btnBrowseProjectDirClick
        end
      end
    end
    object TabSheet5: TTabSheet
      HelpContext = 550
      Caption = 'Volume'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label9: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 101
        Width = 132
        Height = 13
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = 'Default &backup destination:'
        FocusControl = cbMediaType
      end
      object pnlLocal: TPanel
        AlignWithMargins = True
        Left = 12
        Top = 147
        Width = 448
        Height = 68
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 2
        object Label16: TLabel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 26
          Height = 13
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 4
          Align = alTop
          Caption = '&Path:'
        end
        object edtLocalFolder: TEdit
          Left = 0
          Top = 17
          Width = 448
          Height = 21
          Align = alTop
          TabOrder = 0
        end
        object btnBrowseForLocalFolder: TButton
          Left = 368
          Top = 44
          Width = 80
          Height = 24
          Caption = 'Bro&wse'
          TabOrder = 1
          OnClick = btnBrowseForLocalFolderClick
        end
      end
      object pnlFTP: TPanel
        Tag = 1
        AlignWithMargins = True
        Left = 12
        Top = 223
        Width = 448
        Height = 181
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        DesignSize = (
          448
          181)
        object Label11: TLabel
          Left = 0
          Top = 0
          Width = 43
          Height = 13
          Caption = '&Address:'
          FocusControl = edtHost
        end
        object Label12: TLabel
          Left = 228
          Top = 0
          Width = 24
          Height = 13
          Caption = '&Port:'
          FocusControl = edtPort
        end
        object Label13: TLabel
          Left = 0
          Top = 88
          Width = 55
          Height = 13
          Caption = '&User name:'
          FocusControl = edtUser
        end
        object Label14: TLabel
          Left = 228
          Top = 88
          Width = 50
          Height = 13
          Caption = 'Pass&word:'
          FocusControl = edtHostPwd
        end
        object Label15: TLabel
          Left = 0
          Top = 44
          Width = 48
          Height = 13
          Caption = '&Directory:'
        end
        object ckbDialup: TCheckBox
          Left = 0
          Top = 141
          Width = 322
          Height = 17
          Caption = 'Dial-up &connection below before connecting to volume'
          TabOrder = 6
        end
        object edtHost: TEdit
          Left = 0
          Top = 16
          Width = 219
          Height = 21
          TabOrder = 0
        end
        object edtPort: TEdit
          Left = 228
          Top = 16
          Width = 61
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          Text = '21'
        end
        object edtUser: TEdit
          Left = 0
          Top = 104
          Width = 219
          Height = 21
          TabOrder = 4
        end
        object edtHostPwd: TEdit
          Left = 228
          Top = 104
          Width = 217
          Height = 21
          PasswordChar = '*'
          TabOrder = 5
        end
        object edtHostDir: TEdit
          Left = 0
          Top = 60
          Width = 445
          Height = 21
          TabOrder = 2
        end
        object chkPassive: TCheckBox
          Left = 312
          Top = 16
          Width = 97
          Height = 17
          Caption = 'PASV mode'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object ckbDialupHangup: TCheckBox
          Left = 0
          Top = 164
          Width = 306
          Height = 17
          Caption = '&Hang-up on disconnect'
          Enabled = False
          TabOrder = 7
        end
      end
      object GroupBox5: TGroupBox
        AlignWithMargins = True
        Left = 12
        Top = 12
        Width = 448
        Height = 81
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Caption = ' For new project use as default: '
        TabOrder = 0
        object rbDefaultUseLast: TRadioButton
          Left = 16
          Top = 24
          Width = 245
          Height = 17
          Caption = '&Last project backup settings'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbDefaultUseDefault: TRadioButton
          Left = 16
          Top = 48
          Width = 245
          Height = 17
          Caption = '&Default backup settings'
          TabOrder = 1
        end
      end
      object cbMediaType: TComboBox
        AlignWithMargins = True
        Left = 12
        Top = 118
        Width = 448
        Height = 21
        Margins.Left = 12
        Margins.Top = 0
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Style = csDropDownList
        TabOrder = 3
        OnChange = cbMediaTypeChange
      end
    end
  end
  object btnOK: TButton
    Left = 232
    Top = 496
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 316
    Top = 496
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 400
    Top = 496
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 3
    OnClick = btnHelpClick
  end
  object ilOptions1: TImageList
    BkColor = clFuchsia
    Height = 42
    Width = 42
    Left = 124
    Top = 486
    Bitmap = {
      494C01010500090004002A002A00FF00FF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000A800000054000000010020000000000080DC
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007D878900788184007A8385007C8588007E888A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF006D7577004E54560044494A00474C4E004C51530051575900565C5E005A61
      63005E66680062696B00656D6F00697173006D75770071797B00747D7F007780
      8200798284007A8486007B8587007E878A00808A8C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF007D86
      8900484C4E003F3C37007D7360006C645400655D4F005D584A0057524700524E
      45004F4C45004B4A440049484400474844004547440042454500404546004247
      4800454B4C00484D4F004A5052004E54560053595B00585F61005D6466006168
      6A00646C6E00676F71006B7375006F777A00737C7E00767F81007C858800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF007780
      8200333334007E7D79008D857300C4C2BE00B5B5AF00B4B3AC00B1AEA600ADA8
      9F00A6A19700A29C91009F968A0099928500958D7D008E867700877F6D007B72
      6300726959006C645400676050005F584B0058514600524E43004E4B43004C4A
      430049484300474844004547430043464400414546004146470051575900757D
      8000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00747D
      7F003E3E3F009E9D9D00796F5F00CDCCC800C5C4C200C6C5C300CBCAC900D1D0
      CD00D5D4D100D8D7D600DBDCD900E0DFDC00E3E1DE00E4E3E100E4E2E000E3E1
      DE00E2DFDC00E0DDD700DEDBD400DAD8D100D7D3CA00CCC7BF00C1BCB100B6B0
      A400ADA69A00A69F92009D968800968F80008F847500827A6A00776E5E00656B
      6A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF007078
      7A00414141009A9B9E0068615200B7B3AB00C2C2C000BBBAB600BFBDBA00C2C1
      BE00C6C4C100C9C8C400CCCBC800D0CFCB00D3D2CE00D7D5D100DBD9D500DEDE
      DA00E5E4E000E9E8E400EDECE800F2F0EC00F8F6F200FCFBF600FFFFFB00FFFF
      FC00FFFFFB00FFFFFC00FFFFFB00FEFFFA00FBFBF600FFFFFE00B2AB9F005E5F
      5900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF006970
      7200464646009B9B9E00625B5300A1998E00C6C6C400B3B2AF00B9B8B500BDBC
      B800C0BFBC00C3C2BF00C7C6C200CAC9C600CDCDC900D0D0CC00D2D2CE00D8D5
      D000D9D8D400DEDCD700E1E0DB00E5E4DF00E8E7E200ECEAE500F0EEE900F3F1
      EC00F4F2ED00F4F2ED00F4F2ED00F4F2ED00F5F3EE00FFFEFA00D6D1CB00605C
      4F007A838500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00646B
      6D004D4D4D009B9B9C005E5B57008F857500C6C7C600AEADAB00B4B3B000B7B6
      B300BBBAB700BDBDBA00BEC1C000C4C0BC00CBBDB600D3BEB600DCC4BB00DFCB
      C100E2D0C600E3D2CB00E4D4CE00E4D8D100E5DED900E6E4DF00EAE8E400EDEB
      E700F1EFEA00F3F1EC00F4F2ED00F4F2ED00F4F2ED00F9F7F300EBE8E4006E65
      5600727A7D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF005E65
      6600545454009A9A9A005C5D5C007B716000C3C2BF00ACABAB00AEADAA00B1B1
      AE00B4B5B500B9B3AE00C6A9A000D7B7AC00E6D0C900F1E5E200F2EEEC00F0F0
      F000ECF0F100ECEEEE00ECECEA00ECE6E300EAE0D800E8DAD300E7DFD900E7E6
      E100EBE9E400EEECE700F2F0EB00F4F2ED00F4F2ED00F5F3EE00FDFBF7008B83
      7300686E6F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00575D
      5F0060606000979797005C5D5E006E675800BBB8B200B0B0AE00A4A7A500AAAB
      AC00B99E9300CFA69B00E3D3D100F1F6F700FAFEFD00FAFCF900F4F6F500EEF3
      F400EBF0F300EBEFF100EDEEEF00EDEEEE00EEF0EF00EEEAE900EBE1DB00E8DA
      D100E6E2DE00E8E7E300ECEAE500EFEDE900F3F1EC00F4F2ED00FFFFFD00A69F
      92005E615D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF005258
      59006B6B6B00969696005C5D600066615800A6A19700B9BDBD009D9B9A00BD8D
      7F00D5B6AE00E5EEF700E7F6FF00EDF3F700F4F6F500F8F8F500F3F5F400EDF2
      F400E9EFF200EAEDF000EBECED00ECECEC00EDEBEA00EEEBEA00EEECEC00EDE6
      E100E8D7D000E5E0DA00E6E5E000EAE8E300EEEBE700F1EFEA00FEFCF800C8C3
      B9005D5A51007B848700FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF004D51
      530077777700959595005D5D600065625D00938D7F00C5C2C100B77E7000DCC2
      C000E6F2FC00E3ECF400E3EDF500E9F1F600F2F5F600F8F8F500F3F5F500ECF1
      F400E8EEF300E8ECF000EAEBED00EAEAEA00EBE9E900ECE9E700EDE9E700EEEA
      E800EDE5E100E7D3CD00E2DED900E4E3DE00E8E6E100EBE9E400F3F1EC00E4E1
      D9006A615200737C7F00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00474C
      4D00818181008F8F8F005E5E5E00636364007C776700D8B5AA00DAC2C000E4ED
      F700E1E5EC00E1E8F000E2EBF400E6EFF600F0F4F600F9F8F600F4F6F600EBF1
      F500E6EDF300E8EBEF00E8EAEB00E9E8E900EAE7E600EBE6E500ECE6E400EDE6
      E300EEE8E500ECE1DB00E3D3CB00DFDDD900E2E1DC00E5E3DE00E6E5E000F1EE
      E900827A6A0069707200FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF004246
      47008E8E8E008A8A8A00606060006465690070604E00DED0CA00E9EBF500DEDD
      E100DFE1E800E0E5ED00E0E9F100E2EDF600EBF2F700F7F8F700F5F6F700E9F1
      F600E5EDF300E6EAED00E7E7E900E8E6E600E9E4E400EAE4E200EBE3E100EBE3
      E000ECE4E000EEE8E400E7D7CE00DDD4CE00DCDBD800DEDDD800DBDBD700E7E7
      E6009B93850060636000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF003B3E
      3F009B9B9B00878787005B6366007F544B00864B3400BDC2BC00F0ECF000DAD7
      DC00DEDDE300DFE1E800DFE5EE00DFEAF400E6F0F700F4F7F700F8F7F700E8F0
      F700E3EBF200E5E8EC00E6E4E700E7E3E300E8E1E000E8E0DE00E9E0DD00EAE0
      DC00EBE0DC00ECE2DD00EBDEDB00E0CBC300D8D6D100D7D5D100D5D3CF00DDDE
      DE00BBB5AA005E5C54007E878A00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF007E888A003739
      3A00A5A5A50082848700635F6100A6493600B29A9500928E7F00F7F1F400D9D3
      D600DDD9DE00DEDDE300DEE2E900DEE7F000E1EDF700F1F6F900F9FCFD00E6F2
      F900E1EAF000E3E4EB00E5E2E500E5DFDF00E6DDDC00E7DDDA00E8DCD900E9DC
      D800EADDD800EADDD800ECE2DC00E3CBC300D6CDC700CDCFCB00CFCDCA00D6D5
      D100D7D6CE00675F530077808200FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF007D8789003335
      3600AAAAAA007C8687007B453A00C5827400D6C6CA00847A6A00F2EBEA00DDCF
      D200DCD3D700DCD8DD00DDDDE400DDE2EB00DEEAF800E9F4FA00EBE0DA00E1D2
      CC00E2D4CC00E1D4CC00E2D8D300E5DADA00E5D9D700E6D8D400E7D8D300E8D8
      D200E8D8D200E9D8D300EBDBD800E6D0C900D6C2BB00C5C7C400C8C5C100CCCE
      CA00D6D6D3007C7261006D757700FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF007C8588003335
      3500B0B3B3007B7C7B009A473400DEBDBD00DCBEBF0080756200DCD6D200E5D4
      D700DAC9CB00DBD1D500DCD7DC00DCDEE600DCE2EB00DDCAC400E9D7D100F5E7
      E700F7EAE800F5E8E500ECDCD300E3D0CA00E4D3CF00E5D2CD00E6D2CC00E7D2
      CC00E7D3CD00E8D5CF00E9D8D100EAD6CF00D7BCB300BBBCB900C2C2BE00C7C7
      C400D0D2CF00968F800063686600FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF007A8486003334
      3500B5BCBD007F696300B66A5B00DEC6C200DEB7B60098837500C0BBB100EEDC
      DC00D6C0BF00DAC9CA00DBCFD200DBD7DB00DBC6BE00F0DED900FDF1F300FFF6
      F700FEF6F800FCF1F200F9F2F100EBDCD600E2CEC400E4CCC600E5CDC600E5CE
      C800E6D0CA00E7D2CC00E8D4CE00EAD6D000D7B8AF00B5B3B000BABAB700C1C1
      BD00C6C8C700B4AFA300605F58007F898C00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00798285003334
      3500BAC3C6008A554A00CF948600DCB7B400DBB0AB00B5958B009E988A00F8E7
      E600D5B4B100D9BFBC00DAC4C400D7C2BE00E9D4CC00FEF3F300FCF1F000DDC5
      BD00D5B5AA00F4E4E300FCF1F100F5EBE900E1CDC500E3C8C100E4CAC300E4CC
      C500E5CDC700E6CFC900E7D1CB00E9D4CE00D7B3A900ABA9A500B6B7B400BBBC
      B900C2C3C000C2BEB800635D520078818400FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00788184003737
      3700C0CACB00924F3E00DBACA500D8AEA600D7A9A100CA9F980089817200F7EA
      E700D7ADA500D8B3AC00D9B7B100D8BCB400F6E5E300FFF5F800D9B8AD00AE7C
      6500B2826C00C6A28F00FDF1F200FBEFEE00E3D3CA00E1C3BC00E2C7C000E3C9
      C200E4CAC400E4CCC600E5CEC800E8D1CB00D4ADA200A3A09C00B0B1AE00B6B7
      B500BDBEBB00C1C0BE00746A5B006E777900FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00778082004040
      4000C6CCCD00994E3C00E6C2BB00D6AAA300D5A8A000DAAAA40086756500E6DF
      DD00E0BAB100D7A9A100D8ACA600DABEB500FAEAEC00FFF2F500BB8F7B00B282
      6C00B7897400B7897600F9EAE800FCF0F200E3D1C800DFC0B900E1C4BD00E2C6
      BF00E3C8C100E4CAC300E4CCC500E6CDC600CFA59A0098979600ABADAA00B1B3
      B100B6B8B600BABBB8008A827200666B6A00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00747D7F004748
      4800CCCDCF009C4E3B00E9CAC500D6A8A000D5A8A000DEAFA80092796B00CCC9
      C200EED0CC00D2A29A00D7ABA300D8BBB100FAE9E900FFF5F700C8A39200A66F
      5500A9745B00CFAE9F00FFF6F600F9EAE900DEC8BF00DFC3BE00E0C4BE00E1C5
      BF00E1C6C000E2C8C200E4CAC500E3C6BF00C29B8F0092939300A7A8A700AFB1
      AF00B2B4B200B1B3B300A49E910060625C00808A8C00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF006F787A005354
      5400D1D4D30098493600EBCFC900D7AAA200D5A79F00DEADA500AF8B7E00A7A6
      9A00FBE6E200D1A19400D5ACA600D4B4AB00F4E2E000FFEFF200F9E8E900D2AE
      A300D7B7AB00FBEEEF00FEF3F400ECDAD400D9C3BA00DDC7C500DEC7C300DFC7
      C300E0C8C300E1C8C400E3CECA00DCB5AD00B59286008C909000A1A2A100ABAE
      AC00AEB0AE00AEB1AF00B1AEA600625D4F007A838500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00697072005C5C
      5C00D0D6D60092463400E9CCC700DAB2AA00D4A79F00D9ACA400C69B91008D87
      7900FFF8F900D3ACA800D4B4B300D3B8B500DDC0B700FEEDEE00FFF0F200FFF4
      F900FFF5F900FFF1F600F5E0DC00DAC1B600DBCBCE00DCCACB00DDC9C900DEC9
      C700DFC9C700DFC9C600E4D2CF00D09E9000A38E8700878B89009DA09E00A8AB
      A900A9ABAA00ACAEAD00B2B2AE00655C4B00727B7D00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00646B6D006767
      6700CED6D90089463500DEB5AC00E4C5C000D2A49C00D6AAA300D8ACA8008477
      6700F2F3F000DCC1C100D3B8BA00D3C3CB00D3BCBA00DFBCB100F4DEDB00FAE7
      E900F7E1E200EBD0C900D9BDB300D8CFD500D9D1D700DACED100DBCCCE00DCCB
      CC00DDCACA00DFCBCB00DFCBC800BD82720093908C0087888600999D9C00A5A8
      A700A6A9A800AAACAB00A7A9A9007E7465006C737500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF005E646600716F
      6F00CCD5D70083544500CC8F8100EEDDD900D2A7A100D5AFAA00E0BAB9008B78
      6800CFCFC800EDDEE100CFBCC000D3C8CF00D2D1E100CFCCD300D2C0B900DBC0
      B600DAC1BC00D2CBCE00D5DCEA00D7D9E400D8D4DC00D9D1D700DACFD300DBCD
      D000DCCCCD00E1D8D900D1A49C00A57C7000838A89008686830094999800A2A6
      A600A3A7A500A6A9A800A1A5A5009C96890062646000FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00585E60007A7A
      7A00C9CED10083736F00AE5A4600F6EAEA00DBB9B600D1AFAD00DEBEBE00A691
      8900ACA99D00FEF8FD00D2C3C900D4CFD800D3D6E400D1E0F400D0EBFF00EEF5
      FF00F0F8FF00D1EBFF00D0DFF300D2D8E600D3D4DF00D4D0D900D5CED400D6CC
      D100D8CDD300DAC7CA00B16C59008C878400777A7900817E7F00878D8D00999D
      9C009B9E9E009EA2A2009B9F9F00A8A69E006360570079828500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0053585A008585
      8500C8C8C8008790920096473500DFB8B100EBE1E100D2B2AF00D9BEC000C1AD
      AA00867F6D00FFFFFF00FDFEFE00FCFDFE00FBFEFF00FBFEFF00FBFFFF00FFFF
      FF00FFFFFF00FBFFFF00F6FFFF00F3FBFF00F2F6FF00F1F2FC00F0EEF500EDE8
      F100EFEBF300D8A7A000AB8981009DA7A8008585850086898800757A7B00878B
      8C008A8E8E008F9291008B8F8F009E9F9D006B6556007B828300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF004D5254009292
      9200C3C3C3008B93940091776F00AE554000F6F2F400E1CED000D4B9BB00D5C3
      CB00877A6C00837B6B008A8070008B8272008D8374008E857600908777009188
      7900958B7D009A9284009F978800A39C8F00A9A29600ADA79C00AFA99F00B6BB
      B200B9B4AC00B0918100A6A49E00A9A59D009B979000A7A49E00B2B3B000B0B0
      AE00ADAEAB00ACACAB00A3A5A400AEAFAC00716A5B00858D8E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00474B4D00A2A2
      A200BFBFBF00918F8F00959FA200914F3E00C78D7F00F9FAFF00DECDD000D3C1
      C900D5C9D200CEC7CE00CACAD200C8CAD600C5CCD900C2CFDE00C3D2E000D0D7
      DD00DBD9D700C9CED300B7C4CC00B0B9C100ACAFB300A6A8A900AAB2B7009672
      64007B4C38006C6F6500706A6000716B5E0067605300625C4E00756F6200726D
      6000746E61007671620077716300776E5C0083888500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0040444500B1B1
      B100BEBEBE0095959500999A9B0096999C0096402A00D4A49D00F8FCFF00E0D8
      DD00D2C8D000D3D0DB00D7D7E500D7DDEC00D7E3F500D6E8FD00DBF0FF00EEFA
      FF00FFFFFF00F4FFFF00E2F7FF00D8EDFF00DCF1FF00E3FDFF00CEA5A800A146
      31007D716D0076797F00757679007C7D80004E515200535A5B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF003A3D3E00BFBF
      BF00BBBBBB00989898009C9C9B009AA0A00098949400963C2800C8928800F6FC
      FF00EBF0F900DAD9E000D1D3E100CFD7E700D2DFF100D1E4F800D7EAFD00E7F3
      FE00F9FAFE00F1F8FE00E2F3FF00DAFCFF00D7E7FB00B7776E00923E2A007B7B
      78007A8084007A7A7A0079797900808080004E4E4E005D646500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF007F898C0035383800C7C7
      C700B9B9B9009B9B9B009E9E9E009D9D9D009BA1A400999D9C00934D3C00B260
      4E00E1C8C800F5FBFF00EEFAFF00E3F0FF00DAEBFB00D6EAFF00DAF2FF00EBFE
      FF00FFFFFF00FFFFFF00EBF4FD00C9A29F00A44A35008B564A007F888A007F82
      85007F7F7F007E7E7E007C7C7C008181810047474700656C6E00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF007D87890033353600D0D0
      D000B6B6B6009E9E9E00A1A1A100A0A0A0009F9E9E009D9FA2009BA5A9009676
      6E0097473400B0615100CDA09900DDC6C500E7E1E700E8EAF500E9E6EE00E5D6
      D500DEB7B000C2807000A44E39008E514100877D7C00858E9200848586008483
      830082828200818181007F7F7F0084848400424242006C747600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00808A8C0033353600E2E2
      E200B3B3B3009E9E9E00A0A0A0009E9E9E009D9D9D009B9B9B009A9A9A00989F
      A200969D9F00917B77008F584900934B3800984E3D009B503C009A4F3E00944C
      3A008D4E41008A6860008A86840088919600898C8D0089898900878787008686
      8600858585008383830082828200848484003D3D3D00727A7D00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0035363700CBCB
      CB00E2E2E200CBCBCB00CDCDCD00CBCBCB00CACACA00C9C9C900C6C6C600C4C4
      C400C2C3C300BFC5C500BAC3C600B6BEC100B1B5B600AEAFAE00A8ADAD00A4AD
      AE00A1AAAD009EA7A8009D9E9F009A9A9A009898960093939300919191008E8E
      8E008B8B8B008989890087878700878787003A3A3A0079828500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF007A8285003738
      3900494949004B4B4B004E4E4E005252520056565600595959005F5F5F006262
      62006767670070707000757575007C7D7D0082828400888989008B8B8B008D8D
      8D00908F8F0092929200949494009595950097979700989898009B9B9B009D9D
      9D009E9E9E009F9F9F00A0A0A0009595950038383900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00828B8E007F88
      8A007B84860078818300747D7F006F77790069707200636A6C005F6567005A5F
      610054595B00515657004F5354004C4F5100494D4E00474A4B00454849004446
      470043454600424344003E3F3F003B3C3D0053575800FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF007F898C007C8588007A838500798285007A8486007D87
      8900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF007F898C007A848600798285007A8486007F898C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007E888A007A83
      8500798284007A8385007E878A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007E888A007C85
      88007B8587007C8588007D8689007E878A007F898C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007881
      84006B7476005E66680053595B004B515200474C4E00454B4C00484E4F004E54
      5500585F6100656C6E00727A7D007F898C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00727B7D0061696B0052595A00494E5000454B4C00494E500053595B006269
      6B00737C7E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007A848600626A6C0050565800474C
      4E0044494B00474C4E005056570061696B007A838500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007F888B006E7678005C636500505658004B51
      52004A5052004C5153004D5354005056570053595B00595F610060676900666E
      70006D757700737C7F00798285007E888A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00757E80005D646600484D
      4F004C413C005D3E310072432D0082492F008B4F33008E503500874D32007D45
      2E00663E2B00553E34004546460053595B006C747600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007C8588007E878A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00757E80005960
      6200494845006E49260097531300B65F1000BD631000B45F0F00975312006D47
      2400494946005A616300767F8100FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00808A8C00585E60005C32240078290D008B31
      0500923405008C330500792B0C005D332300565C5E007F898C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006E777900545B5C00493F3B0066341B007E3713008539
      1000873C1200833A1100813911007B36100074311100673018005B3222005036
      2C00493B360043434300474C4D00505658005C63650068707200757E8000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00666E7000484D4E00613E2E008D4D
      3100A8745F00B69A8C00C5B9B400D0CBC700D8D6D500E0DEDC00E3DFDC00E3DB
      D800D8C6BD00C0998600A3644800713D26004C4643005D6466007C858800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006168
      6A004C525400505657005D6466006A727400757D80007C858800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B7476004A5051008750
      1900D16E1200DC862F00E5974500EB9F5300EBA45B00EBA65F00E8A35F00DE92
      4600CF731A00844B19004A5052006D757700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007982840085351000C8835B00F1DFD300FBF2
      EA00FEEEDF00FBE1C800F2C8A800C981540086340E0078818400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007D8689006067690049444200712C1100C27A4700CF9F6D00AE743A00B883
      4500C58E4F00CE975500D5A05A00DDA45D00E1A65E00DFA25D00D8995800D08B
      4D00C1753700B35D26009643150078320E005F301E004F372F004D4D4D006D75
      7700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0061696B0055453C00904B2E00B9918200D4CC
      CB00D9E0E300D3D9DB00CFD1D300CECCCE00CACBCC00CCCBCB00CFCECF00D7D8
      DB00E7ECF000FBFFFF00FFFFFF00E3CEC600A3644800623F30005A6163007F89
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B8487001E5E
      8000065E8E000C547C001C4861002D455200414749004C5254005A616300676F
      7100727A7D007A848600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF006B747600574D4100BD630C00DB81
      2400E8923A00E7933A00F08F3700F5903800F7933F00E9984500EAA25300EFAD
      6600EFB37400E0984E00B95F0B00554D42006D757700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00778082009C3E0A00FFF1D500FFFFFF00FFFF
      FE00FFF7EA00FFF0DA00FFF1D400FFE7C4009E420E0077808200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007780
      8200565D5F005A312500AB531E00EAC28C00F8E3B500B37D4600BD864A00C891
      5200D1995900D8A25F00E0AA6600E7B26C00ECBA7400EFBD7800F1C07C00F3C5
      8200F6CA8500F6CA8900F4C98800ECBD7D00E1AA6D00CD8B5300B05A26007E52
      3D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B73750060463C00A3644A00DACDCB00E8E6EC00D9D3
      D500D1C6C700C9BBBC00C1B4B500B8ADAE00B0A6A700A99F9F00A0999A009993
      93009790910099949400B0AFB200E7EDF100FFFFFF00BC8A76006C402E006971
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A8385000969
      98000074AC00549ABC00359AC4000070A8000466980009568000184B66002845
      55003C464900494F5000565D5F00646C6E0070797B00798284007F898C00FF00
      FF00FF00FF00FF00FF00FF00FF00757E800059524800CE6A0B00DF7F1C00E482
      1C00E27D1300EB791100C97F10002292030092881400F6862700E68D3200E794
      3E00E99D4E00F0B26E00ECAC6900CA6B0E0059524900757E8000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00778082009B3C0A00F4D4B900F8F2EF00F9F2
      F000FCEDDF00FDE7D100FFE3C500FFD9B4009D3F0D0077808200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00727A7D004F55
      57006C2A1600C47E4700FADEAA00FFF4CB00D3AB7E00BE814500CD985A00D49F
      6000DCA76600E2AE6D00E9B57300ECBA7800EDBC7B00EEBD7D00EEBF8000EFC1
      8200F0C28500F1C48800F2C68B00F5CC9100F9D19600FFE9AF00D1905B007C69
      6100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007E888A005D555100A0604600E9DFE000E9E0E600DECCD000D7C7
      C900D0C2C300CABDBE00C3B8B900BDB2B300B6ADAE00B2AFB100ACAAAC00A2A0
      A1009A959600908C8C00838081007A767700A0A2A300FEFFFF00BC846B006155
      4F007F898C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00767F82006169
      6B00626A6C007A838500FF00FF00FF00FF00FF00FF00FF00FF007A8486000D66
      93000090C7003381AC00A2E7F90000A3D70011A7D700169ECD00148EBE000D7E
      AF00066DA000065A8600144B6B002447590038454B00474C4E0053595B006168
      6A006D75770077808200737C7E00555B5D00C0640C00DE760C00E37A0900E276
      0600E3790600FB750600718D0A0000A70C0000A00800B97D0A00EE7A1600E486
      2400E68E3300E8984400EDAC6400EBA86600BF610C005A616300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006E777900993A0900E6C2A900EADFDC00EBE0
      DE00EEDCCF00F1D8C400F5D6BB00F8D0AC009C3E0E0077808200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006F787A004B4E4F007E2C
      0B00D9A16A00FEE7B500FAE4BC00FFF5D800D1A16D00D0995C00D9A66800E0AD
      6E00E6B47500EBBA7A00EFBF7F00EFC08200F0C28400F1C48700F2C58A00F3C7
      8C00F3C98F00F4CB9200F5CC9400F5CE9700F7D09A00FFDEA700A44F1F00808A
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00767F810080462E00DBC0BD00F5E9ED00E6D4D500DFCFD000D9CA
      CB00D2C4C500CBBEBF00C5B9BA00BFB4B500B6AFB400A37D6C009C7363009C8A
      84009B979900979A9C00908D90008886860074737300828A8E00D5C7C200804B
      350071797B00FF00FF00FF00FF00FF00FF00FF00FF006F787A004A5151001B3E
      1E001B431D005D686600FF00FF00FF00FF00FF00FF00FF00FF007A8486000D63
      8F0001A6DA00006BA200A8D0E20037BCE3000FA9DA0020B4E0002AB8E20030BC
      E40033B9E10032B0D600299FC9001B87B5000C73A600055D8D00104F73002148
      5D0033455000454A4B00454A4B0094511A00DA710800E67C0A00E77E0B00E97F
      0C00EA810C00FF7D09005AA31E0005B5290000B22100888F1000F8730500DF79
      0A00E2801A00E58B2E00E8964100EFAC6600E09548008C542100737C7F00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B858700737C
      7E00676F71005D6466005C62640051575900973B0A00D9B49E00DBCDCB00DDCE
      CD00E0CBBF00E3C7B600E7C5AE00E8C1A1009B3E0E0077808200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0071797B004C4C4B0091340700E4B8
      8100FDE9B700FAE6C000FFF5D800FCEFD700D5A06900DEAD7000E4B47700E9BA
      7D00EEBF8200F1C38600F2C58900F2C78C00F3C88E00F4CA9100F5CC9400F5CE
      9600F6CF9900F7D19C00F8D39E00F9D4A100FEDCAA00F2CC9B0083442700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00757B7C00A2614800FBE8EC00F0DEE000E8D6D700E1D0D200DBCB
      CC00D4C6C700CDBFC100C7BABB00C3BDC100A5786500C5998900C9ACA400B07A
      6800A0675100976C5B00968F8C00939290008D8B8B007F8283008D888400A359
      3B005157590062696B006B737500757D80006B737500444F4A00034804001BA1
      43001FA2490028532C00FF00FF00FF00FF00FF00FF00FF00FF007A8486000D63
      8F0002ABDF000083BC00619BBB0099E5F80009AADB0025B4DF002CB7E00032B9
      E10038BDE3003FC3E40048C7E90051CCEC004FC5E60044B5D600339FC6001F86
      B1000E72A2000361970017537100D5680400EC810A00EB820D00EE850E00EF87
      0F00F3880F00FF850B003DB938001DC13C000DC13A00849C1D00FF780600E27A
      0900E1770700E27E1600E68A2C00EB974400EDAC6500CF721700666B6B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF007D868900747D7F00697173005A6163004B5152004244
      450051352C0067331B00622D1B00552D2000902F0300C9A28F00D1C6C900D4C6
      CA00D3BEB600D5B8A800D9B6A100DBB19600993C0C0077808300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00737C7F004D4F500092380B00ECC48D00FEE6
      B900FAE8C400FFF2D600FFFAE400F9E9D400DEAC7100E8BA7F00ECC08400F0C4
      8900F3C88D00F4CA9000F4CB9300F5CD9500F6CF9800F7D19B00F8D29D00F8D4
      A000F9D5A300FAD8A500FBD9A800FCDBAB00FFECBE00D99F6F007B5E5500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007C85880067696800A8695400FDEBEF00F2DFE100EAD8D900E3D2D300DDCD
      CE00D6C7C900CFC1C200C8BCBD00C5BEC200A6736000DECFCE00D1CFD900CECB
      D200D7CFD200C492810089695B00686C6E0052514F0047484800423F3F004C2F
      23002B2C2B002D313100373A3B00414648003D424300054D06000E9C24002FF3
      740022AF4F00355C3A00FF00FF00FF00FF00FF00FF00FF00FF007A8486000D63
      8F0002A9DD0000A3DB000C6D9F00CEEEF8002CBCE50025B8E20031BCE40037BE
      E4003DC1E50042C3E60048C5E7004DC8E70050C6E5004EC4E1004EBEDD0049B6
      D30044A7C5002293C20065726400ED710000EF880E00F0891000F48C1100FF8D
      0D00FF850500D19D1F0028D4580033CE51002ACB4C0032C04000E1891000F67F
      0A00EC7A0900F8730400EF7C1700E88A3000FFA15700ED8F3F007C5C3C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007D878900757E
      8000697173005C6264004D535400424647004E382F00612C1B007F290900A342
      0E00C27F5B00A03F0E00D4A48900C9875D00AB501D009B3A07009F522E00AB74
      5E00BC958A00C8A9A100CEB1A300D2AC9500983B0B0068707200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0079828400515759008D340900EDC79200FFEDC300FDF0
      CF00FFF9E100FFFBE700FFFFF600F8EEDE00E9BB8000F1C68D00F3CA9100F5CD
      9500F6CE9800F7D09A00F8D29D00F8D49F00F9D5A200FAD7A500FBD9A800FBDB
      AA00FCDCAD00FEDEB000FEDFB200FFE1B400FFF3C900B96A3A007C818200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006971
      73004F5557003F434500A3654A00FFF5FC00FDEFF500F2E3E900E9D9DE00DFCF
      D400D8CACB00D0C3C400CABDBE00C6BEC200A6756200C9B9B600BAB2B500C7BB
      BD00A59EA300504C4B003B383600626061008080800099999900A4A4A4009EA6
      A900959697007E7E7E00616161003C383C001B251C000053000009BB1A0017C1
      3E000054030076868200FF00FF00FF00FF00FF00FF00FF00FF007A8486000D64
      900002ABDF0002B4E800006FA900A5C1D60085E0F8001CB9E30037C0E7003CC3
      E70043C5E80048C7E8004DC9EA0053CCEA0054CAE80051C4E3004EBCDA0047B0
      D0003EA3C300279AC5009E713A00F77E0000F48C1100F78F1200FF920D00E69C
      1C00BCAD310053D962003DE26E0043DC66003FD75F0027D65A004AC04100FF7E
      0800E6840D008F8F1200299508001092030061921C00B9913900A15D23007C85
      8800FF00FF00FF00FF00FF00FF00FF00FF00727A7D005D6466004E5455004247
      48004D3931005F2D1D007C290B009F3F0B00B9683600D7956400F1C08D00FFE5
      B500FCFBFB00A2440D00FDF6EC00FFEAD100FCD9B900ECBF9900D5956700B963
      3000A54612009A3A0C00A04F2A00AB6A4C009035070044494B00595F6100676F
      7100737C7F007C858800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF005B6264007E2D0E00EBC59300FFF7D100FBECCF00F7E8
      CD00F6E3C900F6E3CC00F7E6D500F3DCC600F3C88F00F7D09A00F8D29E00F9D5
      A000FAD6A300FCD9A500FCDAA700FCDAAA00FCDCAD00FDDEAF00FEDFB200FFE0
      B300FFE1B400FFE1B600FFE1B600FFE4B900FFE8BD0090441C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F898C007157
      4B00884D3100884C3200944C2D00BC867200C99D8F00D1ADA300D9BFBA00DFCC
      CE00DDCFD200D9CFD300D1CBCF00CCC8CD00A5766300BBAEB000B9ADAF006E66
      6700323432009B9C9C00E5E4E600F6FEFE00F0F6F600EBF3F300E8EFEF00E2E2
      E200E3E3E300E1E2E200DFE3E800D0D5D600ACA7AA00695A6800243C2500034E
      050037503C00757E8000FF00FF00FF00FF00FF00FF00FF00FF007A8486000D64
      900002ADE20002B4E8000094CC003E83AC00DEFDFF002BBFE7003BC4EA0042C7
      EA0048C9EB004DCBEC0052CDEC0057D0ED0059CFEB0057C9E60053C1DE004AB5
      D30040A6C6002B98BF00B36E2400FB880500F9911300FF911000ECA322003DE8
      740037F284004DEE820055ED7F0051EB7B004CE5740045DE680030D75D0058BD
      3F0029BC380000B7290000A61400009903000091000000850000B26117007A84
      8600FF00FF00FF00FF00FF00FF00788184005A4C44005D2D1E0079290B009A3C
      0700B7663400D4946400EFC39600FFDFB100FFEBBF00FFE9BA00FFDDAA00FFEB
      C400E7D3CF00A3410000FFFCEE00F7DAC000F4D0AD00F8D4B200FAD8B700FCDB
      B700F6CFAB00E9B28800D0895A00B55F2B00A3451000842D0700622D1A005037
      2E00424646004C5254005C6264006A727400757E80007E878A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006B73750069322100D49F6F00F7DEB200E5BB8F00E5B98600E7BA
      8300ECC08800F1C38B00F4C88E00F6CD9500F9D5A200F8D7A400F6D3A200FFD8
      A400FFE9A900FFE2A800FFE8AD00FFF8BB00FFE6B500FFE1B500FFE1B600FFE2
      B600FFE2B700FFE2B700FFE2B800FFEEC400ECC196007E4A3800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007C8588007F49
      3200E5C4BF00E5D1D000C9A99E00B98F7F00AD796400A56A5300A2654900A05F
      4500A1634800A66D5700AE806E00B29084009F644D00AF9B9C006D6263003E41
      4100EBECEC00FDFDFD00EBF1F100D4AAAA00C4666600C4696900D2B4B400DBE2
      E200D9DADA00D3DCE600D0C9CA00D0CFD000DAE4ED00E0E0E000BCB1BB00584E
      57002729290050565700757D8000FF00FF00FF00FF00FF00FF007A8486000D64
      900002B1E50002B3E70000B3E8000068A000E0EAF1006EDAF60035C5EC0047CB
      ED004CCDED0052CFEE0057D1EF005CD3EF0060D4EF005DCFEA0058C6E2004FB9
      D70044AACA003198BC00BB6E1D00FE8F0A00FD961400FF9A1C00D1BA470041F7
      8A005DF78E0063FB940063FC95005FF9900059F3870051EA7A0046DF6A002ED7
      5C0028C7470020B9330013AC1F00059E0A0000940200008C0300B46412007C85
      8800FF00FF00FF00FF00FF00FF00686E70009A370400CF906500EDC59D00FFE2
      BB00FFF2CE00FFF0CA00FFE9C000FFE0B500FFDCB000FFDBAE00FFD6A300FFFA
      DD00D0A89C00B3560C00FFFFF200F7D8BF00F4D1B100F4D0AF00F4CEAB00F3CB
      A800F3CAA600F7CEA800FBD3AC00FAD3AB00F4C79D00E6AF8100CF895900B561
      2D009F3F0B007D2C0A005F2E1D004D3A3300434849004F5557005E6567006D75
      77007D878900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007E878A005C504B00B0602C00EECB9B00E7BD8300EFC68E00F4CD9700F7D1
      9D00F8D4A000F9D6A300FBD8A600FBD9A800F7D3A200EFC59500F1BC8500DEA5
      710050396300131B80001B20820076657C00FFEEB800FFE5B900FFE2B800FFE3
      B900FFE3B900FFE3BA00FFE4BB00FFF6CF00D0956700796A6600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A848600814A
      3500F6E4E300E7DADB00D5BFBD00DAC6C500D9C8C700DAC6C600D7C2BE00CFB6
      B200C9A9A300C09A9000B27E6A00A8684E00A46044009B573800302D2900E0E2
      E300FEFEFE00EDF2F200E3DBDB00BF444400CB5E5E00CA585800C25A5A00E0E6
      E700DBE1EA00DDA05500F68B0000F18A0400D6AA7A00D1D6DF00D8DBD900E0E0
      E00081808100252526005157590079828500FF00FF00FF00FF007A8486000D64
      900001B3E70001B5E90001BCF000007EBA0087ACC400D3FEFF0032C7EC004BCF
      F00051D1F00056D3F0005BD5F10060D6F10065D8F20064D5EF005ECDE80056C0
      DC004AB0CE00319FC500B26F2400FF8F0800FF9E1E00FFA93700F3BB530059FF
      98006BFF9F007DFFA3007CFFA40073FFA10061FF9B0056F58A004FE8770042DB
      640034CD500026BF3B0018B1270009A3110000970300088C0300B5641800FF00
      FF00FF00FF00FF00FF00FF00FF0066524A00B86B3D00FFFFEB00FFF0CE00FFE8
      C400FFE2BD00FFE1BB00FFE0B800FFDFB600FFDEB400FFDDB100FFD8A600FFFF
      F500BB7C6700C06A1C00FFFDF100F7D9C100F5D2B300F4D1B100F4CFAD00F3CD
      AA00F3CBA700F3C9A300F2C7A000F2C59C00F2C49B00F6C89D00F9CBA100F9CC
      9E00F0BE9100DFA47900C67B5000AF582A0098390500782C0C005C3120004C3F
      380059606200808A8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006F787A007F351100ECBF8B00F9D59F00F7D39F00F9D5A200FAD7A500FBD9
      A800FBDBAB00FCDCAD00FDDEB000F9D8A900F0C79700E5B18000DFA063001E12
      5E00000DD3000029FC000027F3000000B1005F547900FFFAC200FFE4BB00FFE4
      BB00FFE4BC00FFE4BD00FFE5BE00FFF6D000B56133007D848600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00778083008B51
      3800FDEAEA00E2CECD00D2BBB800D5BEBB00D4BDB900D4BCB800D3BCB800D3BC
      BA00D3BFBC00D4BCBD00CFB1A800C89F8E00CA8E76008C5E4800646A6B00FFFF
      FF00F2F2F200F1F2F200EFF3F300CD8E8E00C3535300C3555500D29D9B00E6EF
      F400DAD4D200F37E0000FF9A0000FF940000E8860400D6D9E900E5D8E500E4D5
      DD00F5E9F4008D8A8D00252626005D646600FF00FF00FF00FF007A8486000D65
      900001B6EA0001B8EC0001BBEF0000A9DF001A72A300FFFFFF005BD7F40049D1
      F20056D5F2005BD6F30060D8F30064DAF30069DCF4006BDCF30066D4ED005EC9
      E30053B9D50036A9D2009B6F3800FF8D0500FFA72E00FFB44B00FFBC5F00D2DC
      840079FFAB008DFFB00094FFB3008DFFAC0085F99C0069F8920050F0820047E0
      6C0039D257002BC441001CB52C000DA61600009A0200198A0300AE662C00FF00
      FF00FF00FF00FF00FF007A8385006F342300D9A47F00FFF7DB00FFE5C500FFE5
      C300FFE4C000FFE2BE00FFE1BC00FFE1B900FFDFB700FFDEB500FFDBAC00FFFF
      FF00AC5E3B00D38A3D00FFFBF100F7DCC500F5D3B500F5D2B300F4D0B000F4CE
      AD00F3CCA900F3CAA600F2C8A200F2C69F00F2C49C00F1C29800F0C09500F0BE
      9100F1BE9000F3C19600F3C59F00EFC0A000E4B09200D4977B00BD724D00A94E
      230088370E0079828500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0064605E00BB6F3A00FFEAB800FBD9A700FBDAAA00FDDCAD00FDDEAF00FEDF
      B100FFE0B300FFE2B500FEDFB200F5CFA200E8B88B00E9AB70008D5E53000015
      BC001D6BFF00185BFF000537F8000033FB0000028F00E7C9A800FFEFC200FFE5
      BE00FFE5BE00FFE5BF00FFE8C200FFEBC5008F462000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00757D80009659
      3E00FFF3F500DDC8C600D5BEBB00D6BFBC00D5BDBC00D0B7B400CFB7B300D1B6
      B300D1B7B300D0B7B200CBA99F00C4978600C78B71007D513F0080858900FFFF
      FF00F7F7F700F5F5F500F3F4F400F3FCFC00E8DCDC00E5DEDE00EBF4F400E7E8
      E600E4EAF100DFB88900EB921F00E9942700DCC3AC00D5DEE1006BBE75004ABC
      60008DC59100F2E8EF006E6E6E0034363700737C7F00FF00FF007A8486000D63
      910001B9ED0001BBEF0001B9ED0000C2F400006EA700D1D8E200B9F5FF0041D2
      F3005AD8F5005FDAF50064DBF50068DDF5006CDEF60071E0F6006FDDF30068D2
      EA005DC4DE003FB4DC00747B6A00FC810000FFB03D00FFBA5700FFC87200FFD2
      8C00E5EBA900E2EEB500F2E8AD00F9DB9400FFC36F00E0CA69004FF98D0049E4
      72003CD55C002DC645001EB730000FA81A00009F0300557F04009A735400FF00
      FF00FF00FF00FF00FF006E77790089310B00F4DABB00FFF0D300FFE7C900FFE6
      C700FFE5C400FFE4C200FFE3BF00FFE2BD00FFE1BB00FFE0B700FFE3BA00FBF8
      F300A1461300E2A75C00FEF8F000F8DDC400F5D5B800F5D3B600F4D1B200F4D0
      AF00F4CEAC00F3CCA800F3C9A500F2C7A100F2C69E00F1C49B00F1C29700F0BF
      9400F0BE9000F0BC8D00EDB98F00EAB69100E8B69700E9B89E00EBBFAA00E2B0
      9E009035070079828400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007E87
      8A006A403100E5B68400FFEABB00FEDFB100FEE0B300FFE1B400FFE1B500FFE2
      B600FFE1B600FFE3B800FBDBB000F1C99D00E3B18300EBAA6D006C4554000947
      D80050B1FF004397FF001655FF000030FA000007AA00C8AD9A00FFF5C600FFE6
      C000FFE6C100FFE6C200FFF1CE00EEC7A3007E473300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0072797A00A465
      4A00FFF5F800DAC4C200D6BFBC00D6BEBA00E0CDBC00EAE2E600E2D7DE00DBCD
      D300D5C2C400D1BBBC00C9A9A500C2978900C0886F009260490055575A00FFFF
      FF00FCFCFC00F9F9F900F6F6F600F4F5F500F3F8F800FDFFFF00FFFFFF00FFF8
      FF00FEFBFE00EEF6FF00DFE6F000DEE6F200F4EAFF005ABE660010C64B002AD1
      680007BD3900A3C9A200E4D9E300383838005F666800FF00FF007A8486000D63
      8F0001BBF00001BEF20001BCF00001C4F6000096CD005C8FB300FFFFFF0054DA
      F7005CDBF70063DDF70068DEF7006CE0F70070E1F80075E3F80077E4F70073DD
      F20069D0E80054C1DF004C9EB800D8690200FFB43E00FFBE5D00FFCC7A00FFDD
      9C00FFEAB900FFF6CE00FFECBD00FFDE9E00FFCC7D00FFB3550087E2770040E9
      77003CD55C002DC646001FB831000DA91A00009F0400AD6D0600848B8C00FF00
      FF00FF00FF00FF00FF0065605E00AA502400FFF9E200FFEBD000FFE9CC00FFE8
      CA00FFE7C800FFE6C500FFE5C300FFE4C100FFE3BE00FFE1B800FFEECD00ECDE
      D900A33F0700E9B46800FDF7ED00F7DEC800F6D6BA00F5D5B800F5D3B500F4D1
      B100F4CFAE00F3CDAA00F3CBA700F3C9A400F2C7A000F2C59D00F1C39900F1C1
      9600F0BF9300F0BD8F00EFBB8D00ECB88F00E9B59100E6B39300E5B49A00DEA8
      91008F36080079828400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007780
      8200843C1400FDDFB300FFE7BA00FFE1B600FFE2B600FFE2B700FFE2B800FFE2
      B800FFE3B900FFE3BA00FADAB100F1C99F00E3B18600E4A66F009B665A000024
      A80059C2FF004AA2FF00185CFF00002CFF0000017C00F3D7B400FFEDC700FFE7
      C300FFE7C400FFE7C500FFFAD900D3986D0079605800FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0072737200AA6D
      5600FFF8FB00D9C3C100D7C0BF00D6C0BF00CCA04900FFD48E00FFE5B200FFE9
      C300FFECCF00FBEFE000F4E9DE00E1C9BC00D2AA9900CC957D003C333500B7BE
      C300FFFFFF00FFFFFF00FBFBFB00F8F8F800FFFFFF00D5CED500748474005D87
      5E0089928900E4D3DC00F8F9FB00E4E7E500F3E8F20092CB960015BB3F001BC2
      4D002ABA4600C0D1C100F4EEF400838383003E4142007F888B007A8486000D63
      8F0001BEF20001C2F60001BFF30001C0F40000BCF100006B9F00FFFAF9009EED
      FF0053DBF80067E0F9006CE1F90070E3F90074E4F90077E5F9007CE7FA007DE6
      F90075DDF20069CEE50049C1E6008F784E00FC8E1600FFC36400FFC87900FFDC
      9900FFEBB800FFF8CC00FFECBB00FFDA9C00EDD4840091EC880057F3870048E3
      6F003AD359002CC543001DB62E0000AF180048870500B36E3D00FF00FF00FF00
      FF00FF00FF007E878A006A403300CA8E6A00FFFFEC00FFEBD200FFEAD000FFE9
      CE00FFE8CB00FFE7C900FFE6C700FFE5C400FFE4C200FFE0BB00FFFAE100DBBA
      B100AE510F00EDBA6E00FDF6ED00F8DFCA00F6D7BD00F6D6BA00F5D4B700F5D2
      B400F4D0B000F4CEAD00F3CCA900F3CAA600F2C8A300F2C69F00F2C49C00F1C2
      9800F1C09500F0BE9200F0BC8E00EEBA8E00EBB79000E8B49200E7B69800E0AA
      90009036090079828400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006E77
      7900A8592C00FFF1C700FFE3B800FFE2B800FFE2B800FFE3B900FFE3B900FFE3
      BB00FFE4BB00FFE5BD00FCDEB700F3CDA600E7B99000DBA37700E6A16A00492F
      5C00002EBF00115AFD00002CF10000008C008D7B8B00FFFECF00FFE7C500FFE8
      C600FFE8C600FFE8C700FFFCDC00BB7044007A787700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00706D6A00B278
      6000FFFBFF00D8C2BD00D8C2C100D5BFBB00CB9A3A00FEBE5D00FFBE5B00FFBA
      5600FFBD5500FFC05C00FFC46800FCBF6900EFB06500E8A76900C08350002E28
      24007D899200F1F5F700FFFFFF00FFFFFF00DED5DE00152314000054000000A6
      020007B73C00268B5300CCC7C900F6F5F600E9E9E900F5E9F200C8D9C400B3D4
      AF00E4DDD400ECE2E700E4E6E400C0C0C000313233007A8486007A8486000D64
      900001C1F50001C5F90001C2F60001C1F50001CBFF00007CB600A5BCCE00FAFF
      FF0057DFFA006BE3FA006FE4FB0074E5FA0078E7FB007BE8FB007EE9FB0083EB
      FB0082E9F9007AE0F1006AD0E90053B4CF00CC610C00CCBA4A00A4E88800FFD1
      8700FFE0A300FFE4AA00F1E6A500A7F29F0066FF9F0051FF940051EB7C0044DD
      680036CF530028C13E0006BB2A001C9F1300C9630F00FF00FF00FF00FF00FF00
      FF00FF00FF00757E8000792E1500E8C5AC00FFFAE800FFEDD600FFECD400FFEB
      D200FFEACF00FFE9CD00FFE8CA00FFE7C800FFE6C500FFE1BB00FFFFF900C28A
      7800BC682200EDBB6D00FDF7EE00F8E1CC00F6D9BF00F6D8BD00F5D6B900F5D4
      B600F5D2B300F4D0AF00F4CEAC00F3CCA800F4CCA900F8CEA700F3C79F00F1C4
      9A00F1C29700F0BF9400F0BE9100F0BC8D00EDB98E00EAB69100E9B89700E2AC
      8F009036090079828400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006A61
      5E00C67E5000FFF5CC00FFE3BA00FFE3BA00FFE4BB00FFE4BC00FFE4BD00FFE4
      BD00FFE5BE00FFE5BF00FEE3BD00F7D7B000EEC69D00E4B38900DCA37300E5A2
      6A007D5157003924620046326600B99F9500FFFFD200FFE9C800FFE8C700FFE9
      C800FFE9C900FFEACB00FFF4D600A04D20007E888A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006F666100BB88
      7300FFFAFE00D7BEBC00D9C3C500D4BDB400CE9C3C00FFC77100FFC56F00FFC3
      6B00FFC26700FFC06300FFBE5C00FFBC5700F9B24D00EEA03D00ED953300D882
      2C006F3E160033313000909BA200FFFFFF00B1B5B1000045000003A908001EC4
      48003EFD920000831500626C5800FFFFFF00EDEDEB00E8EAEB00FFEEF300FCE8
      EF00D2D9E300E9E0DD00EFE7E500D7D8D80036373700798285007A8486000D64
      900001C6FA0001C8FC0001C5F90001C4F80001CAFE0000ABE4002E7BA700FFFF
      FF0083EBFD0065E4FC0073E7FC0077E8FC007BE9FC007EEAFC0082EBFC0085EC
      FC0088EEFD0089EDFB0081E4F40069DBF60070A9B200B369050052DD6500E4DC
      8500FFD08400FFD38B00E3DC8B0050FF9F0048FF950048F3860043E5740037D8
      5F002ECA4B000CC53B0022A82100C0670700908B8300FF00FF00FF00FF00FF00
      FF00FF00FF00696F71009C3D0E00FFF4E300FFF2DF00FFF0DE00FFF0DF00FFEF
      D900FFF0DB00FFEAD000FFE9CE00FFE8CC00FFE7C900FFE3C000FFFFFF00B26A
      4B00CD823700EAB86C00FDF7EF00F8E2CE00F7DAC100F6D9BF00F6D7BC00F5D5
      B800F5D3B500F4D1B200F4CFAE00F5CFB100FFCF9A00F2BC8600FFD49E00F3C6
      9E00F1C39A00F1C19600F0BF9300F0BD8F00EFBB8D00ECB88F00EBBA9600E3AE
      8E009136080079828400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006A4D
      4300DEAB7F00FFF3CB00FFE4BC00FFE4BD00FFE4BE00FFE5BE00FFE5BF00FFE5
      C000FFE6C000FFE6C100FFE7C200FCE1BC00F5D4AF00EEC6A000E6B99100E1B0
      8600EEB68300F4C08900FFE8B300FFFFDA00FFFFD200FFEFCB00FFE9CA00FFEA
      CA00FFEACB00FFF1D300FBE1C20086411F00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006E5D5500C79B
      8B00FFF9FB00D7BEBC00DAC4C700D4B9AA00D09F3E00FFCA7A00FFC77400FFC5
      7000FFC46D00FFC36A00FFC16600FFC06300FFC06100FDBD5D00F6B05000F0A3
      4300F59A3600D27A280054301700736F7A002E792B000093000017BB350038ED
      84000FAB4100001A0000C3BAC300FFFFFF00EFF1F100FBF3EF00C3DEE70013BC
      EA0000C1F6001ABCEB00CCDDE300ECE5E4003D3D3D007A8486007A8486000D64
      900000C9FD0000CAFE0001C8FC0001C8FC0001C8FC0000D0FF00006DA500E7E3
      E800D9FFFF0060E4FD0076E9FD007AEAFD007EEBFD0081ECFD0085EDFD0087EE
      FD008BEFFD008EF1FE008FF1FD0090EBF90074E6FF0081B3BA00B7671000A2A8
      3100F0CC6B00FFCE7500FFC56D00F2C46400BACD61007FD5610050D75D0040CF
      500018C53C0069971100D4640C00938A7F00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0068554E00B9714900FFFFFB00FFF3E200FFEFDA00FFBF8400FFB5
      7200FFD9B100FFF0DE00FFEBD100FFEACF00FFE9CD00FFEACB00FFFFFD00A64D
      2400DD9E5200E9B36800FDF8F000F8E3D000F7DCC400F6DBC100F6D9BE00F6D7
      BB00F5D5B700F5D3B400F5D3B500FFD39A0072486F0000008700775E9500FFD7
      A300F2C59C00F1C39900F1C19500F0BE9200F0BD8E00EEBA8E00EDBC9500E6B0
      8D009236080079828400FF00FF00FF00FF00FF00FF00FF00FF007E878A00723E
      2A00EFCAA100FFEFC900FFE5BF00FFE5C000FFE5C000FFE6C100FFE6C100FFE6
      C200FFE6C300FFE7C400FFE7C500FFE8C600FCE2C000F6D8B400F0CEA900EDCA
      A500EEC8A600FADBB700FBE5C4005D53820063578200FFECC800FFF7D500FFEA
      CD00FFEBCE00FFF7DB00EDC9AA00794D3C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0070564900D2AC
      9E00FCF4F600D7BEBC00DBC7CB00D3B7A300D6A24000FFCD8100FFC97800FFC7
      7500FFC67200FFC56F00FFC36B00FFC26800FFC16500FFC06200FFBE5E00F9B5
      5500EFA54800F49B3B00F78C3300103C00000082000011B8280030DF71001AC9
      610026642100EBE5EA00FFFFFF00F7F7F700F5F5F500FFFBF4006DC8E50000BF
      FF0000D1FF0000BFFF0088CFE600F9E9E400373939007E888A007A8486000D64
      900005CCFE0004CEFF0003CCFF0001CBFF0001CAFE0000D4FF000094CE00729C
      BB00FFFFFF0075EBFF0067E8FF0070E9FE0074EAFE007BEDFE0082EFFE0089F0
      FE008CF1FE0090F2FE0093F3FE0096F5FF0098F5FD008AF8FF0085DCEE00AB8A
      5B00B4741300CC8F1F00FE9D2E00FFA53400FF9C2400FF8F0C00FC810000E06F
      0000B5771000835F470061696A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007F898C00713A2A00D9B19600FFFFFB00FFF8ED00FFC59300FFCD9D00FFE8
      D200FFB67300FFE9CF00FFEED900FFECD300FFEACD00FFF4DD00F2E7E400A23E
      0800E9B26500E6B06500FDF8F000F9E4D200F7DDC600F7DCC400F6DAC000F6D8
      BD00F5D6BA00F5D4B600FBD9B900E7B68800150D95007B82EE0012119E00F1C6
      A000F7CB9F00F1C49B00F1C29800F1C09400F0BE9100F0BC8E00EFBE9300E8B2
      8D009236080079828400FF00FF00FF00FF00FF00FF00FF00FF007A838500853C
      1600FDE1BB00FFEBC700FFE6C100FFE7C200FFE6C300FFE7C400FFE7C400FFE7
      C500FFE8C600FFE8C600FFE8C700FFE8C800FDE5C400FADFBE00F6D9B800F2D1
      AF00ECC9A900FFDDAC00796279000022C7000014DE0020196B00FFF0CD00FFF7
      D600FFEACE00FFFDE500D9A68100785D5500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00734F4000D9B9
      AD00F8EDF100D7C0BC00DCC8CD00D0B49800DBA74900FFD18800FFCA7C00FFC9
      7900FFC87700FFC77400FFC57000FFC46D00FFC36900FFC16600FFC16300FFBF
      6000FFC05A00FDA64B00555C12000083000006B8180028D05E002EE67F00015F
      0700EFEBEA00FFFFFF00FEFEFE00FBFBFB00F9F9F900FFFDF900F8F5F50057C8
      E90026C2EC005CC7E400F7F5F500D3D1D00037393900FF00FF007A8486000F65
      900014D0FE0011D2FF000ED0FF000CCFFF000ACEFF0008D2FF0000C6FA000B6A
      A000FFFFFF00FFFFFF00EBFFFF00D4FFFF00C2FFFF00AEFBFF009AF6FF008EF4
      FF008AF3FF0089F3FF008BF4FF0092F5FF0099F6FF009EF7FF009AFCFF0091FF
      FF009DE5E700ACAC8C00BB8D4F00C5823400CB7B2600C9833200C3905200BDB8
      9400CBF9F30030A6D70033546E007B848700FF00FF00FF00FF00FF00FF00FF00
      FF007C8588007B351B00ECD4C300FFFFF700FFFAF000FFBE7E00FFEED700FFFF
      FE00FFC28800FFDBB700FFF3E200FFEDD600FFE9CF00FFFFF800D6B3A800AE4F
      1000EEBA6D00E5AF6500FDF8F100F9E5D400F7DFC900F7DDC600F7DCC300F6D9
      BF00F6D7BC00F5D5B900FCDDBA00E6B990001B1398009C9FF30016149F00F1C7
      A200F8CCA100F2C59D00F1C39A00F1C29700F0BF9300F0BD9000F1C09000E9B4
      8C009237090079828400FF00FF00FF00FF00FF00FF00FF00FF00767F8100994D
      2500FFF1D000FFE8C500FFE7C400FFE7C500FFE8C600FFE8C600FFE8C700FFE9
      C700FFE9C800FFE9C900FFE9CA00FDE7C700FBE2C200F7DABA00F2D1AF00EBC4
      A000E2B28C00EDAE7800433667001F71FF000545FF00000BCE0038317000FFFF
      DB00FFF1D500FFFFEA00C6845D0079726F00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F898C00764C3A00E1C5
      BC00F5E8EB00D8C1BD00DCC9D100CEAD8600E2AF5400FFD38E00FFCD8200FFCB
      7F00FFCA7B00FFC97800FFC77500FFC67200FFC56F00FFC36B00FFC46900FFD3
      6B00CA984F0055514D00545B61002D552C001EB6460036FC8D0000791600B6BF
      AB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EEF4F000EAECEC00FFFF
      F600FFF8F300FFF6EF00FFFFFF009090900051565800FF00FF007A8486000D65
      90001FD4FE001DD6FF001BD4FF0019D3FF0017D3FF0015D2FF0013DEFF00008A
      C100236E9C005991B3008AA9C300ABBCD000CAD0DD00EAE5EC00FFFAFA00FEFF
      FF00FCFFFF00F1FFFF00D5FFFF009EF8FF0092F7FF009CF7FF009DF9FF009FF9
      FF009FFFFF009CFFFF009DFFFF009EFFFF00A0F9FF00ACFFFF00ADFFFF00ABFF
      FF00B7FFFF008FE7EE000B5582006B737500FF00FF00FF00FF00FF00FF00FF00
      FF007D86890088371100F8EBE000FFFEF500FFFBF600FFC69200FFD0A400FFEF
      DE00FFB67100FFEBD500FFF1E100FFEFDA00FFECD600FFFFFF00B1634800CA7E
      3800ECB86B00E5AF6500FDF9F200F9E6D600F8E0CB00F7DFC800F7DDC500F7DB
      C200F6D8BE00F6D7BB00FCDCBD00E8BC97001C149900989CF2001614A000F1C9
      A400F8CEA300F2C7A000F2C59C00F1C39900F1C19600F0BF9200F2C29100ECB6
      8A009037090079828400FF00FF00FF00FF00FF00FF00FF00FF0070797B00B064
      3700FFF8D700FFE8C700FFE8C700FFE8C700FFE9C800FFE9C900FFE9C900FFEA
      CA00FFEACB00FFEACB00FFEACB00FCE6C700F9E0C000F4D6B500EECAA700E4B8
      9400D9A27800E09B650039326D002B81FF000A45FF000033FF000000A9007668
      8500FFFFE200FFFFEC00B46A3F0079828500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007D878900784A3500E8D2
      CA00F1E5E600D9C2C000DFCAD200CDAA7800E7B45E00FFD59300FFCF8700FFCD
      8400FFCC8000FFCA7D00FFC97900FFC87700FFC77400FFCB7100FFCE6D009D7F
      53005C616B00D9DCE400FFFFFF00B29DAE004F5B5B00028C2A00668D5E00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009CC8E1002088E4001E89EA0066A8
      DA00FCFAF700FEFEFE00F7F7F70037373700FF00FF00FF00FF007A8486000E65
      90002AD8FE002ADAFF0027D8FF0025D7FF0023D7FF0021D6FF001FD6FF001CD8
      FF000ABEEF0000AEE0000099CF000089BE00007DB3000077AE000F74A7002679
      A6003E84AD006694B600DAE5ED00FFFFFF009CF9FF0095F8FF009EFAFF00A0FA
      FF00A1FBFF00A2FBFF00A2FCFF00A3FDFF00A3FAFD00AEFEFF00AEFFFF00ACFF
      FF00ACFFFF00B8FFFF001F81AE004A5D6800FF00FF00FF00FF00FF00FF00FF00
      FF00808A8C0088381400F5EBE100FFFFF900FFF9F100FFF5EA00FFBC7E00FFAF
      6700FFDDBE00FFF7ED00FFF1E000FFEFDA00FFFFF400F2E6E3009E380500E9B2
      6700E7AF6500E5AF6600FEF9F300F9E7D800F8E2CD00F8E0CB00F7DEC700F7DC
      C400F6DAC100F6D8BD00FCDDBF00E8BE9A001C159800999FF3001715A000F1CA
      A600F9CFA600F2C8A200F2C69F00F1C49B00F1C29800F1C09500F2C39600EDBA
      8B009237070079828400FF00FF00FF00FF00FF00FF00FF00FF006E6A6800BF79
      4C00FFFDDD00FFE9C900FFE9C900FFEACA00FFEACB00FFEACB00FFEACC00FFEB
      CD00FFEBCD00FFEBCE00FDE9CC00FBE5C700F8DDBE00F2D3B300EBC5A300E1B3
      8E00D79F7400DF9D6B00343170003791FF00104EFF00002DF5000031F2000000
      7B00DBCABA00FFFFF1009C4F28007D868900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B8487007F493200F1DE
      DA00EEDFE000DAC3C100E0CBD200CAA56D00EABC6800FFD79700FFD18C00FFCF
      8900FFCE8500FFCC8200FFCB7E00FFCA7B00FFD67900F8C576005D5A52003430
      3800D5CACA00FFFFFF00ECECEC00DADCDA00847B8100424E3D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFE00348FD900148BFF002697FF00067C
      E400E7F0EE00FFFFFF007272720054595B00FF00FF00FF00FF007A8486000D64
      900038DBFE0036DEFF0033DCFF0031DBFF002FDBFF002DDAFF002BD9FF0029D9
      FF0028DDFF0028E0FF0026E1FF0024E2FF0021E0FF001ADCFF0012D0FD000AC4
      F40002B8E900009FD40000629800DEE9EF00FEFFFF009DFAFF009DFAFF00A1FB
      FF00A2FBFF00A2FCFF00A3FCFF00A3FDFF00A4FAFC00ADFEFE00ADFFFF00ABFF
      FF00A9FFFF00B7FFFF0067C4D9001C4F7400757D8000FF00FF00FF00FF00FF00
      FF00FF00FF00803C2500E9D0C300FFFFFF00FFF9EF00FFFDFA00FFEFDD00FFC4
      8F00FFFEF800FFF4E600FFF2E200FFF6E600FFFFFF00AF634500BF6D2900ECBB
      6F00E3A85E00E4AE6700FEFBF700FAE8D900F8E3D000F8E1CD00F8DFCA00F7DD
      C600F7DBC300F6D9C000FDDEC100E8BF9C001D1699009BA3F40017159F00F2CB
      A800F9D1A800F3CAA500F2C7A100F2C59D00F1C39A00F1C29700F2C49800EEBB
      8D009237080078818400FF00FF00FF00FF00FF00FF00FF00FF006E5E5900CE93
      6B00FFFCDE00FFEACB00FFEACC00FFEBCC00FFEBCD00FFEBCE00FFECCF00FFEC
      CF00FFECD000FFECD100FDE9CC00FAE4C700F6DBBD00F0D0B000E9C2A000DFB0
      8D00D69E7900DF9D6E00373370003D9BFF00195BFF00002EF7000031E8000018
      D1003F3E7E00FFFFE2008A401A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0079828400874F3700F8EC
      EB00EAD9D900DDC4C300E0CBD400C9A36300F0C17400FFD89A00FFD29000FFD1
      8D00FFD08A00FFCE8700FFD28400FFDD8100BBA373000F547800018DC00024AC
      CD00375A620088736F00F0EEED00E1E1E10079797900928F9200FFFFFF00FFFF
      FA00969BE000767DDF00C7C8E800FFFFFF00CDE1EB004B9CDD003F96DF00A2C9
      E100FFFFFF009999990035383800FF00FF00FF00FF00FF00FF007A8486000E64
      900043DFFE0042E2FF003FE0FF003DDFFF003BDEFF0039DEFF0037DDFF0035DC
      FF0034DCFF0031DBFF002FDBFF002EDAFF002BD9FF0029D9FF0028D9FF0026DC
      FF0026DCFF0027E7FF000AB5E50006619500EDF0F600F8FFFF009DFCFF00A0FC
      FF00A4FCFF00A4FDFF00A4FDFF00A4FDFF00A4FAFD00ABFEFE00ABFFFF00A9FF
      FF00A8FFFF00ABFFFF00A1FDFF000366990062696B00FF00FF00FF00FF00FF00
      FF00FF00FF007F584B00CA977D00FFFFFF00FFFBF500FFF9F300FFF9F400FFF8
      F000FFF6EC00FFF5E600FFFCF000FFFFFF00CA978600A03A0000E6B36500E0A8
      5D00DEA25500E2B16E00FFFFFE00F9E8D600F9E5D300F8E3CF00F8E1CC00F7DF
      C900F7DDC500F7DBC200FCE0C300E8C09C001B179A009DA5F50017159F00F2CC
      AB00F9D2AB00F3CBA700F3C9A300F2C7A000F2C59C00F1C39900F2C69B00EEBD
      90009238080079828400FF00FF00FF00FF00FF00FF00FF00FF006E524A00DEAF
      8A00FFFADE00FFEBCE00FFEBCF00FFECCF00FFECD000FFECD100FFEDD100FFED
      D200FFEDD300FEECD200FCE8CE00F9E2C700F5D9BD00EFCEB000E7C0A000DFB0
      8F00D7A07C00E3A072003F376E0042A2FD002267FF00002FFA00002DE5000033
      F20000059B00C7AD9E00874D2C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00767F810092563D00FFF8
      F800E7D5D400DEC5C400E0CBD300CAA35B00F5CA8200FFDA9E00FFD49500FFD3
      9200FFD28F00FFD38C00EFCA8700617F7C0000598C003AC0E00042DDFA0048F1
      FF0022DCFF0014758D0067595400E3E0DF005D5D5D00DEDEDE00FFFFFF00606D
      D8000007F900001FFF00000AE300D2D0E900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009D9D9D002E303100FF00FF00FF00FF00FF00FF00FF00FF007A8486000F64
      90004FE3FE004FE7FF004CE4FF0049E3FF0047E3FF0045E2FF0043E1FF0041E0
      FF0040E0FF003EDFFF003BDFFF003ADEFF0037DDFF0035DDFF0034DCFF0032DB
      FF002FDBFF002EDAFF0032E9FF000AAEDB000E659900F8F8FA00F2FFFF009DFD
      FF009FFDFF00A4FDFF00A4FDFF00A5FEFF00A4FBFD00A9FEFE00AAFFFF00A8FF
      FF00A6FFFF00A4FFFF00B5FFFF00389DC0003D5E6F007B858700FF00FF00FF00
      FF00FF00FF00FF00FF009A360800FAF6F000FFFFFF00FFFDF900FFFBF500FFFB
      F500FFFFFD00FFFFFF00FFFFFF00BF826A009A340000DDA55800DDA55900DBA2
      5600D6984300E9C69600FFFEFF00F9E5D500F9E6D500F9E4D200F8E2CE00F8E0
      CB00F7DEC800F7DCC400FDE0C500E8BF99001E199E009EA8F5001716A000F2CD
      AD00FAD3AD00F3CCA900F3CAA600F2C8A200F2C69F00F2C49C00F3C79D00EFBF
      9300933807007A838500FF00FF00FF00FF00FF00FF00FF00FF006F4B3F00E7BF
      9C00FFF8DF00FFECD000FFECD100FFEDD200FFEDD200FFEDD300FFEDD400FFEE
      D500FFEED500FEECD300FBE8CF00F8E1C700F4D8BE00EECDB100E7C0A100E0B1
      9100D8A38100E7A474004D3A670043A4F8002C76FF000033FE00002DEA000031
      E5000020E300472F590084553B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00737B7D00A0614500FFFB
      FD00E2CFCF00DFC8C800DECACF00CBA15700F9D19200FFD9A200FFD69A00FFD5
      9700FFD39300FFDC9100BFB0870000427F000C98CE0020A7D50079F3FE0065EB
      FE0025C1E70036F1FF001F8BA9005648420088878600FFFFFF00FFFFFF007E87
      DB00000BEE00001AF700001CDD00E3DEF000FFFFFF00FFFFFF00FDFDFC007474
      740036393A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A8486000E65
      90005AE9FE005CEBFF0058E9FF0056E8FF0054E7FF0052E6FF0050E6FF004EE5
      FF004CE4FF004AE3FF0048E3FF0046E2FF0044E1FF0042E1FF0040E0FF003EDF
      FF003CDFFF003ADEFF0038DDFF003DEDFF000DA4D500186B9D00FFFFFE00F7FF
      FF00B5FFFF00A8FFFF00A2FFFF009EFEFF009BFCFE00A2FEFF00A3FFFF00A4FF
      FF00A4FFFF00A2FFFF00ABFFFF007EE1EB0019608C006D757700FF00FF00FF00
      FF00FF00FF00FF00FF00886B6100A24A1E00F2E2D700FFFFFF00FFFFFF00FFFF
      FF00F6EBEA00CD9F8E009D3F1300A94C0500DBA45500D8A25300D69C5000D59B
      4E00D2934000F8EEE300FDF6EE00FAE9D800F9E7D700F9E6D400F8E3D100F8E2
      CD00F8DFCA00F7DEC700FCE0C300E8BC97001F1AA000A0AAF6001714A000F2CF
      AF00FAD5AF00F4CEAB00F3CCA800F3CAA500F2C8A100F2C69E00F3C8A000EEBE
      9200913909007F888B00FF00FF00FF00FF00FF00FF00FF00FF0072443300ECC9
      AB00FFF8DE00FFEDD300FFEDD300FFEED400FFEED500FFEED600FFEED600FFEF
      D700FFEFD800FDECD400FBE8D000F8E1C700F3D8BE00EECDB200E8C1A500E1B4
      9600D8A58800EDAF81005E3F64003F9EEA003687FF00043AFF00002CEE00002D
      DD000033FF000006800073534400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0072767600A86C5100FFFF
      FF00E1CDCC00E0CACA00DDC8C700CCA15000FDD8A000FFDBA400FFD89F00FFD7
      9C00FFD69900FFD49500FFE1950079887E00005A950030C3E50039BEE0003DBF
      DD006EF0FF0051DFF90020D6FF0019546A007A767800FFFFFF00FFFFFF00FFFF
      FF00D7D8FB00B5B7F300FFFFFF00FFFFFF00F7F8F800A6A6A60039393900575D
      5E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A8486000F65
      900068EDFE0068F0FF0064EDFF0062ECFF0061EBFF005EEBFF005CEAFF005BE9
      FF0058E9FF0056E8FF0054E7FF0052E6FF0050E6FF004EE5FF004CE4FF004AE4
      FF0048E3FF0046E2FF0044E1FF0042E1FF004AF2FF000BA0CD002772A000D1DA
      E400ECF2F600F1FFFE00F3FFFF00ECFFFF00DCFFFF00CEFFFF00BEFFFF00ADFF
      FF00A3FFFF009BFFFF0099FFFF00A5FFFF00147DA9004D5D6600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008B7A73008E351300A7532200B2633E00A248
      17009E3C0300A74B0500C8863700DBA55500D3994B00D1974A00D1974900CA87
      2D00E6C69A00FFFFFF00FAEDDE00FAEBDD00FAE9DA00F9E7D600F9E5D300F8E3
      D000F8E1CC00F8E0CA00FBDDBF00E8C09C001D1CA200A1ADF7001715A100F3D0
      B100FAD6B200F4CFAE00F3CDAA00F3CBA700F3C9A400F2C7A000F8CDA700E5AE
      8200863C1D00FF00FF00FF00FF00FF00FF00FF00FF007F898C00773E2700F1D6
      BA00FFF8E000FFEED500FFEED600FFEFD700FFEFD800FFEFD900FFF0D900FFF0
      DA00FFF0DA00FDECD500FBE7D000F7E0C900F3D8C000EECEB600E9C3AA00E2B8
      9C00DEAF9200EFB88E00764F68002F7CCC00439CFF000A42FF00002CF100002D
      DE000034F6000020CD003B3951007E878A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00716F6E00AD745E00FFFF
      FF00E0CCCB00E0CBCE00DCC6C000CDA24E00FFDEAB00FFDCA800FFDAA400FFD9
      A100FFD89E00FFD69B00FFD79700FFE19600527378000071A40026ADD80036B6
      DA007BEFF9004CD7F0003ECEED00205C7400754B26003B3C4000757D86009CA4
      AA00B7BBB500B7B8A900959690006061610036363800454C4E00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A8486001065
      900073F1FE0074F4FF0070F1FF006EF0FF006CEFFF006AEFFF0068EEFF0067ED
      FF0064EDFF0062ECFF0061EBFF005EEBFF005CEAFF005BE9FF0058E9FF0057E8
      FF0054E7FF0052E6FF0050E6FF004EE5FF004DE5FF0051F2FF001DA8D3000179
      AB000E77A9001D76A600327FA9005792B80085B6CF00A3CEDE00BCE2EC00D5F8
      FB00D9FFFF00D9FFFF00CEFFFF00D3FFFF0074D2E100215375007A838500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00843B2B00C3876D00ECD4
      B500C9892D00D0953F00CE964400CD914200CC914200C98B3700C6812800E0B8
      8800FFFFFF00FCF3EB00FBEEE200FAECE000FAEADC00FAE8D900F9E6D500F9E4
      D200F8E2CF00F8E1CE00FAD9B500EAC5A4001E1DA400A3AFF8001815A100F3D1
      B300FAD7B400F4D0B000F4CEAD00F3CCA900F3CAA600F2C8A200FEDDB600BF6F
      410081605300FF00FF00FF00FF00FF00FF00FF00FF007E878A007D3A1D00F8DE
      C500FFF6DF00FFEFD800FFF0D900FFF0DA00FFF0DA00FFF0DB00FFF1DC00FFF1
      DC00FFF0DC00FCECD700FAE7D200F7E1CB00F3D9C300EFD0B900E9C6AD00E5BD
      A200E0B49800EEBD9900A7797A002053A8004DACFF00104AFF00002DF500002D
      E0000030E9000033F80012145D00737C7F00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00706A6600B7836D00FFFF
      FF00E0C8C800E2CCD000DBC2B700D0A55200FFE2B400FFDEAD00FFDCA900FFDB
      A600FFDAA300FFD8A000FFD79C00FFD89900FFE1970054737700005E94004FD5
      EB0043C8E60056D7F0002796BE0087867100FFDA7700D99F58009E7440007D60
      370077644700685D5C007D73740091695A00745D5100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B8487001066
      900081F5FE0081FBFF007CF5FF007BF4FF0078F4FF0076F3FF0074F2FF0072F1
      FF0071F1FF006EF0FF006DF0FF006AEFFF0068EEFF0067EEFF0065EDFF0063EC
      FF0061EBFF005EEBFF005DEAFF005BE9FF0058E8FF0057E8FF005AF1FF0057F1
      FF004DE8FF0041DAF70032CAEB0028BDDF000070A4001E57800024678E00146A
      98001A74A5003284AE00549FBF007BBDD30086CADD0002669A007D888C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008F361100DCB9
      A900FCF9E800DBB27700CC914300C98D3B00CA8B3A00D1A15E00F0DEC400FFFF
      FF00FEF8F400FCF2E800FBF0E600FBEEE200FAECDF00FAEADB00F9E8D800F9E6
      D400F9E4D200F6DDC400FAD5B500EBCBB0001E1EA200A5B1F9001816A200F3D3
      B600FBD9B600F5D2B200F4D0AF00F4CEAC00F3CCA800FDDCB800E5AF88008F32
      0C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007C858800833A1800FBE7
      D000FFF6E100FFF0DA00FFF0DB00FFF1DC00FFF1DD00FFF1DD00FFF2DE00FFF2
      DF00FEF1DE00FCECD900FAE8D400F7E2CE00F4DBC600EFD2BB00EBC9B100E6C1
      A700E4BEA300E8BE9E00CEA08C001C38890051B4FF001757FF00002EF700002D
      E200002EE1000039FF00010E8B00666E7000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006F635D00C3968400FFFF
      FF00E0C8C800E3D0D200DABFAE00D2AB5700FFE7BD00FFE0B100FFDEAD00FFDD
      AA00FFDBA700FFDAA400FFD9A100FFD89E00FFD99B00FFE39C00858F7E000053
      84000B89B90052D5EC00095E8800F0C17E00FFD48300FFD58300FFD88200FFD8
      7700FFE6A300E4CBC700E2CDCD00B9816E0079645B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000F68
      950093FFFF008DFDFF0089F9FF0087F8FF0085F8FF0083F7FF0081F6FF007FF6
      FF007DF5FF007BF4FF0078F4FF0077F3FF0075F2FF0072F2FF0070F1FF006FF0
      FF006FF2FF006CF0FF0069EFFF0067EEFF0065EDFF0063ECFF0061ECFF005FEB
      FF005DEBFF005FEEFF005EEFFF0064FEFF002298C100566C7800FF00FF00FF00
      FF00FF00FF007B909A00678595004C779200346E910028719800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008A3D
      2900B3684200E1C5B900EBD9CB00F1E0CF00F8F0E800FFFFFF00FFFFFF00FFFF
      FE00FFFFFA00FFFFFE00FFFFFE00FFFFFA00FFFFF800FFFEF500FFFCF200FFFA
      EC00FFF3E300FFECD600FFF0D300F6DFCC001F1EA500A6B3F9001817A300F6DA
      C100FDE0BE00F7D6BA00F5D3B400F9D6B500FFE3C400EBB9920099360400887D
      7700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B858700883D1900FDED
      D800FFF6E300FFF1DE00FFF2DE00FFF2DF00FFF2DF00FFF2E000FFF3E100FFF3
      E100FEF1E000FCEDDC00FAEAD700F8E4D100F4DDC900F0D5C000ECCDB600E9C8
      B100E6C0A800E6C1A800F1C5A7002D2E740049ABFF002268FF00002FFA00002D
      E800002DDF000037FF00001EBE003F445C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006F5A5000CDAA9B00FFFE
      FF00E0C8C800E3D1D600D8BCA400D9B16300FFEAC500FFE1B600FFE0B300FFDF
      AF00FFDDAC00FFDCA900FFDBA600FFDAA300FFD89F00FFD89D00FFE89D00D8BF
      8E004B7179000150820047747D00FFDD8A00FFCE8600FFCD8300FFCC8000FFCA
      7500FCD69F00D0B9B900D3BFBF00AA756000776C6500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002363
      8B006ACFE000A6FFFF0095FDFF0093FDFF0091FCFF008FFBFF008DFAFF008BFA
      FF008AF9FF0087F8FF0085F8FF0084F7FF0081F6FF007FF6FF007EF5FF0081FA
      FF007BF5FF007EF9FF0081FEFF007FFFFF007FFFFF007BFFFF0077FBFF0075F9
      FF006FF5FF0069F0FF0067EFFF006CFAFF002496BF004C697900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008C807A008B49380090421F0095441D009B451A009C431400A2461500A64D
      1D00A9532600AC5A2D00B0613700B76E4500BD7A5400C5856200CA906F00CE97
      7400D39D7B00D7A58400E0AF8B00DBAC8D001F1EA100ABB9FC001716A100EFCA
      AD00F8D8BA00F5D4B800F6D8BA00F0CBA800C9875A00953002008A7D7600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B8487008D401900FFF2
      DF00FFF7E400FFF2E000FFF2E000FFF3E100FFF3E200FFF3E300FFF4E300FFF4
      E400FEF2E300FCEEDF00FAEBDB00F8E6D500F5DECD00F1D7C400EDD1BC00EBCA
      B500EAC9B400E5C5AF00FED6B500654F76003588E0002F7CFF000034FC00002D
      EB00002DDE000033F700002DED00202354007A848600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0071534600D6B9AC00FDF8
      FC00E0CAC800E6D2D800D3B59100E0BD7200FFF3D400FFEAC600FFEAC400FFE7
      BF00FFE5BB00FFE4B800FFE2B400FFE0AE00FFDEAA00FFDAA600FFD9A000FFE0
      9F00FFE39B00EDC79000F4CC8F00FFD38F00FFD08B00FFCF8700FFCE8400FFCD
      7D00F9D5A600CFB8B900D4C1BE00A76E550078747100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A8A
      910007699E00A5FEFF00A9FFFF00A0FFFF009EFFFF009CFFFF0099FEFF0097FE
      FF0096FDFF0093FDFF0091FCFF0090FBFF008EFAFF008BFAFF009AFFFF004CB7
      D200076297001479A8001C84AF002A95BB003BA9CA0048B8D50050C6DE005BD1
      E80067E0F20070EEFD0074F4FF0083FFFF002D9FC50050718200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008E8B89008E8682008D817C008C7B75008B7169008A685D00895F
      52008A5848008A5240008F4F3A00813C290015169B00B3C4FF000E0A9300903B
      1200A6440E00AA450600AC4904009A3D0E008A534000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A8486008F421A00FFF5
      E400FFF6E700FFF3E200FFF3E300FFF4E400FFF4E400FFF4E500FFF5E600FFF5
      E700FEF3E600FCEFE100FAECDD00F8E7D700F5E1D000F1DAC800F0D6C400EDD0
      BD00EBCCB800EBCDBA00FCDDC300A28290002161B9003B91FF00053AFD00002C
      EE00002DDE000031EE000036FF00090E6800737C7F00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0074503F00DFC4BB00FBF4
      F600E0CAC800E7D2D900D7B89500CCA35100D8B36D00DCB67100E0BD7600E5C0
      7B00E8C27D00EBC78200EEC98700F4CC8B00F8D29300FBD59900FDD79A00FFD7
      9A00FFD89D00FFDE9D00FFDD9D00FFD89A00FFD79800FFD69500FFD49200FFD5
      8A00F6D6AE00CEB8BA00D5BFBB00A2644B00787D7E00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00446E8900419DC000C6FFFF00AFFFFF00ACFFFF00AAFFFF00A7FFFF00A5FF
      FF00A3FFFF00A0FFFF009EFFFF009CFFFF009AFFFF009EFFFF0096FDFE000265
      99007E8B9000FF00FF007C919B006F8A98005C7F940047759100376E90002A69
      90001D699300136C99000F74A3001980AD000B72A30062839400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00778082000B12A900BFCAFE0004099A003D42
      4300484D4F004C51530050565700565D5F0069717300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A84860092431B00FFF7
      E800FFF6EA00FFF5E500FFF4E600FFF5E700FFF5E700FFF6E800FFF6E900FFF6
      EA00FEF5E800FCF0E400FBEEE000F8E9DB00F5E3D300F4DFCF00F0D8C700F0D8
      C800EED5C400EDD1C000F3D7C300D9B8AF0019398F00409FFF000A42FF00002C
      F200002DDF00002FE900003AFF00000E8E006A727800FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007F898C00764C3A00E5D1CA00F7EF
      F300E1CBCB00E4CFCF00E3CFD000E0CAC800DDC4BC00DAC1B300D6BBAA00D4B9
      A300D3B69900D1B28B00CDAC7E00CDAA7700CDAA7100CEAA6C00CFA96800D0A9
      6100D1A95C00D5A95700D8AB5800DDB15D00E3B45F00E6B66200E9B76200F0BF
      6300EED0AD00CFBBBD00D3BAB5009A5B3F0079828400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00105A8C0094DDEA00CFFFFF00BAFFFF00B7FFFF00B5FFFF00B3FF
      FF00B1FFFF00AEFFFF00ACFFFF00AAFFFF00A7FFFF00BAFFFF004CAFCA003C69
      8600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007A929C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007780820014169C00C1CDFF00060DAA000304
      9C0006079400090A8A000E0F7D00131478002A2D7C007B848700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007A84860092431B00FFF9
      EB00FFF8EA00FFF6E800FFF6E900FFF6E900FFF6EA00FFF6EB00FFF7E900FFF7
      EA00FFF6E900FCF2E700FBEFE100F9EBDE00F6E5D500F5E3D500F3DED000F0D7
      C800F0DACB00F0DACC00F1DACD00FFEBD2003B397B003188F7001453FF00002D
      F500002DE100002FE3000038FF000016A1005F667300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007D868900794A3500ECDFD900F5EC
      ED00E2CCCC00E5CFD000E4CFD000E3CFD000E3CED200E2CDD200E2CFD200E1CE
      D300E0CED300E0CDD300DFCCD400DECBD200DDC9D000DCC8CD00DAC6CB00D9C4
      C600D7BFBF00D5BCB700D3BAAF00CFB7A600CEB2A000CDB09700CCAD8E00CBA7
      7A00D3B8A200D4BFC100CEB6AF008F5337007B848700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006F858F001373A400D9FFFF00DBFFFF00D2FFFF00CFFFFF00CCFF
      FF00C9FFFF00C4FFFF00C1FFFF00BEFFFF00C2FFFF00ADFBFD0003629700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007780820014159D00C5D2FF000B41FF00002E
      FD00002FF600002CF1000029EC000022E1000304960078818400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094461F00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFCF400FEF4EC00FEF4EC00FAF0
      E600F8E9E000F6E7DB00F6E6DB00FFFAE500A390A7000E45B500236EFF00002C
      F800002DE600002DE0000038FF000018AB005D647500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007F888B0084513A00FFFDFB00F7F0
      F300EAD7D800EAD7DB00E9D5D700E8D4D500E5D2D300E4CFCF00E3CECE00E2CC
      CC00E1CBCB00E0CAC900DFC9C800DEC8C700DDC7C600DCC6C500DBC5C400DAC4
      C300DAC4C300DAC3C200D9C2C400D8C2C400D7C1C400D7C1C300D6C0C500D5C1
      C500D3BCBD00D5C0BE00CBAEA9008A5037007D878900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00386B8B0056A5C400BAE5EE00AEE5EE00B3E8F000B5EB
      F200B7F0F400BAF3F600BCF6FA00C0F9FC00D3FFFF0050A6C500456F8900FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007780820014159D00CBD6FF001A4CFF00083D
      FF000A40FF00083DFF00053CFF00033AFF000506950078818400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094471F00B669
      4200B76E4600B86F4800B9724B00BC765000BD7A5700C2805C00C4856300C78A
      6B00C88F6F00C9917100CC977A00CF9E8300D2A18600D2A08500D7AB9300DBB6
      A000DCB7A200E0BCAA00E2C0AF00E7C9B500F3D4BD00232574001966FF000035
      FF00002DE600002DDF000037FF0000119B006F788300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0092553A00D5B5A700D7BC
      B400D4B4AF00D7BAB500DCC0BB00DEC5C300E1C9C900E3CCCC00E3CDCD00E3CE
      CF00E4CFD000E4D0D100E4D1D300E5D2D400E5D2D400E4D2D400E4D2D400E3D2
      D100E0CFD100E0CECF00DFCDCC00DECBCA00DDCAC900DCC7C800DBC6C600DAC4
      C200D9C3C000DAC7C600CAADA40084513900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF002F6E92002468910022699100206892001D69
      93001A699300176A96001468960013699800136A9A001A6A9700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007982850016169D00DBE6FF002358FF000E46
      FF001148FF000E44FF000B43FF00073FFF000707960079828500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008F8D8C008E8B89008D8886008D84
      82008D827F008D807C008C7C77008C7A74008B7670008B736B008B7068008A6D
      64008B6A5F008A665A008C6354008B5E4C00935C450076483D00001A98000541
      FF000033FC000033F100002EE70013176700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008E8A87008A6959008B5D
      4A008C5D48008D5A4600905A4400935A4100955A4100985D41009C5C41009E5E
      4300A1614800A5664C00A76A5000A96D5600AC725D00AF7B6700B5806E00B888
      7700BB8D7E00BD918200BF968900C39A8D00C49D9100C6A39800C8A69C00CAAA
      A000CCADA700D2BAB600C19A8E00875A4600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0011119D00AFB5EE005E7DF1005576
      F2005677F3005577F8005579FB005174FA00090C9900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0061688200060E
      7900001CB1000016A20011156900808A9300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF008F9190008E8D8B008E8A87008D8783008D827D008C7D
      75008B776D008C7367008C6D5F008A695B008B6757008B6351008C614E008D60
      4B008E5E4900915C4500935E45008C807A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0031359600262990002A2A90002A2A
      9100292993002727930027279400232196001F239700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007881
      9000464B76004E547B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00424D3E000000000000003E000000
      28000000A8000000540000000100010000000000E00700000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFC000000000000000000000
      0000000000000000F83FFFFFFFC0000000000000000000000000000000000000
      F000007FFFC0000000000000000000000000000000000000E00000001FC00000
      00000000000000000000000000000000E00000000FC000000000000000000000
      0000000000000000E00000000FC0000000000000000000000000000000000000
      E00000000FC0000000000000000000000000000000000000E000000007C00000
      00000000000000000000000000000000E000000007C000000000000000000000
      0000000000000000E000000007C0000000000000000000000000000000000000
      E000000007C0000000000000000000000000000000000000E000000003C00000
      00000000000000000000000000000000E000000003C000000000000000000000
      0000000000000000E000000003C0000000000000000000000000000000000000
      E000000003C0000000000000000000000000000000000000E000000001C00000
      00000000000000000000000000000000C000000001C000000000000000000000
      0000000000000000C000000001C0000000000000000000000000000000000000
      C000000001C0000000000000000000000000000000000000C000000000C00000
      00000000000000000000000000000000C000000000C000000000000000000000
      0000000000000000C000000000C0000000000000000000000000000000000000
      C000000000C0000000000000000000000000000000000000C000000000400000
      00000000000000000000000000000000C0000000004000000000000000000000
      0000000000000000C00000000040000000000000000000000000000000000000
      C00000000040000000000000000000000000000000000000C000000000400000
      00000000000000000000000000000000C0000000000000000000000000000000
      0000000000000000C00000000000000000000000000000000000000000000000
      C00000000000000000000000000000000000000000000000C000000000400000
      00000000000000000000000000000000C00000003FC000000000000000000000
      0000000000000000C00000003FC0000000000000000000000000000000000000
      800000003FC0000000000000000000000000000000000000800000003FC00000
      00000000000000000000000000000000800000003FC000000000000000000000
      0000000000000000C00000003FC0000000000000000000000000000000000000
      C00000007FC0000000000000000000000000000000000000FFC000007FC00000
      00000000000000000000000000000000FFFFFFFFFFC000000000000000000000
      0000000000000000FFFFFFFFFFC0000000000000000000000000000000000000
      FFFC0FFFFFFFFFFFFC1FFFFFFFC1FFFFFFFFC07FFF000000FFE000FFFFFFFFFF
      F007FFFFFF007FFFFFFE0000FF000000FF80007FFFF3FFFFC001FFFFFE003FFF
      FFFC00001F000000FF00001FFFE03FFF8000FFFFFE003FFFFFF000000F000000
      FE00000FFFC003FF00007FFFFE003FFFFFE000000F000000FC00000FFFC0001E
      00003FFFFE003FFFFFC000000F000000F8000007C3C0000000003FFFFE003FFF
      FF8000000F000000F800000783C0000000001FFFC0003FFFFF0000001F000000
      F800000003C0000000001FFC00003FFFFE0000001F000000F000000003C00000
      00001FC000003FFFFC0000001F000000E000000003C0000000000F00000003FF
      FC0000003F000000C000000003C0000000000E000000003FF80000003F000000
      C000000001C0000000000E0000000007F00000003F000000C000000000C00000
      00001E0000000003F00000003F000000C000000000C0000000001C0000000003
      F00000007F000000C00000000040000000001C0000000003E00000007F000000
      C00000000040000000001C0000000003E00000007F000000C000000000000000
      0000380000000003E00000007F000000C0000000000000000000780000000003
      E00000007F000000C0000000000000000000780000000003E0000000FF000000
      C0000000000000000000F80000000003C0000000FF000000C000000000000000
      0001F00000000003C0000000FF000000C0000000004000000000F00000000003
      C0000000FF00000080000000004000000000F00000000003C0000000FF000000
      8000000000C000000000F00000000003C0000000FF0000008000000000C00000
      0000780000000003C0000001FF0000008000000001C000000000780000000003
      C0000001FF0000008000000003C0000000003C0000000003C0000001FF000000
      8000000007C0000000003C0000000003C0000001FF000000800000000FC00000
      00003E000000000780000000FF000000800000003FC0000000001F8000000007
      80000000FF000000800000007FC0000000001FC00000000F80000000FF000000
      800000007FE0000000383FE00000000F80000000FF000000800000007FE00000
      003FFFF00000001F800000007F000000800000007FE00000003FFFFFF800007F
      800000007F000000800000007FF00004003FFFFFFFFE007F800000007F000000
      000000007FF8000FFF7FFFFFFFFE003F800000007F000000000000007FF8001F
      FFFFFFFFFFFE003FC00000007F000000000000007FFC001FFFFFFFFFFFFE003F
      C00000007F00000080000000FFFE003FFFFFFFFFFFFE003FFF000000FF000000
      80000000FFFFFFFFFFFFFFFFFFFF007FFFFFFFC0FF000000FFFC0000FFFFFFFF
      FFFFFFFFFFFF007FFFFFFFE3FF00000000000000000000000000000000000000
      000000000000}
  end
  object EmailSender: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL
    MailAgent = 'AceBackup 3'
    SASLMechanisms = <>
    Left = 340
    Top = 360
  end
  object Msg: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    ContentTransferEncoding = '8bit'
    Encoding = meMIME
    FromList = <
      item
      end>
    Organization = 'AceBackup'
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 376
    Top = 384
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':25'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv3
    SSLOptions.SSLVersions = [sslvSSLv3]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 408
    Top = 416
  end
end
