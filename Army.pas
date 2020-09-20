unit Army;

interface

uses Classes, VectorTypes, VectorGeometry, util, Fighter;

type

  TArmy = class
  private
    FFighters: TList;
    FEfetivo: Integer;
    FCor: TVector4f;
    FCorDoLider: TVector4f;
    FDistanciaDoCentro: Integer;
    FPosicaoInicial: TWay;
    FLider: TFighter;
    FLideradoPorIA: Boolean;
    FEfetivoMitsuake: Integer;
    FEfetivoDemiOni: Integer;
    function get_Fighters: TList;
    function get_Efetivo: Integer;
    procedure set_Efetivo(const Value: Integer);
    function get_DistanciaDoCentro: Integer;
    procedure set_DistanciaDoCentro(const Value: Integer);
    function get_PosicaoInicial: TWay;
    procedure set_PosicaoInicial(const Value: TWay);
    function get_Lider: TFighter;
    procedure set_Lider(const Value: TFighter);
    function get_PosicaoMedia: TAffineVector;
  public
    procedure Resetar;
    property Efetivo: Integer read get_Efetivo write set_Efetivo;
    property EfetivoMitsuake: Integer read FEfetivoMitsuake write FEfetivoMitsuake;
    property EfetivoDemiOni: Integer read FEfetivoDemiOni write FEfetivoDemiOni;
    property Fighters: TList read get_Fighters;
    property Cor: TVector4f read FCor write FCor;
    property CorDoLider: TVector4f read FCorDoLider write FCorDoLider;
    property DistanciaDoCentro: Integer read get_DistanciaDoCentro write set_DistanciaDoCentro;
    property PosicaoInicial: TWay read get_PosicaoInicial write set_PosicaoInicial;
    property Lider: TFighter read get_Lider write set_Lider;
    property LideradoPorIA: Boolean read FLideradoPorIA write FLideradoPorIA;
    property PosicaoMedia: TAffineVector read get_PosicaoMedia;
  end;

implementation

uses constantes;

{ TArmy }

function TArmy.get_Fighters: TList;
begin
  if not Assigned(FFighters) then
    FFighters := TList.Create;
  Result := FFighters;
end;

function TArmy.get_DistanciaDoCentro: Integer;
begin
  Result := FDistanciaDoCentro;
end;

function TArmy.get_Efetivo: Integer;
begin
  Result := FEfetivo;
end;

function TArmy.get_Lider: TFighter;
begin
  Result := FLider;
end;

function TArmy.get_PosicaoInicial: TWay;
begin
  Result := FPosicaoInicial;
end;

function TArmy.get_PosicaoMedia: TAffineVector;
var
  i, fighters: integer;
  fracao: Single;
  fighter: TFighter;
  posAcum: TAffineVector;
begin
  fighters := 0;
  for i := 0 to 2 do //   vector (0,0,0)
    posAcum[i] :=  0;

  for i := 0 to Self.Fighters.Count - 1 do
  begin
    fighter := TFighter(Self.Fighters[i]);
    if fighter.State <> fsDead then
    begin
      Inc(fighters);
      AddVector(posAcum, fighter.Posicao.AsAffineVector);
    end;
  end;

  fracao := 1 / fighters;
  VectorScale(posAcum, fracao, Result);
end;

procedure TArmy.set_DistanciaDoCentro(const Value: Integer);
begin
  FDistanciaDoCentro := Value;
end;

procedure TArmy.set_Efetivo(const Value: Integer);
begin
  FEfetivo := Value;
end;

procedure TArmy.Resetar;
begin
  FEfetivo := 0;
  FEfetivoMitsuake := 0;
  FEfetivoDemiOni := 0;
  FLider := nil;
end;

procedure TArmy.set_Lider(const Value: TFighter);
begin
  if Assigned(FLider) then // desliga o lider atual, se existir
    FLider.EhLider := False;
  FLider := Value;          // seta novo lider
  if Assigned(FLider) then
    FLider.EhLider := True;  // liga novo lider
end;

procedure TArmy.set_PosicaoInicial(const Value: TWay);
begin
  FPosicaoInicial := Value;
end;

end.
