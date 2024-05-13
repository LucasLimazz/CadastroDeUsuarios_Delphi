unit U_DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  Tdm = class(TDataModule)
    DataSource1: TDataSource;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    QLogin: TFDQuery;
    DsLogin: TDataSource;
    QLoginID: TFDAutoIncField;
    QLoginNOME: TStringField;
    QLoginIDADE: TIntegerField;
    QLoginCPF: TStringField;
    QLoginSEXO: TStringField;
    QLoginCEP: TStringField;
    QLoginRUA: TStringField;
    QLoginCOMPLEMENTO: TStringField;
    QLoginBAIRRO: TStringField;
    QLoginCIDADE: TStringField;
    QLoginESTADO: TStringField;
    FDQuery1ID: TFDAutoIncField;
    FDQuery1NOME: TStringField;
    FDQuery1IDADE: TIntegerField;
    FDQuery1CPF: TStringField;
    FDQuery1SEXO: TStringField;
    FDQuery1CEP: TStringField;
    FDQuery1RUA: TStringField;
    FDQuery1COMPLEMENTO: TStringField;
    FDQuery1BAIRRO: TStringField;
    FDQuery1CIDADE: TStringField;
    FDQuery1ESTADO: TStringField;
    FDQuery1SENHA: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
