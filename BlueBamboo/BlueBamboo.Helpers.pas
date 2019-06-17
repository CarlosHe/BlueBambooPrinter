unit BlueBamboo.Helpers;

interface

uses BlueBamboo.Types;

type
  TBlueBambooBarcodeModeHelper = record Helper for TBlueBambooBarcodeMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
    function ToMaxSize: Integer;
    function ToMaxSizeAsByte: Byte;
    function ToMaxSizeAsArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooCodingHelper = record Helper for TBlueBambooCoding
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooCharacterSetHelper = record Helper for TBlueBambooCharacterSet
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooPrintModeHelper = record Helper for TBlueBambooPrintMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooUnderlineModeHelper = record Helper for TBlueBambooUnderlineMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooReversePrintingModeHelper = record Helper for TBlueBambooReversePrintingMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooKeypadModeHelper = record Helper for TBlueBambooKeypadMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooJustificationModeHelper = record Helper for TBlueBambooJustificationMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

  TBlueBambooBitImageModeHelper = record Helper for TBlueBambooBitImageMode
  public
    { public declarations }
    function ToByte: Byte;
    function ToArrayOfByte: TArray<Byte>;
  end;

implementation

{ TBlueBambooBarcodeModeHelper }

function TBlueBambooBarcodeModeHelper.ToMaxSize: Integer;
begin
  case Self of
    TBlueBambooBarcodeMode.EAN_13:
      Result := 13;
    TBlueBambooBarcodeMode.EAN_8:
      Result := 8;
    TBlueBambooBarcodeMode.UPC_A:
      Result := 12;
    TBlueBambooBarcodeMode.UPC_E:
      Result := 8;
    TBlueBambooBarcodeMode.CODE_128:
      Result := 255;
  end;
end;

function TBlueBambooBarcodeModeHelper.ToMaxSizeAsArrayOfByte: TArray<Byte>;
begin
  Result := [ToMaxSizeAsByte]
end;

function TBlueBambooBarcodeModeHelper.ToMaxSizeAsByte: Byte;
begin
  Result := ToMaxSize;
end;

function TBlueBambooBarcodeModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooBarcodeModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooBarcodeMode.EAN_13:
      Result := $02;
    TBlueBambooBarcodeMode.EAN_8:
      Result := $03;
    TBlueBambooBarcodeMode.UPC_A:
      Result := $00;
    TBlueBambooBarcodeMode.UPC_E:
      Result := $01;
    TBlueBambooBarcodeMode.CODE_128:
      Result := $49;
  end;
end;

{ TBlueBambooCodingHelper }

function TBlueBambooCodingHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooCodingHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooCoding.ACP:
      Result := $30;
    TBlueBambooCoding.UTF8:
      Result := $31;
  end;
end;

{ TBlueBambooCharacterSetHelper }

function TBlueBambooCharacterSetHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooCharacterSetHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooCharacterSet.LatinCharacter:
      Result := $00;
    TBlueBambooCharacterSet.SimplifiedChinese:
      Result := $30;
    TBlueBambooCharacterSet.UTF8:
      Result := $65;
  end;
end;

{ TBlueBambooPrintModeHelper }

function TBlueBambooPrintModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooPrintModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooPrintMode._32DotFont:
      Result := $00;
    TBlueBambooPrintMode._24DotFont:
      Result := $01;
    TBlueBambooPrintMode.DoubleHeightOff:
      Result := $40;
    TBlueBambooPrintMode.DoubleHeightOn:
      Result := $41;
    TBlueBambooPrintMode.DoubleWidthOff:
      Result := $50;
    TBlueBambooPrintMode.DoubleWidthOn:
      Result := $51;
    TBlueBambooPrintMode.UnderlineOff:
      Result := $70;
    TBlueBambooPrintMode.UnderlineOn:
      Result := $71;
  end;
end;

{ TBlueBambooUnderlineModeHelper }

function TBlueBambooUnderlineModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooUnderlineModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooUnderlineMode.UnderlineOff:
      Result := $00;
    TBlueBambooUnderlineMode.UnderlineOn1DotThick:
      Result := $01;
    TBlueBambooUnderlineMode.UnderlineOn2DotsThick:
      Result := $02;
  end;
end;

{ TBlueBambooReversePrintingModeHelper }

function TBlueBambooReversePrintingModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooReversePrintingModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooReversePrintingMode.ReversePrintingOn:
      Result := $01;
    TBlueBambooReversePrintingMode.ReversePrintingOff:
      Result := $00;
  end;
end;

{ TBlueBambooKeypadModeHelper }

function TBlueBambooKeypadModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooKeypadModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooKeypadMode.KeypadOn:
      Result := $01;
    TBlueBambooKeypadMode.KeypadOff:
      Result := $00;
  end;
end;

{ TBlueBambooJustificationModeHelper }

function TBlueBambooJustificationModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooJustificationModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooJustificationMode.LeftJustification:
      Result := $48;
    TBlueBambooJustificationMode.CenterJustification:
      Result := $49;
    TBlueBambooJustificationMode.RightJustification:
      Result := $50;
  end;
end;

{ TBlueBambooBitImageModeHelper }

function TBlueBambooBitImageModeHelper.ToArrayOfByte: TArray<Byte>;
begin
  Result := [ToByte];
end;

function TBlueBambooBitImageModeHelper.ToByte: Byte;
begin
  case Self of
    TBlueBambooBitImageMode.Normal:
      Result := $30;
    TBlueBambooBitImageMode.DoubleWide:
      Result := $31;
    TBlueBambooBitImageMode.DoubleTal:
      Result := $32;
    TBlueBambooBitImageMode.Quadruple:
      Result := $33;
  end;
end;

end.
