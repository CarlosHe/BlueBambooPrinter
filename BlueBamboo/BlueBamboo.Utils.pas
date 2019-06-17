unit BlueBamboo.Utils;

interface

uses
  System.SysUtils, BlueBamboo.Types, FMX.Graphics, System.UITypes,
  System.Classes, System.Math;

type

  TBlueBambooUtils = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class procedure MakeGreyScaleBitmap(var ABitmap: TBitmap);
    class procedure MakeBinarizedBitmap(var ABitmap: TBitmap; const ALevel: Byte = $7F);
    class procedure ProportionalBitmapResize(var ABitmap: TBitmap; AProportional: Single);
    class procedure AdjustBitmapWidthIfNecessary(var ABitmap: TBitmap; AMaxWidth: Integer);
    class procedure InitArrayOfByte(var AArrayOfByte: TArray<Byte>; AMaxLength: Integer; const ADefaultValue: Byte = $00);

    class function BitsToDec(ABits: TBits): Cardinal;

    // class function BitmapToBlueBambooBitImage(ABitmap: TBitmap): TBlueBambooBitImage;

    class function StringToArrayOfByte(AString: string): TArray<Byte>;
    class function HorizontalTabArrayToArrayOfBytes(ATabPositions: TArray<TBlueBambooHorizontalTabRange>): TArray<Byte>;
    class function CanColorize(APosX, APosY: Integer; AAlphaColor: TAlphaColor): Boolean;
  published
    { published declarations }
  end;

implementation

{ TBlueBambooUtils }

class procedure TBlueBambooUtils.AdjustBitmapWidthIfNecessary(var ABitmap: TBitmap; AMaxWidth: Integer);
var
  LProportional: Single;
begin
  if ABitmap.Width > AMaxWidth then
  begin
    LProportional := AMaxWidth / ABitmap.Width;
    ABitmap.Resize(AMaxWidth, Ceil(ABitmap.Height * LProportional));
  end;
end;

class function TBlueBambooUtils.BitsToDec(ABits: TBits): Cardinal;
var
  LDecimal: Real;
  X, Y: Integer;
begin
  LDecimal := 0;
  Y := 0;
  for X := ABits.Size - 1 downTo 0 Do
  begin
    LDecimal := LDecimal + (Integer(ABits[X])) * Exp(Y * Ln(2));
    Y := Y + 1;
  end;
  Result := Round(LDecimal);
end;

class function TBlueBambooUtils.CanColorize(APosX, APosY: Integer; AAlphaColor: TAlphaColor): Boolean;
var
  LAlphaColorRec: TAlphaColorRec;
  LGrey: Byte;
begin
  Result := False;

  LAlphaColorRec := TAlphaColorRec.Create(AAlphaColor);

  LGrey := Round(LAlphaColorRec.R * 0.30 + LAlphaColorRec.G * 0.59 + LAlphaColorRec.B * 0.11);


  if (Odd(APosX)) and (Odd(APosY)) and (LGrey <180) then
    Result := True;

  if (not Odd(APosX)) and (not Odd(APosY)) and (LGrey < 150) then
    Result := True;

  if (Odd(APosX)) and (not Odd(APosY)) and (LGrey < 130) then
    Result := True;

  if (not Odd(APosX)) and (Odd(APosY)) and (LGrey < 100) then
    Result := True;

end;

class function TBlueBambooUtils.HorizontalTabArrayToArrayOfBytes(ATabPositions: TArray<TBlueBambooHorizontalTabRange>): TArray<Byte>;
var
  I: Integer;
begin
  SetLength(Result, Length(ATabPositions));
  for I := Low(ATabPositions) to High(ATabPositions) do
    Result[I] := ATabPositions[I];
end;

class procedure TBlueBambooUtils.InitArrayOfByte(var AArrayOfByte: TArray<Byte>; AMaxLength: Integer; const ADefaultValue: Byte);
var
  I: Integer;
begin
  SetLength(AArrayOfByte, AMaxLength);
  for I := Low(AArrayOfByte) to High(AArrayOfByte) do
    AArrayOfByte[I] := ADefaultValue;

end;

class procedure TBlueBambooUtils.MakeBinarizedBitmap(var ABitmap: TBitmap; const ALevel: Byte);
var
  LTempBitmapData: TBitmapData;
  LTempAlphaColorRec: TAlphaColorRec;
  X, Y: Integer;
  LGrey: Byte;
begin
  ABitmap.Map(TMapAccess.ReadWrite, LTempBitmapData);
  try
    for Y := 0 to LTempBitmapData.Height - 1 do
      for X := 0 to LTempBitmapData.Width - 1 do
      begin
        LTempAlphaColorRec.Create(LTempBitmapData.GetPixel(X, Y));
        LGrey := Round(LTempAlphaColorRec.R * 0.30 + LTempAlphaColorRec.G * 0.59 + LTempAlphaColorRec.B * 0.11);
        if LGrey <= ALevel then
          LGrey := $00
        else
          LGrey := $FF;
        LTempAlphaColorRec.R := LGrey;
        LTempAlphaColorRec.G := LGrey;
        LTempAlphaColorRec.B := LGrey;
        LTempAlphaColorRec.A := $FF;
        LTempBitmapData.SetPixel(X, Y, LTempAlphaColorRec.Color);
      end;
  finally
    ABitmap.Unmap(LTempBitmapData);
  end;
end;

class procedure TBlueBambooUtils.MakeGreyScaleBitmap(var ABitmap: TBitmap);
var
  LTempBitmapData: TBitmapData;
  LTempAlphaColorRec: TAlphaColorRec;
  X, Y: Integer;
  LGrey: Byte;
begin
  ABitmap.Map(TMapAccess.ReadWrite, LTempBitmapData);
  try
    for Y := 0 to LTempBitmapData.Height - 1 do
      for X := 0 to LTempBitmapData.Width - 1 do
      begin
        LTempAlphaColorRec.Create(LTempBitmapData.GetPixel(X, Y));
        LGrey := Round(LTempAlphaColorRec.R * 0.30 + LTempAlphaColorRec.G * 0.59 + LTempAlphaColorRec.B * 0.11);
        LTempAlphaColorRec.R := LGrey;
        LTempAlphaColorRec.G := LGrey;
        LTempAlphaColorRec.B := LGrey;
        LTempAlphaColorRec.A := $FF;
        LTempBitmapData.SetPixel(X, Y, LTempAlphaColorRec.Color);
      end;
  finally
    ABitmap.Unmap(LTempBitmapData);
  end;
end;

class procedure TBlueBambooUtils.ProportionalBitmapResize(var ABitmap: TBitmap; AProportional: Single);
begin
  ABitmap.Resize(Trunc(ABitmap.Width * AProportional), Trunc(ABitmap.Height * AProportional));
end;

class function TBlueBambooUtils.StringToArrayOfByte(AString: string): TArray<Byte>;
begin
  Result := TEncoding.UTF8.GetBytes(AString);
end;

end.
