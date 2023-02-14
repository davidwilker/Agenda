program Agenda;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {formPrincipal},
  unitDM in 'unitDM.pas' {DM: TDataModule},
  unitLogin in 'unitLogin.pas' {formLogin},
  unitConfigServidor in 'unitConfigServidor.pas' {formConfigServidor},
  unitMensagens in 'unitMensagens.pas' {formMensagens},
  unitFuncoes in 'unitFuncoes.pas',
  classe.conexao in 'classe.conexao.pas',
  System.SysUtils,
  unitAgendamento in 'unitAgendamento.pas' {formAgendamento},
  unitProfissional in 'unitProfissional.pas' {formProfissionais},
  classe.profissionais in 'classe.profissionais.pas',
  uFormat in 'uFormat.pas',
  unitClienteConsulta in 'unitClienteConsulta.pas' {formClienteConsulta},
  unitClienteCadastro in 'unitClienteCadastro.pas' {formClienteCadastro},
  classe.clientes in 'classe.clientes.pas',
  classe.agendamento in 'classe.agendamento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TDM, DM);
  if DM.Conexao.funcConectarBancoDados then
  begin

    formLogin := TformLogin.Create(nil);
    formLogin.ShowModal;

    Application.CreateForm(TformPrincipal, formPrincipal);

    formLogin.Hide;
    formLogin.Free;

    Application.Run;
  end else
  begin
    funcCriarMensagem('CONEX�O AO BANCO DE DADOS',
                      'ERRO AO CONECTAR NO BANCO DE DADOS',
                      'N�o foi poss�vel conectar ao Banco de Dados, poss�vel causa: '+
                      DM.Conexao.MsgErro,
                      ExtractFilePath(Application.ExeName) + '\icons\delete.png',
                      'OK');
    Application.CreateForm(TformConfigServidor, formConfigServidor);
    formConfigServidor.ShowModal;
  end;
end.
