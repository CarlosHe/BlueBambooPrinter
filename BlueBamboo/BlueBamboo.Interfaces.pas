unit BlueBamboo.Interfaces;

interface

uses
  System.Generics.Collections, System.Bluetooth,
  FMX.Graphics, BlueBamboo.Types;

type

  IBlueBambooCommand = interface;
  IBlueBambooManager = interface;
  IBlueBambooSendData = interface;
  IBlueBambooDevice = interface;
  IBlueBambooBluetoothDevice = interface;

  IBlueBambooCommand = interface
    ['{BAD84071-EE3B-44CE-B1FA-0A4F4943D08B}']
    { PRINT COMMANDS }
    function Print(AText: string): IBlueBambooCommand;
    function FeedLine: IBlueBambooCommand;
    function FeedNLines(const ALines: TBlueBambooRange = 0): IBlueBambooCommand;
    function FeedPaper(ALines: TBlueBambooRange): IBlueBambooCommand;
    function PrintAndFeedLine(AText: string): IBlueBambooCommand;
    function PrintAndFeedPaper(AText: string; ALines: TBlueBambooRange): IBlueBambooCommand;
    function PrintAndFeedNLines(AText: string; ALines: TBlueBambooRange): IBlueBambooCommand;
    function PrintBarCode(AText: string; const AMode: TBlueBambooBarcodeMode = TBlueBambooBarcodeMode.EAN_13): IBlueBambooCommand;
    function PrintPDF417BarCode(AText: string; const ACol: TBlueBambooPDF417ColRange = 0; ARow: TBlueBambooPDF417RowRange = 0): IBlueBambooCommand;
    { LINE SPACE COMMANDS }
    function SelectDefaultLineSpace: IBlueBambooCommand;
    function SetLineSpace(const ASpace: TBlueBambooRange = 0): IBlueBambooCommand;
    { CHARACTER COMMANDS }
    function SelectACPOrUTF8Coding(const ACoding: TBlueBambooCoding = TBlueBambooCoding.UTF8): IBlueBambooCommand;
    function SelectAnInternationalCharacterSet(const ACharacterSet: TBlueBambooCharacterSet = TBlueBambooCharacterSet.UTF8): IBlueBambooCommand;
    function SelectPrintMode(AMode: TBlueBambooPrintMode): IBlueBambooCommand;
    function TurnUnderlineMode(const AMode: TBlueBambooUnderlineMode = TBlueBambooUnderlineMode.UnderlineOff): IBlueBambooCommand;
    function SelectCharacterSize(const AHeight: TCharacterHeightRange = 0; AWidth: TCharacterWidthRange = 0): IBlueBambooCommand;
    function TurnReversePrintingMode(const AMode: TBlueBambooReversePrintingMode = TBlueBambooReversePrintingMode.ReversePrintingOff): IBlueBambooCommand;
    { KEYPAD BUTTON COMMANDS }
    function TurnKeypadMode(AMode: TBlueBambooKeypadMode): IBlueBambooCommand;
    { PRINT POSITION COMMANDS }
    function SetAbsolutePrintPosition(nL, nH: TBlueBambooRange): IBlueBambooCommand;
    function SelectJustificationMode(AMode: TBlueBambooJustificationMode): IBlueBambooCommand;
    function HorizontalTab: IBlueBambooCommand;
    function SetHorizontalTabPositions(const ATabPositions: TArray<TBlueBambooHorizontalTabRange> = []): IBlueBambooCommand;
    function SetLeftMargin(nL, nH: TBlueBambooRange): IBlueBambooCommand;
    { BIT-IMAGE COMMANDS }
    function PrintBitImage(ABitmap: TBitmap; const AMode: TBlueBambooBitImageMode = TBlueBambooBitImageMode.Normal ): IBlueBambooCommand;
    { OTHERS }
    function Command(ACommand: TArray<Byte>): IBlueBambooCommand;
    function ToList: TList<TArray<Byte>>;
  end;

  IBlueBambooManager = interface
    ['{93EF82CD-E867-46D0-A717-07DE0F92BC3F}']
    procedure RunCommand(ADevice: IBlueBambooDevice; ACommand: IBlueBambooCommand);
  end;

  IBlueBambooSendData = interface
    ['{EA95A665-5956-4292-8F58-7739ED4EB372}']
    procedure SendData(AData: TArray<Byte>);
  end;

  IBlueBambooDevice = interface(IBlueBambooSendData)
    ['{5A36A8A3-3E64-4A6A-AFC3-C4BBD3D38C8C}']
  end;

  IBlueBambooBluetoothDevice = interface(IBlueBambooDevice)
    ['{7FA8EF23-4056-459D-900E-93B152E81F41}']
    function BluetoothEnabled: Boolean; overload;
    function BluetoothEnabled(AValue: Boolean): IBlueBambooBluetoothDevice; overload;
    function BluetoothDeviceList(out ABluetoothDeviceList: TList<TBluetoothDevice>): IBlueBambooBluetoothDevice; overload;
    function BluetoothDeviceList: TList<TBluetoothDevice>; overload;
    function BluetoothDeviceByName(ABluetoothDeviceName: string; out ABluetoothDevice: TBluetoothDevice): IBlueBambooBluetoothDevice;
    function DisconnectPrinter: IBlueBambooBluetoothDevice;
    function ConnectPrinter(ABluetoothDevice: TBluetoothDevice; out AIsConnected: Boolean): IBlueBambooBluetoothDevice; overload;
    function ConnectPrinter(ABluetoothDeviceName: string; out AIsConnected: Boolean): IBlueBambooBluetoothDevice; overload;
    function ConnectPrinter(ABluetoothDevice: TBluetoothDevice): IBlueBambooBluetoothDevice; overload;
    function ConnectPrinter(ABluetoothDeviceName: string): IBlueBambooBluetoothDevice; overload;
    function IsConnected: Boolean;
  end;

  IBlueBambooComPortDevice = interface(IBlueBambooDevice)
    ['{7FA8EF23-4056-459D-900E-93B152E81F41}']
    function ComPort(AComPort: string): IBlueBambooComPortDevice;
  end;

implementation

end.
