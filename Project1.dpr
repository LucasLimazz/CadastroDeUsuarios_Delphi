program Project1;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {Form1},
  U_DM in 'U_DM.pas' {dm: TDataModule},
  U_Login in 'U_Login.pas' {Fm_Login},
  uFormat in 'uFormat.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFm_Login, Fm_Login);
  Application.Run;
end.
