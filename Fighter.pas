unit Fighter;

interface

uses SysUtils, Classes, GLMisc, GLVectorFileObjects, GLNavigator, GLObjects, GLGeomObjects, util, VectorTypes, weapon;

type
  TFighter = class
  private
    FActor: TGLActor;
    FGLNavigator: TGLNavigator;
    FEhLider: Boolean;
    FIsRunning: Boolean;
    FTime: Single;
    FMovement: TVector3f;
    FExternalForce: TVector3f;

    FState: TFighterState;
    FComboState: TComboState;
    FPontosDeVida: Integer;
    FClasseDeArmadura: Integer;
    FUltimaVelocityAdotada: Double;
    FRodadasParado: Integer;
    FLag: Integer;
    FArmy: TObject;
    FCubo: TGLDummyCube;
    FTerritorio: TGLDummyCube;
    FWeapon: TWeapon;
    FInimigoJaVisualizado: Boolean;
    FisBoss: Boolean;
    FisFriend: Boolean;

    function get_Direcao: TGLCoordinates;
    function get_Posicao: TGLCoordinates;
    procedure set_Direcao(const Value: TGLCoordinates);
    procedure set_Posicao(const Value: TGLCoordinates);
    function get_Actor: TGLActor;
    procedure set_Actor(const Value: TGLActor);
    function get_GLNavigator: TGLNavigator;
    procedure set_GLNavigator(const Value: TGLNavigator);
    function get_VelocityCaminhada: Double;
    function get_VelocityCorrida: Double;
    function get_UltimaVelocityAdotada: Double;
  protected
    function get_ArquivoModelo3D: string; virtual; abstract;
    function get_ArquivoAnimacaoStand: string; virtual; abstract;
    function get_ArquivoAnimacaoRun: string; virtual; abstract;
    function get_ArquivoAnimacaoAttack: string; virtual; abstract;
    function get_ArquivoAnimacaoAttack2: string; virtual; abstract;
    function get_ArquivoAnimacaoAttack3: string; virtual; abstract;
    function get_ArquivoAnimacaoDeath: string; virtual; abstract;
    function get_Tamanho: single; virtual; abstract;
    function get_Massa: single; virtual; abstract;
    function get_DistanciaMinimaCombate: Single; virtual; abstract;
    function get_DistanciaMaximaCombate: Single; virtual; abstract;
    function get_RaioDeVisao: Integer; virtual;  abstract;
    function get_AnguloDeVisao: Integer; virtual; abstract;
    function get_FighterType: TFighterType; virtual; abstract;
    function FighterEmZonaDeCombate(Fighter: TFighter): Boolean;
    function FighterEhVisualizado(Fighter: TFighter): Boolean;
    function FighterEstaNoMeuTerritorio(Fighter: TFighter): Boolean;
