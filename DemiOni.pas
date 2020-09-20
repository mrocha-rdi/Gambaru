unit DemiOni;

interface

uses Classes, Fighter, util;

type
  TDemiOni = class(TFighter)
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

constructor TDemiOni.Create(Army: TObject);
begin
  inherited Create(Army);
end;

function TDemiOni.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\demioni.smd';
end;

function TDemiOni.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\demioni_run.smd';
end;

function TDemiOni.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\demioni_stand.smd';
end;

function TDemiOni.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\demioni_attack1.smd';
end;

function TDemiOni.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\demioni_attack2.smd';
end;

function TDemiOni.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\demioni_attack3.smd';
end;

function TDemiOni.get_ArquivoAnimacaoDeath: string;
begin
  Result := '.\Modelos\demioni_death.smd';
end;

function TDemiOni.GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
begin
  if FighterEmZonaDeCombate(liderInimigo) then
  begin
   { TODO: provavelmente isso aqui vai ser o retorno do InternalCombate. Mas tem que pensar em outro nome}
    Result.Attack := True;
    Result.Way := wayCenter;
    Result.Velocity := 0;
  end
  else
  begin
    if FighterEhVisualizado(LiderInimigo) then
      InimigoJaVisualizado := True;

     if FighterEstaNoMeuTerritorio(liderInimigo) OR
        ((TArmy(Self.Army).EfetivoMitsuake = 0) and InimigoJaVisualizado)then
       //Result := InternalFlocking(Amigos, Inimigos)
     else
     begin
       { TODO: provavelmente isso aqui vai ser uma especie de InternalParado. Mas tem que pensar em outro nome}
       Result.Attack := False;
       Result.Way := wayCenter;
       Result.Velocity := 0;
     end;
  end;
end;

function TDemiOni.get_Tamanho: single;
begin
  Result := 0.007;
end;

function TDemiOni.get_Massa: single;
begin
  Result := 120.0;
end;

function TDemiOni.get_DistanciaMinimaCombate: Single;
begin
  Result := 1;
end;

function TDemiOni.get_DistanciaMaximaCombate: Single;
begin
  Result := 1.5;
end;

function TDemiOni.get_RaioDeVisao: Integer;
begin
  Result := 400;
end;

function TDemiOni.get_AnguloDeVisao: Integer;
begin
  Result := 210;
end;

function TDemiOni.get_FighterType: TFighterType;
begin
  Result := ftDemiOni;
end;

procedure TDemiOni.Morrer;
begin
  inherited;
  TArmy(Self.Army).EfetivoDemiOni := TArmy(Self.Army).EfetivoDemiOni - 1; 
end;

end.
