unit unitClienteCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Response.Adapter, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, unitClienteConsulta;

type
  TformClienteCadastro = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    lblEngeAgenda: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    brConfirmar: TSpeedButton;
    Panel7: TPanel;
    btCancelar: TSpeedButton;
    Panel2: TPanel;
    editNomeCliente: TEdit;
    Label1: TLabel;
    editCpfCliente: TEdit;
    Label3: TLabel;
    editRg: TEdit;
    Label4: TLabel;
    editNascimentoCliente: TEdit;
    editCepCliente: TEdit;
    Label5: TLabel;
    pnlBuscaCep: TPanel;
    btBuscaCep: TSpeedButton;
    editEnderecoCliente: TEdit;
    Label6: TLabel;
    editComplementoCliente: TEdit;
    Label7: TLabel;
    editNumeroCliente: TEdit;
    Label8: TLabel;
    editBairroCliente: TEdit;
    Label9: TLabel;
    editCidadeCliente: TEdit;
    Label10: TLabel;
    editUfcliente: TEdit;
    Label11: TLabel;
    editCelularCliente: TEdit;
    Label12: TLabel;
    editTelefoneCliente: TEdit;
    Label13: TLabel;
    editObservacoesCliente: TEdit;
    Label14: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    MemTable: TFDMemTable;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    procedure btCancelarClick(Sender: TObject);
    procedure editCpfClienteExit(Sender: TObject);
    procedure editNascimentoClienteExit(Sender: TObject);
    procedure editCpfClienteChange(Sender: TObject);
    procedure editNascimentoClienteChange(Sender: TObject);
    procedure editCepClienteChange(Sender: TObject);
    procedure editCelularClienteChange(Sender: TObject);
    procedure editTelefoneClienteChange(Sender: TObject);
    procedure ConsultaCEP;
    procedure btBuscaCepClick(Sender: TObject);
    procedure brConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formClienteCadastro: TformClienteCadastro;

implementation

{$R *.dfm}

uses unitFuncoes, uFormat;

procedure TformClienteCadastro.brConfirmarClick(Sender: TObject);
var
  sTipoOperacao: String;
  sErro: String;
begin

  sErro := '';

  with formClienteConsulta.Cliente do
  begin

    DS_NOME         := editNomeCliente.Text;
    DT_NASCIMENTO   := StrToDate(editNascimentoCliente.Text);
    NR_CPF          := SomenteNumero(editCpfCliente.Text);
    NR_RG           := editRg.Text;
    NR_CEP          := SomenteNumero(editCepCliente.Text);
    DS_ENDERECO     := editEnderecoCliente.Text;
    NR_NUMERO       := editNumeroCliente.Text;
    DS_COMPLEMENTO  := editComplementoCliente.Text;
    DS_BAIRRO       := editBairroCliente.Text;
    DS_CIDADE       := editCidadeCliente.Text;
    DS_UF           := editUfcliente.Text;
    NR_TELEFONE     := SomenteNumero(editCelularCliente.Text);
    NR_TELEFONE2    := SomenteNumero(editTelefoneCliente.Text);
    DS_OBS          := editObservacoesCliente.Text;
  end;



  if formClienteConsulta.Cliente.ID_CLIENTE > 0 then
    sTipoOperacao := 'ALTERAR'
  else
    sTipoOperacao := 'INSERIR';

  if formClienteConsulta.Cliente.fncInserirAlterar(sTipoOperacao, sErro) then
  begin
    funcCriarMensagem(sTipoOperacao +' DADOS',
                      'CADASTRO NOVO CLIENTE',
                      sTipoOperacao + ' Cliente com sucesso!',
                      ExtractFilePath(Application.ExeName) + '\icons\bancoConectado.png',
                      'OK');
    Close;

  end else
  begin
      funcCriarMensagem(sTipoOperacao+' DADOS',
                        'ERRO AO CADASTRAR NOVO CLIENTE',
                        'N�o foi poss�vel '+sTipoOperacao+' Cliente, poss�vel causa: '+
                        sErro,
                        ExtractFilePath(Application.ExeName) + '\icons\delete.png',
                        'OK');
      editNomeCliente.SetFocus;
  end;

end;

procedure TformClienteCadastro.btBuscaCepClick(Sender: TObject);
begin
  ConsultaCEP;
end;

procedure TformClienteCadastro.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TformClienteCadastro.ConsultaCEP;
begin
  if SomenteNumero(editCepCliente.Text).Length <> 8 then
    begin
      funcCriarMensagem('VALIDA��O CAMPOS',
                        'ERRO AO VALIDAR CAMPO CEP',
                        'Valor campo CEP inv�lido!',
                        ExtractFilePath(Application.ExeName) + '\icons\alerta.bmp',
                        'OK');
      editCpfCliente.SetFocus;
      exit;
    end;

    RESTRequest1.Resource := SomenteNumero(editCepCliente.Text) + '/json';
    RESTRequest1.Execute;

    if RestRequest1.Response.StatusCode = 200 then
      begin
        if RestRequest1.Response.Content.IndexOf('erro') > 0 then
          begin
            funcCriarMensagem('VALIDA��O CAMPOS',
                              'ERRO AO VALIDAR CAMPO CEP',
                              'Valor campo CEP inv�lido!',
                              ExtractFilePath(Application.ExeName) + '\icons\alerta.bmp',
                              'OK');
            editCepCliente.SetFocus;
          end
        else
          begin
             with MemTable do
             begin

               editEnderecoCliente.Text := FieldByName('logradouro').AsString;
               editBairroCliente.Text   := FieldByName('bairro').AsString;
               editCidadeCliente.Text   := FieldByName('localidade').AsString;
               editUfcliente.Text       := FieldByName('uf').AsString;

             end;
          end;

      end
      else
        ShowMessage('Erro ao consultar CEP');
end;

procedure TformClienteCadastro.editCelularClienteChange(Sender: TObject);
begin
  Formatar(editCelularCliente, TFormato.Celular);
end;

procedure TformClienteCadastro.editCepClienteChange(Sender: TObject);
begin
  Formatar(editCepCliente, TFormato.CEP);
end;

procedure TformClienteCadastro.editCpfClienteChange(Sender: TObject);
begin
  Formatar(editCpfCliente, TFormato.CPF);
end;

procedure TformClienteCadastro.editCpfClienteExit(Sender: TObject);
begin

  if ( editCpfCliente.Text = '') then
  begin
    funcCriarMensagem('VALIDA��O CAMPOS',
                      'ERRO AO VALIDAR CAMPO CPF',
                      'Campo CPF n�o preenchido!',
                      ExtractFilePath(Application.ExeName) + '\icons\alerta.bmp',
                      'OK');
    editCpfCliente.SetFocus;
  end;


end;

procedure TformClienteCadastro.editNascimentoClienteChange(Sender: TObject);
begin
  Formatar(editNascimentoCliente, TFormato.Dt);
end;

procedure TformClienteCadastro.editNascimentoClienteExit(Sender: TObject);
begin

  if editNascimentoCliente.Text = '' then
  begin

    funcCriarMensagem('VALIDA��O CAMPOS',
                      'ERRO AO VALIDAR CAMPO DATA NASCIMENTO',
                      'Campo Data Nascimento n�o preenchido!',
                      ExtractFilePath(Application.ExeName) + '\icons\alerta.bmp',
                      'OK');
    editNascimentoCliente.SetFocus;
  end;

end;

procedure TformClienteCadastro.editTelefoneClienteChange(Sender: TObject);
begin
  Formatar(editTelefoneCliente, TFormato.TelefoneFixo);
end;

end.
