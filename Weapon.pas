unit Weapon;

interface

uses SysUtils, Classes, GLMisc, GLVectorFileObjects, GLNavigator, GLObjects, GLGeomObjects, util, VectorTypes;

type
  TWeapon = class
  private
    FActor: TGLActor;
    FCausouDano: Boolean;
    FAtacando: Boolean;
  protected
    function get_ArquivoModelo3D: string; virtual; abstract;
    function get_ArquivoAnimacaoStand: string; virtual; abstract;
    function get_ArquivoAnimacaoRun: string; virtual; abstract;
    function get_ArquivoAnimacaoAttack: string; virtual; abstract;
    function get_ArquivoAnimacaoAttack2: string; virtual; abstract;
    function get_ArquivoAnimacaoAttack3: string; virtual; abstract;        
    function get_ArquivoAnimacaoDeath: string; virtual; abstract;
  public
    procedure Atacar;
    procedure EndFrameReached(Sender: TObject);

    property Actor: TGLActor read FActor write FActor;
    property CausouDano: Boolean read FCausouDano write FCausouDano;
    property Atacando: Boolean read FAtacando write FAtacando;

    property ArquivoModelo3D: string read get_ArquivoModelo3D;
    property ArquivoAnimacaoStand: string read get_ArquivoAnimacaoStand;
    property ArquivoAnimacaoRun: string read get_ArquivoAnimacaoRun;
    property ArquivoAnimacaoAttack: string read get_ArquivoAnimacaoAttack;
    property ArquivoAnimacaoAttack2: string read get_ArquivoAnimacaoAttack2;
    property ArquivoAnimacaoAttack3: string read get_ArquivoAnimacaoAttack3;        
    property ArquivoAnimacaoDeath: string read get_ArquivoAnimacaoDeath;

  end;

implementation

uses constantes;

{ TWeapon }

procedure TWeapon.Atacar;
begin
  Atacando := True;
  CausouDano := False;
(*  if Assigned(FActor) then
//    if FActor.CurrentAnimation <> 'attack' then
    begin
      case FComboState of
        csAttack1: FActor.SwitchToAnimation(ID_ATTACK1);
        csAttack2: FActor.SwitchToAnimation(ID_ATTACK2);
        csAttack3: FActor.SwitchToAnimation(ID_ATTACK3);
      end; 
      FActor.AnimationMode := aamPlayOnce;
    end; *)
end;

procedure TWeapon.EndFrameReached(Sender: TObject);
begin
  if Assigned(Actor) and
    ((Actor.CurrentAnimation = IntToStr(ID_ATTACK)) OR
     (Actor.CurrentAnimation = IntToStr(ID_ATTACK2)) OR
     (Actor.CurrentAnimation = IntToStr(ID_ATTACK3))) then
  begin
    Atacando := False;
    Actor.SwitchToAnimation(ID_STAND);
  end;
end;

end.
