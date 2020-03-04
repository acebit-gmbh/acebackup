object frmMultiItems: TfrmMultiItems
  Left = 378
  Top = 152
  HelpContext = 200
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'frmMultiItems'
  ClientHeight = 409
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    360
    409)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 373
    Width = 360
    Height = 36
    Align = alBottom
    Shape = bsSpacer
  end
  object btnOK: TButton
    Left = 112
    Top = 385
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 196
    Top = 385
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 280
    Top = 385
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
    Width = 360
    Height = 373
    ActivePage = TS1
    Align = alClient
    TabOrder = 0
    object TS1: TTabSheet
      Caption = 'General'
      DesignSize = (
        352
        345)
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 71
        Width = 328
        Height = 62
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
      object lblContains: TLabel
        Left = 100
        Top = 20
        Width = 65
        Height = 13
        Caption = 'Evaluating ...'
        Transparent = True
      end
      object lblSizeOnMedia: TLabel
        Left = 100
        Top = 104
        Width = 65
        Height = 13
        Caption = 'Evaluating ...'
        Transparent = True
      end
      object Label6: TLabel
        Left = 12
        Top = 80
        Width = 28
        Height = 13
        Caption = 'Type:'
        Transparent = True
      end
      object lblType: TLabel
        Left = 100
        Top = 80
        Width = 34
        Height = 13
        Caption = 'lblType'
        Transparent = True
      end
      object Label5: TLabel
        Left = 12
        Top = 104
        Width = 23
        Height = 13
        Caption = 'Size:'
        Transparent = True
      end
      object Label1: TLabel
        Left = 12
        Top = 160
        Width = 80
        Height = 13
        Caption = 'Original location:'
        Transparent = True
      end
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 12
        Top = 4
        Width = 328
        Height = 59
        Margins.Left = 12
        Margins.Top = 4
        Margins.Right = 12
        Margins.Bottom = 4
        Align = alTop
        Shape = bsBottomLine
      end
      object edtOriginalLocation: TEdit
        Left = 12
        Top = 176
        Width = 328
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object btnChange: TButton
        Left = 256
        Top = 204
        Width = 84
        Height = 24
        Anchors = [akTop, akRight]
        Caption = 'C&hange'
        TabOrder = 1
        OnClick = btnChangeClick
      end
    end
  end
end
