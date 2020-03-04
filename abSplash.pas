unit abSplash;

interface

uses
  Forms, Graphics, Classes, Controls, ExtCtrls, Dialogs, SysUtils, Windows, Vcl.StdCtrls;

type
  TfrmSplashMain = class(TForm)
    SplashImage: TImage;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
  end;

var
  frmSplashMain: TfrmSplashMain;

implementation

uses nsUtils;


{$R *.DFM}

procedure TfrmSplashMain.FormShow(Sender: TObject);
begin
  UpdateVistaFonts(Self);
end;

end.
