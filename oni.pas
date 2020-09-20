unit oni;

interface

uses Classes, GLParticleFX, Fighter, util;

type
  TOni = class(TFighter)
  public
    constructor Create(Army: TObject);
    function get_ArquivoModelo3D: string; override;
    function get_ArquivoAnimacaoStand: string; override;
    function get_ArquivoAnimacaoRun: string; override;
    function get_ArquivoAnimacaoAttack: string; override;
    function get_ArquivoAnimacaoAttack2: string; override;
    function get_ArquivoAnimacaoAttack3: string; override;        
    function get_ArquivoAnimacaoDeath: string; override;
    function get_Tamanho: single; override;
    function get_Massa: single; override;
    function get_DistanciaMinimaCombate: Single; override;
    function get_DistanciaMaximaCombate: Single; override;
    function get_RaioDeVisao: Integer; override;
    function get_AnguloDeVisao: Integer; override;
    function get_FighterType: TFighterType; override;
    function GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction; override;
    procedure Morrer; override;    
  end;

implementation

uses Army;

constructor TOni.Create(Army: TObject);
begin
  inherited Create(Army);
end;

function TOni.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\oni_reference.smd';
end;

function TOni.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\oni_run.smd';
end;

function TOni.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\oni_stand.smd';
end;

function TOni.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\oni_attack01.smd';
end;

function TOni.get_ArquivoAnimacaoAttack2: string;
begin
  //Result := '.\Modelos\oni_attack01.smd';
  Result := '.\Modelos\oni_attack02.smd';
end;

function TOni.get_ArquivoAnimacaoAttack3: string;
begin
  //Result := '.\Modelos\oni_attack01.smd';
  Result := '.\Modelos\oni_attack03.smd';
end;

function TOni.get_ArquivoAnimacaoDeath: string;
begin
  //Result := '.\Modelos\oni_stand.smd';
  Result := '.\Modelos\oni_death.smd';
end;

function TOni.GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
begin
{ Ele deveria fazer cara de interrogacao se
(TArmy(Self.Army).EfetivoMitsuake > 0) OR
(TArmy(Self.Army).EfetivoDemiOni > 0) ... :D
}
  if FighterEmZonaDeCombate(liderInimigo) then
  begin
    Result := InternalLineOfSight(Amigos, Inimigos);
    Result.Attack := True;
    Result.Way := wayCenter;
    Result.Velocity := 0;
  end
  else if (FighterEhVisualizado(LiderInimigo)) then
  begin
    Result := InternalLineOfSight(Amigos, Inimigos)
  end
  else
  begin
    Result.Attack := False;
    Result.Way := wayCenter;
    Result.Velocity := 0;
  end;
end;

function TOni.get_Tamanho: single;
begin
  Result := 0.006;
end;

function TOni.get_Massa: single;
begin
  Result := 120.0;
end;

function TOni.get_DistanciaMaximaCombate: Single;
begin
  Result := 3.0;
end;

function TOni.get_DistanciaMinimaCombate: Single;
begin
  Result := 0;
end;

function TOni.get_RaioDeVisao: Integer;
begin
  Result := 200;
end;

function TOni.get_AnguloDeVisao: Integer;
begin
  Result := 210;
end;


function TOni.get_FighterType: TFighterType;
begin
  Result := ftOni;
end;

procedure TOni.Morrer;
begin
  inherited;
//  TGLSourcePFXEffect(Self.Cubo.Effects[0]).Enabled := False;
end;


end.
