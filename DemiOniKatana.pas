unit DemiOniKatana;

interface

uses Weapon;

type
  TDemiOniKatana = class(TWeapon)
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

{ TDemiOniKatana }

function TDemiOniKatana.get_ArquivoAnimacaoAttack: string;
begin
  Result := '.\Modelos\Quake2Animations.aaf';
end;

function TDemiOniKatana.get_ArquivoAnimacaoAttack2: string;
begin
  Result := '.\Modelos\Quake2Animations.aaf';
end;

function TDemiOniKatana.get_ArquivoAnimacaoAttack3: string;
begin
  Result := '.\Modelos\Quake2Animations.aaf';
end;

function TDemiOniKatana.get_ArquivoAnimacaoDeath: string;
begin

end;

function TDemiOniKatana.get_ArquivoAnimacaoRun: string;
begin

end;

function TDemiOniKatana.get_ArquivoAnimacaoStand: string;
begin

end;

function TDemiOniKatana.get_ArquivoModelo3D: string;
begin
  Result := '.\Modelos\weaponWaste.md2';
end;

end.
