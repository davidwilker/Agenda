object formProfissionais: TformProfissionais
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formProfissionais'
  ClientHeight = 607
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 607
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      481
      607)
    object Label2: TLabel
      Left = 26
      Top = 91
      Width = 153
      Height = 20
      Caption = 'Nome do Profissional *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12615680
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 256
      Top = 151
      Width = 63
      Height = 20
      Caption = 'Contato *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12615680
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 26
      Top = 151
      Width = 102
      Height = 20
      Caption = 'Especialidade *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12615680
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblEngeAgenda: TLabel
      Left = 21
      Top = 36
      Width = 231
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Caption = 'CADASTRO DE PROFISSIONAIS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12615680
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 21
      Top = 526
      Width = 304
      Height = 13
      Caption = 'Precione DELETE para Excluir ou Duplo Clique Para Alterar *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12615680
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object editContato: TEdit
      Tag = 5
      Left = 256
      Top = 177
      Width = 198
      Height = 28
      Hint = 'Contato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = editContatoChange
    end
    object editEspecialidade: TEdit
      Tag = 5
      Left = 26
      Top = 177
      Width = 215
      Height = 28
      Hint = 'Especialidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Panel5: TPanel
      Left = 98
      Top = 552
      Width = 297
      Height = 41
      BevelOuter = bvNone
      TabOrder = 3
      object Panel6: TPanel
        Left = -38
        Top = 0
        Width = 183
        Height = 41
        BevelOuter = bvNone
        Color = 5778209
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInactiveBorder
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btConfirmar: TSpeedButton
          Tag = 5
          Left = 41
          Top = -2
          Width = 151
          Height = 44
          Cursor = crHandPoint
          Caption = 'Confirmar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btConfirmarClick
        end
      end
      object Panel7: TPanel
        Left = 160
        Top = 0
        Width = 137
        Height = 41
        BevelOuter = bvNone
        Color = 6711039
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInactiveBorder
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object btCancelar: TSpeedButton
          Left = 0
          Top = -1
          Width = 145
          Height = 43
          Cursor = crHandPoint
          Caption = 'Cancelar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btCancelarClick
        end
      end
    end
    object Panel2: TPanel
      Left = 16
      Top = 71
      Width = 450
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object editNomeProfissional: TEdit
      Tag = 5
      Left = 26
      Top = 117
      Width = 428
      Height = 28
      Hint = 'Nome Profissional'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dbgProfissionais: TDBGrid
      Left = 16
      Top = 223
      Width = 450
      Height = 297
      DataSource = dsProfissionais
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbgProfissionaisDblClick
      OnKeyDown = dbgProfissionaisKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'id_profissional'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ds_profissional'
          ReadOnly = True
          Width = 193
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ds_especialidade'
          ReadOnly = True
          Width = 184
          Visible = True
        end>
    end
  end
  object dsProfissionais: TDataSource
    Left = 216
    Top = 336
  end
end
