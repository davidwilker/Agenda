unit unitProfissional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, unitDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformProfissionais = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    editContato: TEdit;
    editEspecialidade: TEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    btConfirmar: TSpeedButton;
    Panel7: TPanel;
    btCancelar: TSpeedButton;
    Panel2: TPanel;
    lblEngeAgenda: TLabel;
    editNomeProfissional: TEdit;
    dbgProfissionais: TDBGrid;
    dsProfissionais: TDataSource;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure dbgProfissionaisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btConfirmarClick(Sender: TObject);
    procedure editContatoChange(Sender: TObject);
    procedure dbgProfissionaisDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formProfissionais: TformProfissionais;

implementation

{$R *.dfm}

uses unitFuncoes, uFormat;

procedure TformProfissionais.btCancelarClick(Sender: TObject);
begin
  Close;
end;


procedure TformProfissionais.btConfirmarClick(Sender: TObject);
var
  Operacao : String;
  Erro : String;
begin

  if editNomeProfissional.Text = '' then
  begin
    funcCriarMensagem('INSERINDO DADOS',
                      'ERRO AO CADASTRAR NOVO PROFISSIONAL',
                      'Campos obrigat�rios n�o foram preenchidos',
                      ExtractFilePath(Application.ExeName) + '\icons\delete.png',
                      'OK');
  end
  else
  begin

    if DM.Profissional.Id_Profissional > 0 then
      Operacao := 'ALTERAR'
    else
      Operacao := 'INSERIR';

    DM.Profissional.ds_profissional   := editNomeProfissional.Text;
    DM.Profissional.ds_especialidade  := editEspecialidade.Text;
    DM.Profissional.nr_contato        := SomenteNumero(editContato.Text);

    if DM.Profissional.fncInserirAlterar(Operacao, Erro) then
    begin

      funcCriarMensagem(Operacao +' DADOS',
                        'CADASTRAR NOVO PROFISSIONAL',
                        Operacao + ' Profissional com sucesso!',
                        ExtractFilePath(Application.ExeName) + '\icons\bancoConectado.png',
                        'OK');
      Close;

    end else
    begin
      funcCriarMensagem(Operacao+' DADOS',
                        'ERRO AO CADASTRAR NOVO PROFISSIONAL',
                        'N�o foi poss�vel '+Operacao+' profissional, poss�vel causa: '+
                        Erro,
                        ExtractFilePath(Application.ExeName) + '\icons\delete.png',
                        'OK');
      editNomeProfissional.SetFocus;
    end;
  end;

end;

procedure TformProfissionais.dbgProfissionaisDblClick(Sender: TObject);
begin
  if ( NOT (dbgProfissionais.DataSource.DataSet.IsEmpty ) ) then
  begin
    editNomeProfissional.Text  := dbgProfissionais.DataSource.DataSet.FieldByName('ds_profissional').AsString;
    editEspecialidade.Text     := dbgProfissionais.DataSource.DataSet.FieldByName('ds_especialidade').AsString;
    editContato.Text           := dbgProfissionais.DataSource.DataSet.FieldByName('nr_contato').AsString;

    DM.Profissional.Id_Profissional := dbgProfissionais.DataSource.DataSet.FieldByName('id_profissional').AsInteger;
  end;

end;

procedure TformProfissionais.dbgProfissionaisKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ( NOT (dbgProfissionais.DataSource.DataSet.IsEmpty ) ) AND (Key = VK_DELETE ) then
    DM.Profissional.prcDeleta( dbgProfissionais.DataSource.DataSet.FieldByName('id_profissional').AsInteger);
end;

procedure TformProfissionais.editContatoChange(Sender: TObject);
begin
  Formatar(editContato, TFormato.Celular);
end;

procedure TformProfissionais.FormShow(Sender: TObject);
begin
  dsProfissionais.DataSet := DM.Profissional.fncConsulta('');
end;

end.
