inherited frmImportWizard: TfrmImportWizard
  HelpContext = 300
  Caption = 'Import project'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnCancel: TButton
    OnClick = btnCancelClick
  end
  inherited PageControl: TPageControl
    ActivePage = ts1
    object ts1: TTabSheet
      TabVisible = False
      object pnlWelcome: TPanel
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
          Caption = 'Welcome to the Import project wizard!'
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
          Height = 26
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'Specify the title and location of the project you wish to import' +
            '. If the files are on a remote FTP server, specify the access pa' +
            'rameters.'
          WordWrap = True
        end
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 36
          Top = 76
          Width = 576
          Height = 62
          Margins.Left = 36
          Margins.Top = 8
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          BevelEdges = [beBottom]
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            576
            62)
          object Label8: TLabel
            Left = 8
            Top = 24
            Width = 39
            Height = 13
            Caption = '&System:'
          end
          object btnConnection: TButton
            Left = 480
            Top = 20
            Width = 84
            Height = 23
            Anchors = [akTop, akRight]
            Caption = 'Se&ttings'
            TabOrder = 0
            OnClick = btnConnectionClick
          end
          object cbMediaType: TComboBox
            Left = 72
            Top = 20
            Width = 401
            Height = 24
            Style = csOwnerDrawFixed
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 18
            TabOrder = 1
            OnChange = cbMediaTypeChange
          end
        end
        object PageControl1: TPageControl
          AlignWithMargins = True
          Left = 36
          Top = 146
          Width = 576
          Height = 236
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          ActivePage = tsCD
          Align = alClient
          Style = tsFlatButtons
          TabOrder = 1
          object tsLocal: TTabSheet
            Caption = 'tsLocal'
            TabVisible = False
            object Label10: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 26
              Height = 13
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              Caption = '&Path:'
            end
            object edtLocalFolder: TEdit
              AlignWithMargins = True
              Left = 4
              Top = 21
              Width = 469
              Height = 21
              Margins.Left = 4
              Margins.Top = 0
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 0
            end
            object btnBrowseForLocalFolder: TButton
              Left = 484
              Top = 20
              Width = 84
              Height = 23
              Caption = 'Bro&wse'
              TabOrder = 1
              OnClick = btnBrowseForLocalFolderClick
            end
          end
          object tsFTP: TTabSheet
            Caption = 'tsFTP'
            ImageIndex = 1
            TabVisible = False
            object Label11: TLabel
              Left = 4
              Top = 8
              Width = 43
              Height = 13
              Caption = '&Address:'
              FocusControl = edtHost
            end
            object Label12: TLabel
              Left = 216
              Top = 8
              Width = 24
              Height = 13
              Caption = '&Port:'
              FocusControl = edtPort
            end
            object Label15: TLabel
              Left = 4
              Top = 40
              Width = 48
              Height = 13
              Caption = '&Directory:'
            end
            object Label13: TLabel
              Left = 4
              Top = 72
              Width = 26
              Height = 13
              Caption = '&User:'
              FocusControl = edtUser
            end
            object Label14: TLabel
              Left = 231
              Top = 72
              Width = 50
              Height = 13
              Caption = 'Pass&word:'
              FocusControl = edtHostPwd
            end
            object edtHost: TEdit
              Left = 76
              Top = 4
              Width = 123
              Height = 21
              TabOrder = 0
            end
            object edtPort: TEdit
              Left = 246
              Top = 4
              Width = 63
              Height = 21
              TabOrder = 1
              Text = '21'
            end
            object chkPassive: TCheckBox
              Left = 336
              Top = 6
              Width = 64
              Height = 17
              Caption = 'Pass&ive'
              TabOrder = 2
            end
            object edtHostDir: TEdit
              Left = 76
              Top = 36
              Width = 325
              Height = 21
              TabOrder = 3
            end
            object edtUser: TEdit
              Left = 76
              Top = 68
              Width = 123
              Height = 21
              TabOrder = 4
            end
            object edtHostPwd: TEdit
              Left = 290
              Top = 68
              Width = 112
              Height = 21
              PasswordChar = '*'
              TabOrder = 5
            end
          end
          object tsCD: TTabSheet
            Caption = 'tsCD'
            ImageIndex = 2
            TabVisible = False
            object Label18: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 560
              Height = 13
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              Caption = '&Drive:'
              FocusControl = cbDrives
            end
            object Label3: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 51
              Width = 560
              Height = 13
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              Caption = '&Directory:'
            end
            object cbDrives: TComboBox
              AlignWithMargins = True
              Left = 4
              Top = 21
              Width = 560
              Height = 22
              HelpContext = 1024
              Margins.Left = 4
              Margins.Top = 0
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = cbDrivesChange
            end
            object edtCDFolder: TEdit
              AlignWithMargins = True
              Left = 4
              Top = 68
              Width = 560
              Height = 21
              Margins.Left = 4
              Margins.Top = 0
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              TabOrder = 1
            end
          end
          object tsNAS: TTabSheet
            Caption = 'tsNAS'
            ImageIndex = 3
            TabVisible = False
            DesignSize = (
              568
              226)
            object Label20: TLabel
              AlignWithMargins = True
              Left = 4
              Top = 4
              Width = 560
              Height = 13
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              Caption = '&Network Path:'
            end
            object Label21: TLabel
              Left = 4
              Top = 64
              Width = 26
              Height = 13
              Caption = '&User:'
              FocusControl = edtNetUser
            end
            object Label22: TLabel
              Left = 4
              Top = 99
              Width = 50
              Height = 13
              Caption = 'Pass&word:'
              FocusControl = edtNetPass
            end
            object edtNetPath: TEdit
              AlignWithMargins = True
              Left = 4
              Top = 21
              Width = 473
              Height = 21
              Margins.Left = 4
              Margins.Top = 0
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 0
            end
            object edtNetUser: TEdit
              Left = 78
              Top = 60
              Width = 177
              Height = 21
              Margins.Left = 0
              Margins.Right = 0
              Anchors = [akTop, akRight]
              TabOrder = 1
            end
            object edtNetPass: TEdit
              Left = 78
              Top = 96
              Width = 177
              Height = 21
              Margins.Left = 0
              Margins.Right = 0
              Anchors = [akTop, akRight]
              PasswordChar = '*'
              TabOrder = 2
            end
            object btnBrowseForNetFolder: TButton
              Left = 484
              Top = 20
              Width = 84
              Height = 23
              Caption = 'Bro&wse'
              TabOrder = 3
              OnClick = btnBrowseForNetFolderClick
            end
          end
        end
      end
    end
    object ts2: TTabSheet
      ImageIndex = 1
      TabVisible = False
      object pnlImporting: TPanel
        Tag = 2
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object pbxFileName: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 168
          Width = 576
          Height = 20
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          AutoSize = False
          Caption = '...................'
          EllipsisPosition = epPathEllipsis
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 142
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Importing project files'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 393
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'Please wait while files are imported. To abort the process, clic' +
            'k the Cancel button.'
          WordWrap = True
        end
        object Label23: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 147
          Width = 50
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Importing:'
        end
        object aniProgress: TAnimate
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 576
          Height = 60
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 8
          Align = alTop
          StopFrame = 31
        end
      end
    end
    object ts3: TTabSheet
      ImageIndex = 2
      TabVisible = False
      object pnlFinish: TPanel
        Tag = 3
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label6: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 361
          Width = 205
          Height = 13
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 12
          Align = alBottom
          Caption = 'To open the project, click the Finish button'
        end
        object lblContains: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 84
          Width = 56
          Height = 13
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = '..............'
        end
        object Label7: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 113
          Width = 75
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Size on volume:'
        end
        object lblSizeOnMedia: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 130
          Width = 48
          Height = 13
          Margins.Left = 36
          Margins.Top = 0
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = '............'
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 43
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Content:'
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 38
          Width = 315
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'The wizard has successfully finished importing an existing proje' +
            'ct.'
          WordWrap = True
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 107
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Project imported'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10040064
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
end
