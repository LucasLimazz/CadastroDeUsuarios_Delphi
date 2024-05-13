object dm: Tdm
  Height = 312
  Width = 537
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 40
    Top = 120
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=crudcadastros'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object FDQuery1: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from cadastropessoas')
    Left = 160
    Top = 40
    object FDQuery1ID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuery1NOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 80
    end
    object FDQuery1IDADE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'IDADE'
      Origin = 'IDADE'
    end
    object FDQuery1CPF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 14
    end
    object FDQuery1SEXO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object FDQuery1CEP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 9
    end
    object FDQuery1RUA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'RUA'
      Origin = 'RUA'
      Size = 100
    end
    object FDQuery1COMPLEMENTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 100
    end
    object FDQuery1BAIRRO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 100
    end
    object FDQuery1CIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 60
    end
    object FDQuery1ESTADO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Size = 50
    end
    object FDQuery1SENHA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'SENHA'
      Origin = 'SENHA'
      EditMask = '****************;1;_'
      Size = 100
    end
  end
  object QLogin: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM cadastropessoas'
      'order by ID')
    Left = 312
    Top = 216
    object QLoginID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QLoginNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object QLoginIDADE: TIntegerField
      FieldName = 'IDADE'
      Origin = 'IDADE'
    end
    object QLoginCPF: TStringField
      FieldName = 'CPF'
      Origin = 'CPF'
      Size = 14
    end
    object QLoginSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 1
    end
    object QLoginCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 9
    end
    object QLoginRUA: TStringField
      FieldName = 'RUA'
      Origin = 'RUA'
      Size = 100
    end
    object QLoginCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 100
    end
    object QLoginBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 100
    end
    object QLoginCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object QLoginESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      FixedChar = True
      Size = 2
    end
  end
  object DsLogin: TDataSource
    DataSet = QLogin
    Left = 400
    Top = 216
  end
end
