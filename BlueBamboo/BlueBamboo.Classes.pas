unit BlueBamboo.Classes;

interface

uses
  System.SysUtils,
  BlueBamboo.Interfaces, System.Generics.Collections, BlueBamboo.Types,
  BlueBamboo.Consts, BlueBamboo.Helpers, FMX.Graphics, System.Math,
  System.Classes;

type
  TBlueBambooDevice = class(TInterfacedObject, IBlueBambooDevice)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    procedure SendData(AData: TArray<Byte>); virtual; abstract;
  published
    { published declarations }
  end;

  TBlueBambooManager = class(TInterfacedObject, IBlueBambooManager)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    procedure RunCommand(ADevice: IBlueBambooDevice; ACommand: IBlueBambooCommand);
  published
    { published declarations }
  end;

  TBlueBambooCommand = class(TInterfacedObject, IBlueBambooCommand)
  private
    { private declarations }
    FCommandList: TList<TArray<Byte>>;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; virtual;
    destructor Destroy; override;
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
    function PrintBitImage(ABitmap: TBitmap; const AMode: TBlueBambooBitImageMode = TBlueBambooBitImageMode.Normal): IBlueBambooCommand;
    { OTHERS }
    function Command(ACommand: TArray<Byte>): IBlueBambooCommand;
    function ToList: TList<TArray<Byte>>;
  published
    { published declarations }
  end;

implementation

uses
  BlueBamboo.Utils;

{ TBlueBambooCommand }

function TBlueBambooCommand.Command(ACommand: TArray<Byte>): IBlueBambooCommand;
begin
  Result := Self;
  FCommandList.Add(ACommand);
end;

constructor TBlueBambooCommand.Create;
begin
  FCommandList := TList < TArray < Byte >>.Create;
end;

destructor TBlueBambooCommand.Destroy;
begin
  FCommandList.Free;
  inherited;
end;

function TBlueBambooCommand.FeedLine: IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_FEED_LINE);
end;

function TBlueBambooCommand.FeedNLines(const ALines: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_FEED_N_LINES + [Byte(ALines)] + BLUEBAMBOO_FEED_LINE)
end;

function TBlueBambooCommand.FeedPaper(ALines: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_FEED_PAPER + [Byte(ALines)] + BLUEBAMBOO_FEED_LINE);
end;

function TBlueBambooCommand.HorizontalTab: IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_HORIZONTAL_TAB);
end;

function TBlueBambooCommand.Print(AText: string): IBlueBambooCommand;
begin
  Result := Command(TBlueBambooUtils.StringToArrayOfByte(AText));
end;

function TBlueBambooCommand.PrintAndFeedLine(AText: string): IBlueBambooCommand;
begin
  Result := Print(AText).FeedLine;
end;

