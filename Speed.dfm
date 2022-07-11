object FormCD: TFormCD
  Left = 271
  Top = 188
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'HDDSpeed 1.02'
  ClientHeight = 189
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CoolGroupBox1: TCoolGroupBox
    Left = 0
    Top = 0
    Width = 466
    Height = 159
    ShadowColor = clWhite
    Align = alClient
    Caption = 'Test drive'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object CoolLabel1: TCoolLabel
      Left = 8
      Top = 19
      Width = 29
      Height = 14
      Caption = 'Drive:'
    end
    object CoolLabel2: TCoolLabel
      Left = 32
      Top = 62
      Width = 54
      Height = 14
      Caption = 'CoolLabel2'
    end
    object Gauge1: TGauge
      Left = 24
      Top = 114
      Width = 417
      Height = 17
      Progress = 0
      ShowText = False
    end
    object CoolLabel3: TCoolLabel
      Left = 8
      Top = 133
      Width = 33
      Height = 14
      Caption = '0 Kb/s'
    end
    object CoolLabel4: TCoolLabel
      Left = 344
      Top = 133
      Width = 111
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 Kb/s '
    end
    object CoolLabel5: TCoolLabel
      Left = 168
      Top = 133
      Width = 129
      Height = 14
      ShadowColor = clWhite
      Alignment = taCenter
      AutoSize = False
      Caption = '0 Kb/s'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Gauge2: TGauge
      Left = 24
      Top = 78
      Width = 417
      Height = 17
      Progress = 0
    end
    object CoolLabel6: TCoolLabel
      Left = 8
      Top = 62
      Width = 20
      Height = 14
      Caption = 'File:'
    end
    object CoolLabel7: TCoolLabel
      Left = 8
      Top = 97
      Width = 78
      Height = 14
      Caption = 'Average Speed:'
    end
    object CoolLabel8: TCoolLabel
      Left = 280
      Top = 10
      Width = 49
      Height = 14
      Caption = 'Files read:'
    end
    object CoolLabel9: TCoolLabel
      Left = 331
      Top = 10
      Width = 7
      Height = 14
      Caption = '0'
    end
    object CoolLabel10: TCoolLabel
      Left = 280
      Top = 26
      Width = 73
      Height = 14
      Caption = 'Data read (Kb):'
    end
    object CoolLabel12: TCoolLabel
      Left = 354
      Top = 26
      Width = 7
      Height = 14
      Caption = '0'
    end
    object CoolLabel11: TCoolLabel
      Left = 280
      Top = 42
      Width = 102
      Height = 14
      Caption = 'Current speed (Kb/s):'
    end
    object CoolLabel13: TCoolLabel
      Left = 384
      Top = 42
      Width = 7
      Height = 14
      Caption = '0'
    end
    object Label1: TLabel
      Left = 16
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Label1'
      Visible = False
    end
    object RzDriveComboBox1: TRzDriveComboBox
      Left = 40
      Top = 16
      Width = 233
      Height = 21
      TabOrder = 0
      DriveTypes = [dtFloppy, dtFixed, dtNetwork, dtCDROM]
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 159
    Width = 466
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object abcURLLabel1: TabcURLLabel
      Left = 2
      Top = 15
      Width = 72
      Height = 13
      Cursor = crHandPoint
      Caption = 'online help >>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      URL = 'http://www.fant.boom.ru'
    end
    object Button3: TButton
      Left = 229
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 0
      Visible = False
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 310
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Test'
      Default = True
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 390
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Exit'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 104
    Top = 40
  end
end
