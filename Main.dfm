object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 100
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 25
    Width = 69
    Height = 13
    Caption = 'YOUR_APIKEY'
  end
  object Label2: TLabel
    Left = 16
    Top = 63
    Width = 55
    Height = 13
    Caption = 'YOUR_FILE'
  end
  object Button1: TButton
    Left = 322
    Top = 57
    Width = 75
    Height = 25
    Caption = 'Select File'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 91
    Top = 21
    Width = 387
    Height = 21
    TabOrder = 1
  end
  object Button2: TButton
    Left = 403
    Top = 57
    Width = 75
    Height = 25
    Caption = 'Recognize'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 91
    Top = 59
    Width = 225
    Height = 21
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Left = 136
    Top = 17
  end
end
