unit newtonbox;

interface

uses VectorTypes, GLScene, GLObjects, VectorGeometry, physictypes, Fighter;

type

  TFighterNewtonBox = class
    NewtonBody : PNewtonBody;
    Matrix     : TMatrix4f;
    Size       : TVector3f;
    NewtonWorld: PNewtonWorld;
    Fighter: TFighter;
    procedure Init(pSize, pPosition : TVector3f);
  end;

  TNewtonBoxCamera = class
    NewtonBody : PNewtonBody;
    Matrix     : TMatrix4f;
    Size       : TVector3f;
    NewtonWorld: PNewtonWorld;
    Camera: TGLCamera;
    procedure Init(pMass: Single);
  end;



implementation

uses NewtonImport, constantes;

{ TFighterNewtonBox}

procedure ForceAndTorqueCallback(const body : PNewtonBody); cdecl;
var
  Mass: Single;
  Inertia: TVector3f;
  Force: TVector3f;
  Velocity: TVector3f;
  UserData: Pointer;
begin
  UserData := NewtonBodyGetUserData(body);

  //VERSIONAMENTO:
  //DATA: 08.12.2007.
  //ALTERADO POR: DANIEL.
  //DESCRIÇÃO: SUBSTITUIÇÃO DO VALOR -9.8 PELA CONSTANTE 'GRAVITY' CUJO VALOR É IGUAL
  //           A -100.0. COM ESTA MAGNITUDE AUMENTAMOS A VELOCIDADE DE QUEDA DOS CORPOS
  //           E EVITAMOS QUE OS SALTEM PARA O ALTO APÓS SUBIR AS ESCADAS.
  //           EFEITO DE SALTAR APÓS SAIR DAS ESCADAS MINIMIZADO POR ESTA ALTERAÇÃO,
  //           PORÉM, AINDA PRESENTE COM RESULTADO ACEITÁVEL!
  NewtonBodyGetMassMatrix(body, @Mass, @Inertia[0], @Inertia[1], @Inertia[2]);
  Force[0] := 0;
  Force[1] := GRAVITY * Mass;
  Force[2] := 0;
  NewtonBodyAddForce(body, @Force);

  with TFighter(UserData) do
  begin
    if IsRunning then
    begin
      // GetVelocity: para manter a velocidade da gravidade atuante.
      NewtonBodyGetVelocity(body, @Velocity);
      Velocity[0] := -1 * Direcao.X * SEJIRO_TOP_VELOCITY;
      Velocity[2] := -1 * Direcao.Z * SEJIRO_TOP_VELOCITY;
      NewtonBodySetVelocity(body, @Velocity);
    end
    else
    begin
      // GetVelocity: para manter a velocidade da gravidade atuante.
      // Apenas velocidade da gravidade.
      NewtonBodyGetVelocity(body, @Velocity);
      Velocity[0] := 0.0;
      Velocity[2] := 0.0;
      NewtonBodySetVelocity(body, @Velocity);
    end;
  end;
end;

procedure TFighterNewtonBox.Init(pSize, pPosition : TVector3f);
var
  Inertia: TVector3f;
  Collision: PNewtonCollision;
  vectorUp: array[0..2] of Single;
begin
  Size := pSize;

  // Criando uma caixa para colisões...
  // Utilizando Caixa para parar mais rápido...

  //VERSIONAMENTO:
  //DATA: 08.12.2007.
  //ALTERADO POR: DANIEL.
  //DESCRIÇÃO: ALTERADO DE 'BOX' PARA 'SPHERE'.
  //           ESTA MODIFICAÇÃO POSSIBILITA QUE OS PERSONAGENS SUBAM E DESÇAM AS
  //           ESCADAS, POIS A ESFERA CORRE POR SUPERFÍCIES IRREGULARES, PORÉM,
  //           NÃO TOMBA EM FUNÇÃO DO MÉTODO 'NewtonConstrainUpVector'.
  Collision := NewtonCreateSphere(NewtonWorld, pSize[0], pSize[1], pSize[2], nil);

  // Criando um corpo rígido...
  NewtonBody := NewtonCreateBody(NewtonWorld, Collision);

  // Removendo o "colisador"...
  NewtonReleaseCollision(NewtonWorld, Collision);

  NewtonBodySetAutoFreeze(NewtonBody, 0);

  NewtonWorldUnfreezeBody(NewtonWorld, NewtonBody);

  // Calculando o momento de inércia...
  // ToDo: Obter a inércia para um cilindro ou retângulo dimensionado pelo personagem.
  Inertia[0] := Fighter.Massa * (pSize[1] * pSize[1] + pSize[2] * pSize[2]) / 12;
  Inertia[1] := Fighter.Massa * (pSize[0] * pSize[0] + pSize[2] * pSize[2]) / 12;
  Inertia[2] := Fighter.Massa * (pSize[0] * pSize[0] + pSize[1] * pSize[1]) / 12;

  // Definindo a massa e o momento de inércia do corpo...
  NewtonBodySetMassMatrix(NewtonBody, Fighter.Massa, Inertia[0], Inertia[1], Inertia[2]);

  // Definindo a matriz de localização do corpo...
  NewtonBodyGetMatrix(NewtonBody, @Matrix[0,0]);

  Matrix[3,0] := Fighter.Posicao.AsVector[0];
  Matrix[3,1] := Fighter.Posicao.AsVector[1];
  Matrix[3,2] := Fighter.Posicao.AsVector[2];

  NewtonBodySetMatrix(NewtonBody, @Matrix[0,0]);

  vectorUp[0] := Fighter.Cubo.Up.X;
  vectorUp[1] := Fighter.Cubo.Up.Y;
  vectorUp[2] := Fighter.Cubo.Up.Z;

  // Impede que o personagem tombe!
  NewtonConstraintCreateUpVector(NewtonWorld, @vectorUp, NewtonBody);

  // Aplicando forças...
  NewtonBodySetForceAndTorqueCallBack(NewtonBody, ForceAndTorqueCallBack);

  NewtonBodySetUserData(NewtonBody, Fighter);

