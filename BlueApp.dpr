program BlueApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form4},
  BlueBamboo.Interfaces in 'BlueBamboo\BlueBamboo.Interfaces.pas',
  BlueBamboo.BluetoothDevice in 'BlueBamboo\BlueBamboo.BluetoothDevice.pas',
  BlueBamboo.Classes in 'BlueBamboo\BlueBamboo.Classes.pas',
  BlueBamboo.Consts in 'BlueBamboo\BlueBamboo.Consts.pas',
  BlueBamboo.Types in 'BlueBamboo\BlueBamboo.Types.pas',
  BlueBamboo.Utils in 'BlueBamboo\BlueBamboo.Utils.pas',
  BlueBamboo.Helpers in 'BlueBamboo\BlueBamboo.Helpers.pas',
  BlueBamboo.ComPortDevice in 'BlueBamboo\BlueBamboo.ComPortDevice.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown:=True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
