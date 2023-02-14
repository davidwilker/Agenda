unit unitAgendamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, classe.profissionais, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TformAgendamento = class(TForm)
    Panel1: TPanel;
    cbxProfissionais: TDBLookupComboBox;
    btProfissionais: TSpeedButton;
    Label2: TLabel;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    editData: TMaskEdit;
    editHora: TMaskEdit;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    editCliente: TEdit;
    editTelefone: TEdit;
    editCelular: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    editObservacoes: TEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    btConfirmar: TSpeedButton;
    Panel7: TPanel;
    btCancelar: TSpeedButton;
    dsProfissionais: TDataSource;
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btProfissionaisClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAgendamento: TformAgendamento;

implementation

{$R *.dfm}

uses unitPrincipal, unitProfissional, unitDM, unitClienteConsulta;

procedure TformAgendamento.btCancelarClick(Sender: TObject);
begin
  formPrincipal.pnlTampaBotoes.Enabled := True;
  Close;
end;

procedure TformAgendamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.Profissional.Destroy;
  Action := caFree;
end;

procedure TformAgendamento.FormCreate(Sender: TObject);
begin
  DM.Profissional := TProfissionais.Create( DM.FDConnection );
end;

procedure TformAgendamento.FormShow(Sender: TObject);
begin
  dsProfissionais.DataSet := DM.Profissional.fncConsulta('');
end;

procedure TformAgendamento.SpeedButton3Click(Sender: TObject);
begin
  try
    formClienteConsulta := TFormClienteConsulta.Create( Self );

    formClienteConsulta.ShowModal;
  finally
    formClienteConsulta.Destroy;
  end;
end;

procedure TformAgendamento.btProfissionaisClick(Sender: TObject);
begin

 try
  formProfissionais := TformProfissionais.Create( Self );
  formProfissionais.ShowModal;
 finally
  formProfissionais.Free;
 end;

end;

end.
