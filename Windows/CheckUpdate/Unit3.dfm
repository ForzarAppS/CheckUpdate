object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1086#1084#1086#1097#1100
  ClientHeight = 147
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 585
    Height = 40
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 161
      Height = 13
      Caption = #1057#1054#1047#1044#1040#1053#1048#1045' '#1060#1040#1049#1051#1040' '#1053#1040' '#1071'.'#1044#1048#1057#1050#1045
    end
    object Button1: TButton
      Left = 544
      Top = 9
      Width = 25
      Height = 25
      Caption = #8744
      TabOrder = 0
      OnClick = Button1Click
    end
    object ScrollBox1: TScrollBox
      Left = 16
      Top = 46
      Width = 552
      Height = 250
      TabOrder = 1
      OnMouseWheelDown = ScrollBox1MouseWheelDown
      OnMouseWheelUp = ScrollBox1MouseWheelUp
      object Label6: TLabel
        Left = 3
        Top = 3
        Width = 211
        Height = 13
        Caption = '1. '#1057#1086#1079#1076#1072#1090#1100' '#1087#1072#1087#1082#1091' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1085#1072' '#1071'.'#1044#1080#1089#1082#1077':'
      end
      object Label2: TLabel
        Left = 3
        Top = 22
        Width = 355
        Height = 13
        Caption = '2. '#1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1087#1091#1089#1090#1086#1081' '#1092#1072#1081#1083' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1074' '#1087#1072#1087#1082#1091' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'.'
      end
      object Label3: TLabel
        Left = 3
        Top = 41
        Width = 254
        Height = 13
        Caption = '3. '#1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1092#1072#1081#1083' '#1087#1086' '#1089#1083#1077#1076#1091#1102#1097#1080#1084' '#1087#1088#1072#1074#1080#1083#1072#1084':'
      end
      object Label4: TLabel
        Left = 19
        Top = 60
        Width = 348
        Height = 13
        Caption = '"<'#1085#1072#1079#1074#1072#1085#1080#1077'_'#1087#1088#1086#1075#1088#1072#1084#1084#1099'('#1087#1083#1072#1090#1092#1086#1088#1084#1072')>_v_<'#1074#1077#1088#1089#1080#1103'_'#1087#1088#1086#1075#1088#1072#1084#1084#1099'>.txt".'
      end
      object Label5: TLabel
        Left = 19
        Top = 79
        Width = 262
        Height = 13
        Caption = #1053#1072#1087#1088#1080#1084#1077#1088', "CU(a)_v_1.0.txt" '#1080#1083#1080' "CU(w)_v_1.0.txt".'
      end
      object Label7: TLabel
        Left = 220
        Top = 3
        Width = 160
        Height = 13
        Cursor = crHandPoint
        Hint = 'https://disk.yandex.ru/client/disk'
        Caption = 'https://disk.yandex.ru/client/disk'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label7Click
      end
      object Label8: TLabel
        Left = 19
        Top = 98
        Width = 303
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099': '#1085#1072#1087#1088#1080#1084#1077#1088', '#1087#1077#1088#1074#1099#1077' '#1073#1091#1082#1074#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'.'
      end
      object Label9: TLabel
        Left = 19
        Top = 117
        Width = 123
        Height = 13
        Caption = #1055#1083#1072#1090#1092#1086#1088#1084#1072': '#1085#1072#1087#1088#1080#1084#1077#1088', "'
      end
      object Label10: TLabel
        Left = 19
        Top = 136
        Width = 241
        Height = 13
        Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099': '#1085#1072#1087#1088#1080#1084#1077#1088', "1.0" '#1080#1083#1080' "1.0.1".'
      end
      object Label11: TLabel
        Left = 19
        Top = 155
        Width = 140
        Height = 13
        Caption = #1053#1077#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1099#1081' '#1072#1088#1075#1091#1084#1077#1085#1090':'
      end
      object Label12: TLabel
        Left = 19
        Top = 193
        Width = 376
        Height = 13
        Caption = 
          #1057#1089#1099#1083#1082#1072' '#1085#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077': '#1089#1089#1099#1083#1082#1072' '#1085#1072' '#1092#1072#1081#1083' '#1089' '#1071'.'#1044#1080#1089#1082#1072' '#1073#1077#1079' "https://yadi' +
          '.sk/d/".'
      end
      object Label13: TLabel
        Left = 19
        Top = 174
        Width = 490
        Height = 13
        Caption = 
          '"<'#1085#1072#1079#1074#1072#1085#1080#1077'_'#1087#1088#1086#1075#1088#1072#1084#1084#1099'('#1087#1083#1072#1090#1092#1086#1088#1084#1072')>_v_<'#1074#1077#1088#1089#1080#1103'_'#1087#1088#1086#1075#1088#1072#1084#1084#1099'>_<'#1089#1089#1099#1083#1082#1072'_'#1085#1072 +
          '_'#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077'>.txt".'
      end
      object Label27: TLabel
        Left = 386
        Top = 3
        Width = 4
        Height = 13
        Caption = '.'
      end
      object Label28: TLabel
        Left = 19
        Top = 212
        Width = 240
        Height = 13
        Caption = #1060#1072#1081#1083#1099' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081' '#1085#1072#1076#1086' '#1079#1072#1075#1088#1091#1078#1072#1090#1100' '#1085#1072' '#1071'.'#1044#1080#1089#1082'.'
      end
      object Label29: TLabel
        Left = 145
        Top = 117
        Width = 6
        Height = 13
        Caption = 'a'
        OnDblClick = Label29DblClick
      end
      object Label30: TLabel
        Left = 154
        Top = 117
        Width = 80
        Height = 13
        Caption = '" '#8211' android '#1080#1083#1080' "'
      end
      object Label31: TLabel
        Left = 237
        Top = 117
        Width = 8
        Height = 13
        Caption = 'w'
        OnDblClick = Label31DblClick
      end
      object Label32: TLabel
        Left = 248
        Top = 117
        Width = 61
        Height = 13
        Caption = '" '#8211' windows.'
      end
    end
    object Polosa1: TPanel
      Left = 16
      Top = 39
      Width = 552
      Height = 1
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 54
    Width = 585
    Height = 40
    TabOrder = 1
    object Label14: TLabel
      Left = 16
      Top = 13
      Width = 124
      Height = 13
      Caption = #1056#1040#1041#1054#1058#1040' '#1057' '#1055#1056#1054#1043#1056#1040#1052#1052#1054#1049
    end
    object Button2: TButton
      Left = 544
      Top = 9
      Width = 25
      Height = 25
      Caption = #8744
      TabOrder = 0
      OnClick = Button1Click
    end
    object ScrollBox2: TScrollBox
      Left = 16
      Top = 46
      Width = 552
      Height = 250
      TabOrder = 1
      OnMouseWheelDown = ScrollBox1MouseWheelDown
      OnMouseWheelUp = ScrollBox1MouseWheelUp
      object Label15: TLabel
        Left = 3
        Top = 3
        Width = 394
        Height = 13
        Caption = 
          '1. '#1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1077#1088#1074#1086#1077' '#1087#1086#1083#1077' '#1074#1074#1086#1076#1072' '#1089#1089#1099#1083#1082#1086#1081' '#1089' '#1071'.'#1044#1080#1089#1082#1072' '#1085#1072' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086 +
          #1082#1091#1084#1077#1085#1090':'
      end
      object Label16: TLabel
        Left = 19
        Top = 22
        Width = 284
        Height = 13
        Caption = #1042' '#1089#1089#1099#1083#1082#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086' '#1076#1086#1083#1078#1085#1086' '#1073#1099#1090#1100' "https://yadi.sk/d/".'
      end
      object Label17: TLabel
        Left = 19
        Top = 41
        Width = 339
        Height = 13
        Caption = #1055#1088#1080' '#1074#1089#1090#1072#1074#1082#1077' '#1083#1102#1073#1086#1081' '#1076#1088#1091#1075#1086#1081' '#1089#1089#1099#1083#1082#1080' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081' '#1085#1072#1081#1076#1077#1085#1086' '#1085#1077' '#1073#1091#1076#1077#1090'.'
      end
      object Label18: TLabel
        Left = 3
        Top = 60
        Width = 321
        Height = 13
        Caption = '2. '#1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1074#1090#1086#1088#1086#1077' '#1087#1086#1083#1077' '#1074#1074#1086#1076#1072' '#1090#1077#1082#1091#1097#1077#1081' '#1074#1077#1088#1089#1080#1077#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
      end
      object Label21: TLabel
        Left = 3
        Top = 98
        Width = 544
        Height = 26
        Caption = 
          '3. '#1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1073#1091#1076#1077#1090' '#1085#1072#1081#1076#1077#1085#1086', '#1077#1089#1083#1080' '#1085#1072#1079#1074#1072#1085#1080#1077#1081' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072 +
          ' '#1087#1086' '#1089#1089#1099#1083#1082#1077' '#1085#1077' '#1073#1091#1076#1077#1090' '#1088#1072#1074#1085#1086' '#1074#1090#1086#1088#1086#1084#1091' '#1087#1086#1083#1102' '#1074#1074#1086#1076#1072'.'
        WordWrap = True
      end
      object Label23: TLabel
        Left = 19
        Top = 79
        Width = 129
        Height = 13
        Caption = #1053#1072#1087#1088#1080#1084#1077#1088', 1.0 '#1080#1083#1080' 1.0.1 .'
      end
    end
    object Polosa2: TPanel
      Left = 16
      Top = 39
      Width = 552
      Height = 1
      TabOrder = 2
    end
  end
  object Panel3: TPanel
    Left = 8
    Top = 100
    Width = 585
    Height = 40
    TabOrder = 2
    object Label19: TLabel
      Left = 16
      Top = 13
      Width = 156
      Height = 13
      Caption = #1048#1057#1055#1054#1051#1068#1047#1054#1042#1040#1053#1048#1045' '#1055#1056#1054#1043#1056#1040#1052#1052#1067
    end
    object Button3: TButton
      Left = 544
      Top = 9
      Width = 25
      Height = 25
      Caption = #8744
      TabOrder = 0
      OnClick = Button1Click
    end
    object ScrollBox3: TScrollBox
      Left = 16
      Top = 46
      Width = 552
      Height = 250
      TabOrder = 1
      OnMouseWheelDown = ScrollBox1MouseWheelDown
      OnMouseWheelUp = ScrollBox1MouseWheelUp
      object Label20: TLabel
        Left = 3
        Top = 3
        Width = 541
        Height = 26
        Caption = 
          #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1103#1074#1083#1103#1077#1090#1089#1103' '#1076#1077#1084#1086#1085#1089#1090#1088#1072#1094#1080#1086#1085#1085#1099#1084' '#1087#1088#1086#1077#1082#1090#1086#1084' '#1089' '#1086#1090#1082#1088#1099#1090#1099#1084' '#1080#1089#1093#1086#1076#1085#1099#1084 +
          ' '#1082#1086#1076#1086#1084', '#1082#1086#1090#1086#1088#1099#1081' ('#1073#1077#1089#1087#1083#1072#1090#1085#1086', '#1073#1077#1079' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1089#1077#1088#1074#1077#1088#1072') '#1088#1077#1072#1083#1080#1079#1091#1077#1090 +
          ' '#1087#1088#1086#1074#1077#1088#1082#1091' '#1085#1072' '#1085#1072#1083#1080#1095#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103'.'
        WordWrap = True
      end
      object Label22: TLabel
        Left = 3
        Top = 54
        Width = 368
        Height = 13
        Caption = 
          #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103', '#1095#1090#1086#1073#1099' '#1087#1088#1086#1074#1077#1088#1103#1083#1080#1089#1100' '#1090#1086#1083#1100#1082#1086' '#1073#1086#1083#1077#1077' '#1085#1086#1074#1099#1077' '#1074#1077#1088#1089#1080#1080 +
          '.'
      end
      object Label24: TLabel
        Left = 3
        Top = 35
        Width = 105
        Height = 13
        Caption = #1042#1086#1079#1084#1086#1078#1085#1086' '#1076#1086#1073#1072#1074#1080#1090#1100':'
      end
    end
    object Polosa3: TPanel
      Left = 16
      Top = 39
      Width = 552
      Height = 1
      TabOrder = 2
    end
  end
end
