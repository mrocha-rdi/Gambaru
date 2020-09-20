object DMEngine: TDMEngine
  OldCreateOrder = False
  Left = 259
  Top = 150
  Height = 419
  Width = 484
  object GLScene: TGLScene
    ObjectsSorting = osNone
    Left = 112
    Top = 8
    object GLSkyBox1: TGLSkyBox
      Direction.Coordinates = {9598A23144F7DFB20000803F00000000}
      Position.Coordinates = {0000000000004040000000000000803F}
      Scale.Coordinates = {6F12833A6F12833A6F12833A00000000}
      Up.Coordinates = {1DB356B30000803FB3FA87B300000000}
      MaterialLibrary = GLMaterialLibrary1
      MatNameTop = 'Top'
      MatNameBottom = 'Bottom'
      MatNameLeft = 'Left'
      MatNameRight = 'Right'
      MatNameFront = 'Front'
      MatNameBack = 'Back'
      CloudsPlaneOffset = 0.200000002980232200
      CloudsPlaneSize = 32.000000000000000000
      object GLLightSource1: TGLLightSource
        Ambient.Color = {BEC0403FBEC0403FBEC0403F0000803F}
        ConstAttenuation = 1.000000000000000000
        QuadraticAttenuation = 0.000099999997473788
        Position.Coordinates = {000088C100003042C0C6B5420000803F}
        LightStyle = lsOmni
        SpotCutOff = 180.000000000000000000
      end
    end
    object lscScene06: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {0000804000006041000010410000803F}
      SpotCutOff = 50.000000000000000000
      SpotDirection.Coordinates = {000080BF000080BF0000000000000000}
    end
    object lscScene05: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {000080C000006041000010410000803F}
      SpotCutOff = 50.000000000000000000
      SpotDirection.Coordinates = {0000803F000080BF0000000000000000}
    end
    object lscScene04: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {000080400000604100000C420000803F}
      SpotCutOff = 50.000000000000000000
      SpotDirection.Coordinates = {000080BF000080BF0000000000000000}
    end
    object lscScene03: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {000080C00000604100000C420000803F}
      SpotCutOff = 50.000000000000000000
      SpotDirection.Coordinates = {0000803F000080BF0000000000000000}
    end
    object lscScene02: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {0000804000006041000034420000803F}
      SpotCutOff = 50.000000000000000000
      SpotDirection.Coordinates = {000080BF000080BF0000000000000000}
    end
    object lscScene01: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {000080C000006041000034420000803F}
      SpotCutOff = 50.000000000000000000
      SpotDirection.Coordinates = {0000803F000080BF0000000000000000}
    end
    object CameraControlCube: TGLDummyCube
      Direction.Coordinates = {0000000000000000000080BF00000000}
      Position.Coordinates = {0000803F0000804000005C420000803F}
      CubeSize = 0.100000001490116100
      object GLCamera: TGLCamera
        DepthOfView = 1000.000000000000000000
        FocalLength = 200.000000000000000000
        Direction.Coordinates = {00000000000000000000803F00000000}
        Up.Coordinates = {000000000000803F0000008000000000}
      end
    end
    object ffmScene: TGLFreeForm
      Direction.Coordinates = {00000000000000800000803F00000000}
      Scale.Coordinates = {9A99193E9A99193E9A99193E00000000}
      MaterialLibrary = GLMaterialLibrary
    end
    object DummyCubePosicaoMedia: TGLDummyCube
      Direction.Coordinates = {00000000000000800000803F00000000}
      CubeSize = 1.000000000000000000
    end
    object DummyCube: TGLDummyCube
      Direction.Coordinates = {00000000000000800000803F00000000}
      Position.Coordinates = {000070410000803F000000000000803F}
      Visible = False
      CubeSize = 0.100000001490116100
    end
    object lblPontosDeVida: TGLLabel
      RedrawAtOnce = False
      GuiLayout = GLGuiLayout
      NoZWrite = False
      DoChangesOnProgress = False
      Width = 50.000000000000000000
      Height = 50.000000000000000000
      Top = -15.000000000000000000
      Position.Coordinates = {00000000000070C1000000000000803F}
      BitmapFont = GLWindowsBitmapFont
      DefaultColor = clBlack
      Caption = 'Vida :'
      Alignment = taLeftJustify
      TextLayout = tlCenter
    end
    object lblLoading: TGLLabel
      RedrawAtOnce = False
      GuiLayout = GLGuiLayout
      NoZWrite = False
      DoChangesOnProgress = False
      Visible = False
      Width = 1.000000000000000000
      Height = 1.000000000000000000
      Top = -15.000000000000000000
      Position.Coordinates = {00000000000070C1000000000000803F}
      BitmapFont = fntLoading
      DefaultColor = clWhite
      Caption = 'Carregando...'
      Alignment = taCenter
      TextLayout = tlCenter
    end
    object lblFrase: TGLLabel
      RedrawAtOnce = False
      GuiLayout = GLGuiLayout
      NoZWrite = False
      DoChangesOnProgress = False
      Width = 50.000000000000000000
      Height = 50.000000000000000000
      BitmapFont = GLWindowsBitmapFont
      DefaultColor = clWhite
      Alignment = taLeftJustify
      TextLayout = tlCenter
    end
    object lblGameOver: TGLLabel
      RedrawAtOnce = False
      GuiLayout = GLGuiLayout
      NoZWrite = False
      DoChangesOnProgress = False
      Visible = False
      Width = 1.000000000000000000
      Height = 1.000000000000000000
      Top = -15.000000000000000000
      Position.Coordinates = {00000000000070C1000000000000803F}
      BitmapFont = fntLoading
      DefaultColor = clWhite
      Caption = 'GAME OVER'
      Alignment = taCenter
      TextLayout = tlCenter
    end
    object PFXRenderer: TGLParticleFXRenderer
    end
    object sprLogo: TGLHUDSprite
      Material.Texture.Disabled = False
      Position.Coordinates = {0000C84300009643000000000000803F}
      Width = 238.000000000000000000
      Height = 238.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object sprMain: TGLHUDSprite
      Material.Texture.Disabled = False
      Position.Coordinates = {0000C84300009643000000000000803F}
      Visible = False
      Width = 304.000000000000000000
      Height = 153.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object sprSejiro: TGLHUDSprite
      Material.Texture.Disabled = False
      Position.Coordinates = {0000C84300009643000000000000803F}
      Visible = False
      Width = 78.000000000000000000
      Height = 96.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object sprMitsuake: TGLHUDSprite
      Material.Texture.Disabled = False
      Position.Coordinates = {0000C84300009643000000000000803F}
      Visible = False
      Width = 78.000000000000000000
      Height = 96.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object sprDemiOni: TGLHUDSprite
      Material.Texture.Disabled = False
      Position.Coordinates = {0000C84300009643000000000000803F}
      Visible = False
      Width = 78.000000000000000000
      Height = 96.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object sprOni: TGLHUDSprite
      Material.Texture.Disabled = False
      Position.Coordinates = {0000C84300009643000000000000803F}
      Visible = False
      Width = 78.000000000000000000
      Height = 96.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object sprEnergy: TGLHUDSprite
      Material.FrontProperties.Ambient.Color = {0000803F00000000000000000000803F}
      Position.Coordinates = {000000000000F041000000000000803F}
      Visible = False
      Width = 16.000000000000000000
      Height = 16.000000000000000000
      NoZWrite = False
      MirrorU = False
      MirrorV = False
    end
    object GameMenu: TGLGameMenu
      Visible = False
      Font = GLWindowsBitmapFont
      Items.Strings = (
        'Iniciar Demonstracao'
        'Creditos'
        'Sair')
      Selected = 0
    end
    object dcFogueira: TGLDummyCube
      Position.Coordinates = {48E115C29A9919BF33331FC10000803F}
      CubeSize = 1.000000000000000000
    end
    object dcSaida: TGLDummyCube
      CubeSize = 1.000000000000000000
    end
    object alExit: TGLArrowLine
      Visible = False
      BottomRadius = 0.100000001490116100
      Height = 1.000000000000000000
      TopRadius = 0.100000001490116100
      HeadStackingStyle = ahssIncluded
      TopArrowHeadHeight = 0.500000000000000000
      TopArrowHeadRadius = 0.200000002980232200
      BottomArrowHeadHeight = 0.500000000000000000
      BottomArrowHeadRadius = 0.200000002980232200
    end
  end
  object GLNavigator: TGLNavigator
    MoveUpWhenMovingForward = False
    InvertHorizontalSteeringWhenUpsideDown = False
    VirtualUp.Coordinates = {000000000000803F000000000000803F}
    MovingObject = DummyCube
    UseVirtualUp = True
    AutoUpdateObject = False
    AngleLock = False
    Left = 360
    Top = 280
  end
  object GLUserInterface: TGLUserInterface
    InvertMouse = False
    MouseSpeed = 20.000000000000000000
    GLNavigator = GLNavigator
    Left = 392
    Top = 16
  end
  object GLSceneViewer: TGLFullScreenViewer
    Camera = GLCamera
    Width = 800
    Height = 600
    StayOnTop = True
    RefreshRate = 0
    Left = 24
    Top = 64
  end
  object GLGuiLayout: TGLGuiLayout
    BitmapFont = GLWindowsBitmapFont
    GuiComponents = <>
    Left = 392
    Top = 72
  end
  object GLSoundLibrary: TGLSoundLibrary
    Samples = <>
    Left = 24
    Top = 128
  end
  object GLSMBASS: TGLSMBASS
    Active = True
    MaxChannels = 32
    MasterVolume = 1.000000000000000000
    Sources = <>
    Left = 112
    Top = 128
  end
  object GLMaterialLibrary: TGLMaterialLibrary
    TexturePaths = '.\modelos'
    Left = 32
    Top = 192
  end
  object GLWindowsBitmapFont: TGLWindowsBitmapFont
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = []
    Left = 392
    Top = 128
  end
  object PolygonFXManager: TGLPolygonPFXManager
    Renderer = PFXRenderer
    Acceleration.Coordinates = {00000000CDCC4CBE0000000000000000}
    Friction = 2.000000000000000000
    NbSides = 9
    ParticleSize = 0.300000011920929000
    LifeColors = <
      item
        ColorInner.Color = {0000803F0000803F000000000000803F}
        ColorOuter.Color = {00000000000000000000803F00000000}
        LifeTime = 3.000000000000000000
        SizeScale = 1.000000000000000000
      end
      item
        ColorInner.Color = {0AD7A33E48E1FA3E1F85EB3E0000803F}
        ColorOuter.Color = {0000803F000000000000000000000000}
        LifeTime = 6.000000000000000000
        SizeScale = 1.000000000000000000
      end
      item
        LifeTime = 9.000000000000000000
        SizeScale = 1.000000000000000000
      end>
    Left = 112
    Top = 296
  end
  object mlibTextures: TGLMaterialLibrary
    Left = 112
    Top = 240
  end
  object LogoTimer: TTimer
    Interval = 13500
    OnTimer = LogoTimerTimer
    Left = 200
    Top = 128
  end
  object fntLoading: TGLWindowsBitmapFont
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -37
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    Left = 392
    Top = 176
  end
  object FraseTimer: TTimer
    Enabled = False
    OnTimer = FraseTimerTimer
    Left = 200
    Top = 176
  end
  object InitLevelTimer: TTimer
    Enabled = False
    Interval = 28000
    OnTimer = InitLevelTimerTimer
    Left = 200
    Top = 224
  end
  object IntroTimer: TTimer
    Interval = 3
    OnTimer = IntroTimerTimer
    Left = 200
    Top = 80
  end
  object TrackLoopTimer: TTimer
    Enabled = False
    OnTimer = TrackLoopTimerTimer
    Left = 256
    Top = 312
  end
  object GLFireFXManager1: TGLFireFXManager
    FireDir.Coordinates = {00000000000000000000000000000000}
    InitialDir.Coordinates = {00000000000000000000000000000000}
    MaxParticles = 500
    ParticleSize = 0.699999988079071000
    FireDensity = 1.000000000000000000
    FireEvaporation = 0.860000014305114700
    FireBurst = 2.000000000000000000
    FireRadius = 0.500000000000000000
    Disabled = False
    Paused = False
    ParticleInterval = 0.009999999776482582
    UseInterval = True
    Left = 280
    Top = 32
  end
  object GLMaterialLibrary1: TGLMaterialLibrary
    Left = 32
    Top = 256
  end
end
