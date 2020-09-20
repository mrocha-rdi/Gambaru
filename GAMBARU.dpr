program GAMBARU;

uses
  Forms,
  Controls,
  Engine in 'Engine.pas' {DMEngine: TDataModule},
  util in 'util.pas',
  Fighter in 'Fighter.pas',
  Army in 'Army.pas',
  frmdebug in 'frmdebug.pas' {formDebug},
  constantes in 'constantes.pas',
  Physic in 'Physic.pas',
  oni in 'oni.pas',
  Sejiro in 'Sejiro.pas',
  newtonbox in 'newtonbox.pas',
  Katsome in 'Katsome.pas',
  DemiOni in 'DemiOni.pas',
  Weapon in 'Weapon.pas',
  SejiroKatana in 'SejiroKatana.pas',
  MitsuakeKatana in 'MitsuakeKatana.pas',
  DemiOniKatana in 'DemiOniKatana.pas',
  OniKatana in 'OniKatana.pas',
  Level in 'Level.pas';

{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(TDMEngine, DMEngine);
  Application.CreateForm(TformDebug, formDebug);
  DMEngine.Init;

  Application.Run;
end.
