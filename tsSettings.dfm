object frmTaskSettings: TfrmTaskSettings
  Left = 680
  Top = 285
  BorderStyle = bsDialog
  Caption = 'Task Settings'
  ClientHeight = 489
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pgcSettings: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 406
    Height = 434
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tsTimeplan
    Align = alClient
    TabOrder = 0
    object tsTimeplan: TTabSheet
      Caption = 'Time plan'
      object bvlSeparator: TBevel
        Left = 12
        Top = 93
        Width = 373
        Height = 10
        Shape = bsTopLine
      end
      object lblTask: TLabel
        Left = 12
        Top = 59
        Width = 26
        Height = 13
        Caption = 'Task:'
      end
      object lblExecuteTask: TLabel
        Left = 12
        Top = 109
        Width = 66
        Height = 13
        Caption = 'Execute task:'
      end
      object cbbTriggers: TComboBox
        Left = 12
        Top = 27
        Width = 373
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnSelect = cbbTriggersSelect
      end
      object btnNew: TButton
        Left = 229
        Top = 54
        Width = 75
        Height = 25
        Caption = 'New'
        TabOrder = 1
        OnClick = btnNewClick
      end
      object btnDelete: TButton
        Left = 310
        Top = 54
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = btnDeleteClick
      end
      object pgcTriggers: TPageControl
        Left = 12
        Top = 179
        Width = 373
        Height = 212
        ActivePage = tsMonthly
        TabOrder = 3
        object tsDaily: TTabSheet
          TabVisible = False
          object lblExecuteDaily: TLabel
            Left = 12
            Top = 12
            Width = 87
            Height = 13
            Caption = 'Execute task daily'
          end
          object lblEveryDay: TLabel
            Left = 133
            Top = 12
            Width = 28
            Height = 13
            Alignment = taRightJustify
            Caption = 'every'
          end
          object lblThDay: TLabel
            Left = 238
            Top = 12
            Width = 25
            Height = 13
            Caption = '. day'
          end
          object edtDaily: TEdit
            Left = 167
            Top = 9
            Width = 54
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = '1'
            OnChange = edtDailyChange
          end
          object udDaily: TUpDown
            Left = 221
            Top = 9
            Width = 16
            Height = 21
            Associate = edtDaily
            Min = 1
            Max = 9999
            Position = 1
            TabOrder = 1
          end
        end
        object tsWeekly: TTabSheet
          Caption = 'tsWeekly'
          ImageIndex = 1
          TabVisible = False
          object lblExecuteWeekly: TLabel
            Left = 12
            Top = 12
            Width = 98
            Height = 13
            Caption = 'Execute task weekly'
          end
          object lblEveryWeek: TLabel
            Left = 133
            Top = 12
            Width = 28
            Height = 13
            Alignment = taRightJustify
            Caption = 'every'
          end
          object lblThWeek: TLabel
            Left = 243
            Top = 12
            Width = 32
            Height = 13
            Caption = '. week'
          end
          object lblOnWeek: TLabel
            Left = 149
            Top = 60
            Width = 12
            Height = 13
            Alignment = taRightJustify
            Caption = 'on'
          end
          object edtWeekly: TEdit
            Left = 167
            Top = 9
            Width = 54
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = '1'
            OnChange = edtWeeklyChange
          end
          object udWeekly: TUpDown
            Left = 221
            Top = 9
            Width = 16
            Height = 21
            Associate = edtWeekly
            Min = 1
            Max = 9999
            Position = 1
            TabOrder = 1
          end
          object chklstWeekdays: TCheckListBox
            Left = 167
            Top = 60
            Width = 185
            Height = 127
            OnClickCheck = chklstWeekdaysClickCheck
            BorderStyle = bsNone
            ItemHeight = 13
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7')
            TabOrder = 2
          end
        end
        object tsMonthly: TTabSheet
          ImageIndex = 2
          TabVisible = False
          object lblExecuteMonthly: TLabel
            Left = 12
            Top = 12
            Width = 103
            Height = 13
            Caption = 'Execute task monthly'
          end
          object lblDayOfMonth: TLabel
            Left = 102
            Top = 38
            Width = 71
            Height = 13
            Caption = '. day of month'
          end
          object lblMonth: TLabel
            Left = 12
            Top = 89
            Width = 39
            Height = 13
            Caption = 'Months:'
          end
          object lblOfMonth: TLabel
            Left = 240
            Top = 65
            Width = 62
            Height = 13
            Caption = 'of the month'
          end
          object edtEveryMonth: TEdit
            Left = 48
            Top = 35
            Width = 36
            Height = 21
            TabOrder = 0
            Text = '1'
            OnChange = edtEveryMonthChange
          end
          object udDayOfMonth: TUpDown
            Left = 84
            Top = 35
            Width = 16
            Height = 21
            Associate = edtEveryMonth
            Min = 1
            Max = 9999
            Position = 1
            TabOrder = 1
          end
          object rbOnFirstDay: TRadioButton
            Left = 12
            Top = 36
            Width = 30
            Height = 17
            Caption = 'at'
            TabOrder = 2
            OnClick = rbOnFirstDayClick
          end
          object rbOnMonthWeekday: TRadioButton
            Left = 12
            Top = 63
            Width = 30
            Height = 17
            Caption = 'at'
            TabOrder = 3
            OnClick = rbOnFirstDayClick
          end
          object cbbWeekOfMonth: TComboBox
            Left = 48
            Top = 62
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 4
            OnChange = cbbWeekOfMonthChange
            Items.Strings = (
              'first'
              'second'
              'third'
              'fourth'
              'last')
          end
          object cbbWeekdays: TComboBox
            Left = 144
            Top = 62
            Width = 90
            Height = 21
            Style = csDropDownList
            TabOrder = 5
            OnChange = cbbWeekdaysChange
            Items.Strings = (
              'Sunday'
              'Monday'
              'Tuesday'
              'Wednesday'
              'Thousday'
              'Friday'
              'Saturday')
          end
          object chklstMonths: TCheckListBox
            Left = 12
            Top = 108
            Width = 340
            Height = 87
            OnClickCheck = chklstMonthsClickCheck
            BorderStyle = bsNone
            Columns = 2
            ItemHeight = 13
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12')
            TabOrder = 6
          end
        end
        object tsIdle: TTabSheet
          Caption = 'tsIdle'
          ImageIndex = 4
          TabVisible = False
          object lblExecuteIdle: TLabel
            Left = 12
            Top = 12
            Width = 110
            Height = 13
            Caption = 'Execute task when idle'
          end
          object lblIdleTime: TLabel
            Left = 137
            Top = 12
            Width = 24
            Height = 13
            Alignment = taRightJustify
            Caption = 'after'
          end
          object lblIdleMin: TLabel
            Left = 243
            Top = 12
            Width = 45
            Height = 13
            Caption = 'minute(s)'
          end
          object edtIdleTime: TEdit
            Left = 167
            Top = 9
            Width = 54
            Height = 21
            Alignment = taRightJustify
            TabOrder = 0
            Text = '10'
            OnChange = edtIdleTimeChange
          end
          object udIdleTime: TUpDown
            Left = 221
            Top = 9
            Width = 16
            Height = 21
            Associate = edtIdleTime
            Min = 1
            Max = 999
            Position = 10
            TabOrder = 1
          end
        end
      end
      object pnlBoundarys: TPanel
        Left = 11
        Top = 128
        Width = 372
        Height = 51
        BevelOuter = bvNone
        TabOrder = 4
        object lblEndDate: TLabel
          Left = 252
          Top = 32
          Width = 12
          Height = 13
          Alignment = taRightJustify
          Caption = 'on'
        end
        object lblStartDate: TLabel
          Left = 252
          Top = 5
          Width = 12
          Height = 13
          Alignment = taRightJustify
          Caption = 'on'
        end
        object lblStarting: TLabel
          Left = 137
          Top = 5
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Caption = 'starts'
        end
        object cbbExecuteTask: TComboBox
          Left = 1
          Top = 0
          Width = 130
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnSelect = cbbExecuteTaskSelect
          Items.Strings = (
            'Daily'
            'Weekly'
            'Monthly'
            'Once'
            'At system start'
            'At logon'
            'When idle')
        end
        object chkExpires: TCheckBox
          Left = 190
          Top = 30
          Width = 51
          Height = 17
          Caption = 'expires'
          TabOrder = 1
          OnClick = dtpDateLastChange
        end
        object dtpDateFirst: TDateTimePicker
          Left = 270
          Top = 1
          Width = 100
          Height = 21
          Date = 41736.603203402780000000
          Time = 41736.603203402780000000
          TabOrder = 2
          OnChange = dtpTimeFirstChange
        end
        object dtpDateLast: TDateTimePicker
          Left = 270
          Top = 28
          Width = 100
          Height = 21
          Date = 41736.603203402780000000
          Time = 41736.603203402780000000
          TabOrder = 3
          OnChange = dtpDateLastChange
        end
        object dtpTimeFirst: TDateTimePicker
          Left = 171
          Top = 1
          Width = 70
          Height = 22
          Date = 41732.543752094910000000
          Time = 41732.543752094910000000
          Kind = dtkTime
          TabOrder = 4
          OnChange = dtpTimeFirstChange
        end
      end
    end
    object tsSettings: TTabSheet
      Caption = 'Settings'
      ImageIndex = 1
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 450
    Width = 422
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object btnOk: TButton
      Left = 178
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 259
      Top = 3
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btnApply: TButton
      Left = 340
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
    end
  end
end
