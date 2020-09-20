unit Level;

interface

uses classes, util;

type

  TGambaruFighter = class
  private
    FPositionX: Single;
    FPositionY: Single;
    FPositionZ: Single;
    FLife: Integer;
    FFriend: Boolean;
    FBoss: Boolean;
    FLeader: Boolean;
    FFighterType: TFighterType;
  public
    property PositionX: Single read FPositionX write FPositionX;
    property PositionY: Single read FPositionY write FPositionY;
    property PositionZ: Single read FPositionZ write FPositionZ;
    property Life: Integer read FLife write FLife;
    property Friend: Boolean read FFriend write FFriend;
    property Boss: Boolean read FBoss write FBoss;
    property Leader: Boolean read FLeader write FLeader;
    property FighterType: TFighterType read FFighterType write FFighterType;
  end;

  TGambaruLevel = class
  private
    FMovie: String;
    FIndice: Integer;
    FArena: String;
    FSceneScaleX: Single;
    FSceneScaleY: Single;
    FSceneScaleZ: Single;
    FCameraPositionX: Single;
    FCameraPositionY: Single;
    FCameraPositionZ: Single;
    FFighters: TList;
    FLoadingText: String;
    FSejiroText: String;
    FScriptLevel: TStringList;
    FShowExit: Boolean;
    FExitX: Single;
    FExitY: Single;
    FExitZ: Single;
  public
    property Indice: Integer read FIndice write FIndice;
    property Arena: String read FArena write FArena;
    property SceneScaleX: Single read FSceneScaleX write FSceneScaleX;
    property SceneScaleY: Single read FSceneScaleY write FSceneScaleY;
    property SceneScaleZ: Single read FSceneScaleZ write FSceneScaleZ;
    property CameraPositionX: Single read FCameraPositionX write FCameraPositionX;
    property CameraPositionY: Single read FCameraPositionY write FCameraPositionY;
    property CameraPositionZ: Single read FCameraPositionZ write FCameraPositionZ;
    property Fighters: TList read FFighters write FFighters;
    property LoadingText: String read FLoadingText write FLoadingText;
    property ScriptLevel: TStringList read FScriptLevel write FScriptLevel;
    property SejiroText: String read FSejiroText write FSejiroText;
    property ExitX: Single read FExitX write FExitX;
    property ExitY: Single read FExitY write FExitY;
    property ExitZ: Single read FExitZ write FExitZ;
    property ShowExit: Boolean read FShowExit write FShowExit;
    property Movie: String read FMovie write FMovie;
  end;


implementation

end.
