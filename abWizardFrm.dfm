inherited frmNewProjectWizard: TfrmNewProjectWizard
  Left = 374
  HelpContext = 1100
  Caption = 'New project wizard'
  ClientWidth = 641
  ExplicitWidth = 647
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel5: TBevel
    Width = 641
    ExplicitWidth = 641
  end
  inherited btnBack: TButton
    Left = 377
    ExplicitLeft = 377
  end
  inherited btnNext: TButton
    Left = 461
    ExplicitLeft = 461
  end
  inherited btnCancel: TButton
    Left = 553
    ExplicitLeft = 553
  end
  inherited PageControl: TPageControl
    Width = 641
    ActivePage = ts1
    ExplicitWidth = 641
    object ts1: TTabSheet
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          633
          386)
        object Label34: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 601
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Welcome to the New Project Wizard!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 240
        end
        object Label35: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 597
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'Please specify the project name and where do you want to store y' +
            'our backups.'
          WordWrap = True
          ExplicitWidth = 382
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Project &name:'
          FocusControl = edtTitle
          ExplicitWidth = 67
        end
        object Label28: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 109
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Do not use symbols (i.e.,  / \ : * ? " < > |)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 201
        end
        object Label24: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 138
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'You can specify one or more destinations.'
          FocusControl = edtTitle
          ExplicitWidth = 201
        end
        object edtTitle: TEdit
          AlignWithMargins = True
          Left = 36
          Top = 84
          Width = 577
          Height = 21
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          TabOrder = 0
        end
        object lvVolumes: TListView
          AlignWithMargins = True
          Left = 36
          Top = 155
          Width = 577
          Height = 173
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Columns = <
            item
              Caption = 'Volume'
              Width = 75
            end
            item
              Caption = 'System'
              Width = 100
            end
            item
              AutoSize = True
              Caption = 'Destination'
            end>
          ColumnClick = False
          GridLines = True
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnDblClick = lvVolumesDblClick
        end
        object cbSyncMode: TComboBox
          Left = 36
          Top = 345
          Width = 273
          Height = 21
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          Style = csDropDownList
          Anchors = [akLeft, akBottom]
          TabOrder = 2
        end
        object btnAddVolume: TButton
          Left = 333
          Top = 345
          Width = 88
          Height = 23
          Anchors = [akRight, akBottom]
          Caption = '&Add...'
          TabOrder = 3
          OnClick = btnAddVolumeClick
        end
        object btnEdit: TButton
          Left = 429
          Top = 345
          Width = 88
          Height = 23
          Anchors = [akRight, akBottom]
          Caption = '&Edit...'
          TabOrder = 4
          OnClick = btnEditClick
        end
        object btnDelete: TButton
          Left = 525
          Top = 345
          Width = 88
          Height = 23
          Anchors = [akRight, akBottom]
          Caption = '&Delete'
          TabOrder = 5
          OnClick = btnDeleteClick
        end
      end
    end
    object ts2: TTabSheet
      ImageIndex = 5
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label5: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 601
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Security and Compression settings.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 228
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 597
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Define the encryption and compression options'
          WordWrap = True
          ExplicitWidth = 225
        end
        object Label22: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = '&Files format:'
          FocusControl = cbFileFormat
          ExplicitWidth = 60
        end
        object Label23: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 259
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = '&Compression:'
          FocusControl = rbCompression
          ExplicitWidth = 65
        end
        object grpSecurity: TGroupBox
          AlignWithMargins = True
          Left = 36
          Top = 121
          Width = 577
          Height = 122
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = ' &Security: '
          TabOrder = 0
          object Label4: TLabel
            Left = 20
            Top = 24
            Width = 55
            Height = 13
            Caption = '&Encryption:'
            FocusControl = cbEncryption
          end
          object lblPassword: TLabel
            Left = 20
            Top = 56
            Width = 50
            Height = 13
            Caption = '&Password:'
          end
          object cbEncryption: TComboBox
            Left = 108
            Top = 20
            Width = 200
            Height = 21
            Style = csDropDownList
            TabOrder = 0
            OnChange = cbEncryptionChange
          end
          object edtPassword: TEdit
            Left = 108
            Top = 52
            Width = 200
            Height = 21
            PasswordChar = '*'
            TabOrder = 1
          end
          object chkMask1: TCheckBox
            Left = 328
            Top = 52
            Width = 80
            Height = 17
            Caption = '&Hide'
            Checked = True
            State = cbChecked
            TabOrder = 2
            OnClick = chkMask1Click
          end
          object chkStoreArchivePwd: TCheckBox
            Left = 444
            Top = 52
            Width = 97
            Height = 17
            Caption = '&Remember'
            TabOrder = 3
          end
          object chkAutoMangle: TCheckBox
            Left = 20
            Top = 88
            Width = 349
            Height = 16
            Caption = 'Automatically make anonymous file names on media.'
            TabOrder = 4
          end
        end
        object cbFileFormat: TComboBox
          AlignWithMargins = True
          Left = 36
          Top = 84
          Width = 577
          Height = 21
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 1
          Text = 'Proprietary (recommended)'
          OnChange = cbFileFormatChange
          Items.Strings = (
            'Proprietary (recommended)'
            'Store files "AS IS"')
        end
        object rbCompression: TComboBox
          AlignWithMargins = True
          Left = 36
          Top = 276
          Width = 577
          Height = 21
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 2
          Text = 'None'
          Items.Strings = (
            'None'
            'Fastest'
            'Default'
            'Best')
        end
      end
    end
    object ts3: TTabSheet
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 601
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'General settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 104
        end
        object Label8: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 597
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'Define versioning options, file types to include in the project,' +
            ' and Log options'
          WordWrap = True
          ExplicitWidth = 371
        end
        object Label10: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Default action on name &collision:'
          FocusControl = edtTitle
          ExplicitWidth = 154
        end
        object cbDefAction: TComboBox
          AlignWithMargins = True
          Left = 36
          Top = 84
          Width = 577
          Height = 21
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Style = csDropDownList
          TabOrder = 0
          OnSelect = cbDefActionSelect
        end
        object grpLog: TGroupBox
          AlignWithMargins = True
          Left = 36
          Top = 253
          Width = 577
          Height = 116
          Margins.Left = 36
          Margins.Top = 8
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = ' Log file: '
          TabOrder = 1
          object lblSendMail: TLabel
            Left = 24
            Top = 44
            Width = 79
            Height = 13
            Caption = '&Report by email:'
            FocusControl = cbSendMail
          end
          object lblSendMailContent: TLabel
            Left = 24
            Top = 84
            Width = 77
            Height = 13
            Caption = 'Report &content:'
            FocusControl = cbSendMailContent
          end
          object chkWriteLog: TCheckBox
            Left = 24
            Top = 20
            Width = 133
            Height = 17
            Hint = 'About|Display information about the program'
            Caption = 'M&aintain log file'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = chkWriteLogClick
          end
          object cbSendMail: TComboBox
            Left = 140
            Top = 40
            Width = 398
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 1
            Text = 'Do not send'
            Items.Strings = (
              'Do not send'
              'Send on failure'
              'Send always')
          end
          object cbSendMailContent: TComboBox
            Left = 140
            Top = 80
            Width = 398
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 2
            Text = 'Complete report'
            Items.Strings = (
              'Complete report'
              'Errors report')
          end
        end
        object GroupBox1: TGroupBox
          AlignWithMargins = True
          Left = 36
          Top = 117
          Width = 577
          Height = 124
          Margins.Left = 36
          Margins.Top = 8
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = ' File types: '
          TabOrder = 2
          DesignSize = (
            577
            124)
          object lblIncluded: TLabel
            Left = 24
            Top = 24
            Width = 117
            Height = 13
            Caption = '&Included file extensions:'
          end
          object lblExcluded: TLabel
            Left = 24
            Top = 68
            Width = 119
            Height = 13
            Caption = 'E&xcluded file extensions:'
          end
          object edtInclude: TEdit
            Left = 24
            Top = 40
            Width = 515
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object edtExclude: TEdit
            Left = 24
            Top = 84
            Width = 515
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
          end
          object btnEditIncluded: TButton
            Left = 545
            Top = 40
            Width = 24
            Height = 23
            Anchors = [akTop, akRight]
            Caption = '...'
            TabOrder = 2
            OnClick = btnEditIncludedClick
          end
          object btnEditExcluded: TButton
            Left = 545
            Top = 84
            Width = 24
            Height = 23
            Anchors = [akTop, akRight]
            Caption = '...'
            TabOrder = 3
            OnClick = btnEditExcludedClick
          end
        end
      end
    end
    object ts4: TTabSheet
      ImageIndex = 7
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 397
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          633
          397)
        object Bevel9: TBevel
          AlignWithMargins = True
          Left = 36
          Top = 117
          Width = 577
          Height = 16
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Shape = bsBottomLine
        end
        object Label21: TLabel
          Left = 36
          Top = 172
          Width = 223
          Height = 13
          Caption = '&Execute application before processing project:'
          FocusControl = edExecApp1
        end
        object Label15: TLabel
          Left = 477
          Top = 220
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Timeout:'
          WordWrap = True
        end
        object Label32: TLabel
          Left = 36
          Top = 260
          Width = 215
          Height = 13
          Caption = 'E&xecute application after processing project:'
          FocusControl = edExecApp2
        end
        object Label20: TLabel
          Left = 477
          Top = 308
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Timeout:'
          WordWrap = True
        end
        object Label27: TLabel
          Left = 592
          Top = 308
          Width = 16
          Height = 13
          Caption = 'min'
          WordWrap = True
        end
        object Label19: TLabel
          Left = 592
          Top = 220
          Width = 16
          Height = 13
          Caption = 'min'
          WordWrap = True
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 601
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Advanced settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 119
        end
        object Label9: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 577
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'You can schedule the project processing for a convenient time. T' +
            'o specify the schedule, click Schedule button.'
          FocusControl = edtTitle
          ExplicitWidth = 529
        end
        object Label7: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 597
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 'The wizard helps you to configure advanced settings of project.'
          WordWrap = True
          ExplicitWidth = 307
        end
        object lblSchedule: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 96
          Width = 477
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 120
          Margins.Bottom = 4
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          ExplicitWidth = 3
        end
        object btnEditSchedule: TButton
          Left = 532
          Top = 104
          Width = 81
          Height = 23
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = '&Schedule...'
          TabOrder = 0
          OnClick = btnEditScheduleClick
        end
        object edExecApp1: TEdit
          Left = 36
          Top = 188
          Width = 550
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object ckbWaitApp1: TCheckBox
          Left = 36
          Top = 216
          Width = 138
          Height = 17
          Caption = '&Wait termination'
          TabOrder = 2
        end
        object seTimeOutBefore: TSpinEdit
          Left = 540
          Top = 216
          Width = 47
          Height = 22
          MaxValue = 180
          MinValue = 1
          TabOrder = 3
          Value = 10
        end
        object btBrowseApp1: TButton
          Left = 593
          Top = 188
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 4
          OnClick = btBrowseApp1Click
        end
        object edExecApp2: TEdit
          Left = 36
          Top = 276
          Width = 550
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
        end
        object ckbWaitApp2: TCheckBox
          Left = 36
          Top = 304
          Width = 143
          Height = 17
          Caption = '&Wait termination'
          TabOrder = 6
        end
        object seTimeOutAfter: TSpinEdit
          Left = 540
          Top = 304
          Width = 47
          Height = 22
          MaxValue = 180
          MinValue = 1
          TabOrder = 7
          Value = 10
        end
        object btBrowseApp2: TButton
          Tag = 1
          Left = 593
          Top = 276
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 8
          OnClick = btBrowseApp1Click
        end
      end
    end
    object ts5: TTabSheet
      ImageIndex = 6
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label14: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 243
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 'The wizard verifies the settings you have entered.'
          WordWrap = True
        end
        object Label16: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 381
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'Check if the information you have entered is correct and click t' +
            'he Finish button.'
          FocusControl = edtTitle
        end
        object Label13: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 160
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Verifying project settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object memSettings: TRichEdit
          AlignWithMargins = True
          Left = 36
          Top = 88
          Width = 577
          Height = 286
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 12
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          Zoom = 100
        end
      end
    end
  end
  object odExternalApp: TOpenDialog
    Filter = 'Executables (*.exe)|*.exe|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 492
    Top = 152
  end
end
