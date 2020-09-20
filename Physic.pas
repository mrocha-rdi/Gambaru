unit Physic;

interface

uses SysUtils, VectorTypes,
     glVectorFileObjects, vectorlists, vectorgeometry,
     GLScene,  GLObjects,
     NewtonImport, Army, Fighter, newtonbox;

type
  TPhysic = class
    NewtonWorld: PNewtonWorld;
    NewtonBoxFighters: array of TFighterNewtonBox;
    NewtonBoxCamera: TNewtonBoxCamera;
  public
    procedure Init;
    procedure Apply(Army: TArmy); overload;
    procedure Apply(const AMesh: TGLBaseMesh); overload;
    procedure Apply(Camera: TGLCamera); overload;
    procedure Update;
  end;

implementation

uses util, constantes;





{ TPhysic }

procedure TPhysic.Apply(const AMesh: TGLBaseMesh);
var
  CollisionTree3DS: PNewtonCollision;
  Matrix: TMatrix4f;
  face3DS: array[0..2] of TAffineVector;
  i, j: integer;
  VectorList: TAffineVectorList;
  NewtonBody3DS: PNewtonBody;
  Min, Max: TVector3f;
begin
  CollisionTree3DS := NewtonCreateTreeCollision(NewtonWorld, nil);

  NewtonTreeCollisionBeginBuild(CollisionTree3DS);

  for j := 0 to AMesh.MeshObjects.Count - 1 do
  begin
    if AMesh.MeshObjects.Items[j].TriangleCount > 0 then
    begin
      VectorList := AMesh.MeshObjects.Items[j].ExtractTriangles(nil, nil);
      if VectorList <> nil then
      begin
        i := 0;
        repeat
          face3DS[0] := VectorList.Items[i+0];
          face3DS[1] := VectorList.Items[i+1];
          face3DS[2] := VectorList.Items[i+2];

          face3DS[0,0] := face3DS[0,0] * AMesh.Scale.X;
          face3DS[0,1] := face3DS[0,1] * AMesh.Scale.Y;
          face3DS[0,2] := face3DS[0,2] * AMesh.Scale.Z;

          face3DS[1,0] := face3DS[1,0] * AMesh.Scale.X;
          face3DS[1,1] := face3DS[1,1] * AMesh.Scale.Y;
          face3DS[1,2] := face3DS[1,2] * AMesh.Scale.Z;

          face3DS[2,0] := face3DS[2,0] * AMesh.Scale.X;
          face3DS[2,1] := face3DS[2,1] * AMesh.Scale.Y;
          face3DS[2,2] := face3DS[2,2] * AMesh.Scale.Z;

          NewtonTreeCollisionAddFace(CollisionTree3DS, 3, @face3DS[0], SizeOf(TAffineVector), 1);
          inc(i,3);
          until i > VectorList.Count - 1;
      end;
    end;
  end;

  NewtonTreeCollisionEndBuild(CollisionTree3DS, 1);

  NewtonBody3DS := NewtonCreateBody(NewtonWorld, CollisionTree3DS);

  Matrix := IdentityHmgMatrix;

  NewtonBodySetMatrix(NewtonBody3DS, @Matrix);

  NewtonCollisionCalculateAABB(CollisionTree3DS, @Matrix[0,0], @Min[0], @Max[0]);

  NewtonSetWorldSize(NewtonWorld, @Min[0], @Max[0]);

  NewtonReleaseCollision(NewtonWorld, CollisionTree3DS);


end;

procedure TPhysic.Init;
begin
  NewtonWorld := NewtonCreate(nil, nil);
end;

procedure TPhysic.Apply(Army: TArmy);
var
  i: Integer;
  nb: TFighterNewtonBox;
  size: VectorTypes.TVector3f;
  size4f: VectorTypes.TVector4f;
  fighter: TFighter;
