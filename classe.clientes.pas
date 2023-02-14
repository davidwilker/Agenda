unit classe.clientes;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms;

Type

  TCliente = Class

    private
      FConexao        : TFDConnection;

      FID_CLIENTE     : Integer;
      FDS_NOME        : String;
      FDT_NASCIMENTO  : TdateTime;
      FNR_CPF         : String;
      FNR_RG          : String;
      FNR_CEP         : String;
      FDS_ENDERECO    : String;
      FNR_NUMERO      : String;
      FDS_COMPLEMENTO : String;
      FDS_BAIRRO      : String;
      FDS_CIDADE      : String;
      FDS_UF          : String;
      FNR_TELEFONE    : String;
      FNR_TELEFONE2   : String;
      FDS_OBS         : String;

    public
      property Conexao        : TFDConnection  read   FConexao         write FConexao;
      property ID_CLIENTE     : Integer        read   FID_CLIENTE      write FID_CLIENTE;
      property DS_NOME        : String         read   FDS_NOME         write FDS_NOME;
      property DT_NASCIMENTO  : TdateTime      read   FDT_NASCIMENTO   write FDT_NASCIMENTO;
      property NR_CPF         : String         read   FNR_CPF          write FNR_CPF;
      property NR_RG          : String         read   FNR_RG           write FNR_RG;
      property NR_CEP         : String         read   FNR_CEP          write FNR_CEP;
      property DS_ENDERECO    : String         read   FDS_ENDERECO     write FDS_ENDERECO;
      property NR_NUMERO      : String         read   FNR_NUMERO       write FNR_NUMERO;
      property DS_COMPLEMENTO : String         read   FDS_COMPLEMENTO  write FDS_COMPLEMENTO;
      property DS_BAIRRO      : String         read   FDS_BAIRRO       write FDS_BAIRRO;
      property DS_CIDADE      : String         read   FDS_CIDADE       write FDS_CIDADE;
      property DS_UF          : String         read   FDS_UF           write FDS_UF;
      property NR_TELEFONE    : String         read   FNR_TELEFONE     write FNR_TELEFONE;
      property NR_TELEFONE2   : String         read   FNR_TELEFONE2    write FNR_TELEFONE2;
      property DS_OBS         : String         read   FDS_OBS          write FDS_OBS;

      Constructor Create (Conexao : TFDConnection);
      destructor  Destroy; Override;

      function  fncInserirAlterar (Tipooperacao: String; out Erro: String ): Boolean;
      procedure prcDeleta (id_chave: Integer);
      function  fncConsulta ( Texto: String ): TFDQuery;
  End;
var
  QryConsulta : TFDQuery;

implementation

{ TCliente }

uses unitFuncoes;

constructor TCliente.Create(Conexao: TFDConnection);
begin
  FConexao                := Conexao;
  QryConsulta             := TFDQuery.Create( nil );
  QryConsulta.Connection  := FConexao;
end;

destructor TCliente.Destroy;
begin
  QryConsulta.Destroy;
  inherited;
end;

function TCliente.fncConsulta(Texto: String): TFDQuery;
begin
  try
    FConexao.Connected := False;
    Fconexao.Connected := True;

    QryConsulta.SQL.Clear;
    QryConsulta.SQl.Add('select ID_CLIENTE,DS_NOME,DT_NASCIMENTO,NR_CPF,NR_RG,NR_CEP,');
    QryConsulta.SQL.Add('DS_ENDERECO,NR_NUMERO,DS_COMPLEMENTO,DS_BAIRRO,DS_CIDADE,DS_UF,NR_TELEFONE,NR_TELEFONE2,DS_OBS from clientes');
    QryConsulta.SQL.Add('where DS_NOME like :p_Texto or NR_CPF like :p_Texto');

    QryConsulta.ParamByName('p_texto').AsString := '%'+Texto+'%';
    QryConsulta.Open;

  finally
    Result := QryConsulta;
  end;
end;

function TCliente.fncInserirAlterar(Tipooperacao: String;
  out Erro: String): Boolean;
var
  QryInserir : TFDQuery;
