unit Katsome;

interface

uses Classes, util, Fighter;

type
  TKatsome = class(TFighter)
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

constructor TKatsome.Create(Army: TObject);
begin
  inherited Create(Army);
end;

function TKatsome.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\sejiro_reference.smd';
end;

function TKatsome.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\sejiro_run.smd';
end;

function TKatsome.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\sejiro_stand.smd';
end;

function TKatsome.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\sejiro_attack01.smd';
end;

function TKatsome.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\sejiro_attack02.smd';
end;

function TKatsome.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\sejiro_attack03.smd';
end;

function TKatsome.get_ArquivoAnimacaoDeath: string;
begin
  Result := '.\Modelos\sejiro_death.smd';
end;

function TKatsome.GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
var
  bVisualizadoNesteTurno: Boolean;
begin
  bVisualizadoNesteTurno := False;

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

  if not InimigoJaVisualizado then
  begin
    Result := InternalLineOfSightLider(LiderAmigo, liderinimigo, amigos, inimigos);
//    Result := InternalFlocking(Amigos, Inimigos);
  end;

end;

//VERSIONAMENTO:
//DATA: 09.12.2007.
//DESCRIÇÃO: MODIFICADO O TAMANHO DOS MITSUAKÊS PARA FICAR COMPATÍVEL
//           COM O TAMANHO DE SEJIRO.
function TKatsome.get_Tamanho: single;
begin
  Result := 0.003;
end;

function TKatsome.get_Massa: single;
begin
  Result := 120.0;
end;

function TKatsome.get_DistanciaMinimaCombate: Single;
begin
  Result := 0;
end;

function TKatsome.get_DistanciaMaximaCombate: Single;
begin
  Result := 2;
end;

//VERSIONAMENTO:
//DATA: 09.12.2007.
//DESCRIÇÃO: RAIO DE VISÃO: 20 - FICOU BACANA COM ESTA DISTÂNCIA.
function TKatsome.get_RaioDeVisao: Integer;
begin
  Result := 2000;
end;

function TKatsome.get_AnguloDeVisao: Integer;
begin
  Result := 360;
end;

function TKatsome.get_FighterType: TFighterType;
begin
  Result := ftKatsome;
end;

procedure TKatsome.Morrer;
begin
  inherited;
  TArmy(Self.Army).EfetivoMitsuake := TArmy(Self.Army).EfetivoMitsuake - 1;
end;

end.
