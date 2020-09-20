unit Sejiro;

interface

uses SysUtils, Fighter, Classes, util;

type
  TSejiro = class(TFighter)
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
  end;

implementation

constructor TSejiro.Create(Army: TObject);
begin
  inherited Create(Army);
end;

function TSejiro.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\sejiro_reference.smd';
end;

function TSejiro.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\sejiro_run.smd';
end;

function TSejiro.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\sejiro_stand.smd';
end;

function TSejiro.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\sejiro_attack01.smd';
end;

function TSejiro.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\sejiro_attack02.smd';
end;

function TSejiro.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\sejiro_attack03.smd';
end;

function TSejiro.get_ArquivoAnimacaoDeath: string;
begin
  Result := '.\Modelos\sejiro_death.smd';
end;

function TSejiro.GetAction(LiderAmigo, LiderInimigo: TFighter; Amigos, Inimigos: TList): TFighterAction;
begin
  raise exception.create('acao decidida do sejiro ??');
end;

//VERSIONAMENTO:
//DATA: 09.12.2007.
//DESCRIÇÃO: MODIFICADO O TAMANHO DO PERSONAGEM PARA ADEQUAR AO REESCALONAMENTO
//           DO CENÁRIO QUE PASSOU A TER SCALE := 0,15!
function TSejiro.get_Tamanho: single;
begin
  Result := 0.004;
end;

function TSejiro.get_Massa: single;
begin
  Result := 80.0;
end;

function TSejiro.get_DistanciaMinimaCombate: Single;
begin
  Result := 1;
end;

function TSejiro.get_DistanciaMaximaCombate: Single;
begin
  Result := 1.5;
end;

function TSejiro.get_RaioDeVisao: Integer;
begin
  Result := 400;
end;

function TSejiro.get_AnguloDeVisao: Integer;
begin
  Result := 210;
end;


function TSejiro.get_FighterType: TFighterType;
begin
  Result := ftSejiro;
end;

end.

