unit U_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFm_Login = class(TForm)
    Label1: TLabel;
    EdNome: TEdit;
    Label2: TLabel;
    EdSenha: TEdit;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn2: TBitBtn;
    Bevel4: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fm_Login: TFm_Login;

implementation

{$R *.dfm}

uses U_DM, UPrincipal;

procedure TFm_Login.BitBtn1Click(Sender: TObject);
begin
  // Autenticação de login
  with dm.QLogin do
  begin
    Close;
    sql.add('');
    sql.clear;
    Params.clear;
    sql.add('select * from cadastropessoas');
    sql.add('where nome =:NOME');
    Parambyname('NOME').asstring:=EdNome.Text;
    sql.add('And senha =:SENHA');
    Parambyname('SENHA').asstring:=EdSenha.Text;
    open;
  end;

  // se nada for encontrado
  if dm.QLogin.recordcount =0 then
  begin
    Messagedlg('Usuário não encontrado!',
    MtInformation, [mbOk], 0);
    EdNome.Clear;
    EdSenha.Clear;
    EdNome.SetFocus;
    Abort;
  end
  else
  // se encontrar o usuário
  Form1:=TForm1.Create(self);
  Form1.ShowModal;
end;

procedure TFm_Login.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFm_Login.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // Enter igual ao tab
  if key=#13 then
  begin
    Key:=#0;
    Perform(wm_nextDlgCtl,0,0);
  end;

end;

end.
