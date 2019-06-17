unit BlueBamboo.ComPortDevice;

interface

uses System.SysUtils, BlueBamboo.Interfaces, BlueBamboo.Classes, BlueBamboo.Consts;

type

  TBlueBambooComPortDevice = class(TBlueBambooDevice, IBlueBambooComPortDevice)
  private
    { private declarations }
    FComPort: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const AComPort: string = ''); virtual;
    destructor Destroy; override;
    procedure SendData(AData: TArray<Byte>); override;
    function ComPort(AComPort: string): IBlueBambooComPortDevice;
  published
    { published declarations }
  end;

implementation

{ TBlueBambooBluetoothDevice }

function TBlueBambooComPortDevice.ComPort(AComPort: string): IBlueBambooComPortDevice;
begin
  Result := Self;
  FComPort := AComPort;
end;

constructor TBlueBambooComPortDevice.Create(const AComPort: string);
begin
  FComPort := AComPort;
end;

destructor TBlueBambooComPortDevice.Destroy;
begin

  inherited;
end;

procedure TBlueBambooComPortDevice.SendData(AData: TArray<Byte>);
var
  LPrinter: System.Text;
begin
  inherited;
  try
    AssignFile(LPrinter, FComPort);
    Rewrite(LPrinter);
    Write(LPrinter, TEncoding.ANSI.GetString(AData));
  finally
    CloseFile(LPrinter);
  end;
end;

end.