begin
  try
    try
      FConexao.Connected := False;
      FConexao.Connected := True;

      QryInserir := TFDQuery.Create(nil);
      QryInserir.Connection := FConexao;

      QryInserir.Close;
      QryInserir.SQL.Clear;

      if TipoOperacao = 'INSERIR' then
      begin

        QryInserir.SQl.Add('insert into clientes (ID_CLIENTE, DS_NOME, DT_NASCIMENTO,NR_CPF,NR_RG,NR_CEP,');
        QryInserir.SQL.Add('DS_ENDERECO,NR_NUMERO,DS_COMPLEMENTO,DS_BAIRRO,DS_CIDADE,DS_UF,NR_TELEFONE,NR_TELEFONE2,DS_OBS)');
        QryInserir.SQL.Add('values (:p_id_cliente, :p_ds_nome, :p_dt_nascimento, :p_nr_cpf, :p_nr_rg, :p_nr_cep,');
        QryInserir.SQL.Add(':p_ds_endereco, :p_nr_numero, :p_ds_complemento, :p_ds_bairro, :p_ds_cidade, :p_ds_uf, :p_nr_telefone, :p_nr_telefone2, :p_ds_obs)');

        QryInserir.ParamByName('p_id_cliente').AsInteger := fncProximoCodigo('Clientes', 'id_cliente');

      end else
      begin
        QryInserir.SQl.Add('update clientes set DS_NOME = :p_ds_nome, DT_NASCIMENTO = :p_dt_nascimento, NR_CPF = :p_nr_cpf, NR_RG = :p_nr_rg, NR_CEP = :p_nr_cep,');
        QryInserir.SQL.Add('DS_ENDERECO = :p_ds_endereco, NR_NUMERO = :p_nr_numero, DS_COMPLEMENTO = :p_ds_complemento, DS_BAIRRO = :p_ds_bairro, DS_CIDADE = :p_ds_cidade, DS_UF = :p_ds_uf, NR_TELEFONE = :p_nr_telefone, NR_TELEFONE2 = :p_nr_telefone2, DS_OBS = :p_ds_obs ');
        QryInserir.SQL.Add('where ID_CLIENTE = :p_id_cliente');

        QryInserir.ParamByName('p_id_cliente').AsInteger := fncProximoCodigo('Clientes', 'id_cliente');

      end;

      QryInserir.ParamByName('p_DS_NOME').AsString         := DS_NOME;
      QryInserir.ParamByName('p_DT_NASCIMENTO').AsDateTime := DT_NASCIMENTO;
      QryInserir.ParamByName('p_NR_CPF').AsString          := NR_CPF;
      QryInserir.ParamByName('p_NR_RG').AsString           := NR_RG;
      QryInserir.ParamByName('p_NR_CEP').AsString          := NR_CEP;
      QryInserir.ParamByName('p_DS_ENDERECO').AsString     := DS_ENDERECO;
      QryInserir.ParamByName('p_NR_NUMERO').AsString       := NR_NUMERO;
      QryInserir.ParamByName('p_DS_COMPLEMENTO').AsString  := DS_COMPLEMENTO;
      QryInserir.ParamByName('p_DS_BAIRRO').AsString       := DS_BAIRRO;
      QryInserir.ParamByName('p_DS_CIDADE').AsString       := DS_CIDADE;
      QryInserir.ParamByName('p_DS_UF').AsString           := DS_UF;
      QryInserir.ParamByName('p_NR_TELEFONE').AsString     := NR_TELEFONE;
      QryInserir.ParamByName('p_NR_TELEFONE2').AsString    := NR_TELEFONE2;
      QryInserir.ParamByName('p_DS_OBS').AsString          := DS_OBS;

      QryInserir.ExecSQL;

      Result := True;
    except
      on E: Exception do
      begin
        Erro := E.Message;
        Result := False;
      end;

    end;
  finally
    QryInserir.Destroy;
  end;

end;

procedure TCliente.prcDeleta(id_chave: Integer);
begin
  if funcCriarMensagem('Confirmar', 'Excluir Cliente',
    'Tem certeza que deseja excluir esse CLIENTE ?',
    ExtractFilePath(Application.ExeName) + '\icons\alerta.bmp', 'CONFIRMA') then
  begin

    FConexao.Connected := False;
    FConexao.Connected := True;

    FConexao.ExecSQL('Delete from clientes where id_cliente = :id_chave', [id_chave]);
  end;

end;

end.

