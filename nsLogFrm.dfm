object frmLogView: TfrmLogView
  Left = 326
  Top = 250
  HelpContext = 400
  Caption = 'frmLogView'
  ClientHeight = 563
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SynMemo1: TMemo
    Left = 0
    Top = 46
    Width = 647
    Height = 498
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 544
    Width = 647
    Height = 19
    Panels = <>
  end
  object clbr1: TCoolBar
    Left = 0
    Top = 0
    Width = 647
    Height = 46
    AutoSize = True
    BandBorderStyle = bsNone
    Bands = <
      item
        Break = False
        Control = pnlLocalCaption
        FixedSize = True
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 18
        Width = 632
      end
      item
        Break = False
        Control = tlbLogView
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 24
        Width = 641
      end>
    object tlbLogView: TToolBar
      Left = 11
      Top = 18
      Width = 632
      Height = 24
      ButtonWidth = 77
      DisabledImages = frmMain.iml16d
      Images = frmMain.iml16n
      List = True
      ShowCaptions = True
      TabOrder = 0
      Wrapable = False
      object btnacClose: TToolButton
        Left = 0
        Top = 0
        Action = acClose
        AutoSize = True
      end
      object btnacSaveAs: TToolButton
        Left = 57
        Top = 0
        Action = acSaveAs
        AutoSize = True
      end
      object btnacPrint: TToolButton
        Left = 138
        Top = 0
        Action = acPrint
        AutoSize = True
      end
      object btnacHelp: TToolButton
        Left = 203
        Top = 0
        Action = acHelp
        AutoSize = True
      end
      object btn6: TToolButton
        Left = 255
        Top = 0
        Width = 8
        Caption = 'btn6'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btn5: TToolButton
        Left = 263
        Top = 0
        AutoSize = True
        Caption = 'View:'
        Style = tbsTextButton
      end
      object cbViewMode: TComboBox
        Left = 300
        Top = 0
        Width = 150
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
      object btn1: TToolButton
        Left = 450
        Top = 0
        Width = 8
        Caption = 'btn1'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object ProgressBar1: TProgressBar
        Left = 458
        Top = 0
        Width = 150
        Height = 22
        TabOrder = 1
      end
    end
    object pnlLocalCaption: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 0
      Width = 632
      Height = 18
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Log View'
      TabOrder = 1
    end
  end
  object PrintDialog: TPrintDialog
    Left = 100
    Top = 104
  end
  object SaveDialog: TSaveDialog
    Filter = 'Log Files (*.log)|*.log|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 68
    Top = 104
  end
  object acLogView: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = acClose
            Caption = '&Close'
            ImageIndex = 32
          end
          item
            Action = acSaveAs
            Caption = '&Save as...'
            ImageIndex = 20
          end
          item
            Action = acPrint
            Caption = '&Print...'
            ImageIndex = 33
          end
          item
            Action = acHelp
            Caption = '&Help'
            ImageIndex = 35
          end
          item
            Caption = '-'
          end
          item
            Action = acView
            Caption = '&View:'
            CommandStyle = csControl
            CommandProperties.Width = 200
            CommandProperties.ContainedControl = cbViewMode
          end>
      end>
    DisabledImages = frmMain.iml16d
    LargeDisabledImages = frmMain.iml24d
    LargeImages = frmMain.iml24n
    Images = frmMain.iml16n
    Left = 378
    Top = 126
    StyleName = 'Platform Default'
    object acClose: TAction
      Caption = 'Close'
      ImageIndex = 32
      OnExecute = btnCloseClick
    end
    object acSaveAs: TAction
      Caption = 'Save as...'
      ImageIndex = 20
      OnExecute = btnSaveAsClick
    end
    object acPrint: TAction
      Caption = 'Print...'
      ImageIndex = 33
      OnExecute = btnPrintClick
    end
    object acHelp: TAction
      Caption = 'Help'
      ImageIndex = 35
      OnExecute = btnHelpClick
    end
    object acView: TAction
      Caption = 'View:'
      OnExecute = acViewExecute
    end
  end
end
