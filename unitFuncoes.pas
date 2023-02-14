unit unitFuncoes;

interface

uses
  Vcl.Forms, Winapi.Windows, System.SysUtils, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Graphics, Vcl.ComCtrls, System.Classes, unitDM,
  FireDAC.Comp.Client;

  function fncProximoCodigo( Tabela, Campo: String): Integer;
  function Criptografia( Senha, Chave: string): string;
  function funcCriarMensagem (TituloJanela, TituloMsg, Msg, Icone, Tipo : String ): boolean;

implementation

uses unitMensagens;

function fncProximoCodigo( Tabela, Campo: String): Integer;
var
        QryConsulta : TFDQuery;
begin
        Result := 1;

        try
                DM.FdConnection.Connected := False;
                DM.FdConnection.Connected := True;

                QryConsulta := TFDQuery.Create( nil );
                QryConsulta.Connection := DM.FdConnection;

                QryConsulta.Close;
                QryConsulta.SQL.Clear;
                QryConsulta.SQl.Add('Select max( '+Campo+' ) as codigo from ' + tabela);
                QryConsulta.Open;

                if QryConsulta.FieldByName('CODIGO').AsString <> '' then
                        Result := QryConsulta.FieldByName('CODIGO').AsInteger + 1;


        finally
                QryConsulta.Destroy;
        end;


end;

function Criptografia( Senha, Chave: String ): string;
var
  x, y : Integer;
  NovaSenha : String;
begin
  for x := 1 to Length( Chave )  do
  begin
    NovaSenha := '';

    for y := 1 to Length( Senha ) do
    begin

      NovaSenha := NovaSenha + chr ( ( Ord( Chave[X]) xor Ord( Senha[y] ) ) );
    
    end;

    Senha := NovaSenha;
      
  end;

  result := Senha;
end;

function funcCriarMensagem (TituloJanela, TituloMsg, Msg, Icone, Tipo : String ): boolean;
begin
  Result := false;

  formMensagens                 := TformMensagens.Create(nil);
  formMensagens.sTituloJanela   := TituloJanela;
  formMensagens.sTituloMsg      := TituloMsg;
  formMensagens.sMsg            := Msg;
  formMensagens.sCaminhoIcone   := Icone;
  formMensagens.sTipo           := Tipo;

  formMensagens.ShowModal;
  Result := formMensagens.bRespostaMSG;
end;

end.
