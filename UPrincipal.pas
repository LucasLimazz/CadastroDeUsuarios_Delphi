unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BtnCep: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    MemTable: TFDMemTable;
    Label12: TLabel;
    edt_ID: TEdit;
    edt_cep: TEdit;
    edt_nome: TEdit;
    edt_sexo: TEdit;
    edt_idade: TEdit;
    edt_cpf: TEdit;
    edt_complemento: TEdit;
    edt_bairro: TEdit;
    edt_rua: TEdit;
    edt_cidade: TEdit;
    edt_uf: TEdit;
    btn_sair: TBitBtn;
    btn_incluir: TBitBtn;
    btn_excluir: TBitBtn;
    btn_editar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_atualizar: TBitBtn;
    btn_gravar: TBitBtn;
    Bevel1: TBevel;
    edt_pesquisar: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    edt_senha: TEdit;
    procedure BtnCepClick(Sender: TObject);
    procedure btn_incluirClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_atualizarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure LimparCampos();
    procedure TratarBotoes();
    procedure edt_pesquisarChange(Sender: TObject);
  private
    procedure ConsultarCEP(cep: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses U_DM, uFormat;

procedure TForm1.btn_atualizarClick(Sender: TObject);
begin
  TratarBotoes();
  try
    if dm.FDQuery1.Active then
      dm.FDQuery1.Close;
      dm.FDQuery1.Open;
      ShowMessage('Dados atualizados com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao atualizar os dados: ' + E.Message);
  end;
end;

procedure TForm1.btn_cancelarClick(Sender: TObject);
begin
  dm.FDQuery1.Cancel;
  dm.FDQuery1.CancelUpdates;
  LimparCampos();
  messagedlg ('Ação cancelada!',mtInformation,[mbOk],0);
end;

procedure TForm1.btn_excluirClick(Sender: TObject);
begin
    TratarBotoes();
    try
    dm.FDQuery1.CachedUpdates := True;
      if MessageDlg('Deseja realmente excluir esse usuário?', MtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        dm.FDQuery1.Delete;
        dm.FDQuery1.ApplyUpdates;
        ShowMessage('Registro deletado com sucesso!');
      end;
    except
      on E: Exception do
      begin
        dm.FDConnection1.Rollback;
        ShowMessage('Erro ao excluir registro: ' + E.Message);
      end
    end;
  dm.FDQuery1.Close;
  dm.FDQuery1.Open;
  LimparCampos();
end;

procedure TForm1.btn_editarClick(Sender: TObject);
begin
  TratarBotoes();
  dm.FDQuery1.CachedUpdates := True;
  if messagedlg ('Deseja realmente editar esse registro?',mtConfirmation,[mbOk,mbNo],0)=mrOk then
  begin
    dm.FDQuery1.Edit;
  end
  else
    abort;
end;

procedure TForm1.btn_gravarClick(Sender: TObject);
begin
  TratarBotoes();
  if dm.FDQuery1.State in [dsInsert, dsEdit] then
  begin
    dm.FDQuery1.FieldByName('NOME').AsString := edt_nome.Text;
    dm.FDQuery1.FieldByName('SEXO').AsString := edt_sexo.Text;
    dm.FDQuery1.FieldByName('CPF').AsString := edt_cpf.Text;
    dm.FDQuery1.FieldByName('IDADE').AsString := edt_idade.Text;
    dm.FDQuery1.FieldByName('SENHA').AsString := edt_senha.Text;
    dm.FDQuery1.FieldByName('CEP').AsString := edt_cep.Text;
    dm.FDQuery1.FieldByName('RUA').AsString := edt_rua.Text;
    dm.FDQuery1.FieldByName('COMPLEMENTO').AsString := edt_complemento.Text;
    dm.FDQuery1.FieldByName('CIDADE').AsString := edt_cidade.Text;
    dm.FDQuery1.FieldByName('BAIRRO').AsString := edt_bairro.Text;
    dm.FDQuery1.FieldByName('ESTADO').AsString := edt_uf.Text;

    if dm.FDQuery1.State = dsInsert then
      dm.FDQuery1.Post; // Se estiver inserindo, faz o Post
      ShowMessage('Registro gravado com sucesso!');
  end
  else
  begin
    ShowMessage('O dataset não está em modo de edição ou inserção.');
  end;
  dm.FDQuery1.ApplyUpdates; // Aplica as atualizações
  dm.FDQuery1.Close;
  dm.FDQuery1.Open;
  LimparCampos();
end;


procedure TForm1.btn_incluirClick(Sender: TObject);
begin
  TratarBotoes();
  LimparCampos();
  dm.FDQuery1.Active:= True;
  dm.FDQuery1.Last;
  dm.FDQuery1.CachedUpdates := True;
  dm.FDQuery1.Append;
  dm.FDQuery1.FieldByName('ID').ReadOnly := False;
  edt_nome.SetFocus;
end;

procedure TForm1.btn_sairClick(Sender: TObject);
begin
  Application.Terminate;
end;

// Validação de caracteres do campo CEP informado pelo usuário + requisição da API.
procedure Tform1.ConsultarCEP(cep: string);
begin
  if SomenteNumero(edt_cep.Text).Length <> 8 then
  begin
    ShowMessage('CEP inválido');
    exit;
  end;

  RESTRequest1.Resource := SomenteNumero(edt_cep.Text) + '/json';
  RESTRequest1.Execute;

  if RESTRequest1.Response.StatusCode = 200 then
  begin
    if RESTRequest1.Response.Content.IndexOf ('erro') > 0 then
    ShowMessage('CEP não encontrado')
    else
    begin
      with MemTable do
      begin
         edt_cep.Text := FieldByName('cep').AsString;
         edt_rua.Text := FieldByName('logradouro').AsString;
         edt_bairro.Text := FieldByName('bairro').AsString;
         edt_cidade.Text := FieldByName('localidade').AsString;
         edt_uf.Text := FieldByName('uf').AsString;
      end;
    end;
  end
  else
    ShowMessage('Erro ao consultar CEP');
end;

// Ao clicar em um registro da tabela, os campos são preenchidos para melhor visualização dos mesmos.
procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  if Assigned(DBGrid1.DataSource) and Assigned(DBGrid1.DataSource.DataSet) and
     (DBGrid1.DataSource.DataSet.RecordCount > 0) then
  begin
    edt_ID.Text := DBGrid1.DataSource.DataSet.FieldByName('ID').AsString;
    edt_nome.Text := DBGrid1.DataSource.DataSet.FieldByName('NOME').AsString;
    edt_sexo.Text := DBGrid1.DataSource.DataSet.FieldByName('SEXO').AsString;
    edt_cpf.Text := DBGrid1.DataSource.DataSet.FieldByName('CPF').AsString;
    edt_idade.Text := DBGrid1.DataSource.DataSet.FieldByName('IDADE').AsString;
    edt_senha.Text := DBGrid1.DataSource.DataSet.FieldByName('SENHA').AsString;
    edt_cep.Text := DBGrid1.DataSource.DataSet.FieldByName('CEP').AsString;
    edt_rua.Text := DBGrid1.DataSource.DataSet.FieldByName('RUA').AsString;
    edt_complemento.Text := DBGrid1.DataSource.DataSet.FieldByName('COMPLEMENTO').AsString;
    edt_cidade.Text := DBGrid1.DataSource.DataSet.FieldByName('CIDADE').AsString;
    edt_bairro.Text := DBGrid1.DataSource.DataSet.FieldByName('BAIRRO').AsString;
    edt_uf.Text := DBGrid1.DataSource.DataSet.FieldByName('ESTADO').AsString;
  end;
end;


// Função do campo Pesquisar, o mesmo busca pelo nome do usuário cadastrado no DBGrid.
procedure TForm1.edt_pesquisarChange(Sender: TObject);
begin
  dm.FDQuery1.locate('NOME', edt_pesquisar.Text,[loPartialKey]);
end;

procedure TForm1.LimparCampos; // Limpa os campos após determinada ação.
begin
  edt_ID.Text := '';
  edt_nome.Text := '';
  edt_sexo.Text := '';
  edt_cpf.Text := '';
  edt_idade.Text := '';
  edt_senha.Text := '';
  edt_cep.Text := '';
  edt_rua.Text := '';
  edt_complemento.Text := '';
  edt_cidade.Text := '';
  edt_bairro.Text := '';
  edt_uf.Text := '';
end;

procedure TForm1.TratarBotoes;
begin
  btn_incluir.Enabled := not btn_incluir.Enabled;
  btn_excluir.Enabled := not btn_excluir.Enabled;
  btn_editar.Enabled := not btn_editar.Enabled;
  btn_atualizar.Enabled := not btn_atualizar.Enabled;
  btn_gravar.Enabled := not btn_gravar.Enabled;
end;

procedure TForm1.BtnCepClick(Sender: TObject);
begin
  ConsultarCEP(edt_cep.Text);
end;

end.
