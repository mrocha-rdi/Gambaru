unit constantes;

interface

const
  DISTANCIA_CENTRO = 1;
  LAG_ATAQUE = 12;
  MAX_RODADAS_SEM_MOVIMENTO = 10;

  CLASSE_DE_ARMADURA = 15;

  PONTOS_DE_VIDA = 40;
  PONTOS_DE_MAGIA = 10;
  PONTOS_DE_VIDA_LIDER = 40;

  VELOCIDADE_CAMINHADA = 45;
  VELOCIDADE_CORRIDA = 20;
  VELOCIDADE_ONI = 5;
  ANGULO_VIRADA = 5.0;


  VITALIDADE_MINIMA_CORRIDA = 20;

  ID_STAND = 1;
  ID_RUN = 2;
  ID_ATTACK = 3;
  ID_ATTACK2 = 4;
  ID_ATTACK3 = 5;
  ID_DEATH = 6;


  DEMI_ONI_SCALE = 0.01;

var
  GRAVITY: Extended;
  SEJIRO_TOP_VELOCITY: Extended;
  CAMERA_MASS: Extended;

  PESO_COESAO: Integer;//  = 0;
  PESO_ALINHAMENTO: Integer;//  = 0;
  PESO_SEPARACAO: Integer; // = 0;
  PESO_OFENSIVO: Integer; // = 1;
  PESO_OFENSIVO_LIDER: Integer; // = 0;
  PESO_LIDER: Integer; // = 0;
  ESPACAMENTO_INICIAL: Integer; // = 40;

  MENU_TRACK_THEME: Integer;//  = 20;
  INTERVAL_MENU_TRACK: Integer; // = 45000;
  GAMEOVER_TRACK_THEME: Integer; // = 21;
  INTERVAL_GAMEOVER_TRACK: Integer; // = 86000;
  ONI_TRACK_THEME: Integer; // = 19;
  LOGO_TRACK_THEME: Integer; // = 2;
  LEVEL_TRACK_THEME: Integer; // = 14;
  LEVELCOMPLETE_TRACK_THEME: Integer; // = 49;
  INTERVAL_ONI_TRACK: Integer; // = 43000;
  INTERVAL_LEVEL_TRACK: Integer; // = 68000;
  INTERVAL_LEVELCOMPLETE_TRACK: Integer; // = 19000;



implementation

end.
