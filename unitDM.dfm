object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 448
  Width = 709
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=E:\DB\AGENDAMENTO\DADOS.FDB'
      'Server=127.0.0.1'
      'Port=3064'
      'DriverID=FB')
    LoginPrompt = False
    Left = 80
    Top = 80
  end
  object FBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 184
    Top = 80
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 280
    Top = 80
  end
end
