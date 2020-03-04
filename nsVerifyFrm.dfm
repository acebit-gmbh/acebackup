inherited frmVerifyWizard: TfrmVerifyWizard
  HelpContext = 1000
  Caption = 'Verify project'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnBack: TButton
    TabOrder = 2
  end
  inherited btnNext: TButton
    TabOrder = 1
  end
  inherited btnCancel: TButton
    OnClick = btnCancelClick
  end
  inherited PageControl: TPageControl
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
        object Label22: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 361
          Width = 162
          Height = 13
          Margins.Left = 36
          Margins.Top = 4
          Margins.Right = 20
          Margins.Bottom = 12
          Align = alBottom
          Caption = 'To continue, click the Next button'
        end
        object Label34: TLabel
          AlignWithMargins = True
          Left = 16
          Top = 12
          Width = 241
          Height = 18
          Margins.Left = 16
          Margins.Top = 12
          Margins.Right = 16
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Welcome to the Verify project wizard'
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
          Width = 244
          Height = 13
          Margins.Left = 24
          Margins.Top = 4
          Margins.Right = 12
          Margins.Bottom = 4
          Align = alTop
          Caption = 'This wizard helps you to verify the current project.'
          WordWrap = True
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 67
          Width = 555
          Height = 26
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 
            'For example, the wizard adds items that are available on volume ' +
            'but not in the project. The wizard also removes all items from t' +
            'he project that are not available on volume.'
          WordWrap = True
        end
        object Label8: TLabel
          AlignWithMargins = True
          Left = 36
          Top = 109
          Width = 263
          Height = 13
          Margins.Left = 36
          Margins.Top = 12
          Margins.Right = 20
          Margins.Bottom = 4
          Align = alTop
          Caption = 'Depending on the volume this may take a few minutes.'
          WordWrap = True
        end
      end
    end
    object ts2: TTabSheet
      ImageIndex = 1
      TabVisible = False
      object pnlImporting: TPanel
        Tag = 1
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 632
          Height = 386
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object Label1: TLabel
            AlignWithMargins = True
            Left = 36
            Top = 159
            Width = 46
            Height = 13
            Margins.Left = 36
            Margins.Top = 20
            Margins.Right = 20
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Verifying:'
          end
          object pbxFileName: TLabel
            AlignWithMargins = True
            Left = 36
            Top = 176
            Width = 576
            Height = 20
            Margins.Left = 36
            Margins.Top = 0
            Margins.Right = 20
            Margins.Bottom = 4
            Align = alTop
            AutoSize = False
            Caption = '.....................'
            EllipsisPosition = epPathEllipsis
          end
          object Label9: TLabel
            AlignWithMargins = True
            Left = 16
            Top = 12
            Width = 134
            Height = 18
            Margins.Left = 16
            Margins.Top = 12
            Margins.Right = 16
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Verifying project files'
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
            Width = 394
            Height = 13
            Margins.Left = 24
            Margins.Top = 4
            Margins.Right = 12
            Margins.Bottom = 4
            Align = alTop
            Caption = 
              'Please wait while files are checked. To abort the process click ' +
              'the "Cancel" button.'
            WordWrap = True
          end
          object aniProgress: TAnimate
            AlignWithMargins = True
            Left = 36
            Top = 75
            Width = 576
            Height = 60
            Margins.Left = 36
            Margins.Top = 20
            Margins.Right = 20
            Margins.Bottom = 4
            Align = alTop
            StopFrame = 31
          end
        end
      end
    end
    object ts3: TTabSheet
      ImageIndex = 2
      TabVisible = False
      object pnlFinish: TPanel
        Tag = 2
        Left = 0
        Top = 0
        Width = 632
        Height = 386
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
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
            Top = 183
            Width = 43
            Height = 13
            Margins.Left = 36
            Margins.Top = 12
            Margins.Right = 20
            Margins.Bottom = 8
            Align = alTop
            Caption = 'Content:'
          end
          object Label6: TLabel
            AlignWithMargins = True
            Left = 36
            Top = 361
            Width = 219
            Height = 13
            Margins.Left = 36
            Margins.Top = 4
            Margins.Right = 20
            Margins.Bottom = 12
            Align = alBottom
            Caption = 'To reopen the project, click the Finish button.'
          end
          object lblSizeOnMedia: TLabel
            AlignWithMargins = True
            Left = 36
            Top = 208
            Width = 75
            Height = 13
            Margins.Left = 36
            Margins.Top = 4
            Margins.Right = 20
            Margins.Bottom = 8
            Align = alTop
            Caption = 'Size on volume:'
          end
          object lblConsistent: TLabel
            AlignWithMargins = True
            Left = 36
            Top = 133
            Width = 275
            Height = 26
            Margins.Left = 36
            Margins.Top = 20
            Margins.Right = 20
            Margins.Bottom = 12
            Align = alTop
            Caption = 
              'The Wizard has detected no inconsistency of the project.'#13#10'All th' +
              'e project'#39's items are stored on the volume.'
            WordWrap = True
          end
          object lblShowReport: TLabel
            AlignWithMargins = True
            Left = 36
            Top = 75
            Width = 258
            Height = 26
            Margins.Left = 36
            Margins.Top = 20
            Margins.Right = 20
            Margins.Bottom = 12
            Align = alTop
            Caption = 
              'The wizard has detected inconsistency of the project.'#13#10'Select th' +
              'e "Show report" option to show details.'
            Visible = False
            WordWrap = True
          end
          object Label2: TLabel
            AlignWithMargins = True
            Left = 16
            Top = 12
            Width = 96
            Height = 18
            Margins.Left = 16
            Margins.Top = 12
            Margins.Right = 16
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Project verified'
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
            Width = 315
            Height = 13
            Margins.Left = 24
            Margins.Top = 4
            Margins.Right = 12
            Margins.Bottom = 4
            Align = alTop
            Caption = 
              'The wizard has successfully finished verifying the current proje' +
              'ct.'
            WordWrap = True
          end
          object chkShowReport: TCheckBox
            AlignWithMargins = True
            Left = 36
            Top = 241
            Width = 576
            Height = 17
            Margins.Left = 36
            Margins.Top = 12
            Margins.Right = 20
            Margins.Bottom = 8
            Align = alTop
            Caption = 'Show report'
            TabOrder = 0
            Visible = False
          end
        end
      end
    end
  end
end
