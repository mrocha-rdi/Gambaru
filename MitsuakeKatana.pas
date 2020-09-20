unit MitsuakeKatana;

interface

uses Weapon;

type
  TMitsuakeKatana = class(TWeapon)
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

{ TMitsuakeKatana }

function TMitsuakeKatana.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\mitsuake_weapon_attack01.smd';
end;

function TMitsuakeKatana.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\mitsuake_weapon_attack02.smd';
end;

function TMitsuakeKatana.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\mitsuake_weapon_attack03.smd';
end;

function TMitsuakeKatana.get_ArquivoAnimacaoDeath: string;
begin
  Result := '.\Modelos\mitsuake_weapon_death.smd';
end;

function TMitsuakeKatana.get_ArquivoAnimacaoRun: string;
begin
  Result := '.\Modelos\mitsuake_weapon_run.smd';
end;

function TMitsuakeKatana.get_ArquivoAnimacaoStand: string;
begin
  Result := '.\Modelos\mitsuake_weapon_stand.smd';
end;

function TMitsuakeKatana.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\mitsuake_weapon_reference.smd';
end;

end.