begin

  for i := 0 to Army.Fighters.Count - 1 do
  begin
    fighter := TFighter(Army.Fighters[i]);

    SetLength(NewtonBoxFighters, Length(NewtonBoxFighters)+1);
    // Rotina para pegar as dimensões do AABB...
    // Utilizei apenas a maior dimensão...
    // Para evitar que o personagem afunde no cenário, tive que usar dimensões iguais para todos os eixos.
    size4f := fighter.Actor.AxisAlignedDimensions;
    // ALT-DANIEL: Aplicada a rotação do Mesh em 90° no plano YZ!
    size[0] := Size4f[0];
    size[1] := - 1 * Size4f[2];
    size[2] := Size4f[1];

    //VERSIONAMENTO:
    //DATA: 08.12.2007.
    //ALTERADO POR: DANIEL.
    //DESCRIÇÃO: RETIRADO OS COMADOS PARA DOBRAR O TAMANHO. ROTINA DESNECESSÁRIA.
    //           POR MODIFICARMOS O PADRÃO DE ENVELOPE DOS CORPOS DE 'BOX' PARA
    //           'SPHERE', PASSAMOS A UTILIZAR AS MEDIDAS COMO RAIOS E NÃO COMO
    //           ARESTAS DO QUADRADO. RESULTADO: UMA ESFERA DEFORMADA (ELIPSÓIDE)
    //           EM FUNÇÃO DOS DIFERENTES VALORES DE X,Y E Z.
    //size[0] := size[0] * 2;      <-- RETIRADO.
    //size[1] := size[1] * 2;      <-- RETIRADO.
    //size[2] := size[2] * 2;      <-- RETIRADO.

    nb := TFighterNewtonBox.Create;
    nb.NewtonWorld := NewtonWorld;
    nb.Fighter := fighter;

    nb.Init(size, fighter.Cubo.Position.AsAffineVector);

    NewtonBoxFighters[High(NewtonBoxFighters)] := nb;
    NewtonBodySetUserData(nb, fighter);
  end;

end;

procedure TPhysic.Update;
var
  i: integer;
  nb: TFighterNewtonBox;
  Matrix: TMatrix4f;
  //VERSIONAMENTO:
  //DATA: 09.12.2007.
  //DESCRIÇÃO: INCLUÍDA A VARIÁVEL 'CAMERAHEIGHTMODIFIER' PARA CONTROLAR A ALTURA
  //           DA CÂMERA QUANDO O SEJITO MUDAR DE PATAMAR NO CENÁRIO.
  CameraHeightModifier: single;
begin
  CameraHeightModifier := 0.0;
  { Update de NewtonBoxFighters}
  for i := Low(NewtonBoxFighters) to High(NewtonBoxFighters) do
  begin
    nb := TFighterNewtonBox(NewtonBoxFighters[i]);
    {TODO : IF SUPERPROVISORIO: O IDEAL EH PRENDER O PERSONAGEM AO CHAO PARA EVITAR INERCIA !!!!!
      EVITANDO O BUG DO CADAVER DERRAPANTE.}
    if Assigned(nb.Fighter) and (nb.Fighter.State <> fsDead) then
    begin
      NewtonBodyGetMatrix(nb.NewtonBody, @Matrix[0,0]);

      //TODO: "Fighter" vai se tornar algo mais generico: BaseObject ?
      nb.Fighter.Posicao.X := Matrix[3,0];
      nb.Fighter.Posicao.Y := Matrix[3,1];
      nb.Fighter.Posicao.Z := Matrix[3,2];

      //VERSIONAMENTO:
      //DATA: 09.12.2007.
      //DESCRIÇÃO: SOMENTE ATUALIZE A ALTURA DA CÂMERA SE O NEWTONBOX FOR DO SEJIRO.
      if nb.Fighter.FighterType = ftSejiro then
      begin
        CameraHeightModifier := nb.Fighter.Posicao.Y;
      end;
    end;
  end;

  { Update de NewtonBoxCamera }
  NewtonBodyGetMatrix(NewtonBoxCamera.NewtonBody, @Matrix[0,0]);
  TGLDummyCube(NewtonBoxCamera.Camera.Parent).Position.X := Matrix[3,0];

  //VERSIONAMENTO:
  //DATA: 09.12.2007.
  //DESCRIÇÃO: POSIÇÃO DA CÂMERA SOMADA AO MODIFICADOR DE ALTURA.
  TGLDummyCube(NewtonBoxCamera.Camera.Parent).Position.Y := Matrix[3,1] + CameraHeightModifier;
  TGLDummyCube(NewtonBoxCamera.Camera.Parent).Position.Z := Matrix[3,2];


  { TODO: verificar callbackcamera, tem codigo q pode vir pra ca}

  { Update de NewtonWorld }
  NewtonUpdate(NewtonWorld, (12 / 1000));

end;

procedure TPhysic.Apply(Camera: TGLCamera);
begin
(*  if Assigned(NewtonBoxCamera) then
    raise exception.create('Falha Grave: Camera ja instanciada'); *)

  if not Assigned(NewtonBoxCamera) then
  begin

    NewtonBoxCamera := TNewtonBoxCamera.Create;
    NewtonBoxCamera.NewtonWorld := NewtonWorld;
    NewtonBoxCamera.Camera := Camera;

    NewtonBoxCamera.Init(10);
  end;

end;

end.
