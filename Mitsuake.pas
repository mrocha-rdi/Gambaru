unit Mitsuake;

interface

uses Classes, util, Fighter;

type
  TMitsuake = class(TFighter)
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

constructor TMitsuake.Create(Army: TObject);
begin
  inherited Create(Army);
end;

function TMitsuake.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\mitsuake_reference.smd';
end;

function TMitsuake.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\mitsuake_run.smd';
end;

function TMitsuake.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\mitsuake_stand.smd';
end;

function TMitsuake.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\mitsuake_attack01.smd';
end;

function TMitsuake.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\mitsuake_attack02.smd';
end;

function TMitsuake.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\mitsuake_attack03.smd';
end;

function TMitsuake.get_ArquivoAnimacaoDeath: string;
begin
  Result := '.\Modelos\mitsuake_death.smd';
end;

function TMitsuake.GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
var
  bVisualizadoNesteTurno: Boolean;
begin
  bVisualizadoNesteTurno := False;

  { Basta visualizar Sejiro uma unica vez para que um Mitsuake vá ao seu encontro.}
  if (FighterEhVisualizado(LiderInimigo)) and (not InimigoJaVisualizado) then
  begin
    InimigoJaVisualizado := True;
    bVisualizadoNesteTurno := True;
  end;

  if FighterEmZonaDeCombate(liderInimigo) then
  begin
   { TODO: provavelmente isso aqui vai ser o retorno do InternalCombate. Mas tem que pensar em outro nome}
    Result.Attack := True;
    Result.way := wayCenter;
    Result.Velocity := 0;
  end
  else
  begin

    if InimigoJaVisualizado then
      //Result := InternalFlocking(Amigos, Inimigos)
      //Result := InternalLineOfSightLider(LiderAmigo, LiderInimigo, Amigos, Inimigos)
      Result := InternalLineOfSight(Amigos, Inimigos)
    else
    begin
      Result.Velocity := 0;
      Result.Way := wayCenter;
      Result.Attack := False;
    end;
  end;

  if bVisualizadoNesteTurno then
    Result.Info := 'Matem ! Sem piedade !!!';

end;

//VERSIONAMENTO:
//DATA: 09.12.2007.
//DESCRIÇÃO: MODIFICADO O TAMANHO DOS MITSUAKÊS PARA FICAR COMPATÍVEL
//           COM O TAMANHO DE SEJIRO.
function TMitsuake.get_Tamanho: single;
begin
  Result := 0.009;
end;

function TMitsuake.get_Massa: single;
begin
  Result := 120.0;
end;

function TMitsuake.get_DistanciaMinimaCombate: Single;
begin
  Result := 0;
end;

function TMitsuake.get_DistanciaMaximaCombate: Single;
begin
  Result := 2;
end;

//VERSIONAMENTO:
//DATA: 09.12.2007.
//DESCRIÇÃO: RAIO DE VISÃO: 20 - FICOU BACANA COM ESTA DISTÂNCIA.
function TMitsuake.get_RaioDeVisao: Integer;
begin
  Result := 20;
end;

function TMitsuake.get_AnguloDeVisao: Integer;
begin
  Result := 210;
end;

function TMitsuake.get_FighterType: TFighterType;
begin
  Result := ftMitsuake;
end;

procedure TMitsuake.Morrer;
begin
  inherited;
  TArmy(Self.Army).EfetivoMitsuake := TArmy(Self.Army).EfetivoMitsuake - 1; 
end;

end.
