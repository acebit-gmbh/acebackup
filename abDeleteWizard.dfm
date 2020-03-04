inherited frmDeleteWizard: TfrmDeleteWizard
  Caption = 'Delete Files/Folders'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnBack: TButton
    Visible = False
  end
  inherited btnNext: TButton
    Caption = '&Delete'
  end
  inherited btnCancel: TButton
    Left = 552
    OnClick = btnCancelClick
  end
  inherited PageControl: TPageControl
    ActivePage = ts1
    object ts1: TTabSheet
      Caption = 'ts1'
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
          Caption = 'Confirm Delete'
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
          Caption = 
            'Are you sure you want to delete the selected items from the proj' +
            'ect?'
          WordWrap = True
        end
        object Image1: TImage
          Left = 36
          Top = 76
          Width = 48
          Height = 48
          Picture.Data = {
            055449636F6E0000010001003030000001002000A82500001600000028000000
            3000000060000000010020000000000080250000000000000000000000000000
            0000000088878718918E8D93838281E0838281E0828180E1828180E1828180E1
            828180E1828180E1828180E1828180E1828180E1828180E1828180E1828180E1
            828180E1828180E1828180E1828180E1828180E1828180E1828180E1868484D7
            7F7A7A3900000006000000060000000600000006000000060000000600000008
            0000000700000001000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000009B979668B1AFAEF2E1E1E0FDDBDDDEFFD9DDDDFFD9DDDEFED9DDDDFE
            D8DCDCFED8DCDBFED7DBDBFED7DBDBFED7DBDCFED8DCDDFED7DBDCFED8DBDCFE
            D7DBDAFED7DBDBFED7DADBFED7DADAFED7DBDBFED4D9D9FFE0DFDEFFCBCBC9FE
            868485AF0000004E0000004E0000004E0000004E0000004E0000004F0000004E
            0000003700000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000AAA8A759B1B3B3EDC8E5E7FF3798B4FF19A0C6FF1DA3CBFF1DA2CAFF
            1CA1CAFF1BA0C9FF14A6D7FF0DA8DEFF1183ACFF1C7EA4FF0FA5DCFF199FD0FF
            1E9AC8FF1F9AC7FF1E9BC8FF1E9BC8FF1D9CCBFF1C95C1FF66A4BDFFC7C6C5FF
            BABAB9FBD6D6D7F6D6D6D7F6D6D6D7F6D6D6D7F6D6D6D7F6D7D7D8F6DCDCDDFC
            000000600000000E000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000BFBEBD14AFAEADB3B5BDBDF689CBD7FF0FA0C4FF0AC1EBFF07C7F3FF
            05C4F3FF03C1F2FF03CAFFFF039ECFFF09090BFF4A2416FF228BB2FF03B5F5FF
            07B2F1FF08AEEDFF08AEEDFF08B0F0FF02A9EBFF2B8BB0FFCAD4D6FFB9B7B6FF
            ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            000000600000000D000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000AAA9A84DB1B2B2E8CDDEDFFF369AB4FF04B7E1FF00C3EFFF
            00BFEEFF00BCEDFF00BFF5FF00A6DAFF014255FF1C3941FF0C92C3FF00AFF1FF
            00A7EAFF00A5E7FF00A3E6FF00A4EAFF0989BDFFAECDD8FFBFBEBEFFCDCDCDFF
            F1F2F3FFF4F5F6FFF3F4F5FFF3F4F5FFF3F4F5FFF3F4F5FFF5F6F7FFFFFFFFFF
            0000005E0000000D000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000B7B6B60AB2B2B1ACBCBFBFFFA9D6DEFF159CBFFF04BFE6FF
            00C4EEFF00C2EEFF00C1F1FF00B6E8FF009CD3FF0199CFFF00A3D7FF00B1EFFF
            00ACEBFF00A9EAFF00A8EBFF009DE2FF489CBCFFD9DBDAFFBCBBBBFFE8E9E9FF
            F5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F5F6FFF4F5F6FFF5F7F8FFFFFFFFFF
            0000005E0000000D000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000B5B5B445B4B4B4FFD0DEDFFF429EB5FF04BCE3FF
            00CAF1FF00C4EEFF00CEFCFF09C3E1FF01161DFF322624FF1CA9C2FF00B9F3FF
            00B1EFFF00AEECFF00ABEDFF188DBBFFCADAE0FFBDBCBCFFD4D3D4FFF4F5F6FF
            F5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F5F6FFF5F7F8FFFFFFFFFF
            0000005E0000000D000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000B5B5B504C1C0C0FFBEC0C0FFBCDFE4FF23A1BEFF
            04CCEDFF02CEF2FF00D6FFFF0AC3DEFF000304FF1D0803FF11AAC6FF00BEF4FF
            00B5F0FF00B3EFFF00A3DFFF70AEC5FFCECECEFFBFBDBDFFF0F1F1FFF5F6F7FF
            F5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FFFFFFFFFF
            0000005E0000000D000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000CECECDFFBDBCBDFFD3DBDCFF5FABBEFF
            10C9E1FF14E8FEFF12E9FFFF0FC5DDFF121213FF24100DFF11A9C4FF00C9F8FF
            00C5F3FF00BCF2FF2393BAFFD8DEE0FFB9B7B6FFDAD9DAFFF5F6F7FFF5F6F7FF
            F5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FFFFFFFFFF
            0000006200000013000000060000000600000006000000060000000600000006
            0000000800000007000000010000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFD7D7D7FFBAB9B9FFCEE8EAFF
            33A5BAFF0EDEEFFF18F7FFFF16CCDEFF3A3334FF3E2A27FF1CACBEFF08D8FCFF
            03D3FCFF04B2DDFF88B9CBFFC7C6C7FFC3C3C2FFF5F6F7FFF6F6F7FFF6F6F7FF
            F5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FFFFFFFFFF
            0000008F000000570000004E0000004E0000004E0000004E0000004E0000004F
            0000004E00000037000000090000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFF7F8F9FFBFBEBDFFD1D4D4FF
            80BECBFF13BDD2FF08FFFFFF19D4E3FF4E4847FF483331FF1DA9BBFF10DFFCFF
            00CEF3FF3F9DBAFFD7D8D9FFBAB8B7FFE5E5E6FFF6F7F8FFF6F7F8FFF6F6F7FF
            F6F6F7FFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FFFFFFFFFF
            858686F9CBCCCCF6D6D6D7F6D6D6D7F6D6D6D7F6D6D6D7F6D6D6D7F6D7D7D8F6
            DCDCDDFC000000600000000E0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFDFEFFFFDFDFE0FFB9B9B8FF
            D9E9E8FF3FA5BAFF04EAF0FF17DBEBFF645A59FF5E4C49FF23ADBFFF0DE4FBFF
            18B6D5FFBCD3DCFFBEBEBEFFCCCBCCFFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FF
            F6F7F8FFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FFFFFFFFFF
            A1A1A1FFF2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000600000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFDFEFFFFF8F9FAFFC3C2C2FF
            CED0D0FF8BC0CBFF1AC0D1FF17DBEAFF7A5F5FFF7B5B5AFF2CB2C2FF01D7ECFF
            55A6BEFFD5D6D5FFB8B6B6FFEFEFF0FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FF
            F6F7F8FFF6F7F8FFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FFFFFFFFFF
            9A9B9BFFE8E9E9FFF4F5F6FFF3F4F5FFF3F4F5FFF3F4F5FFF3F4F5FFF5F6F7FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFEFEFFFFF9F9FAFFE5E6E6FF
            B9B7B6FFD7E5E5FF4DA8BAFF15D1E4FF5A6D6EFF606564FF22BDCDFF1BB3CCFF
            D3DDE0FFB6B7B7FFD7D7D7FFF7F7F8FFF7F7F8FFF7F7F8FFF6F7F8FFF6F7F8FF
            F6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F6F7FFF6F6F7FFF6F8F9FFFFFFFFFF
            9B9B9CFFE9E9EAFFF5F6F7FFF5F6F7FFF5F6F7FFF5F5F6FFF4F5F6FFF5F7F8FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFEFEFFFFF9F9FAFFF9F9FAFF
            C9C9C9FFC8C9C9FF98C3CDFF25B5C7FF04ECEDFF06EAEBFF02D9E4FF67AEC0FF
            CCCCCCFFBEBFBEFFF7F8F9FFF7F8F9FFF7F7F8FFF7F7F8FFF6F7F8FFF6F7F8FF
            F6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F6F7FFF8F8F9FFFFFFFFFF
            9B9B9CFFE9E9EAFFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F5F6FFF5F7F8FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFEFEFFFFF9F9FAFFF9F9FAFF
            EEEEEFFFB8B7B6FFD8E1E1FF62A6B7FF05E2EBFF00FFFFFF2DBCCDFFDAE0E0FF
            B2B2B2FFE2E2E3FFF7F8F9FFF7F8F9FFF7F8F9FFF7F7F8FFF7F7F8FFF6F7F8FF
            F6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF8F7F8FFFFFFFFFF
            9B9B9CFFE9E9EAFFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFEFFFFFFF9F9FAFFF9F9FAFF
            F9F9FAFFD4D3D3FFC1C1C0FFB3D2D9FF2AACBBFF05CFDCFF7DB4C3FFBFC0C0FF
            C6C5C5FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F7F8FFF7F7F8FF
            F7F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF8F9FAFFFFFFFFFF
            9B9B9CFFE9E9EAFFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFEFFFFFFF9FAFBFFF9F9FAFF
            F9F9FAFFF5F5F6FFBBBAB9FFD6DADAFF62AEBEFF44B1C3FFD7D8D8FFAEB1B1FF
            ECECEDFFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FF
            F7F7F8FFF7F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF8F9FAFFFFFFFFFF
            9B9B9CFFE9E9EAFFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFFFFFFFFF9FAFBFFF9FAFBFF
            F9FAFBFFF9F9FAFFDDDDDDFFB5B4B3FFD7EFF0FFEBEDECFFB1B2B2FFD1D2D2FF
            F8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FF
            F7F8F9FFF7F7F8FFF7F7F8FFF7F7F8FFF6F7F8FFF6F7F8FFF8F9FAFFFFFFFFFF
            9B9B9CFFE9E9EAFFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFFFFFFFFFAFAFBFFF9FAFBFF
            F9FAFBFFF9FAFBFFF9F9FAFFC6C5C5FFCAC9C9FFCBCBCAFFBBBABAFFF4F5F6FF
            F8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FF
            F7F8F9FFF7F8F9FFF7F7F8FFF7F7F8FFF7F7F8FFF6F7F8FFF8F9FAFFFFFFFFFF
            9B9C9DFFE9EAEBFFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFFFFFFFFFAFAFBFFFAFAFBFF
            F9FAFBFFF9FAFBFFF9F9FAFFEBEBECFFB7B5B4FFB9B7B7FFDFDFE0FFF8F9FAFF
            F8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FF
            F7F8F9FFF7F8F9FFF7F8F9FFF7F7F8FFF7F7F8FFF7F7F8FFF7F9FAFFFFFFFFFF
            9B9C9DFFE9EAEBFFF6F7F8FFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF7F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFFFFFFFFFAFAFBFFFAFAFBFF
            FAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFFF9F9FAFF
            F9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FF
            F8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF9F9FAFFFFFFFFFF
            9B9C9DFFE9EAEBFFF6F7F8FFF6F7F8FFF6F7F8FFF6F6F7FFF6F6F7FFF6F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D3FFFFFFFFFFFAFAFBFFFAFAFBFF
            FAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFF
            F9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FF
            F8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF9FAFBFFFFFFFFFF
            9B9C9DFFE9EAEBFFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F6F7FFF8F8F9FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFAFAFBFFFAFAFBFF
            FAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFFF9FAFBFFF9F9FAFF
            F9F9FAFFF9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FF
            F8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF9FAFBFFFFFFFFFF
            9B9C9DFFE9EAEBFFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF8F7F8FF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFAFBFCFFFAFAFBFF
            FAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFF
            F9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFF
            F8F8F9FFF8F8F9FFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF9FAFBFFFFFFFFFF
            9C9C9DFFEAEAEBFFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF8F9FAFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFBFBFCFFFAFBFCFF
            FAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFF
            F9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFF
            F8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFF8F8F9FFF9FAFBFFFFFFFFFF
            9C9D9DFFEAEAEBFFF7F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FFF8F9FAFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFF
            F9FAFBFFF9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFF
            F8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFFAFAFBFFFFFFFFFF
            9A9B9BFFE9EAEBFFF7F7F8FFF7F7F8FFF7F7F8FFF6F7F8FFF6F7F8FFF8F9FAFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFF
            FAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFF
            F9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFFAFAFBFFFFFFFFFF
            979898FFEAEBECFFF7F8F9FFF7F7F8FFF7F7F8FFF7F7F8FFF6F7F8FFF8F9FAFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFF
            FAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFFF9F9FAFF
            F9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF7F7F7FFFFFFFFFF
            A1A1A2FFEDEEEFFFF7F8F9FFF7F8F9FFF7F7F8FFF7F7F8FFF7F7F8FFF7F9FAFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFAFBFFFAFAFBFF
            FAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFFF9F9FAFF
            F9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFFAFBFCFFF8F8F9FFF4F4F4FFFFFFFFFF
            9D9D9DFFEDEDEEFFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF9F9FAFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D3D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFAFBFF
            FAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFF
            FBFCFDFFF9FAFBFFF8F9F9FFF9F9F9FFF6F6F5FFF1F1F1FFEBEBEBFFDEDEDEFF
            BDBDBDFFF4F4F5FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF9FAFBFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D3D4D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFBFCFF
            FAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFFEFFFFFF
            EBECEDFFA6A6A6FFB9B9B9FFB6B6B6FFB6B6B6FFB5B5B5FFD5D5D5FF898A8AFF
            EFEFF0FFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF7F8F9FFF9FAFBFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D4D4D4FFFFFFFFFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFFFFFFFF
            E6E6E8FFC7C7C7FFFFFFFFFFFFFFFFFFF8F8F8FFF0F0F0FF989999FFE0E1E1FF
            F8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFF8F8F9FFF7F8F9FFF7F8F9FFF9FAFBFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFFFCFCFDFF
            FBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFFFFFFFF
            E8E8E8FFC2C2C2FFFFFFFFFFEDEDEDFFE7E7E8FF9D9D9EFFE4E4E5FFF8F9FAFF
            F8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFF8F8F9FFF9FAFBFF
            FFFFFFFF0000005E0000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFFFCFCFDFF
            FCFCFDFFFBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFAFBFCFFFAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFEFEFEFF
            E5E5E5FFBEBEBEFFF6F6F6FFE5E6E6FFA0A0A1FFE4E4E4FFF9F9FAFFF9F9FAFF
            F9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFF8F8F9FFFAFAFBFF
            FFFFFFFF000000600000000E0000000000000000000000000000000000000000
            00000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFFFCFCFDFF
            FCFCFDFFFCFCFDFFFBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFBFCFFF9F8F8FFFAFAFAFF
            E3E3E3FFBABABAFFF1F1F2FF999B9BFFE4E4E5FFF9F9FAFFF9F9FAFFF9F9FAFF
            F9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F8F9FFF8F8F9FFFAFAFBFF
            FFFFFFFF000000630000000D0000000000000000000000000000000000000000
            00000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFFFCFCFDFF
            FCFCFDFFFCFCFDFFFDFCFDFFFCFDFEFFFBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFAFBFFF5F5F4FFF3F3F3FF
            E2E2E1FFD2D2D3FFA4A4A5FFE3E3E4FFF9FAFBFFF9FAFBFFF9F9FAFFF9F9FAFF
            F9F9FAFFF9F9FAFFF9F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF8F9FAFFF7F7F7FF
            FFFFFFFF000000590000000A0000000000000000000000000000000000000000
            00000000000000000000000000000000D4D4D3FFFFFFFFFFFDFDFEFFFDFDFEFF
            FDFDFEFFFDFDFEFFFDFDFEFFFDFDFEFFFCFDFEFFFCFCFDFFFCFCFDFFFCFCFDFF
            FCFCFDFFFCFCFDFFFCFCFDFFFCFCFDFFFCFCFDFFFDFDFEFFF9F9F9FFF9F9F8FF
            E0DDDDFF9D9D9EFFE6E6E7FFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFFF9FAFBFF
            F9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFFAFBFCFFF8F8F9FFF4F4F4FF
            FFFFFFFF0000005E0000000B0000000000000000000000000000000000000000
            00000000000000000000000000000000D5D5D5FFDADADAFFDADADAFFDADADAFF
            DADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFF
            DADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDBDADAFFE2E2E3FF
            B3BFC1FFEBEBECFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFF
            F9FAFBFFFBFCFDFFF9FAFBFFF8F9F9FFF9F9F9FFF6F6F5FFF1F1F1FFEBEBEBFF
            DEDEDEFF0000003D000000040000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D3D4D4FFFFFFFFFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFF
            FAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFF9FAFBFF
            FEFFFFFFEBECEDFFA6A6A6FFB9B9B9FFB6B6B6FFB6B6B6FFB5B5B5FFD5D5D5FF
            4B4B4BA300000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D4D4D4FFFFFFFFFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFF
            FFFFFFFFE6E6E8FFC7C7C7FFFFFFFFFFFFFFFFFFF8F8F8FFF0F0F0FF7D7D7DC6
            0000001900000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFF
            FCFCFDFFFBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFAFBFFFAFAFBFFFAFAFBFFFAFAFBFF
            FFFFFFFFE8E8E8FFC2C2C2FFFFFFFFFFEDEDEDFFE7E7E8FF848485C800000015
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFF
            FCFCFDFFFCFCFDFFFBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFBFCFFFAFBFCFFFAFAFBFFFAFAFBFF
            FEFEFEFFE5E5E5FFBEBEBEFFF6F6F6FFE5E6E6FF878788C70000001600000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFF
            FCFCFDFFFCFCFDFFFCFCFDFFFBFCFDFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFBFCFFFAFBFCFFF9F8F8FF
            FAFAFAFFE3E3E3FFBABABAFFF1F1F2FF7C7E7EC3000000160000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D4D4D4FFFFFFFFFFFCFCFDFF
            FCFCFDFFFCFCFDFFFCFCFDFFFDFCFDFFFCFDFEFFFBFCFDFFFBFBFCFFFBFBFCFF
            FBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFAFAFBFFF5F5F4FF
            F3F3F3FFE2E2E1FFD2D2D3FF8F8F8FCC00000017000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D4D4D3FFFFFFFFFFFDFDFEFF
            FDFDFEFFFDFDFEFFFDFDFEFFFDFDFEFFFDFDFEFFFCFDFEFFFCFCFDFFFCFCFDFF
            FCFCFDFFFCFCFDFFFCFCFDFFFCFCFDFFFCFCFDFFFCFCFDFFFDFDFEFFF9F9F9FF
            F9F9F8FFE0DDDDFF818081C30000001400000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000D5D5D5FFDADADAFFDADADAFF
            DADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFF
            DADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDBDADAFF
            E2E2E3FF6D8587800000000F0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000007FFF0000000000007FFF0000000000007FFF000000000000
            7FFF0000800000007FFF0000800000007FFF0000C00000007FFF0000C0000000
            7FFF0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000E0000000
            003F0000E0000000003F0000E0000000003F0000E0000000003F0000FFF00000
            007F0000FFF0000000FF0000FFF0000001FF0000FFF0000003FF0000FFF00000
            07FF0000FFF000000FFF0000FFF000001FFF0000FFF000003FFF0000FFFFFFFF
            FFFF0000}
        end
        object lblCount: TLabel
          Left = 104
          Top = 88
          Width = 39
          Height = 13
          Caption = 'lblCount'
        end
        object chkProcessImmediately: TCheckBox
          Left = 36
          Top = 364
          Width = 189
          Height = 17
          Caption = 'Process delete immediately'
          Checked = True
          State = cbChecked
          TabOrder = 0
          Visible = False
        end
      end
    end
    object ts2: TTabSheet
      Caption = 'ts2'
      ImageIndex = 1
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
          Caption = 'Processing Delete'
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
            'AceBackup is deleting items from the backup media.'#13#10'This process' +
            ' can take a few minutes. To abort the process click the "Cancel"' +
            ' button.'
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
  end
end
