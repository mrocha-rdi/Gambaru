unit frmdebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLWin32Viewer, MPlayer, ExtCtrls;

type
  TformDebug = class(TForm)
    GLSceneViewer1: TGLSceneViewer;
    MediaPlayer: TMediaPlayer;
    pnlMovie: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDebug: TformDebug;

implementation

uses Engine;

{$R *.dfm}

procedure TformDebug.FormCreate(Sender: TObject);
begin
  GLSceneViewer1.Camera := DMEngine.GLCamera;
  Self.OnKeyDown := DMEngine.HandleKeysMenu;
  DMEngine.MediaPlayer := MediaPlayer;
  DMEngine.SceneViewer := GLSceneViewer1;
  DMEngine.PanelDisplayMovie := pnlMovie;
end;

procedure TformDebug.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MediaPlayer.Stop;
  MediaPlayer.Close;
end;

end.
