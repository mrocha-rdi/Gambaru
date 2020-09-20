unit Engine;

interface

uses
  Forms, Controls, Windows, SysUtils, Classes, ExtCtrls, GLScene, GLWin32FullScreenViewer,
  GLNavigator, GLVectorFileObjects, GLObjects, GLGeomObjects, GLMisc,
  GLSkydome, GLCadencer, GLCollision, Dialogs, GLGui, GLWindows, GLSound,
  GLSMBASS, util, GLTexture, GLBitmapFont, GLWindowsFont, GLParticleFX,
  GLTilePlane, GLGraph, VectorGeometry, VectorTypes, GLHeightData,
  GLTerrainRenderer, GLFile3DS, fighter, physic, army,
  GLFireFX, GLLensFlare, GLSkyBox, tga, GLHUDObjects, GLGameMenu, MPlayer, GLWin32Viewer,
  GLShadowPlane, Level, GLTree;

type
  TDMEngine = class(TDataModule)
    PFXRenderer: TGLParticleFXRenderer;
    GLScene: TGLScene;
    GLCamera: TGLCamera;
    DummyCubePosicaoMedia: TGLDummyCube;
    DummyCube: TGLDummyCube;
    GLNavigator: TGLNavigator;
    GLUserInterface: TGLUserInterface;
    GLSceneViewer: TGLFullScreenViewer;

    GLGuiLayout: TGLGuiLayout;
    GLSoundLibrary: TGLSoundLibrary;
    GLSMBASS: TGLSMBASS;
    GLMaterialLibrary: TGLMaterialLibrary;
    lblPontosDeVida: TGLLabel;
    GLWindowsBitmapFont: TGLWindowsBitmapFont;
    PolygonFXManager: TGLPolygonPFXManager;
    mlibTextures: TGLMaterialLibrary;
    ffmScene: TGLFreeForm;
    CameraControlCube: TGLDummyCube;
    lscScene01: TGLLightSource;
    sprLogo: TGLHUDSprite;
    LogoTimer: TTimer;
    sprMain: TGLHUDSprite;
    GameMenu: TGLGameMenu;
    lblLoading: TGLLabel;
    fntLoading: TGLWindowsBitmapFont;
    sprSejiro: TGLHUDSprite;
    lblFrase: TGLLabel;
    FraseTimer: TTimer;
    sprMitsuake: TGLHUDSprite;
    sprDemiOni: TGLHUDSprite;
    sprOni: TGLHUDSprite;
    InitLevelTimer: TTimer;
    IntroTimer: TTimer;
    lblGameOver: TGLLabel;
    sprEnergy: TGLHUDSprite;
    TrackLoopTimer: TTimer;
    lscScene02: TGLLightSource;
    lscScene03: TGLLightSource;
    lscScene04: TGLLightSource;
    lscScene05: TGLLightSource;
    lscScene06: TGLLightSource;
    GLFireFXManager1: TGLFireFXManager;
    GLSkyBox1: TGLSkyBox;
    GLMaterialLibrary1: TGLMaterialLibrary;
    GLLightSource1: TGLLightSource;
    dcFogueira: TGLDummyCube;
    dcSaida: TGLDummyCube;
    alExit: TGLArrowLine;
    procedure HandleKeysLevel(const deltaTime: Double);
    procedure GLCadencerProgress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure CollisionManagerCollision(Sender: TObject; object1,
      object2: TGLBaseSceneObject);
    procedure GLHeightField1GetHeight(const x, y: Single; var z: Single;
      var color: TVector4f; var texPoint: TTexPoint);
    procedure LogoTimerTimer(Sender: TObject);
    procedure FraseTimerTimer(Sender: TObject);
    procedure InitLevelTimerTimer(Sender: TObject);
    procedure IntroTimerTimer(Sender: TObject);
    procedure TrackLoopTimerTimer(Sender: TObject);
    procedure MediaPlayerExit(Sender: TObject);
    procedure DoLevelIntro;
  private
    estadovideo: integer;
    FGameState: TGameState;
    FPhysic: TPhysic;
    FCollisionManager: TCollisionManager;
    FGLCadencer: TGLCadencer;
    gameover: Boolean;
    levelcomplete: Boolean;
    FArmyJogador: TArmy;
    FArmyInimigo: TArmy;
    FNumeroColisoesMesmoArmy: Integer;
    FMediaPlayer: TMediaPlayer;
    FMediaPlayerx: TMediaPlayer;
    MediaPlayerDisplayRect: TRect;
    displayzerado: Trect;
    FSceneViewer: TGLSceneViewer;
    FPanelDisplayMovie: TPanel;
    CurrentTrack: Integer;
    CurrentLevel: Integer;
    GameLevel: TGambaruLevel;
    Levels: TList;

    procedure UpdateGUI;
    procedure UpdateCollisions;
    procedure UpdateCharacters;
    procedure UpdatePhysic;

    procedure InitCharacters;
    procedure InitScene;
    procedure InitPhysic;
    procedure InitCamera;
    procedure InitGUI;

    procedure AddFighter(x,y,z: Single; life: Integer; FighterType: TFighterType; LevelBoss: Boolean;  Army: TArmy; Territorio: TGLDummyCube; Leader: Boolean);
    procedure AddActor(fighter: TFighter; posx, posy, posz: Single);
    procedure LoadSound(pFileName, pSoundName: String; Playing: Boolean; pOrigin: TGLBaseSceneObject);
    function LoadTexture(MatName, FileName: string): TGLLibMaterial;
    function LoadSkyDome(MatName, FileName: string): TGLLibMaterial;
    procedure LoadSprites;
    procedure InternalExecutarAcoes(Army, Contra: TArmy);

    procedure ShowFrase(fighterType: TFighterType; Frase: String; Interval: Integer);
    procedure ClearFrase;
    procedure PlayMovie(fileName: String);
    procedure PlayTrack(trackIndex: Integer; Loop: Boolean; trackInterval: Integer = 0);

    function get_PosicaoMediaArmys: TAffineVector;
    function get_Physic: TPhysic;
    function get_GLCadencer: TGLCadencer;
    function get_ArmyInimigo: TArmy;
    function get_ArmyJogador: TArmy;

    procedure set_GameState(Value: TGameState);
    function get_CollisionManager: TCollisionManager;
    function get_MediaPlayerx: TMediaPlayer;
  public
    {TODO: Variaveis publicas altamente revoltadas}
    FBlah: Single;
    FCont: Integer;

    procedure LoadScript;
    procedure DestroyPreviousLevel;
    procedure ParserScript(code: TStringList; startIndex, endIndex: Integer; out errors: String);
    procedure ParserLevelDivision(code: TStringList; startIndex, endIndex: Integer; out errors: String);
    procedure Init;
    procedure HandleKeysMenu(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    property Physic: TPhysic read get_Physic;
    property CollisionManager: TCollisionManager read get_CollisionManager;
    property GLCadencer: TGLCadencer read get_GLCadencer;

    property ArmyJogador: TArmy read get_ArmyJogador;
    property ArmyInimigo: TArmy read get_ArmyInimigo;
    property PosicaoMediaArmys: TAffineVector read get_PosicaoMediaArmys;
    property NumeroColisoesMesmoArmy: Integer read FNumeroColisoesMesmoArmy write FNumeroColisoesMesmoArmy;

    property GameState: TGameState read FGameState write set_GameState;
    property MediaPlayer: TMediaPlayer read FMediaPlayer write FMediaPlayer;
    property SceneViewer: TGLSceneViewer read FSceneViewer write FSceneViewer;

    property PanelDisplayMovie: TPanel read FPanelDisplayMovie write FPanelDisplayMovie;

    property MediaPlayerx: TMediaPlayer read     get_MediaPlayerx;
  end;

var
  DMEngine: TDMEngine;

implementation

{$R *.dfm}

uses GLFileSMD, Jpeg, Keyboard, constantes, XCollection,
     oni, sejiro, mitsuake, katsome, demioni,
     weapon, mitsuakekatana, sejirokatana, demionikatana, onikatana;

procedure TDMEngine.GLCadencerProgress(Sender: TObject;
  const deltaTime, newTime: Double);
begin
  // "MAIN LOOP"
  HandleKeysLevel(deltaTime);
  UpdateCharacters;
  UpdateCollisions;
  UpdatePhysic;
  UpdateGUI;
  //UpdateSpecialFX;

end;

procedure TDMEngine.HandleKeysLevel(const deltaTime: Double);
var
  SejiroCube: TGLDummyCube;
begin
  if (ArmyJogador.Lider.State = fsDead) or
     (not (FGameState in [stLevelIntro, stLevel])) then Exit;

  SejiroCube := ArmyJogador.Lider.Cubo;

  if IsKeyDown(VK_UP) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle + 180;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_DOWN) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_LEFT) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle - 90;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_RIGHT) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle + 90;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_UP) and IsKeyDown(VK_RIGHT) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle + 135;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_UP) and IsKeyDown(VK_LEFT) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle - 135;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_DOWN) and IsKeyDown(VK_RIGHT) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle + 45;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if IsKeyDown(VK_DOWN) and IsKeyDown(VK_LEFT) then
  begin
    SejiroCube.Direction := CameraControlCube.Direction;
    SejiroCube.TurnAngle := SejiroCube.TurnAngle - 45;
    ArmyJogador.Lider.IsRunning := true;
  end;

  if not (IsKeyDown(VK_UP) or IsKeyDown(VK_DOWN) or IsKeyDown(VK_LEFT) or IsKeyDown(VK_RIGHT)) then
  begin
    if ArmyJogador.Lider.IsRunning then
    begin
      SejiroCube.Direction := SejiroCube.Direction;
      SejiroCube.TurnAngle := SejiroCube.TurnAngle;
      ArmyJogador.Lider.Parar;
    end;

    if IsKeydown(VK_SPACE) then
      ArmyJogador.Lider.Atacar;
    
  end
  else
    ArmyJogador.Lider.Andar(0);
