unit util;

interface

type

  TCameraMedia = (cmInativa, cmGeral, cmAmigo, cmInimigo);

  TWay = (wayLeft, wayCenter, wayRight);

  TFighterState = (fsStoped, fsMoving, fsDead);

  TComboState = (csAttack1, csAttack2, csAttack3);

  TFighterAction = record
    Way: TWay;
    Velocity: Double;
    Attack: Boolean;
    Info: String;
  end;

  TFighterType = (ftSejiro, ftKatsome, ftMitsuake, ftDemiOni, ftOni);

  TGameState = (stLogo, stMenu, stLoading, stLevelIntro, stLevel, stLevelComplete, stGameSuccess, stGameOver);

implementation

end.
