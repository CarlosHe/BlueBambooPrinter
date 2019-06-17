unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  System.Generics.Collections, System.Bluetooth.Components,
  BlueBamboo.Interfaces, BlueBamboo.BluetoothDevice, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Bluetooth, BlueBamboo.Classes, BlueBamboo.Types,
  FMX.Objects, BlueBamboo.ComPortDevice, FMX.Layouts;

type
  TForm4 = class(TForm)
    ComboBoxBluetoothDevices: TComboBox;
    ButtonDemo: TButton;
    Image1: TImage;
    ButtonImage: TButton;
    ButtonConnect: TButton;
    ButtonListDevices: TButton;
    ButtonCommand: TButton;
    VertScrollBox1: TVertScrollBox;
    ButtonIsConnected: TButton;
    procedure ButtonDemoClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ButtonImageClick(Sender: TObject);
    procedure ButtonConnectClick(Sender: TObject);
    procedure ComboBoxBluetoothDevicesChange(Sender: TObject);
    procedure ButtonListDevicesClick(Sender: TObject);
    procedure ButtonCommandClick(Sender: TObject);
    procedure ButtonIsConnectedClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  BlueBambooBluetoothDevice: IBlueBambooBluetoothDevice;
  BlueBambooComPortDevice: IBlueBambooComPortDevice;
  BlueBambooManager: IBlueBambooManager;

implementation

{$R *.fmx}

procedure TForm4.ButtonListDevicesClick(Sender: TObject);
var
  LBluetoothDeviceList: TList<TBluetoothDevice>;
  I: Integer;
begin
  ComboBoxBluetoothDevices.Clear;
  try
    LBluetoothDeviceList := BlueBambooBluetoothDevice.BluetoothDeviceList;
    for I := 0 to LBluetoothDeviceList.Count - 1 do
      ComboBoxBluetoothDevices.Items.Add(LBluetoothDeviceList[I].DeviceName);
  finally
  end;
end;

procedure TForm4.ButtonCommandClick(Sender: TObject);
var
  LCommand: IBlueBambooCommand;
begin
  LCommand := TBlueBambooCommand.Create;
  try

    LCommand

      .SelectPrintMode(TBlueBambooPrintMode._24DotFont)

      .Command([$1D, $76, $30, 51, Lo(24), Hi(24), Lo(24), Hi(24),

      $1F, $00, $F8, $00, $1F, $00, $F8, $00, $1F, $00, $F8, $00, $1F, $00, $F8, $00, $1F, $00, $F8, $00, $1F, $00, $F8, $00, $7F, $81, $FE, $00, $7F, $81, $FE, $00, $7F, $81, $FE,
      $00, $7F, $81, $FE, $00, $7F, $81, $FE, $00, $7F, $81, $FE, $00, $7F, $C3, $FE, $00, $7F, $C3, $FE, $00, $7F, $C3, $FE, $00, $7F, $C3, $FE, $00, $7F, $C3, $FE, $00, $7F, $C3,
      $FE, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF,
      $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $E7, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00,
      $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF,
      $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF,
      $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF,
      $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $00,
      $FF, $FF, $FF, $00, $FF, $FF, $FF, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE,
      $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $7F, $FF, $FE, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF,
      $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $3F, $FF, $FC, $00, $1F,
      $FF, $F8, $00, $1F, $FF, $F8, $00, $1F, $FF, $F8, $00, $1F, $FF, $F8, $00, $1F, $FF, $F8, $00, $1F, $FF, $F8, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00,
      $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0, $00, $0F, $FF, $F0,
      $00, $07, $FF, $E0, $00, $07, $FF, $E0, $00, $07, $FF, $E0, $00, $07, $FF, $E0, $00, $07, $FF, $E0, $00, $07, $FF, $E0, $00, $03, $FF, $C0, $00, $03, $FF, $C0, $00, $03, $FF,
      $C0, $00, $03, $FF, $C0, $00, $03, $FF, $C0, $00, $03, $FF, $C0, $00, $01, $FF, $80, $00, $01, $FF, $80, $00, $01, $FF, $80, $00, $01, $FF, $80, $00, $01, $FF, $80, $00, $01,
      $FF, $80, $00, $00, $7E, $00, $00, $00, $7E, $00, $00, $00, $7E, $00, $00, $00, $7E, $00, $00, $00, $7E, $00, $00, $00, $7E, $00, $00, $00, $3C, $00, $00, $00, $3C, $00, $00,
      $00, $3C, $00, $00, $00, $3C, $00, $00, $00, $3C, $00, $00, $00, $3C, $00, $00

      ]);

    LCommand.Command([$0D]);

    // BlueBambooManager.RunCommand(BlueBambooComPortDevice, LCommand);
    BlueBambooManager.RunCommand(BlueBambooBluetoothDevice, LCommand);
  finally

  end;
end;

procedure TForm4.ButtonConnectClick(Sender: TObject);
var
  LBluetoothIsConnected: Boolean;
