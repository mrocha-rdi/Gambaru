object formDebug: TformDebug
  Left = 206
  Top = 139
  BorderStyle = bsNone
  Caption = 'Cielti Studios - Gambaru (DEMO)'
  ClientHeight = 436
  ClientWidth = 647
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    647
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMovie: TPanel
    Left = 0
    Top = 0
    Width = 647
    Height = 436
    Align = alClient
    Color = clBlack
    TabOrder = 2
  end
  object GLSceneViewer1: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 647
    Height = 436
    Buffer.BackgroundColor = clBlack
    Align = alClient
  end
  object MediaPlayer: TMediaPlayer
    Left = 144
    Top = 104
    Width = 253
    Height = 30
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoEnable = False
    AutoRewind = False
    Display = pnlMovie
    Visible = False
    TabOrder = 0
  end
end
