object frmProcess: TfrmProcess
  Left = 362
  Top = 193
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'frmProcess'
  ClientHeight = 326
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pbxFileName: TLabel
    AlignWithMargins = True
    Left = 12
    Top = 80
    Width = 483
    Height = 20
    Margins.Left = 12
    Margins.Top = 4
    Margins.Right = 12
    Margins.Bottom = 4
    Align = alTop
    AutoSize = False
    EllipsisPosition = epPathEllipsis
  end
  object pbxAction: TLabel
    AlignWithMargins = True
    Left = 12
    Top = 108
    Width = 483
    Height = 17
    Margins.Left = 12
    Margins.Top = 4
    Margins.Right = 12
    Align = alTop
    AutoSize = False
  end
  object Label1: TLabel
    AlignWithMargins = True
    Left = 12
    Top = 153
    Width = 483
    Height = 13
    Margins.Left = 12
    Margins.Top = 4
    Margins.Right = 12
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Overall progress:'
  end
  object lblTotalSize: TLabel
    Left = 360
    Top = 204
    Width = 53
    Height = 13
    Caption = 'lblTotalSize'
  end
  object lblProcSize: TLabel
    Left = 124
    Top = 204
    Width = 50
    Height = 13
    Caption = 'lblProcSize'
  end
  object lblTimeElapsed: TLabel
    Left = 124
    Top = 224
    Width = 69
    Height = 13
    Caption = 'lblTimeElapsed'
  end
  object lblSpeed: TLabel
    Left = 124
    Top = 244
    Width = 40
    Height = 13
    Caption = 'lblSpeed'
  end
  object lblTimeRemaining: TLabel
    Left = 360
    Top = 224
    Width = 81
    Height = 13
    Caption = 'lblTimeRemaining'
  end
  object Label2: TLabel
    Left = 16
    Top = 204
    Width = 74
    Height = 13
    Caption = 'Processed size:'
  end
  object Label3: TLabel
    Left = 256
    Top = 204
    Width = 74
    Height = 13
    Caption = 'Remaining size:'
  end
  object Label4: TLabel
    Left = 16
    Top = 224
    Width = 66
    Height = 13
    Caption = 'Time elapsed:'
  end
  object Label5: TLabel
    Left = 256
    Top = 224
    Width = 75
    Height = 13
    Caption = 'Time remaining:'
  end
  object Label6: TLabel
    Left = 16
    Top = 244
    Width = 59
    Height = 13
    Caption = 'Avg. speed:'
  end
  object aniProgress: TAnimate
    AlignWithMargins = True
    Left = 12
    Top = 12
    Width = 483
    Height = 60
    Margins.Left = 12
    Margins.Top = 12
    Margins.Right = 12
    Margins.Bottom = 4
    Align = alTop
    StopFrame = 31
  end
  object ProgressBar1: TProgressBar
    AlignWithMargins = True
    Left = 12
    Top = 125
    Width = 483
    Height = 16
    Margins.Left = 12
    Margins.Top = 0
    Margins.Right = 12
    Margins.Bottom = 8
    Align = alTop
    Smooth = True
    TabOrder = 1
  end
  object ProgressBar2: TProgressBar
    AlignWithMargins = True
    Left = 12
    Top = 170
    Width = 483
    Height = 17
    Margins.Left = 12
    Margins.Top = 0
    Margins.Right = 12
    Margins.Bottom = 4
    Align = alTop
    TabOrder = 2
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 282
    Width = 507
    Height = 44
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      507
      42)
    object btnCancel: TButton
      Left = 416
      Top = 8
      Width = 80
      Height = 24
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
  end
end