function TBlueBambooCommand.PrintAndFeedNLines(AText: string; ALines: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Print(AText).FeedNLines(ALines);
end;

function TBlueBambooCommand.PrintAndFeedPaper(AText: string; ALines: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Print(AText).FeedPaper(ALines);
end;

function TBlueBambooCommand.PrintBarCode(AText: string; const AMode: TBlueBambooBarcodeMode): IBlueBambooCommand;
var
  LBarCode: string;
begin
  Result := Self;

  if AMode <> TBlueBambooBarcodeMode.CODE_128 then
    LBarCode := Copy(AText.PadLeft(AMode.ToMaxSize, '0'), 1, AMode.ToMaxSize)
  else
    LBarCode := AText;

  Result := Command(BLUEBAMBOO_BAR_CODE + [AMode.ToByte, AMode.ToMaxSizeAsByte] + TBlueBambooUtils.StringToArrayOfByte(LBarCode))
end;

function TBlueBambooCommand.PrintBitImage(ABitmap: TBitmap; const AMode: TBlueBambooBitImageMode = TBlueBambooBitImageMode.Normal): IBlueBambooCommand;
var
  LBitmap: TBitmap;
  LBits: TBits;
  LBitmapData: TBitmapData;
  LBitImageArray: TArray<Byte>;
  X, Y, W: Integer;
begin
  Result := Self;
  LBitmap := TBitmap.Create;
  LBits := TBits.Create;
  try
    LBitmap.Assign(ABitmap);
    LBits.Size := 8;

    TBlueBambooUtils.MakeGreyScaleBitmap(LBitmap);
    LBitmap.Map(TMapAccess.Read, LBitmapData);

    TBlueBambooUtils.InitArrayOfByte(LBitImageArray, Trunc(Ceil(LBitmap.Width / 8) * LBitmap.Height), $FF);
    Y := 0;
    W := 0;

    while Y <= LBitmapData.Height-1 do
    begin
      X := 0;
      while X <= Ceil(LBitmapData.Width / 8) * 8 - 1 do
      begin
        if (X <= LBitmapData.Width - 1) then
            LBits[X - (X div 8) * 8] := TBlueBambooUtils.CanColorize(X,Y, LBitmapData.GetPixel(X, Y))
        else
          LBits[X - (X div 8) * 8] := False;

        Inc(X);

        if X - (X div 8) * 8 = 0 then
        begin
          LBitImageArray[W] := TBlueBambooUtils.BitsToDec(LBits);
          Inc(W)
        end;
      end;
      Inc(Y);
    end;
    ABitmap.Unmap(LBitmapData);

    Command(BLUEBAMBOO_PRINT_BIT_IMAGE + AMode.ToArrayOfByte + [Lo(Ceil(LBitmap.Width / 8)), Hi(Ceil(LBitmap.Width / 8)), Lo(LBitmap.Height), Hi(LBitmap.Height)]+LBitImageArray);

  finally
    LBits.Free;
    LBitmap.Free;
  end;
end;

function TBlueBambooCommand.PrintPDF417BarCode(AText: string; const ACol: TBlueBambooPDF417ColRange; ARow: TBlueBambooPDF417RowRange): IBlueBambooCommand;
var
  LColByteLo, LColByteHi: Byte;
  LRowByteLo, LRowByteHi: Byte;
  LLenByteLo, LLenByteHi: Byte;
  LFormat: TArray<Byte>;
begin

  Result := Self;

  LColByteLo := Lo(ACol);
  LColByteHi := Hi(ACol);

  LRowByteLo := Lo(ARow);
  LRowByteHi := Hi(ARow);

  LLenByteLo := Lo(Length(AText));
  LLenByteHi := Hi(Length(AText));

  LFormat := BLUEBAMBOO_PDF417_BAR_CODE_3;

  if ACol > 3 then
    LFormat := BLUEBAMBOO_PDF417_BAR_CODE_7;

  Result := Command(LFormat + [LColByteHi, LColByteLo, LRowByteHi, LRowByteLo, LLenByteHi, LLenByteLo] + TBlueBambooUtils.StringToArrayOfByte(AText));
end;

function TBlueBambooCommand.SelectACPOrUTF8Coding(const ACoding: TBlueBambooCoding = TBlueBambooCoding.UTF8): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SELECT_ACP_OR_UTF8_CODING + ACoding.ToArrayOfByte);
end;

function TBlueBambooCommand.SelectAnInternationalCharacterSet(const ACharacterSet: TBlueBambooCharacterSet = TBlueBambooCharacterSet.UTF8): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SELECT_AN_INTERNATIONAL_CHARACTER_SET + ACharacterSet.ToArrayOfByte);
end;

function TBlueBambooCommand.SelectCharacterSize(const AHeight: TCharacterHeightRange; AWidth: TCharacterWidthRange): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SELECT_CHARACTER_SIZE + [AWidth * 16 + AHeight]);
end;

function TBlueBambooCommand.SelectDefaultLineSpace: IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_DEFAULT_LINE_SPACE);
end;

function TBlueBambooCommand.SelectJustificationMode(AMode: TBlueBambooJustificationMode): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SELECT_JUSTIFICATION_MODE + AMode.ToArrayOfByte);
end;

function TBlueBambooCommand.SelectPrintMode(AMode: TBlueBambooPrintMode): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SELECT_PRINT_MODE + AMode.ToArrayOfByte);
end;

function TBlueBambooCommand.SetAbsolutePrintPosition(nL, nH: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SET_ABSOLUTE_PRINT_POSITION + [nL, nH]);
end;

function TBlueBambooCommand.SetHorizontalTabPositions(const ATabPositions: TArray<TBlueBambooHorizontalTabRange>): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SET_HORIZONTAL_TAB_POSITIONS + TBlueBambooUtils.HorizontalTabArrayToArrayOfBytes(ATabPositions) + [$00]);
end;

function TBlueBambooCommand.SetLeftMargin(nL, nH: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SET_LEFT_MARGIN + [nL, nH]);
end;

function TBlueBambooCommand.SetLineSpace(const ASpace: TBlueBambooRange): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_SET_LINE_SPACE + [ASpace]);
end;

function TBlueBambooCommand.ToList: TList<TArray<Byte>>;
begin
  Result := FCommandList;
end;

function TBlueBambooCommand.TurnKeypadMode(AMode: TBlueBambooKeypadMode): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_TURN_KEYPAD_MODE + AMode.ToArrayOfByte);
end;

function TBlueBambooCommand.TurnReversePrintingMode(const AMode: TBlueBambooReversePrintingMode): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_TURN_REVERSE_PRINTING_MODE + AMode.ToArrayOfByte);
end;

function TBlueBambooCommand.TurnUnderlineMode(const AMode: TBlueBambooUnderlineMode = TBlueBambooUnderlineMode.UnderlineOff): IBlueBambooCommand;
begin
  Result := Command(BLUEBAMBOO_TURN_UNDERLINE_MODE + AMode.ToArrayOfByte);
end;

{ TBlueBambooManager }

procedure TBlueBambooManager.RunCommand(ADevice: IBlueBambooDevice; ACommand: IBlueBambooCommand);
var
  LCommandArray: TArray<Byte>;
begin
  for LCommandArray in ACommand.ToList do
    ADevice.SendData(LCommandArray);
end;

end.