end;

procedure TDMEngine.CollisionManagerCollision(Sender: TObject; object1,
  object2: TGLBaseSceneObject);
var
  f1, f2 : TFighter;
  w1, w2 : TWeapon;
  bColisaoEntreArmas, bColisaoEntreFighters: Boolean;

  procedure TrataColisaoEntreArmas;
  begin

  end;

  procedure TrataColisaoEntreFighters;
  begin

  end;

  procedure TrataColisaoArmaFighter;
  var
    weapon: TWeapon;
    fighter: TFighter;
  begin
    if Assigned(w1) then
      weapon := w1
    else
      weapon := w2;

    if (not weapon.Atacando) or (weapon.CausouDano)  then Exit;

    if Assigned(f1) then
      fighter := f1
    else
      fighter := f2;

    if (fighter.weapon = weapon) or (fighter.State = fsDead) then Exit;

    if fighter.PontosDeVida > 0 then
      fighter.PontosDeVida := fighter.PontosDeVida - 1;

    weapon.CausouDano := True;

    if (fighter.PontosDeVida <= 0) then
    begin
      ShowFrase(fighter.FighterType, 'Arghh...', 4000);
      fighter.Morrer;

      if fighter.FighterType = ftSejiro then
      begin
        //CollisionManager.OnCollision := nil;
        gameover := true;
        //GameState := stGameOver
      end
      else if fighter.isBoss then
      begin
        //CollisionManager.OnCollision := nil;
        levelcomplete := true;
        //GameState := stLevelComplete
      end
(*      else
      begin
          if (not fighter.isFriend) and
             (TArmy(fighter.Army).EfetivoMitsuake = 0) and
             (TArmy(fighter.Army).EfetivoDemiOni = 0) then
          begin
            //VERSIONAMENTO:
            //DATA: 09.12.2007.
            //DESCRIÇÃO: EXISTE LIMITADOR DE LUZES EM UMA CENA (8 RECOMENDADO PELA OPENGL)
            //           PORÉM ARQUI UTILIZEI APENAS 06 (SEIS).
            //           AS LUZES DO PATAMAR SUPERIOR FICAM APAGADAS ATÉ O ONI APARECER,
            //           QUANDO ELE APARECE, MIGRAMOS AS POSIÇÕES DE LUZES JÁ EXISTENTES.
            lscScene01.Position.Z := -13.0;
            lscScene02.Position.Z := -13.0;
            lscScene03.Position.Z := -23.0;
            lscScene04.Position.Z := -23.0;
            lscScene05.Position.Z := -42.0;
            lscScene06.Position.Z := -42.0;
//            AddFighter(0,8,-42,75,ftOni, True, ArmyInimigo, nil);
//            TODO_DSL
            AddFighter(0,16,-42,75,ftOni, True, ArmyInimigo, nil, true);
            Physic.Apply(ArmyInimigo);
            PlayTrack(ONI_TRACK_THEME, True, INTERVAL_ONI_TRACK);
            ShowFrase(ftOni, 'Eu o impedirei de recuperar a Lanterna, Sejiro !', 8000);
          end  ;
      end *);
    end
    else
      fighter.Apanhar;

  end;


begin

{ TODO: Aqui da pra usar algum esquema bem mais legal q esse monte de IF. É
  interessante notar que poderiamos ter um cenario bem mais complexo, com um monte
  de objetos diferentes interagindo (e nao apenas 2).

  Uma ideia seria fazer o seguinte:

    TWeapon e TFighter derivando de TBaseObject. Dai essa classe teria um metodo
    Collision. Os IFs estariam dentro de cada classe, tratando o mundo conhecido por cada uma
    delas.  Talvez fosse o caso de user INTERFACE ! Avaliar isso com cuidado :)

O codigo aqui seria assim:

  if Assigned(object1.TagObject) and Assigned(object2.TagObject) then
  begin
    if object1.TagObject is TFighter then
      TFighter(object1.TagObject).Collision(object2.TagObject)
    else if object1.TagObject is TWeapon then
      TWeapon(object1.TagObject).Collision(object2.TagObject)

      ou...

      ICOLLISION(object1.TagObject).Collision(object2.TagObject).

      voltarei neste ponto !!!

      ....

    }

  if Assigned(object1.TagObject) and Assigned(object2.TagObject) then
  begin
    f1 := nil;
    f2 := nil;
    w1 := nil;
    w2 := nil;
    
    if object1.TagObject is TFighter then
      f1 := TFighter(object1.TagObject)
    else if object1.TagObject is TWeapon then
      w1 := TWeapon(object1.TagObject);

    if object2.TagObject is TFighter then
      f2 := TFighter(object2.TagObject)
    else if object2.TagObject is TWeapon then
      w2 := TWeapon(object2.TagObject);

    bColisaoEntreFighters :=  Assigned(f1) and Assigned(f2);

    if bColisaoEntreFighters then
      TrataColisaoEntreFighters
    else
    begin
      bColisaoEntreArmas   := Assigned(w1) and Assigned(w2);
      if bColisaoEntreArmas then
        TrataColisaoEntreArmas
      else
      begin
        TrataColisaoArmaFighter;
      end;
    end;


  end;
end;


procedure TDMEngine.UpdateGUI;
begin
  sprEnergy.Width := ArmyJogador.Lider.PontosDeVida * 2;
  Application.MainForm.Caption := 'X ' + FloatToStr(ArmyJogador.Lider.Posicao.X)
    + ' Y ' + FloatToStr(ArmyJogador.Lider.Posicao.Y)
    + ' Z ' + FloatToStr(ArmyJogador.Lider.Posicao.Z);

  alExit.Position := ArmyJogador.Lider.Posicao;
  alExit.Position.Y := ArmyJogador.Lider.Posicao.Y + 3.0;

  alExit.PointTo(dcSaida, dcSaida.Up.AsVector);


end;

procedure TDMEngine.GLHeightField1GetHeight(const x, y: Single;
  var z: Single; var color: TVector4f; var texPoint: TTexPoint);
begin
  z := 0;
end;


procedure TDMEngine.LoadSound(pFileName, pSoundName: String; Playing: Boolean; pOrigin: TGLBaseSceneObject);
var
  spl: TGLSoundSample;
  ssrc: TGLSoundSource;
begin
  spl := TGLSoundSample.Create(GLSoundLibrary.Samples);
  spl.LoadFromFile(pFileName);
  spl.Name := pSoundName;

  ssrc := TGLSoundSource.Create(GLSMBASS.Sources);

  with ssrc do
  begin
    SoundLibrary := GLSoundLibrary;
    SoundName := pSoundName;

    if Playing then
      Volume := 1
    else
      Volume := 0;

    NbLoops := 2;
    MinDistance := 1;
    MaxDistance := 100;
    InsideConeAngle := 360;
    OutsideConeAngle := 360;
    Origin := pOrigin;
  end;

end;


function TDMEngine.get_Physic: TPhysic;
begin
  if not Assigned(FPhysic) then
    FPhysic := TPhysic.Create;
  Result := FPhysic;
