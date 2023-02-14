unit unitConfigServidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  unitFuncoes, unitDM, classe.conexao;

type
  TformConfigServidor = class(TForm)
    shpFundo: TShape;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    btConfirmar: TSpeedButton;
    Panel7: TPanel;
    btCancelar: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Panel8: TPanel;
    Panel9: TPanel;
    editCaminhoBase: TEdit;
    editPorta: TEdit;
    editNomeBase: TEdit;
    editSenhaBase: TEdit;
    Label5: TLabel;
    editLoginBase: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    editCaminhoBaseAtual: TEdit;
    editNomeBaseAtual: TEdit;
    Label11: TLabel;
    editLoginBaseAtual: TEdit;
    Label12: TLabel;
    editPortaBaseAtual: TEdit;
    Label13: TLabel;
    editSenhaBaseAtual: TEdit;
    Label14: TLabel;
    procedure btConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formConfigServidor: TformConfigServidor;

implementation

{$R *.dfm}

procedure TformConfigServidor.btCancelarClick(Sender: TObject);
begin
 Close;
end;

procedure TformConfigServidor.btConfirmarClick(Sender: TObject);
begin



  if editCaminhoBase.Text = '' then
  begin
    funcCriarMensagem('CONEX�O AO BANCO DE DADOS',
                      'ERRO AO CONECTAR NO BANCO DE DADOS',
                      'Campos obrigat�rios n�o foram preenchidos',
                      ExtractFilePath(Application.ExeName) + '\icons\delete.png',
                      'OK');
  end
  else
  begin
    DM.Conexao.Servidor := editCaminhoBase.Text;
    DM.Conexao.Base     := editNomeBase.Text;
    DM.Conexao.Login    := editLoginBase.Text;
    DM.Conexao.Senha    := editSenhaBase.Text;
    DM.Conexao.Porta    := editPorta.Text;

    DM.Conexao.procGravarArquivoINI;

    if DM.Conexao.funcConectarBancoDados then
    begin


      funcCriarMensagem('CONEX�O AO BANCO DE DADOS',
                        'CONECTADO AO BANCO DE DADOS',
                        'Banco de dados conectado com sucesso!',
                        ExtractFilePath(Application.ExeName) + '\icons\bancoConectado.png',
                        'OK');
      Application.Terminate;

    end else
    begin
      funcCriarMensagem('CONEX�O AO BANCO DE DADOS',
                        'ERRO AO CONECTAR NO BANCO DE DADOS',
                        'N�o foi poss�vel conectar ao Banco de Dados, poss�vel causa: '+
                        DM.Conexao.MsgErro,
                        ExtractFilePath(Application.ExeName) + '\icons\delete.png',
                        'OK');
      editCaminhoBase.SetFocus;
    end;
  end;


end;

procedure TformConfigServidor.FormShow(Sender: TObject);
begin
  if DM.Conexao.funcLerArquivoINI then
  begin
    editCaminhoBaseAtual.Text := DM.Conexao.Servidor;;
    editNomeBaseAtual.Text    := DM.Conexao.Base;
    editLoginBaseAtual.Text   := DM.Conexao.Login;
    editSenhaBaseAtual.Text   := DM.Conexao.Senha;
    editPortaBaseAtual.Text   := DM.Conexao.Porta ;
  end;


end;

end.
