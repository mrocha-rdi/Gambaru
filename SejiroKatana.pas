unit SejiroKatana;

interface

uses Weapon;

type
  TSejiroKatana = class(TWeapon)
  protected
    function get_ArquivoModelo3D: string; override;
    function get_ArquivoAnimacaoStand: string; override;
    function get_ArquivoAnimacaoRun: string; override;
    function get_ArquivoAnimacaoAttack: string; override;
    function get_ArquivoAnimacaoAttack2: string; override;
    function get_ArquivoAnimacaoAttack3: string; override;        
    function get_ArquivoAnimacaoDeath: string; override;
  end;


implementation

{ TSejiroKatana }

function TSejiroKatana.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\katana_attack01.smd';
end;

function TSejiroKatana.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\katana_attack02.smd';
end;

function TSejiroKatana.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\katana_attack03.smd';
end;

function TSejiroKatana.get_ArquivoAnimacaoDeath: string;
begin
  Result := '.\Modelos\katana_death.smd';
end;

function TSejiroKatana.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\katana_run.smd';
end;

function TSejiroKatana.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\katana_stand.smd';
end;

function TSejiroKatana.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\katana_reference.smd';
end;

end.
