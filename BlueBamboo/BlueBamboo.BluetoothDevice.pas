unit BlueBamboo.BluetoothDevice;

interface

uses BlueBamboo.Interfaces,
  System.Bluetooth, System.Bluetooth.Components, System.Generics.Collections,
  BlueBamboo.Classes, BlueBamboo.Consts;

type

  TBlueBambooBluetoothDevice = class(TBlueBambooDevice, IBlueBambooBluetoothDevice)
  private
    { private declarations }
    FBluetooth: TBluetooth;
    FSocket: TBluetoothSocket;
    FBluetoothDeviceList: TList<TBluetoothDevice>;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const ABluetoothEnabled: Boolean = False); virtual;
    destructor Destroy; override;

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
    procedure SendData(AData: TArray<Byte>); override;

  published
    { published declarations }
  end;

implementation

uses
  System.SysUtils;

{ TDPP250BluetoothDevice }

function TBlueBambooBluetoothDevice.BluetoothEnabled: Boolean;
begin
  Result := FBluetooth.Enabled;
end;

function TBlueBambooBluetoothDevice.BluetoothDeviceList(out ABluetoothDeviceList: TList<TBluetoothDevice>): IBlueBambooBluetoothDevice;
begin
  Result := Self;
end;

function TBlueBambooBluetoothDevice.BluetoothEnabled(AValue: Boolean): IBlueBambooBluetoothDevice;
begin
  FBluetooth.Enabled := AValue;
end;

function TBlueBambooBluetoothDevice.ConnectPrinter(ABluetoothDevice: TBluetoothDevice; out AIsConnected: Boolean): IBlueBambooBluetoothDevice;
begin
  Result := Self;
  AIsConnected := False;
  if ABluetoothDevice <> nil then
  begin
    FSocket := ABluetoothDevice.CreateClientSocket(StringToGUID(BLUEBAMBOO_BLUETOOTH_UUID), False);
    if FSocket <> nil then
    begin
      FSocket.Connect;
      AIsConnected := FSocket.Connected;
    end;
  end;
end;

function TBlueBambooBluetoothDevice.ConnectPrinter(ABluetoothDeviceName: string; out AIsConnected: Boolean): IBlueBambooBluetoothDevice;
var
  LBluetoothDevice: TBluetoothDevice;
begin
  Result := Self;
  BluetoothDeviceByName(ABluetoothDeviceName, LBluetoothDevice);
  ConnectPrinter(LBluetoothDevice, AIsConnected);
end;

function TBlueBambooBluetoothDevice.ConnectPrinter(ABluetoothDeviceName: string): IBlueBambooBluetoothDevice;
var
  LBluetoothDevice: TBluetoothDevice;
  LIsConnected: Boolean;
begin
  Result := Self;
  BluetoothDeviceByName(ABluetoothDeviceName, LBluetoothDevice);
  ConnectPrinter(LBluetoothDevice, LIsConnected);
end;

function TBlueBambooBluetoothDevice.ConnectPrinter(ABluetoothDevice: TBluetoothDevice): IBlueBambooBluetoothDevice;
var
  LIsConnected: Boolean;
begin
  Result := Self;
  ConnectPrinter(ABluetoothDevice, LIsConnected);
end;

constructor TBlueBambooBluetoothDevice.Create(const ABluetoothEnabled: Boolean);
begin
  FBluetooth := TBluetooth.Create(nil);
  FBluetooth.Enabled := ABluetoothEnabled;
  FBluetoothDeviceList := TList<TBluetoothDevice>.Create;
end;

destructor TBlueBambooBluetoothDevice.Destroy;
begin
  FBluetoothDeviceList.Free;
  DisconnectPrinter;
  FBluetooth.Free;
  inherited;
end;

function TBlueBambooBluetoothDevice.DisconnectPrinter: IBlueBambooBluetoothDevice;
begin
  Result := Self;
  if FSocket <> nil then
  begin
    FSocket.Close;
    FSocket.Free;
  end;
end;

function TBlueBambooBluetoothDevice.IsConnected: Boolean;
begin
  Result := Assigned(FSocket) and FSocket.Connected;
end;

function TBlueBambooBluetoothDevice.BluetoothDeviceByName(ABluetoothDeviceName: string; out ABluetoothDevice: TBluetoothDevice): IBlueBambooBluetoothDevice;
var
  LBluetoothDevice: TBluetoothDevice;
begin
  Result := Self;
  ABluetoothDevice := nil;
  for LBluetoothDevice in FBluetooth.PairedDevices do
    if LBluetoothDevice.DeviceName = ABluetoothDeviceName then
      ABluetoothDevice := LBluetoothDevice;
end;

function TBlueBambooBluetoothDevice.BluetoothDeviceList: TList<TBluetoothDevice>;
var
  LBluetoothDevice: TBluetoothDevice;
  LBluetoothService: TBluetoothService;
begin
  FBluetoothDeviceList.Clear;
  for LBluetoothDevice in FBluetooth.PairedDevices do
    // for LBluetoothService in LBluetoothDevice.LastServiceList do
    // begin
    // if LBluetoothService.UUID.ToString.ToUpper = BLUEBAMBOO_BLUETOOTH_UUID.ToUpper then
    // begin
    FBluetoothDeviceList.Add(LBluetoothDevice);
  // Break;
  // end;
  // end;
  Result := FBluetoothDeviceList;
end;

procedure TBlueBambooBluetoothDevice.SendData(AData: TArray<Byte>);
begin
  inherited;
  if FSocket.Connected then
    FSocket.SendData(AData);
end;

end.
