inherited frmRestoreWizard: TfrmRestoreWizard
  HelpContext = 2
  Caption = 'Restore Wizard'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnCancel: TButton
    Left = 552
    OnClick = btnCancelClick
  end
  inherited PageControl: TPageControl
    ActivePage = ts1
    object ts1: TTabSheet
      TabVisible = False
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label34: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 600
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Welcome to the Restore Wizard!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label35: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 596
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Select folders/files you want to restore.'
          WordWrap = True
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 361
          Width = 596
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 12
          Align = alBottom
          Caption = 'To continue, click Next'
          WordWrap = True
        end
        object tvRestore: TTreeView
          AlignWithMargins = True
          Left = 36
          Top = 59
          Width = 576
          Height = 294
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alClient
          Images = imlSys16
          Indent = 19
          PopupMenu = pmContext
          StateImages = imlStateImages
          TabOrder = 0
          OnExpanding = tvRestoreExpanding
          OnGetImageIndex = tvRestoreGetImageIndex
        end
      end
    end
    object ts2: TTabSheet
      ImageIndex = 1
      TabVisible = False
      object pnlScan: TPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          632
          386)
        object Label9: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 600
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Restore settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 596
          Height = 26
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'Please specify where you want to restore you files to.'#13#10'You may ' +
            'restore the files to their original location or to arbitrary loc' +
            'ation.'
          WordWrap = True
        end
        object chkProcessImmediately: TCheckBox
          Left = 36
          Top = 364
          Width = 189
          Height = 17
          Caption = 'Process restoring immediately'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object rbOriginal: TRadioButton
          AlignWithMargins = True
          Left = 36
          Top = 80
          Width = 576
          Height = 17
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Restore to original location'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbRestoreClick
        end
        object rbAlternate: TRadioButton
          AlignWithMargins = True
          Left = 36
          Top = 105
          Width = 576
          Height = 17
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Restore to alternate location:'
          TabOrder = 2
          OnClick = rbRestoreClick
        end
        object edtAlternate: TEdit
          AlignWithMargins = True
          Left = 48
          Top = 126
          Width = 564
          Height = 21
          Margins.Left = 48
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Enabled = False
          TabOrder = 3
        end
        object chkSmartRestore: TCheckBox
          AlignWithMargins = True
          Left = 36
          Top = 171
          Width = 576
          Height = 17
          Margins.Left = 36
          Margins.Top = 20
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Smart Restore (only missing or different items will be restored)'
          TabOrder = 5
        end
        object btnBrowse: TButton
          Left = 526
          Top = 168
          Width = 86
          Height = 23
          Anchors = [akRight, akBottom]
          Caption = 'Browse...'
          Enabled = False
          TabOrder = 4
          OnClick = btnBrowseClick
        end
      end
    end
    object ts3: TTabSheet
      ImageIndex = 3
      TabVisible = False
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label7: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 600
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Processing Restore'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 596
          Height = 26
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'AceBackup is restoring selected items from the current project. ' +
            #13#10'This process can take a few minutes. To abort the process clic' +
            'k the "Cancel" button.'
          WordWrap = True
        end
        object pnlProcess: TPanel
          AlignWithMargins = True
          Left = 36
          Top = 72
          Width = 576
          Height = 310
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
        end
      end
    end
    object ts4: TTabSheet
      ImageIndex = 2
      TabVisible = False
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object lblContains: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 576
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 8
          Align = alTop
          Caption = 'Content:'
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 600
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Wizard completed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 596
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 'The wizard has finished all operations.'
          WordWrap = True
        end
      end
    end
  end
  object imlStateImages: TImageList
    Left = 144
    Top = 268
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000057120000551203005213
      00005612000055130000550F0000551300005412000053110000591100005412
      0000551001005613000000000000000000000000000056110000561100005513
      00005510000056110000520E01005710020054120000550F0200551000005712
      0000541200005611000000000000000000000000000057120000551203005213
      00005612000055130000550F0000551300005412000053110000591100005412
      0000551001005613000000000000000000000000000057120000551203005213
      00005612000055130000550F0000551300005412000053110000591100005412
      0000551001005613000000000000000000000000000056110000FBF9F800FAF8
      F700F5F7F700F4FAF500F8F9F700FAF8F800F8F7F900F7F9FA00F7F6F800FAF8
      F700F9F7F6005611020000000000000000000000000056110000F4F9F700F8F7
      FB00F8F8F800F8F8F800FBF9F900F7F8F600F8F8F800F7F9F900F8F8F800F5F7
      F800F8F7F9005611000000000000000000000000000056110000FBF9F800FAF8
      F700F5F7F700F4FAF500F8F9F700FAF8F800F8F7F900F7F9FA00F7F6F800FAF8
      F700F9F7F6005611020000000000000000000000000056110000FBF9F800FAF8
      F700F5F7F700F4FAF500F8F9F700FAF8F800F8F7F900F7F9FA00F7F6F800FAF8
      F700F9F7F6005611020000000000000000000000000054120000F5F7F700F8F8
      F800F8F8F800F5F8FC00FBF7FC00F8F7F900FAF8F700F6F8F800F8F9F500F6F8
      F800F3F8F6005611000000000000000000000000000056110000F6F8F900F8F8
      F800F6F9F700F8F8F800F9F7F700F9F8FA00F6F8F900FAF8F800F6F8F800F8F9
      F700F9F9F9005611000000000000000000000000000054120000F5F7F700F8F8
      F800F8F8F800F5F8FC00FBF7FC00F8F7F900FAF8F700F6F8F800F8F9F500F6F8
      F800F3F8F6005611000000000000000000000000000054120000F5F7F700F8F8
      F800F8F8F800F5F8FC00FBF7FC00F8F7F900FAF8F700F6F8F800F8F9F500F6F8
      F800F3F8F60056110000000000000000000000000000550F0200F5FBF600FAF6
      FB00008B0000008B0000008B0000008B0000008B0000008B0000008B0000FCF8
      F700FAF6FB005612000000000000000000000000000056110000F6F8F900F8F9
      F700FAF7F900F9F8FA00FAF6F500F6F8F900FAF8F700F6F8F800FAF7F900F9F9
      F900F9F8FA0056110000000000000000000000000000550F0200F5FBF600FAF6
      FB00F9F9F900F7F7F70002860000F8F7F900F4F9F700F7F9FA00F6F5F700FCF8
      F700FAF6FB0056120000000000000000000000000000550F0200F5FBF600FAF6
      FB00008B0000008B0000008B0000008B0000008B0000008B0000008B0000FCF8
      F700FAF6FB0056120000000000000000000000000000560F0100F5FAF800F8F8
      F800008B0000008B0000008B0000008B0000008B0000008B0000008B0000FAF7
      F900F6F7FB005711000000000000000000000000000056110000F6F8F800F8F9
      F700F6F8F800FAF8F700F9FAF600F6F8F900FAF8F800F5F8F600F8F9F700F8F9
      F700F9F7F70056110000000000000000000000000000560F0100F5FAF800F8F8
      F800F9F7F60001890100008D020000870000F6F8F900FBF8F300F9F9F900FAF7
      F900F6F7FB0057110000000000000000000000000000560F0100F5FAF800F8F8
      F800008B0000008B0000008B0000008B0000008B0000008B0000008B0000FAF7
      F900F6F7FB005711000000000000000000000000000054110200F6F8F900FEF6
      F600008B0000008B0000008B0000008B0000008B0000008B0000008B0000FBF9
      F900F5F9F4005712000000000000000000000000000056110000F5F4F600F4F3
      F500F6F4F400F1F5F600FBF6F700F8F8F800F8F7F900F8F8F800F7F6F800FAF8
      F800F6F9F7005611000000000000000000000000000054110200F6F8F900FEF6
      F60003880200008B000000890000008C000004880000F7F8F600F9F8FA00FBF9
      F900F5F9F4005712000000000000000000000000000054110200F6F8F900FEF6
      F600008B0000008B0000008B0000008B0000008B0000008B0000008B0000FBF9
      F900F5F9F4005712000000000000000000000000000057120000F0F3F700F0F3
      F800008B0000008B0000008B0000008B0000008B0000008B0000008B0000F6F7
      FB00F7F9F9005610000000000000000000000000000056110000F2F2F200EFF1
      F100F1F0F400EEF4F300F4F4F400F5F6F400F5F4F600F7F6F800F8F7F900F5F8
      F600F8F7F9005611000000000000000000000000000057120000F0F3F700F0F3
      F8000187000002870100FEF9F800008900000089000000890000F7F8F600F6F7
      FB00F7F9F9005610000000000000000000000000000057120000F0F3F700F0F3
      F800008B0000008B0000008B0000008B0000008B0000008B0000008B0000F6F7
      FB00F7F9F9005610000000000000000000000000000050130000E5EBF200EEED
      EF00008B0000008B0000008B0000008B0000008B0000008B0000008B0000F4F9
      F700FBF9F9005610000000000000000000000000000056110000E9EBEC00E6EB
      EA00E7ECEB00EBEEEC00EDEFF000EDEFF000F2F2F200F6F4F300F0F6F500F7F7
      F700FAF8F8005611000000000000000000000000000050130000E5EBF200EEED
      EF0003870000F1F0F400F6F0F500FAF3FA00018901000089000000880000F4F9
      F700FBF9F9005610000000000000000000000000000050130000E5EBF200EEED
      EF00008B0000008B0000008B0000008B0000008B0000008B0000008B0000F4F9
      F700FBF9F900561000000000000000000000000000005A120100E0E3E700E0E4
      E500008B0000008B0000008B0000008B0000008B0000008B0000008B0000FAF7
      F900F6F6F6005611020000000000000000000000000056110000E3E6EA00E2E6
      E700E1E5E600E5EAE900EAEBE900E7ECEB00EBEDED00EBF0EF00F1F2F000F3F2
      F400F7F9F900561100000000000000000000000000005A120100E0E3E700E0E4
      E500E2E5E900E4E9E800E9E9E900EEECEC00F5EFF4000589000000890200FAF7
      F900F6F6F600561102000000000000000000000000005A120100E0E3E700E0E4
      E500008B0000008B0000008B0000008B0000008B0000008B0000008B0000FAF7
      F900F6F6F6005611020000000000000000000000000059110000D4DDE000D8DC
      DD00008B0000008B0000008B0000008B0000008B0000008B0000008B0000ECF0
      F100F0F2F2005711000000000000000000000000000056110000D9E2E600DDE1
      E200DDE3E200E1E3E300E2E8E300E6E8E800E4E7EB00ECE9EB00EAECEC00EAEF
      F200EEF1F5005611000000000000000000000000000059110000D4DDE000D8DC
      DD00D7DCDD00DBE0DF00DAE2E100E0E5E400E3E6EA00E9EAEE0001850200ECF0
      F100F0F2F2005711000000000000000000000000000059110000D4DDE000D8DC
      DD00008B0000008B0000008B0000008B0000008B0000008B0000008B0000ECF0
      F100F0F2F2005711000000000000000000000000000059130200D3D8DB00CCDA
      D900D6D8D800D5DADD00D7DDDC00D7DDE200DBE0DE00E1E3E400E2E5EA00E4E9
      E700E7ECED00560E020000000000000000000000000056110000DBDFE000D6E1
      DF00DEE0E000DDE0E400DEE1E500DFE3E400E1E6E400E5E7E800E3E7E800ECEC
      EC00ECF1F2005611000000000000000000000000000059130200D3D8DB00CCDA
      D900D6D8D800D5DADD00D7DDDC00D7DDE200DBE0DE00E1E3E400E2E5EA00E4E9
      E700E7ECED00560E020000000000000000000000000059130200D3D8DB00CCDA
      D900D6D8D800D5DADD00D7DDDC00D7DDE200DBE0DE00E1E3E400E2E5EA00E4E9
      E700E7ECED00560E020000000000000000000000000054120000CED7DB00D1D6
      D900D1D6D700D2D7DA00D4D7DB00D1DADD00D8DFDC00D9DEDD00DCE2E100D6E4
      E300E0E6EB005412000000000000000000000000000056110000D6E2E200DADE
      E300DCDFE300DDE2E500DDE3E200DFE5E400E0E6E500DEE7E400E5E8ED00E6E9
      ED00E8EEED005611000000000000000000000000000054120000CED7DB00D1D6
      D900D1D6D700D2D7DA00D4D7DB00D1DADD00D8DFDC00D9DEDD00DCE2E100D6E4
      E300E0E6EB005412000000000000000000000000000054120000CED7DB00D1D6
      D900D1D6D700D2D7DA00D4D7DB00D1DADD00D8DFDC00D9DEDD00DCE2E100D6E4
      E300E0E6EB005412000000000000000000000000000054120000581302005311
      000055130100571300005813000051130100540F000057130000561200005311
      0000571200005712010000000000000000000000000056110000561100005611
      0000561100005611000056110000561100005611000056110000561100005611
      0000561100005611000000000000000000000000000054120000581302005311
      000055130100571300005813000051130100540F000057130000561200005311
      0000571200005712010000000000000000000000000054120000581302005311
      000055130100571300005813000051130100540F000057130000561200005311
      0000571200005712010000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object imlSys16: TImageList
    ShareImages = True
    Left = 184
    Top = 268
  end
  object OpenDialog: TOpenDialog
    Options = [ofAllowMultiSelect, ofFileMustExist, ofEnableSizing, ofForceShowHidden]
    Left = 408
    Top = 256
  end
  object acContext: TActionList
    Left = 499
    Top = 256
    object acCheckAll: TAction
      Caption = 'Check All'
      OnExecute = acCheckAllExecute
    end
    object acUncheckAll: TAction
      Caption = 'Uncheck All'
      OnExecute = acUncheckAllExecute
    end
  end
  object pmContext: TPopupActionBar
    Left = 313
    Top = 258
    object CheckAll2: TMenuItem
      Action = acCheckAll
    end
    object UncheckAll2: TMenuItem
      Action = acUncheckAll
    end
  end
end