begin
  if not ComboBoxBluetoothDevices.Selected.Text.IsEmpty then
  begin
    BlueBambooBluetoothDevice.ConnectPrinter(ComboBoxBluetoothDevices.Selected.Text, LBluetoothIsConnected);
    ButtonDemo.Enabled := LBluetoothIsConnected;
    ButtonImage.Enabled := LBluetoothIsConnected;
    ButtonCommand.Enabled := LBluetoothIsConnected;
  end;
end;

procedure TForm4.ButtonDemoClick(Sender: TObject);
var
  LCommand: IBlueBambooCommand;
begin

  LCommand := TBlueBambooCommand.Create;

  try

    LCommand.SelectACPOrUTF8Coding(TBlueBambooCoding.UTF8).SelectPrintMode(TBlueBambooPrintMode._32DotFont)

    { ***********************************
      TABULAÇÃO
      *********************************** }
      .SetHorizontalTabPositions([6, 14, 20]).TurnReversePrintingMode(TBlueBambooReversePrintingMode.ReversePrintingOn).Print('NOME  ').HorizontalTab.Print('TIPO    ')
      .HorizontalTab.Print('VALOR     ').FeedLine.TurnReversePrintingMode(TBlueBambooReversePrintingMode.ReversePrintingOff)

      .Print('BLUE').HorizontalTab.Print('PRINTER').HorizontalTab.Print('12,00').FeedLine.Print('PRIN').HorizontalTab.Print('PRINTER').HorizontalTab.Print('50,00')
      .FeedLine.Print('TESTE').HorizontalTab.Print('PRINTER').HorizontalTab.Print('60,00').FeedLine.PrintAndFeedLine('------------------------')
    { ***********************************
      SUBLINHADO
      *********************************** }
      .TurnUnderlineMode(TBlueBambooUnderlineMode.UnderlineOn2DotsThick).PrintAndFeedLine(' SUBLINHADO ').TurnUnderlineMode(TBlueBambooUnderlineMode.UnderlineOff)
      .PrintAndFeedLine('------------------------')

    { ***********************************
      MODO 32 COLUNAS
      *********************************** }
      .SelectPrintMode(TBlueBambooPrintMode._24DotFont).PrintAndFeedLine('IMPRESSÃO EM 32 COLUNAS').PrintAndFeedLine('--------------------------------')

    { ***********************************
      MODO 24 COLUNAS
      *********************************** }
      .SelectPrintMode(TBlueBambooPrintMode._32DotFont).PrintAndFeedLine('IMPRESSÃO EM 24 COLUNAS').PrintAndFeedLine('------------------------')

    { ***********************************
      CÓDIGO DE BARRAS
      *********************************** }
      .PrintAndFeedLine('BAR CODE EAN 13').PrintBarCode('6901234567891', TBlueBambooBarcodeMode.EAN_13).PrintAndFeedLine('------------------------')
      .PrintAndFeedLine(' * BAR CODE EAN 8').PrintBarCode('69012345', TBlueBambooBarcodeMode.EAN_8).PrintAndFeedLine('------------------------')
      .PrintAndFeedLine(' * BAR CODE UPC A').PrintBarCode('690123456789', TBlueBambooBarcodeMode.UPC_A).PrintAndFeedLine('------------------------')
      .PrintAndFeedLine(' * BAR CODE UPC E').PrintBarCode('1234578', TBlueBambooBarcodeMode.UPC_E).FeedLine;

    BlueBambooManager.RunCommand(BlueBambooBluetoothDevice, LCommand);
    // BlueBambooManager.RunCommand(BlueBambooComPortDevice, LCommand);

  finally

  end;

end;

procedure TForm4.ButtonImageClick(Sender: TObject);
var
  LCommand: IBlueBambooCommand;
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  LCommand := TBlueBambooCommand.Create;
  try
    LBitmap.Assign(Image1.Bitmap);
    LCommand.PrintBitImage(LBitmap, TBlueBambooBitImageMode.Normal);

    BlueBambooManager.RunCommand(BlueBambooBluetoothDevice, LCommand);
    // BlueBambooManager.RunCommand(BlueBambooComPortDevice, LCommand);
  finally
    LBitmap.Free
  end;
end;

procedure TForm4.ButtonIsConnectedClick(Sender: TObject);
begin
  if BlueBambooBluetoothDevice.IsConnected then
    ShowMessage('Conectado')
  else
    ShowMessage('Desconectado');
end;

procedure TForm4.ComboBoxBluetoothDevicesChange(Sender: TObject);
begin
  ButtonConnect.Enabled := ComboBoxBluetoothDevices.ItemIndex >= 0;
end;

procedure TForm4.Image1Click(Sender: TObject);
var
  LOpenFile: TOpenDialog;
begin
  LOpenFile := TOpenDialog.Create(nil);
  try
    if LOpenFile.Execute then
      Image1.Bitmap.LoadFromFile(LOpenFile.FileName);
  finally
    LOpenFile.Free;
  end;
end;

initialization

BlueBambooManager := TBlueBambooManager.Create;
BlueBambooComPortDevice := TBlueBambooComPortDevice.Create('COM4');
BlueBambooBluetoothDevice := TBlueBambooBluetoothDevice.Create(True);

end.