//    function ForaDoCenario: Boolean;
//    function InternalProcureOCentro: TFighterAction;
    function InternalLineOfSight(Friends, Enemys: TList): TFighterAction;
    function InternalLineOfSightLider(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
  public
    constructor Create(Army: TObject);

    property ArquivoModelo3D: string read get_ArquivoModelo3D;
    property ArquivoAnimacaoStand: string read get_ArquivoAnimacaoStand;
    property ArquivoAnimacaoRun: string read get_ArquivoAnimacaoRun;
    property ArquivoAnimacaoAttack: string read get_ArquivoAnimacaoAttack;
    property ArquivoAnimacaoAttack2: string read get_ArquivoAnimacaoAttack2;
    property ArquivoAnimacaoAttack3: string read get_ArquivoAnimacaoAttack3;
    property ArquivoAnimacaoDeath: string read get_ArquivoAnimacaoDeath;

    property Tamanho: single read get_Tamanho;
    property Massa: single read get_Massa;

    property DistanciaMinimaCombate: Single read get_DistanciaMinimaCombate;
    property DistanciaMaximaCombate: Single read get_DistanciaMaximaCombate;

    property RaioDeVisao: Integer read get_RaioDeVisao;
    property AnguloDeVisao: Integer read get_AnguloDeVisao;
    property FighterType: TFighterType read get_FighterType;

    property Posicao: TGLCoordinates read get_Posicao write set_Posicao;
    property Direcao: TGLCoordinates read get_Direcao write set_Direcao;

    property VelocityCaminhada: Double read get_VelocityCaminhada;
    property VelocityCorrida: Double read get_VelocityCorrida;
    property UltimaVelocityAdotada: Double read get_UltimaVelocityAdotada;

    property EhLider: Boolean read FEhLider write FEhLider;

    property Actor: TGLActor read get_Actor write set_Actor;
    property Cubo: TGLDummyCube read FCubo write FCubo;
    property Territorio: TGLDummyCube read FTerritorio write FTerritorio;
    property GLNavigator: TGLNavigator read get_GLNavigator write set_GLNavigator;

    property State: TFighterState read FState write FState;
    property ComboState: TComboState read FComboState write FComboState;
    property Army: TObject read FArmy;

    property PontosDeVida: Integer read FPontosDeVida write FPontosDeVida;
    property isBoss: Boolean read FisBoss write FisBoss;
    property isFriend: Boolean read FisFriend write FisFriend;

    property ClasseDeArmadura: Integer read FClasseDeArmadura write FClasseDeArmadura;

    property Lag: Integer read FLag write FLag;

    property RodadasParado: Integer read FRodadasParado write FRodadasParado;


    property InimigoJaVisualizado: Boolean read FInimigoJaVisualizado write FInimigoJaVisualizado;


    // Para uso da engine de Fisica.
    property IsRunning: Boolean read FIsRunning write FIsRunning;
    property Time: Single read FTime write FTime;
    property Movement: TVector3f read FMovement write FMovement;
    property ExternalForce: TVector3f read FExternalForce write FExternalForce;

    property Weapon: TWeapon read FWeapon write FWeapon;

    procedure EndFrameReached(Sender: TObject);

    function GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction; virtual; abstract;

    procedure Andar(Velocity: Double);
    procedure Parar;
    procedure VirarPraDireita;
    procedure VirarPraEsquerda;
    procedure Atacar;
    procedure Apanhar;
    procedure Morrer; dynamic;
  end;

implementation

uses VectorGeometry, GLTexture, constantes, Math;

{ TFighter }

constructor TFighter.Create(Army: TObject);
begin
  FClasseDeArmadura := CLASSE_DE_ARMADURA;
  FPontosDeVida := PONTOS_DE_VIDA;

  FUltimaVelocityAdotada := 0;
  FRodadasParado := 0;

  FState := fsStoped;

  FArmy := Army;
  inherited Create;
end;

function TFighter.get_Actor: TGLActor;
begin
  Result := FActor;
end;

function TFighter.get_Direcao: TGLCoordinates;
begin
  Result := Cubo.Direction;
end;

function TFighter.get_Posicao: TGLCoordinates;
begin
  Result := Cubo.Position;
end;

procedure TFighter.set_Actor(const Value: TGLActor);
begin
  FActor := Value;
end;

procedure TFighter.set_Direcao(const Value: TGLCoordinates);
begin
  Cubo.Direction := Value;
end;

procedure TFighter.set_Posicao(const Value: TGLCoordinates);
begin
  Cubo.Position := Value;
end;

function TFighter.get_GLNavigator: TGLNavigator;
begin
  Result := FGLNavigator;
end;

procedure TFighter.set_GLNavigator(const Value: TGLNavigator);
begin
  FGLNavigator := Value;
end;

function TFighter.get_VelocityCaminhada: Double;
begin
  Result := VELOCIDADE_CAMINHADA;
end;

procedure TFighter.Andar(Velocity: Double);
begin
(*
  FGLNavigator.MovingObject := Cubo;
  FGLNavigator.MoveForward(Velocity);  // corrida normal
  FGLNavigator.MovingObject := nil;
*)

  State := fsMoving;
  IsRunning := True;

  if Assigned(FActor) then
    if FActor.CurrentAnimation <> '2' then
    begin
      FActor.SwitchToAnimation(ID_RUN);
      FActor.AnimationMode := aamLoop;
    end;


  FUltimaVelocityAdotada := Velocity;
  FRodadasParado := 0;

  FMovement[0] := FMovement[0] + Direcao.X;
  FMovement[2] := FMovement[2] + Direcao.Z;


end;

procedure TFighter.Parar;
begin
  if Assigned(FActor) then
  begin
    FActor.SwitchToAnimation(ID_STAND);
    FActor.AnimationMode := aamLoop;
  end;
  IsRunning := False;
  FState := fsStoped;
end;

procedure TFighter.VirarPraDireita;
begin
  FGLNavigator.MovingObject := Cubo;
  FGLNavigator.TurnHorizontal(-ANGULO_VIRADA);
  FGLNavigator.MovingObject := nil;
  if Assigned(FActor) then
    if FActor.CurrentAnimation <> '2' then
    begin
      FActor.SwitchToAnimation(ID_RUN);
      FActor.AnimationMode := aamLoop;
    end;
end;

procedure TFighter.VirarPraEsquerda;
begin
  FGLNavigator.MovingObject := Cubo;
  FGLNavigator.TurnHorizontal(ANGULO_VIRADA);
  FGLNavigator.MovingObject := nil;
  if Assigned(FActor) then
    if FActor.CurrentAnimation <> '2' then
    begin
      FActor.SwitchToAnimation(ID_RUN);
      FActor.AnimationMode := aamLoop;
    end;
end;

procedure TFighter.Atacar;
begin
  if Assigned(FActor) then
    if not ((FActor.CurrentAnimation = IntToStr(ID_ATTACK)) OR
     (FActor.CurrentAnimation = IntToStr(ID_ATTACK2)) OR
     (FActor.CurrentAnimation = IntToStr(ID_ATTACK3))) then
    begin
      case FComboState of
        csAttack1: FActor.SwitchToAnimation(ID_ATTACK);
        csAttack2: FActor.SwitchToAnimation(ID_ATTACK2);
        csAttack3: FActor.SwitchToAnimation(ID_ATTACK3);
      end;
      FActor.AnimationMode := aamPlayOnce;
      FWeapon.Atacar;
    end;
end;

procedure TFighter.Apanhar;
begin
  if Assigned(FActor) then
  begin
    if FActor.CurrentAnimation <> '1' then
    begin
      FActor.SwitchToAnimation(ID_STAND);
      FActor.AnimationMode := aamLoop;
    end;
    FActor.SwitchToAnimation(ID_STAND);
  end;
end;

procedure TFighter.Morrer;
begin
  if FActor.CurrentAnimation <> '4' then
    FActor.SwitchToAnimation(ID_DEATH);
  State := fsDead;
  FActor.AnimationMode := aamPlayOnce;
end;
  
function TFighter.InternalLineOfSightLider(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
var
  direcaoLider, posicaoLider, vetorDistancia: TVector3F;
  vetorAux: TAffineVector;
//  produtoEscalar: Single;

begin
//  produtoEscalar := VectorDotProduct(Posicao.AsVector, Direcao.AsVector);

  direcaoLider := LiderAmigo.Direcao.AsAffineVector;
  posicaoLider := LiderAmigo.Posicao.AsAffineVector;

  vetorDistancia := VectorSubtract(Self.Posicao.AsAffineVector, posicaoLider);

  vetorAux := VectorCrossProduct(Self.Direcao.AsAffineVector, vetorDistancia);

  if vetorAux[1] < 0 then
    Result.Way := wayLeft
  else
  begin
    if vetorAux[1] = 0 then
      Result.Way := wayCenter
    else
     Result.Way := wayRight
  end;


    Result.Velocity := VelocityCaminhada
end;


function TFighter.get_VelocityCorrida: Double;
begin
  Result := VELOCIDADE_CORRIDA;
end;

//VERSIONAMENTO:
//DATA: 10.12.2007.
//DESCRIÇÃO: I.A. RESOLVIDA.
//           A IDÉIA BÁSICA DESTE ALGORITMO É O LINE-OF-SIGHT, PORÉM, COM UMA
//           ALTERAÇÃO DE DIREÇÃO QUANDO OS INIMIGOS SE APROXIMAM UNS DOS OUTROS.

function TFighter.InternalLineOfSight(Friends, Enemys: TList): TFighterAction;
var i: Integer;
    friend, enemy: TFighter;
    dirFriend, dirFriendNormalized: TVector3f;
    distEnemy, distEnemyNormalized: TVector3f;
    dirFinal, crossProduct: TAffineVector;
    KeepLowerDistance: TVector3f;
begin
  dirFriendNormalized := NullVector;
  dirFinal            := NullVector;
  SetVector(KeepLowerDistance, 1000.0, 1000.0, 1000.0);

  //PRIMEIRO: VERIFICAMOS QUEM DOS NOSSOS AMIGOS MITSUAKÊS ESTÃO MAIS PRÓXIMOS.
  //E ENTÃO GUARDO APENAS A INFORMAÇÃO DE DISTÂNCIA DESTE SUJEITO.
  for i := 0 to Friends.Count - 1 do
  begin
    friend := TFighter(Friends[i]);
    if (friend.State <> fsDead) and (friend <> Self) then
    begin
      dirFriend := VectorSubtract(Self.Posicao.AsAffineVector, Friend.Posicao.AsAffineVector);
      dirFriend[1] := 0.0; //Diferença de altura desnecessária.
      if VectorLength(dirFriend) < VectorLength(KeepLowerDistance) then
        KeepLowerDistance := dirFriend;
    end;
  end;

  //SE A MENOR DISTÂNCIA ENCONTRADA ENTRE OS SUJEITOS É MENOR DO QUE 3.0 ENTÃO...
  //PRECISO CORRIGIR A POSIÇÃO DO MITSUAKÊ PARA NÃO SOBREPOR AS IMAGENS (POSIÇÕES).
  if VectorLength(KeepLowerDistance) < 3.0 then
    dirFriendNormalized := VectorNormalize(KeepLowerDistance);

  // LOCALIZO O SEJIRO POR LINE OF SIGHT SIMPLESMENTE...
  enemy := TFighter(Enemys[0]);
  if (enemy.State <> fsDead) then
  begin
    distEnemy := VectorSubtract(Enemy.Posicao.AsAffineVector, Self.Posicao.AsAffineVector);
    distEnemy[1] := 0.0; //Diferença de altura desnecessária.

    distEnemyNormalized := VectorNormalize(distEnemy);
  end;

  // COMBINO OS RESULTADOS DA DIREÇÃO DO SEJIRO E A DIREÇÃO INVERSA DO SUJEITO MITSUAKÊ MAIS PRÓXIMO.
  AddVector(dirFinal, dirFriendNormalized);
  AddVector(dirFinal, distEnemyNormalized);
  dirFinal := VectorNormalize(dirFinal);

  // TOMO A DECISÃO DE ONDE IR ENTÃO...
  crossProduct := VectorCrossProduct(Self.Direcao.AsAffineVector, dirFinal);
  if crossProduct[1] <= 0 then
    Result.Way := wayRight
  else
    Result.Way := wayLeft;

  if enemy.FighterType = ftMitsuake then
    Result.Velocity := VELOCIDADE_CORRIDA
  else
    // ONI MAIS LENTO QUE OS MITSUAKES.
    Result.Velocity := VELOCIDADE_ONI;
    
  Result.Attack := False;
end;


function TFighter.get_UltimaVelocityAdotada: Double;
begin
  Result := FUltimaVelocityAdotada;
end;

function TFighter.FighterEmZonaDeCombate(Fighter: TFighter): Boolean;
var
  distancia: TVector3f;
begin
  distancia := VectorSubtract(Self.Posicao.AsAffineVector, Fighter.Posicao.AsAffineVector);

  Result := (VectorLength(distancia) >= Self.DistanciaMinimaCombate)
            and (VectorLength(distancia) <= Self.DistanciaMaximaCombate)

end;

function TFighter.FighterEhVisualizado(Fighter: TFighter): Boolean;
var
  distancia: TVector3f;
begin
  distancia := VectorSubtract(Self.Posicao.AsAffineVector, Fighter.Posicao.AsAffineVector);

  Result := (VectorLength(distancia) <= Self.RaioDeVisao);

  { TODO: aqui é preciso considerar o angulo de visao !! }

end;


function TFighter.FighterEstaNoMeuTerritorio(
  Fighter: TFighter): Boolean;
begin
  Result := Assigned(FTerritorio) and (FTerritorio.PointInObject(Fighter.Posicao.AsVector));
end;

procedure TFighter.EndFrameReached(Sender: TObject);
begin
  if Assigned(Actor) and
      ((Actor.CurrentAnimation = IntToStr(ID_ATTACK)) OR
     (Actor.CurrentAnimation = IntToStr(ID_ATTACK2)) OR
     (Actor.CurrentAnimation = IntToStr(ID_ATTACK3))) then
  begin
  {TODO: algum temporizador ou sei la oque tem de fazer voltar pra attack1 quando o jogador demorar a apertar o botao}
    if FComboState = csAttack3 then
      FComboState := csAttack1
    else
      Inc(FComboState);
    Actor.SwitchToAnimation(ID_STAND);
  end;
end;


end.