end;

{ TNewtonBoxCamera }

procedure ForceAndTorqueCallbackCamera(const body : PNewtonBody); cdecl;
var
  Mass: Single;
  Inertia: TVector3f;
  Force: TVector3f;
  Acceleration: TVector3f;
  vectorDirection: TVector3f;
  vectorDistance: TVector3f;
  UserData: Pointer; 
begin
  UserData := NewtonBodyGetUserData(body);

  // Boas práticas!
  Acceleration[0] := 0.0;
  Acceleration[1] := 0.0;
  Acceleration[2] := 0.0;

  NewtonBodyGetMassMatrix(body, @Mass, @Inertia[0], @Inertia[1], @Inertia[2]);

  with TGLCamera(UserData) do
  begin
    // Controle adicional ao TargetObject da Camera.
    vectorDistance[0] := TGLDummyCube(TargetObject).Position.X - TGLDummyCube(Parent).Position.X;
    vectorDistance[1] := TGLDummyCube(TargetObject).Position.Y - TGLDummyCube(Parent).Position.Y;
    vectorDistance[2] := TGLDummyCube(TargetObject).Position.Z - TGLDummyCube(Parent).Position.Z;

    vectorDirection[0] := vectorDistance[0];
    vectorDirection[1] := 0;
    vectorDirection[2] := vectorDistance[2];

    NormalizeVector(vectorDirection);

    { TODO: Como isso poderia estar no physic update ? }
    TGLDummyCube(Parent).Direction.X := vectorDirection[0];
    TGLDummyCube(Parent).Direction.Y := 0; // Não quero modificar a direção em Y!
    TGLDummyCube(Parent).Direction.Z := vectorDirection[2];

    if VectorLength(vectorDistance) >= 20 then
    begin
      //VERSIONAMENTO:
      //DATA: 09.12.2007.
      //DESCRIÇÃO: MULTIPLICADA A ACELERAÇÃO PELO FATOR '2' PARA COMPENSAR O AUMENTO
      //           DE VELOCIDADE DADO AO SEJIRO (SEJIRO_TOP_VELOCITY = 20).
      Acceleration[0] := (2 * SEJIRO_TOP_VELOCITY * vectorDirection[0]);
      Acceleration[1] := 0.0; // Por enquanto não quero aceleração em Y!
      Acceleration[2] := (2 * SEJIRO_TOP_VELOCITY * vectorDirection[2]);

      Force[0] := Mass * Acceleration[0];
      Force[1] := 0.0;
      Force[2] := Mass * Acceleration[2];

      NewtonBodyAddForce(body, @Force);
    end
    else
    begin
      Force[0] := 0.0;
      Force[1] := 0.0;
      Force[2] := 0.0;
      NewtonBodyAddForce(body, @Force);
    end
  end;
end;

procedure TNewtonBoxCamera.Init(pMass: Single);
var
  Inertia: TVector3f;
  Collision: PNewtonCollision;
  damp: TVector3f;
  CameraCube: TGLDummyCube;
begin
  CameraCube := TGLDummyCube(Camera.Parent);

  // Criando uma caixa para colisões...
  // Utilizando Caixa para parar mais rápido...
  Collision := NewtonCreateBox(NewtonWorld, CameraCube.CubeSize, CameraCube.CubeSize, CameraCube.CubeSize, nil);

  // Criando um corpo rígido...
  NewtonBody := NewtonCreateBody(NewtonWorld, Collision);

  // Removendo o "colisador"...
  NewtonReleaseCollision(NewtonWorld, Collision);

  NewtonBodySetAutoFreeze(NewtonBody, 0);

  NewtonWorldUnfreezeBody(NewtonWorld, NewtonBody);

  // Calculando o momento de inércia...
  Inertia[0] := CAMERA_MASS * (2 * CameraCube.CubeSize * CameraCube.CubeSize) / 12;
  Inertia[1] := CAMERA_MASS * (2 * CameraCube.CubeSize * CameraCube.CubeSize) / 12;
  Inertia[2] := CAMERA_MASS * (2 * CameraCube.CubeSize * CameraCube.CubeSize) / 12;

  // Definindo a massa e o momento de inércia do corpo...
  NewtonBodySetMassMatrix(NewtonBody, CAMERA_MASS, Inertia[0], Inertia[1], Inertia[2]);

  // Definindo a matriz de localização do corpo...
  NewtonBodyGetMatrix(NewtonBody, @Matrix[0,0]);

  Matrix[3,0] := CameraCube.Position.AsVector[0];
  Matrix[3,1] := CameraCube.Position.AsVector[1];
  Matrix[3,2] := CameraCube.Position.AsVector[2];

  NewtonBodySetMatrix(NewtonBody, @Matrix[0,0]);

  damp[0] := 1;
  damp[1] := 1;
  damp[2] := 1;
  NewtonBodySetLinearDamping(NewtonBody, 1);
	NewtonBodySetAngularDamping(NewtonBody, @damp[0]);

  NewtonBodySetForceAndTorqueCallBack(NewtonBody, ForceAndTorqueCallBackCamera);

  NewtonBodySetUserData(NewtonBody, Camera);

end;

end.