end;

procedure TDMEngine.InitCharacters;
var
  i: integer;
  ftr: TGambaruFighter;
begin
  for i := 0 to GameLevel.Fighters.Count - 1 do
  begin
    ftr := TGambaruFighter(GameLevel.Fighters[i]);
    if ftr.Friend then
      AddFighter(ftr.PositionX, ftr.PositionY, ftr.PositionZ, ftr.life, ftr.FighterType, ftr.Boss, ArmyJogador, nil, ftr.Leader)
    else
      AddFighter(ftr.PositionX, ftr.PositionY, ftr.PositionZ, ftr.life, ftr.FighterType, ftr.Boss, ArmyInimigo, nil, ftr.Leader);
  end;


//   FASE 2
(*  AddFighter(-8.5,2,12,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter( 8.5,2,12,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter(-8.5,2,27,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter( 8.5,2,27,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter(0,2,0,120,ftSejiro, True, ArmyJogador, nil); *)

(*  AddFighter(-8.5,16,-12,25,ftMitsuake, True, ArmyInimigo, nil);
  AddFighter( 8.5,16,-12,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter( 8.5,16,-27,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter(-8.5,16,-27,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter( 8.5,16,-27,25,ftMitsuake, False, ArmyInimigo, nil);
  AddFighter( 8.5,16,-27,25,ftMitsuake, False, ArmyInimigo, nil);

  AddFighter(-6,2,40,120,ftSejiro, True, ArmyJogador, nil);
  AddFighter(-4,2,50,120,ftKatsome, False, ArmyJogador, nil);
(*  AddFighter(-2,2,50,120,ftKatsome, False, ArmyJogador, nil);
  AddFighter(0,2,50,120,ftKatsome, False, ArmyJogador, nil);
  AddFighter(2,2,50,120,ftKatsome, False, ArmyJogador, nil);
  AddFighter(4,2,50,120,ftKatsome, False, ArmyJogador, nil); *)
//  AddFighter(6,2,50,120,ftKatsome, False, ArmyJogador, nil);


end;

procedure TDMEngine.AddFighter(x,y,z: Single; life: Integer; FighterType: TFighterType; LevelBoss: Boolean; Army: TArmy; Territorio: TGLDummyCube; Leader: Boolean);
var
  fighter: TFighter;
  weapon: TWeapon;
begin
  fighter := nil;
  weapon := nil;
  Army.Efetivo := Army.Efetivo + 1;
  case FighterType of
    ftSejiro:
      begin
        fighter := TSejiro.Create(Army);
        fighter.isFriend := true;        
        weapon := TSejiroKatana.Create;
      end;
    ftMitsuake:
      begin
        fighter := TMitsuake.Create(Army);
        weapon := TMitsuakeKatana.Create;
        Army.EfetivoMitsuake := Army.EfetivoMitsuake + 1;
      end;
    ftKatsome:
      begin
        fighter := TKatsome.Create(Army);
        fighter.isFriend := true;
        weapon := TMitsuakeKatana.Create;
        Army.EfetivoMitsuake := Army.EfetivoMitsuake + 1;
      end;
    ftDemiOni:
      begin
        fighter := TDemiOni.Create(Army);
        weapon := TDemiOniKatana.Create;
        Army.EfetivoDemiOni := Army.EfetivoDemiOni + 1;
      end;
    ftOni:
      begin
        fighter := TOni.Create(Army);
        weapon := TOniKatana.Create;
      end;
  end;

  if Assigned(fighter) then
  begin
    fighter.isBoss := LevelBoss;
    fighter.Weapon := weapon;
    Army.Fighters.Add(fighter);

    if Leader then
      Army.Lider := fighter;

    fighter.PontosDeVida := life;
    fighter.Territorio := Territorio;

    AddActor(fighter, x, y, z);
  end;

end;

procedure TDMEngine.UpdateCharacters;
begin
  InternalExecutarAcoes(FArmyJogador, FArmyInimigo);
  InternalExecutarAcoes(FArmyInimigo, FArmyJogador);
end;

function TDMEngine.get_ArmyInimigo: TArmy;
begin
  if not Assigned(FArmyInimigo) then
  begin
    FArmyInimigo := TArmy.Create;
    FArmyInimigo.PosicaoInicial := wayRight;
    FArmyInimigo.LideradoPorIA := True;
  end;
  Result := FArmyInimigo;
end;

function TDMEngine.get_ArmyJogador: TArmy;
begin
  if not Assigned(FArmyJogador) then
  begin
    FArmyJogador := TArmy.Create;
    FArmyJogador.PosicaoInicial := wayLeft;
    FArmyJogador.LideradoPorIA := False;
  end;
  Result := FArmyJogador;
end;

function TDMEngine.get_PosicaoMediaArmys: TAffineVector;
var
  fracao: Single;
  i: Integer;
  posAcum: TAffineVector;
begin
  for i := 0 to 2 do //   vector (0,0,0)
    posAcum[i] :=  0;

  AddVector(posAcum, ArmyJogador.PosicaoMedia);
  AddVector(posAcum, ArmyInimigo.PosicaoMedia);

  fracao := 1 / 2;
  VectorScale(posAcum, fracao, Result);
end;

procedure TDMEngine.AddActor(fighter: TFighter; posx, posy, posz: Single);
var
  fighterActor, weaponActor: TGLActor;
  cube: TGLDummyCube;
  collision: TGLBCollision;
  fx : TGLSourcePFXEffect;


  procedure AddDummyCube;
  begin
    cube := TGLDummyCube.CreateAsChild(GLScene.Objects);

    with cube do
    begin
      TagObject := fighter;

      Direction.X := 0;
      Direction.Y := 0;

      if fighter.FighterType in [ftSejiro, ftKatsome] then
        Direction.Z := 1
      else
        Direction.Z := -1;

      Up.X := 0;
      Up.Y := 1;
      Up.Z := 0;

      Position.Z := posz;  // lado
      Position.Y := posy; // cima
      Position.X := posx; // atrás

      CubeSize := 1;

      collision := TGLBCollision.Create(cube.Behaviours);
      collision.Manager := CollisionManager;
      collision.BoundingMode := cbmFaces;

(*      if fighter.FighterType = ftOni then
      begin
        fx := TGLSourcePFXEffect.Create(cube.Effects);
        fx.Manager :=  PolygonFXManager;
        fx.DisabledIfOwnerInvisible := False;
        fx.EffectScale := 5;
        fx.Enabled := True;
        fx.InitialVelocity.SetVector(0, 0.2, 0);  // 0, -0.2, 0
        fx.Name := 'PFX Source';
        fx.ParticleInterval := 0.05;  // 0.05
        fx.PositionDispersionRange.Style := csVector;
        fx.PositionDispersionRange.SetVector(1,1,1);
        fx.VelocityDispersion := 0.1;  // 0.1
      end; *)

    end;

    fighter.Cubo := cube;
  end;

  procedure AddFighterActor;
  var
    j: Integer;
  begin
    fighterActor := TGLActor.Create(GLScene);

    fighterActor.Parent := cube;
    fighterActor.OnEndFrameReached := fighter.EndFrameReached;

    with fighterActor do
    begin

      Direction.X :=  0;
      Direction.Y :=  1;
      Direction.Z :=  0;


      Up.X := 0;
      Up.Y := 0;
      Up.Z := 1;

      Interval := 100;
      AnimationMode:=aamLoop;

      MaterialLibrary := GLMaterialLibrary;

      LoadFromFile(fighter.ArquivoModelo3D);

      AddDataFromFile(fighter.ArquivoAnimacaoStand);
      AddDataFromFile(fighter.ArquivoAnimacaoRun);
      AddDataFromFile(fighter.ArquivoAnimacaoAttack);
      AddDataFromFile(fighter.ArquivoAnimacaoAttack2);
      AddDataFromFile(fighter.ArquivoAnimacaoAttack3);
      AddDataFromFile(fighter.ArquivoAnimacaoDeath);

      // TODO: Deverá existir um metodo em Fighter, abstrato, do tipo AddCustomAnimations..
      // ou AddOtherAnimations, sei lá.
(*      AddDataFromFile('.\modelos\samurai_healing.smd');
      AddDataFromFile('.\modelos\samurai_thor.smd'); *)

      for j := ID_STAND to ID_DEATH do
        Animations[j].Name := IntToStr(j);

      Scale.SetVector(fighter.Tamanho, fighter.Tamanho, fighter.Tamanho, 0);

      SwitchToAnimation(ID_STAND);
    end;

    fighter.Actor := fighterActor;

  end;

  procedure AddWeaponActor;
  var
    j: Integer;
  begin

    weaponActor := TGLActor.Create(GLScene);

    weaponActor.Parent := fighterActor;
    weaponActor.OnEndFrameReached := fighter.Weapon.EndFrameReached;


    with weaponActor do
    begin
      TagObject := fighter.Weapon;

(*      Direction.X :=  0;
      Direction.Y :=  0;
      Direction.Z :=  1;

      Up.X := 0;
      Up.Y := 1;
      Up.Z := 0; *)

      Interval := 100;
      AnimationMode:=aamLoop;

      MaterialLibrary := GLMaterialLibrary;

      LoadFromFile(fighter.weapon.ArquivoModelo3D);

      AddDataFromFile(fighter.weapon.ArquivoAnimacaoStand);
      AddDataFromFile(fighter.weapon.ArquivoAnimacaoRun);
      AddDataFromFile(fighter.weapon.ArquivoAnimacaoAttack);
      AddDataFromFile(fighter.weapon.ArquivoAnimacaoAttack2);
      AddDataFromFile(fighter.weapon.ArquivoAnimacaoAttack3);
      AddDataFromFile(fighter.weapon.ArquivoAnimacaoDeath);

      // TODO: Deverá existir um metodo em Fighter, abstrato, do tipo AddCustomAnimations..
      // ou AddOtherAnimations, sei lá.

      for j := ID_STAND to ID_ATTACK3 do
        Animations[j].Name := IntToStr(j);

//      Scale.SetVector(fighter.Tamanho, fighter.Tamanho, fighter.Tamanho, 0);
      Scale.SetVector(1, 1, 1, 0);

      SwitchToAnimation(ID_STAND);

      collision := TGLBCollision.Create(weaponActor.Behaviours);
      collision.Manager := CollisionManager;
      collision.BoundingMode := cbmFaces;
      
    end;


    fighter.weapon.Actor := weaponActor;
  end;


begin

  AddDummyCube;
  AddFighterActor;
  AddWeaponActor;

  fighter.GLNavigator := GLNavigator;
end;

procedure TDMEngine.InternalExecutarAcoes(Army, Contra: TArmy);
var
  i : Integer;
  fighter: TFighter;
  action: TFighterAction;
  IsPlayer: Boolean;

  procedure InternalMovimentacao(_fighter: TFighter);
  begin
    case action.Way of
      wayRight: _fighter.VirarPraDireita;
      wayLeft: _fighter.VirarPraEsquerda;
    end;
    if action.Velocity > 0 then
      _fighter.Andar(action.Velocity)
    else
    begin
      if _fighter.RodadasParado >= MAX_RODADAS_SEM_MOVIMENTO then
        _fighter.Parar
      else
        _fighter.RodadasParado := _fighter.RodadasParado + 1;
    end;
  end;


begin
  for i := 0 to Army.Fighters.Count - 1 do
  begin
    fighter := TFighter(Army.Fighters[i]);
    //IsPlayer := fighter.EhLider and not Army.LideradoPorIA;

    isplayer := fighter.FighterType = ftSejiro;


    // Player NUNCA se submete a IA
    if (fighter.State <> fsDead) and (not IsPlayer) then
    begin
      action := fighter.GetAction(Army.Lider, Contra.Lider, Army.Fighters, Contra.Fighters);

      if action.Info <> '' then
        ShowFrase(fighter.FighterType, action.Info, 4000);

      fighter.IsRunning := (action.Velocity > 0);

      if action.Attack then
        fighter.Atacar
      else
        InternalMovimentacao(fighter)

    end;
    fighter.Weapon.Actor.Synchronize(fighter.Actor);
  end;
end;


function TDMEngine.LoadTexture(Matname,Filename : string) : TGLLibMaterial;
begin
  Result := mlibTextures.AddTextureMaterial(Matname,'.\texturas\' + Filename);
  Result.Material.Texture.Disabled := false;
  Result.Material.Texture.TextureMode := tmDecal;
end;

procedure TDMEngine.InitPhysic;
begin
  Physic.Init;
  Physic.Apply(ffmScene);
  Physic.Apply(ArmyJogador);
  Physic.Apply(ArmyInimigo);
  Physic.Apply(GLCamera);
end;

procedure TDMEngine.InitScene;
var
  fx : TGLSourcePFXEffect;
begin
  alExit.Visible := gamelevel.showexit;
//  dcSaida.Visible := true;
//  dcSaida.VisibleAtRunTime := true;
  if gamelevel.showexit then
  begin
    dcSaida.Position.X := gamelevel.ExitX;
    dcSaida.Position.Y := gamelevel.ExitY;
    dcSaida.Position.Z := gamelevel.ExitZ;
  end;

  LoadSprites;


  ffmScene.LoadFromFile(GameLevel.Arena);

  ffmScene.Scale.X := GameLevel.SceneScaleX;
  ffmScene.Scale.Y := GameLevel.SceneScaleY;
  ffmScene.Scale.Z := GameLevel.SceneScaleZ;

(*  GLCamera.Position.X := GameLevel.CameraPositionX;
  GLCamera.Position.Y := GameLevel.CameraPositionY;
  GLCamera.Position.Z := GameLevel.CameraPositionZ; *)
  CameraControlCube.Position.X := GameLevel.CameraPositionX;
  CameraControlCube.Position.Y := GameLevel.CameraPositionY;
  CameraControlCube.Position.Z := GameLevel.CameraPositionZ;



(*  ffmScene.Scale.X := 0.5;
  ffmScene.Scale.Y := 0.5;
  ffmScene.Scale.Z := 0.5; *)

(*  GLCamera.Position.X := 0;
  GLCamera.Position.Y := 2;
  GLCamera.Position.Z := 125; *)

  ffmScene.Material.Texture.Disabled := False;

(*  GLFireFXManager1.Cadencer := GLCadencer;
  GLFireFXManager1.Paused := false;
  GLFireFXManager1.FireDir.X := 0;
  GLFireFXManager1.FireDir.Y := 0;
  GLFireFXManager1.FireDir.Z := -1;
  GLFireFXManager1.InitialDir.X :=   10.5;
  GLFireFXManager1.InitialDir.Y := 8;
  GLFireFXManager1.InitialDir.Z :=-12; *)


  glfirefxmanager1.Disabled := false;

     LoadSkyDome('Left','left.jpg');
     LoadSkyDome('Right','right.jpg');
     LoadSkyDome('Top','up.jpg');
     LoadSkyDome('Bottom','down.jpg');
     LoadSkyDome('Front','front.jpg');
     LoadSkyDome('Back','back.jpg');
     with LoadSkyDome('Clouds','Cloud.jpg') do
     begin
          // Add transparency to clouds
          Material.BlendingMode := bmTransparency;
          Material.FrontProperties.Diffuse.Alpha := 0.2;

          // scale the clouds texture
          TextureScale.X := 8;
          TextureScale.y := 8;
     end;

    if (GameLevel.Indice = 1) then
    begin
        fx := TGLSourcePFXEffect.Create(dcFogueira.Effects);
        fx.Manager :=  PolygonFXManager;
        fx.DisabledIfOwnerInvisible := True;
        fx.EffectScale := 5;
        fx.Enabled := True;
        fx.InitialVelocity.SetVector(0, 0.2, 0);  // 0, -0.2, 0
        fx.Name := 'PFX Source';
        fx.ParticleInterval := 0.05;  // 0.05
        fx.PositionDispersionRange.Style := csVector;
        fx.PositionDispersionRange.SetVector(1,1,1);
        fx.VelocityDispersion := 0.1;  // 0.1
    end
    else
      dcFogueira.visible := false;



end;

procedure TDMEngine.InitCamera;
begin

  GLCamera.TargetObject := ArmyJogador.Lider.Cubo;

end;

procedure TDMEngine.UpdatePhysic;
begin
  if FGameState = stLevelComplete then Exit;
  
  Physic.Update;
end;

procedure TDMEngine.UpdateCollisions;
begin
  if not (FGameState in [stLevel, stLevelIntro]) then Exit;
  CollisionManager.CheckCollisions;
  if gameover then
    GameState := stGameOver
  else if levelcomplete then
    gamestate := stLevelComplete;
end;


procedure TDMEngine.set_GameState(Value: TGameState);
var
  errors: String;
begin
  FGameState := Value;

  case FGameState of
    stLogo:
      begin
        Screen.Cursor := crNone;
        LoadScript;
        CurrentLevel := -1;

        PlayTrack(LOGO_TRACK_THEME, False);
        sprLogo.Material.Texture.Image.LoadFromFile('.\media\logo.jpg');
        sprLogo.Position.X := Screen.Width / 2;
        sprLogo.Position.Y := Screen.Height / 2;
        sprLogo.Visible := True;
      end;

    stMenu:
      begin
        PlayTrack(MENU_TRACK_THEME, True, INTERVAL_MENU_TRACK);
        sprMain.Material.Texture.Image.LoadFromFile('.\media\maintitle.jpg');
        sprMain.Position.X := Application.MainForm.Width / 2;
        sprMain.Position.Y := Application.MainForm.Height / 4;
        sprLogo.Visible := False;
        sprMain.Visible := True;
        GameMenu.Position.X := Application.MainForm.Width / 2;
        GameMenu.Position.Y := Application.MainForm.Height / 2;
        GameMenu.Visible := True;
      end;

    stLoading:
      begin

        ShowCursor(longbool(false));




        CurrentLevel := CurrentLevel + 1;
        GameLevel := levels.items[CurrentLevel];


        MediaPlayer.Stop;
        sprMain.Visible := False;
        GameMenu.Visible := False;

        lblLoading.Height := Application.MainForm.Height;
        lblLoading.Width := Application.MainForm.Width;
        lblLoading.Position.X := 0;
        lblLoading.Position.Y := 0;

        lblLoading.Caption := gamelevel.loadingtext;

        lblLoading.Visible := True;


//        PlayMovie('.\media\gambaru_intro.wmv');
        if (trim(GameLevel.Movie) <> '') then
          PlayMovie(GameLevel.Movie);

        Application.ProcessMessages;

        if CurrentLevel > 0 then
           DestroyPreviousLevel;

        ParserScript(GameLevel.ScriptLevel, 0, GameLevel.ScriptLevel.Count -1,  errors );



        InitCharacters;

        InitScene;

        InitCamera;

        InitPhysic;

        InitGUI;



//        InitLevelTimer.Enabled := True;

//        InitLevelTimerTimer(Self);

//        DoLevelIntro;
      end;

    stLevelIntro:
      begin
        levelcomplete := false;

        lblLoading.Visible := False;

        if trim(gamelevel.sejirotext) <> '' then
          ShowFrase(ftSejiro, gamelevel.sejiroText, 40000);

        GameState := stLevel;
      end;

    stLevel:
      begin
        GLCadencer.Scene := GLScene;
        GLCadencer.Enabled := True;
        PlayTrack(LEVEL_TRACK_THEME, True, INTERVAL_LEVEL_TRACK);
      end;

    stLevelComplete:
      begin
        if CurrentLevel = Levels.Count - 1 then
          GameState := stGameSuccess
        else
          GameState := stLoading;
      end;

    stGameSuccess:
      begin
        PlayTrack(LEVELCOMPLETE_TRACK_THEME, True, INTERVAL_LEVELCOMPLETE_TRACK);
        ShowFrase(ftSejiro, 'Kyotawa foi vingada! Preciso percorrer as demais vilas!', 80000);
      end;

    stGameOver:
      begin
        lblGameOver.Visible := True;
        lblGameOver.Position.X := Application.MainForm.Width / 2;
        lblGameOver.Position.Y := Application.MainForm.Height / 2;

        PlayTrack(GAMEOVER_TRACK_THEME, True, INTERVAL_GAMEOVER_TRACK);

        lscScene01.SpotCutOff := 10;
        lscScene02.SpotCutOff := 10;
        lscScene03.SpotCutOff := 10;
        lscScene04.SpotCutOff := 10;
        lscScene05.SpotCutOff := 10;
        lscScene06.SpotCutOff := 10;
      end;

  end;

end;

procedure TDMEngine.LogoTimerTimer(Sender: TObject);
begin
  LogoTimer.Enabled := False;
  GameState := stMenu;
end;

procedure TDMEngine.HandleKeysMenu(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FGameState <> stMenu then Exit;

  if IsKeyDown(VK_UP) then
    GameMenu.SelectPrev
  else if IsKeyDown(VK_DOWN) then
    GameMenu.SelectNext
  else if IsKeyDown(VK_RETURN) then
    case GameMenu.Selected of
      0: GameState := stLoading;
// TODO      1: GameState := stCredits
// TODO:     2: Application.Destroy...
    end;

end;

procedure TDMEngine.Init;
begin
  GameState := stLogo;
  with MediaPlayerDisplayRect do
  begin
    Left:=0;
    Top:=0;
    Bottom:=Screen.Height;
    Right:=Screen.Width;
  end;

  with displayzerado do
  begin
    Left:=0;
    Top:=0;
    Bottom:=0;
    Right:=0;
  end;


end;

procedure TDMEngine.LoadSprites;
begin
  sprSejiro.Material.Texture.Image.LoadFromFile('.\media\sprite_sejiro.jpg');
  sprSejiro.Position.X := sprSejiro.Width / 2;
  sprSejiro.Position.Y := Application.MainForm.Height - sprSejiro.Height;

  sprMitsuake.Material.Texture.Image.LoadFromFile('.\media\sprite_mitsuake.jpg');
  sprMitsuake.Position.X := sprMitsuake.Width / 2;
  sprMitsuake.Position.Y := Application.MainForm.Height - sprMitsuake.Height;

  sprOni.Material.Texture.Image.LoadFromFile('.\media\sprite_oni.jpg');
  sprOni.Position.X := sprOni.Width / 2;
  sprOni.Position.Y := Application.MainForm.Height - sprOni.Height;

  // {TODO} sprDemiOni

  lblFrase.Position.X := 80;
  lblFrase.Position.Y :=   sprSejiro.Position.Y;
end;

procedure TDMEngine.FraseTimerTimer(Sender: TObject);
begin
  ClearFrase;
  FraseTimer.Enabled := False;
end;

procedure TDMEngine.ShowFrase(fighterType: TFighterType; Frase: String;
  Interval: Integer);
begin
  ClearFrase;
  case fighterType of
    ftSejiro: sprSejiro.Visible := True;
    ftMitsuake: sprMitsuake.Visible := True;
    ftDemiOni: sprDemiOni.Visible := True;
    ftOni: sprOni.Visible := True;
  end;
  lblFrase.Visible := True;
  lblFrase.Caption := Frase;
  FraseTimer.Interval := Interval;
  FraseTimer.Enabled := True;
//  Application.ProcessMessages;
end;

procedure TDMEngine.PlayMovie(fileName: String);
begin
(*  MediaPlayerx := TMediaPlayer.Create(Application.MainForm);
  mediaplayerx.Notify := true;
  MediaPlayerx.Parent :=  Application.MainForm;
  MediaPlayerx.FileName := fileName;
  GLCadencer.Enabled := False;
    SceneViewer.Visible := False;
    MediaPlayerx.OnNotify := MediaPlayerExit;



  PanelDisplayMovie.Visible := false;

  with MediaPlayerDisplayRect do
  begin
    Left:=0;
    Top:=0;
    Bottom:=Screen.Height;
    Right:=Screen.Width;
  end; *)

  MediaPlayer.VisibleButtons := [];
  MediaPlayer.EnabledButtons := [];

  MediaPlayer.Stop;
  TrackLoopTimer.Enabled := False;

  MediaPlayerx.FileName := fileName;
  mediaplayerx.Visible := true;
  GLCadencer.Enabled := False;
  SceneViewer.Visible := False;

  PanelDisplayMovie.Visible := true;



  MediaPlayerx.Open;
//  MediaPlayerx.Display := Application.MainForm;
  MediaPlayerx.Display := PanelDisplayMovie;
  MediaPlayerx.DisplayRect := MediaPlayerDisplayRect;



  MediaPlayerx.Play;




end;

procedure TDMEngine.InitLevelTimerTimer(Sender: TObject);
begin
(*  SceneViewer.Visible := True;
  InitLevelTimer.Enabled := False;

  GameState := stLevelIntro; *)

end;

procedure TDMEngine.IntroTimerTimer(Sender: TObject);
begin
//  sprLogo.Rotation := FBlah;
  sprLogo.Width := FBlah / 2;
  sprLogo.Height := FBlah / 2;
  FBlah := FBlah + 0.3;
  FCont := FCont + 1;

  if FCont = 580 then
  begin
    sprLogo.Width := 238;
    sprLogo.Height := 238;
    IntroTimer.Enabled := False;
  end;


end;

procedure TDMEngine.PlayTrack(trackIndex: Integer; Loop: Boolean; trackInterval: Integer);
begin



  MediaPlayer.DeviceType := dtCDAudio;
  MediaPlayer.Open;
  MediaPlayer.Stop;
  MediaPlayer.Position := trackIndex;



  MediaPlayer.Play;

  if Loop then
  begin
    TrackLoopTimer.Enabled := True;
    TrackLoopTimer.Interval := trackInterval;
    CurrentTrack := trackIndex;
  end
  else
    TrackLoopTimer.Enabled := False;

end;

procedure TDMEngine.ClearFrase;
begin
  sprSejiro.Visible := False;
  sprMitsuake.Visible := False;
  sprOni.Visible := False;
  lblFrase.Visible := False;
end;

procedure TDMEngine.InitGUI;
begin
  sprEnergy.Visible := True;
end;

procedure TDMEngine.TrackLoopTimerTimer(Sender: TObject);
begin
  MediaPlayer.Stop;
  MediaPlayer.Position := CurrentTrack;
  MediaPlayer.Play;

end;

procedure TDMEngine.LoadScript;
var
  script: TStringList;
  iAIDiv, iLevelDiv, iTrackDiv, iPhysDiv: Integer;
  errors: String;
begin
  errors := '';
  script := TStringList.Create;
  script.LoadFromFile('script.gs');

  // Assegurar que as divisões estão todas declaradas
  iAIDiv := script.IndexOf('AI division.');
  if iAIDiv = -1 then
    errors := errors + #13#10 + 'AI division não encontrada';

  iLevelDiv := script.IndexOf('Level division.');
  if iLevelDiv = -1 then
    errors := errors + #13#10 + 'Level division não encontrada';

  iTrackDiv := script.IndexOf('Track division.');
  if iTrackDiv = -1 then
    errors := errors + #13#10 + 'Track division não encontrada';

  iPhysDiv := script.IndexOf('Physics division.');
  if iPhysDiv = -1 then
    errors := errors + #13#10 + 'Physics division não encontrada';

  // Assegurar que as divisões estão em ordem
  // iAIDiv -> iPhysDiv -> iTrackDiv -> ILevelDiv
  if (iAIDiv <> -1) and (iPhysDiv <> -1) and (iTrackDiv <> -1) and (iLevelDiv <> -1) then
  begin

    if (iAIDiv > iPhysDiv) or (iAIDiv > iLevelDiv) or (iAIDiv > iTrackDiv) then
      errors := errors + #13#10 + 'AI Division deve ser a primeira divisão declarada';
    if (iLevelDiv < iPhysDiv) or (iLevelDiv < iLevelDiv) or (iAIDiv > iTrackDiv) then
      errors := errors + #13#10 + 'Level Division deve ser a última divisão declarada';
    if (iTrackDiv < iPhysDiv) then
      errors := errors + #13#10 + 'Track Division deve ser declarada após Physic Division';

    ParserScript(script, iPhysDiv + 1, iTrackDiv - 1,  errors);
    ParserScript(script, iAIDiv + 1, iPhysDiv - 1, errors);
    ParserScript(script, iTrackDiv + 1, iLevelDiv -1, errors);
    ParserLevelDivision(script, iLevelDiv + 1, script.Count -1, errors);



  end;



  // Interromper a execução caso o script esteja inválido
  if errors <> '' then
  begin
    errors := 'Script invalido: ' + errors;
    raise Exception.Create(errors);
  end;






end;

procedure TDMEngine.ParserScript(code: TStringList; startIndex, endIndex: Integer; out errors: String);
var
  linha, command, variavel, valor: String;
  i, inicio, fim : Integer;
begin
//foreach linha... in linhas...
  inicio := startIndex;
  fim := endIndex;
  for i := inicio to fim do
  begin
    linha := code[i];
    if (trim(linha) = '') then continue;
    if (copy(linha, 1, 2) <> '  ') then
      errors := errors + #13#10 + 'identação incorreta'
    else
    begin
      command := copy(linha, 3, 4);
      if command = 'let ' then
      begin
        variavel := TRIM(copy(linha, 7, pos('=', linha) - 7));
        valor := TRIM(copy(linha, pos('=', linha) + 1, 50));
        // TODO: separar analise de variaveis por tipo de division.
        //       passar division em analise como parametro.
        if variavel = 'gravity' then
          GRAVITY := StrToFloat(valor)
        else if variavel = 'velocity' then
          SEJIRO_TOP_VELOCITY := StrToFloat(valor)
        else if variavel = 'cameraMass' then
          CAMERA_MASS := StrToFloat(valor)
        else if variavel = 'cohesion' then
          PESO_COESAO := StrToInt(valor)
        else if variavel = 'alignment' then
          PESO_ALINHAMENTO := StrToInt(valor)
        else if variavel = 'dispersion' then
          PESO_SEPARACAO := StrToInt(valor)
        else if variavel = 'offensiveness' then
          PESO_OFENSIVO := StrToInt(valor)
        else if variavel = 'spacing' then
          ESPACAMENTO_INICIAL := StrToInt(valor)
        // Audio Division
        else if variavel = 'intro' then
        begin
          if pos('in', valor) <> 0 then
          begin
            LOGO_TRACK_THEME := StrToInt(copy(valor, 1, pos('in', valor) - 2));
            //interval... := StrToInt(copy(valor, pos('in', valor) + 2, 50)));
          end
          else
             LOGO_TRACK_THEME := StrToInt(valor);
        end
        else if variavel = 'menu' then
        begin
          if pos('in', valor) <> 0 then
          begin
            MENU_TRACK_THEME := StrToInt(copy(valor, 1, pos('in', valor) - 2));
            INTERVAL_MENU_TRACK := 1000 * StrToInt(TRIM(copy(valor, pos('in', valor) + 2, pos('seconds', valor)-7)));
          end
          else
             MENU_TRACK_THEME := StrToInt(valor);
        end
        else if variavel = 'gameover' then
        begin
          if pos('in', valor) <> 0 then
          begin
            GAMEOVER_TRACK_THEME := StrToInt(copy(valor, 1, pos('in', valor) - 2));
            INTERVAL_GAMEOVER_TRACK := 1000 * StrToInt(TRIM(copy(valor, pos('in', valor) + 2, pos('seconds', valor)-7)));
          end
          else
             GAMEOVER_TRACK_THEME := StrToInt(valor);
        end
        else if variavel = 'boss' then
        begin
          if pos('in', valor) <> 0 then
          begin
            ONI_TRACK_THEME := StrToInt(copy(valor, 1, pos('in', valor) - 2));
            INTERVAL_ONI_TRACK := 1000 * StrToInt(TRIM(copy(valor, pos('in', valor) + 2, pos('seconds', valor)-7)));
          end
          else
            ONI_TRACK_THEME := StrToInt(valor);
        end
        else if variavel = 'level' then
        begin
          if pos('in', valor) <> 0 then
          begin
            LEVEL_TRACK_THEME := StrToInt(copy(valor, 1, pos('in', valor) - 2));
            INTERVAL_LEVEL_TRACK := 1000 * StrToInt(TRIM(copy(valor, pos('in', valor) + 2, pos('seconds', valor)-7)));
          end
          else
            LEVEL_TRACK_THEME := StrToInt(valor);
        end
        else if variavel = 'levelcomplete' then
        begin
          if pos('in', valor) <> 0 then
          begin
            LEVELCOMPLETE_TRACK_THEME := StrToInt(copy(valor, 1, pos('in', valor) - 2));
            INTERVAL_LEVELCOMPLETE_TRACK := 1000 * StrToInt(TRIM(copy(valor, pos('in', valor) + 2, pos('seconds', valor)-7)));
          end
          else
            INTERVAL_LEVELCOMPLETE_TRACK := StrToInt(valor);
        end
      end
      else
        errors := errors + #13#10 + 'comando de script inválido';
    end;
  end;
end;

procedure TDMEngine.ParserLevelDivision(code: TStringList; startIndex,
  endIndex: Integer; out errors: String);
var
  i, inicio, fim: Integer;
  linha, posicao, valor, variavel, command: String;
  lvl: TGambaruLevel;
  ftr: TGambaruFighter;
begin
  lvl := nil;
  inicio := startIndex;
  fim := endIndex;
  levels := TList.Create;
  for i := inicio to fim do
  begin
    linha := code[i];
    if (trim(linha) = '') then continue;

    if (not Assigned(lvl)) and
       ((copy(linha, 1, 2) <> '  ') or (copy(linha, 3, 6) <> 'level ')) then
    begin
       errors := errors + #13#10 + 'identação de level incorreta na linha ' + IntToStr(i + 1) + ' da level division.'
    end
    else if ((copy(linha, 1, 2) = '  ') and (copy(linha, 3, 6) = 'level ')) then
    begin
      lvl := TGambaruLevel.Create;
      levels.Add(lvl);
      lvl.Indice := levels.Count;
      lvl.Fighters := TList.Create;
      lvl.ScriptLevel := TStringList.Create;
    end
    else
    begin
      if (copy(linha, 1, 4) <> '    ') then
          errors := errors + #13#10 + 'identação de comando de level incorreta na linha ' + IntToStr(i + 1) + ' da level division.';
      // preencher estrutura de levels para o engine fazer um loop desses levels
      command := copy(linha, 5, 4);
      if (not Assigned(lvl)) then
      begin
        errors := errors + #13#10 + 'level não definido na linha ' + IntToStr(i + 1) + ' da level division.';
        continue;
      end;

      if command = 'let ' then
      begin
        variavel := TRIM(copy(linha, 9, pos('=', linha) - 9));
        valor := TRIM(copy(linha, pos('=', linha) + 1, 60));
        // TODO: separar analise de variaveis por tipo de division.
        //       passar division em analise como parametro.
        if variavel = 'arena' then
          lvl.Arena := stringreplace(valor, '''', '', [rfReplaceAll]) // replace aspas
        else if variavel = 'loading' then
          lvl.LoadingText := stringreplace(valor, '''', '', [rfReplaceAll]) // replace aspas
        else if variavel = 'sejiroText' then
          lvl.SejiroText := stringreplace(valor, '''', '', [rfReplaceAll]) // replace aspas
        else if variavel = 'movie' then
          lvl.Movie := stringreplace(valor, '''', '', [rfReplaceAll]) // replace aspas
        else if variavel = 'scale' then
        begin
          valor := stringreplace(valor, '.', ',', [rfReplaceAll]);
          lvl.SceneScaleX := StrToFloat(copy(valor, 1, pos('/', valor) - 1));
          valor := copy(valor, pos('/', valor) + 1, 50);
          lvl.SceneScaleY := StrToFloat(copy(valor, 1, pos('/', valor) - 1));
          lvl.SceneScaleZ := StrToFloat(copy(valor, pos('/', valor) + 1, 50));
        end
        else if variavel = 'exit' then
        begin
          valor := stringreplace(valor, '.', ',', [rfReplaceAll]);
          lvl.ExitX := StrToFloat(copy(valor, 1, pos('/', valor) - 1));
          valor := copy(valor, pos('/', valor) + 1, 50);
          lvl.ExitY := StrToFloat(copy(valor, 1, pos('/', valor) - 1));
          lvl.ExitZ := StrToFloat(copy(valor, pos('/', valor) + 1, 50));
          lvl.ShowExit := true;
        end
        else if variavel = 'camera' then
        begin
          valor := stringreplace(valor, '.', ',', [rfReplaceAll]);
          lvl.CameraPositionX := StrToFloat(copy(valor, 1, pos('/', valor) - 1));
          valor := copy(valor, pos('/', valor) + 1, 50);
          lvl.CameraPositionY := StrToFloat(copy(valor, 1, pos('/', valor) - 1));
          lvl.CameraPositionZ := StrToFloat(copy(valor, pos('/', valor) + 1, 50));
        end
        else
        begin
          lvl.ScriptLevel.Add('  ' + Trim(linha)); // adaptando identacao
        end;
      end
      else if command = 'add ' then
      begin
        variavel := TRIM(copy(linha, 9, pos('at ', linha) - 9));
        posicao := TRIM(copy(linha, pos('at ', linha) + 3,  pos('life', linha) - pos('at ', linha) - 3));
        valor := TRIM(copy(linha, pos('life', linha) + 4,  50));
        ftr := TGambaruFighter.Create;
        lvl.Fighters.Add(ftr);

        if pos('mitsuake', variavel) > 0 then
          ftr.FighterType :=  ftMitsuake
        else if pos('oni', variavel) > 0 then
          ftr.FighterType :=  ftOni
        else if pos('katsome', variavel) > 0 then
          ftr.FighterType :=  ftKatsome
        else if pos('sejiro', variavel) > 0 then
          ftr.FighterType :=  ftSejiro
        else
          errors := errors + #13#10 + 'tipo de personagem inválido na linha '+ IntToStr(i + 1) + ' da level division.';



        ftr.Friend := ftr.FighterType in [ftSejiro, ftKatsome];

        posicao := stringreplace(posicao, '.', ',', [rfReplaceAll]);


        ftr.PositionX := StrToFloat(copy(posicao, 1, pos('/', posicao) - 1));
        posicao := copy(posicao, pos('/', posicao) + 1, 50);
        ftr.PositionY := StrToFloat(copy(posicao, 1, pos('/', posicao) - 1));
        ftr.PositionZ := StrToFloat(copy(posicao, pos('/', posicao) + 1, 50));

        ftr.Life := StrToInt(valor);
        ftr.Boss := pos('boss', variavel) > 0;
        ftr.Leader := (pos('leader', variavel) > 0) or (ftr.FighterType = ftSejiro);

      end
      else
      begin
        errors := errors + #13#10 + 'comando não compreendido na linha ' + IntToStr(i + 1) + ' da level division.';
        continue;
      end;


    end;


  end;

end;

procedure TDMEngine.DestroyPreviousLevel;
var
  i, j: Integer;
  ftr: TFighter;
  bv : TGLBCollision;
begin
 // destruir todos os objetos criados no level anterior
  CollisionManager.OnCollision := nil;


(*GLCadencer.Enabled := false;
GLCadencer.OnProgress := Nil;
GLCadencer.Scene := NIL;
GLCadencer.Mode := cmManual;
GLCadencer.Reset; *)

(*while GLCadencer.IsBusy do
Application.ProcessMessages; *)

//GLCadencer.Free;

//  GLSMBASS.Cadencer := nil;
//  PolygonFXManager.Cadencer := nil;



  for i := ArmyJogador.Fighters.Count - 1 downto 0 do
  begin
    ftr := TFighter(ArmyJogador.Fighters[i]);


    for j := ftr.Cubo.Behaviours.Count - 1 downto 0 do
    begin
      bv := TGLBCollision(ftr.Cubo.Behaviours[j]);
      bv.Manager := nil;
      ftr.Cubo.Behaviours.Remove(bv);
//      bv.Destroy;
    end;

    for j := ftr.Weapon.Actor.Behaviours.Count - 1 downto 0 do
    begin
      bv := TGLBCollision(ftr.Weapon.Actor.Behaviours[j]);
      bv.Manager := nil;
      ftr.Weapon.Actor.Behaviours.Remove(bv);
//      bv.Destroy;
    end;
    ftr.Actor.Destroy;
    ftr.Weapon.Destroy;
    ftr.Cubo.Destroy;
    ftr.Destroy;
    ArmyJogador.Fighters.Remove(ftr);
  end;

  for i := ArmyInimigo.Fighters.Count - 1 downto 0 do
  begin
    ftr := TFighter(ArmyInimigo.Fighters[i]);
    for j := ftr.Cubo.Behaviours.Count - 1 downto 0 do
    begin
      bv := TGLBCollision(ftr.Cubo.Behaviours[j]);
      bv.Manager := nil;
      ftr.Cubo.Behaviours.Remove(bv);
//      bv.Destroy;
    end;
    for j := ftr.Weapon.Actor.Behaviours.Count - 1 downto 0 do
    begin
      bv := TGLBCollision(ftr.Weapon.Actor.Behaviours[j]);
      bv.Manager := nil;
      ftr.Weapon.Actor.Behaviours.Remove(bv);
//      bv.Destroy;
    end;
    ftr.Actor.Destroy;
    ftr.Weapon.Destroy;
    ftr.Cubo.Destroy;
    ftr.Destroy;
    ArmyInimigo.Fighters.Remove(ftr);
  end;

  ArmyInimigo.Resetar;
  ArmyJogador.Resetar;


//  GLCadencer.Destroy;
  CollisionManager.Destroy;


  FCollisionManager := nil;
  FPhysic := nil;
//  FGLCadencer := nil;


//  application.me

end;

function TDMEngine.get_CollisionManager: TCollisionManager;
begin
  if not Assigned(FCollisionManager) then
  begin
    FCollisionManager := TCollisionManager.Create(Self);
    FCollisionManager.OnCollision := CollisionManagerCollision
  end;
  result := FCollisionManager;
end;

function TDMEngine.get_GLCadencer: TGLCadencer;
begin
  if not Assigned(FGLCadencer) then
  begin
    FGLCadencer := TGLCadencer.Create(Self);
    FGLCadencer.Enabled := False;
    FGLCadencer.OnProgress := GLCadencerProgress;
//    FGLCadencer.Scene :=
    GLSMBASS.Cadencer := FGLCadencer;
    PolygonFXManager.Cadencer := FGLCadencer;
  end;
  result := FGLCadencer;
end;

procedure TDMEngine.MediaPlayerExit(Sender: TObject);
begin
  if (TMediaPlayer(sender).Mode = mpplaying) then
  begin
    if (estadovideo = 0) then
      estadovideo := 1
    else
    begin
      estadovideo := 0;
      DoLevelIntro;

    end;

    TMediaPlayer(sender).notify := true;
  end;



end;

procedure TDMEngine.DoLevelIntro;
begin
      GameState := stLevelIntro;

      mediaplayerx.DisplayRect := displayzerado;
      mediaplayerx.Display := nil;

      GLCadencer.Enabled := true;

      PanelDisplayMovie.Visible := false;

      MediaPlayerx.Visible := false;

      SceneViewer.Visible := True;
       InitLevelTimer.Enabled := False;

       Application.ProcessMessages;

       Application.MainForm.Refresh;
       Application.MainForm.Repaint;

end;


function TDMEngine.get_MediaPlayerx: TMediaPlayer;
begin
  if not assigned(FMediaPlayerx) then
  begin
  FMediaPlayerx := TMediaPlayer.Create(Application.MainForm);
  FMediaPlayerx.EnabledButtons := [];
  Fmediaplayerx.Notify := true;
  FMediaPlayerx.Parent :=  Application.MainForm;
//  MediaPlayerx.ParentWindow :=
//  MediaPlayerx.DeviceType := dtAutoSelect;
    FMediaPlayerx.OnNotify := MediaPlayerExit;
    FMediaPlayerx.VisibleButtons := [];

  end;

  result := fmediaplayerx;



end;

function TDMEngine.LoadSkyDome(Matname,Filename : string) : TGLLibMaterial;
begin
   Result := GLMaterialLibrary1.AddTextureMaterial(Matname,'.\media\' + Filename);
   Result.Material.Texture.Disabled := false;
   Result.Material.Texture.TextureMode := tmDecal;
end;


end.


    // fazendo de maneira fixa oq sera resultado de parserleveldivision
    // Fase 1


(*    lvl := TGambaruLevel.Create;
    lvl.Arena := '.\Modelos\sakoji.3DS';
    lvl.SceneScaleX := 0.15;
    lvl.SceneScaleY := 0.15;
    lvl.SceneScaleZ := 0.15;
    lvl.LoadingText := 'Batalha em Sakoji';
    lvl.Fighters := TList.Create;

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -8.5;
    ftr.PositionY := 2;
    ftr.PositionZ := 12;
    ftr.Life := 75;
    ftr.Boss := True;
    ftr.Leader := True;
    ftr.Friend := False;
    ftr.FighterType :=  ftMitsuake;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -8.5;
    ftr.PositionY := 2;
    ftr.PositionZ := 16;
    ftr.Life := 25;
    ftr.Boss := False;
    ftr.Leader := False;
    ftr.Friend := False;
    ftr.FighterType :=  ftMitsuake;
    lvl.Fighters.Add(ftr);


    ftr := TGambaruFighter.Create;
    ftr.PositionX := -6;
    ftr.PositionY :=  2;
    ftr.PositionZ :=  40;
    ftr.FighterType :=  ftSejiro;
    ftr.Life := 120;
    ftr.Leader := True;
    ftr.Boss := False;
    ftr.friend := True;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -6;
    ftr.PositionY :=  2;
    ftr.PositionZ :=  45;
    ftr.FighterType :=  ftKatsome;
    ftr.Life := 120;
    ftr.Leader := False;
    ftr.Boss := False;
    ftr.friend := True;
    lvl.Fighters.Add(ftr);


    levels.Add(lvl);



    lvl := TGambaruLevel.Create;
    lvl.Arena := '.\Modelos\scene.3DS';
    lvl.SceneScaleX := 0.15;
    lvl.SceneScaleY := 0.15;
    lvl.SceneScaleZ := 0.15;
    lvl.LoadingText := 'Sejiro em Sakoji';
    lvl.Fighters := TList.Create;

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -8.5;
    ftr.PositionY := 2;
    ftr.PositionZ := 12;
    ftr.Life := 25;
    ftr.Boss := True;
    ftr.Leader := True;
    ftr.Friend := False;
    ftr.FighterType :=  ftMitsuake;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -6;
    ftr.PositionY :=  2;
    ftr.PositionZ :=  40;
    ftr.FighterType :=  ftSejiro;
    ftr.Life := 120;
    ftr.Leader := True;
    ftr.Boss := False;
    ftr.friend := True;
    lvl.Fighters.Add(ftr);

    levels.Add(lvl); *)



(*    lvl := TGambaruLevel.Create;
    lvl.Arena := '.\Modelos\scene.3DS';
    lvl.SceneScaleX := 0.5;
    lvl.SceneScaleY := 0.5;
    lvl.SceneScaleZ := 0.5;
(*    lvl.CameraPositionX := 0;
    lvl.CameraPositionY := 8;
    lvl.CameraPositionZ := 10; *)
(*    lvl.LoadingText := 'Batalha Final';

    lvl.Fighters := TList.Create;

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -8.5;
    ftr.PositionY :=  16;
    ftr.PositionZ :=  -12;
    ftr.FighterType :=  ftMitsuake;
    ftr.Life := 25;
    ftr.Leader := True;
    ftr.Boss := False;
    ftr.friend := False;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := 8.5;
    ftr.PositionY :=  16;
    ftr.PositionZ :=  -12;
    ftr.FighterType :=  ftMitsuake;
    ftr.Life := 25;
    ftr.Leader := True;
    ftr.Boss := True;
    ftr.friend := False;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -6;
    ftr.PositionY :=  2;
    ftr.PositionZ :=  40;
    ftr.FighterType :=  ftSejiro;
    ftr.Life := 120;
    ftr.Leader := True;
    ftr.Boss := False;
    ftr.friend := True;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -4;
    ftr.PositionY :=  2;
    ftr.PositionZ :=  50;
    ftr.FighterType :=  ftKatsome;
    ftr.Life := 120;
    ftr.Leader := False;
    ftr.Boss := False;
    ftr.friend := True;
    lvl.Fighters.Add(ftr);


    levels.Add(lvl);


    lvl := TGambaruLevel.Create;
    lvl.Arena := '.\Modelos\sakoji.3DS';
    lvl.SceneScaleX := 0.15;
    lvl.SceneScaleY := 0.15;
    lvl.SceneScaleZ := 0.15;
    lvl.LoadingText := 'Batalha Ultima';
    lvl.Fighters := TList.Create;

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -8.5;
    ftr.PositionY := 2;
    ftr.PositionZ := 12;
    ftr.Life := 75;
    ftr.Boss := True;
    ftr.Leader := True;
    ftr.Friend := False;
    ftr.FighterType :=  ftOni;
    lvl.Fighters.Add(ftr);

    ftr := TGambaruFighter.Create;
    ftr.PositionX := -8.5;
    ftr.PositionY := 2;
    ftr.PositionZ := 16;
    ftr.Life := 75;
    ftr.Boss := False;
    ftr.Leader := False;
    ftr.Friend := False;
    ftr.FighterType :=  ftOni;
    lvl.Fighters.Add(ftr);


    ftr := TGambaruFighter.Create;
    ftr.PositionX := -6;
    ftr.PositionY :=  2;
    ftr.PositionZ :=  40;
    ftr.FighterType :=  ftSejiro;
    ftr.Life := 120;
    ftr.Leader := True;
    ftr.Boss := False;
    ftr.friend := True;
    lvl.Fighters.Add(ftr);

    levels.Add(lvl); *)
