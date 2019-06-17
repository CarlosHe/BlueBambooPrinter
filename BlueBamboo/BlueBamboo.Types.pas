unit BlueBamboo.Types;
{$SCOPEDENUMS ON}

interface

type
  TBlueBambooRange = 0 .. 255;

  TBlueBambooPDF417ColRange = 0 .. 7;
  TBlueBambooPDF417RowRange = 0 .. 90;

  TCharacterHeightRange = 0 .. 7;
  TCharacterWidthRange = 0 .. 7;

  TBlueBambooHorizontalTabRange = 0 .. 32;

  TBlueBambooBarcodeMode = (EAN_13, EAN_8, UPC_A, UPC_E, CODE_128);
  TBlueBambooCoding = (ACP, UTF8);

  TBlueBambooCharacterSet = (LatinCharacter, SimplifiedChinese, UTF8);

  TBlueBambooPrintMode = (_32DotFont, _24DotFont, DoubleHeightOff, DoubleHeightOn, DoubleWidthOff, DoubleWidthOn, UnderlineOff, UnderlineOn);
  TBlueBambooUnderlineMode = (UnderlineOff, UnderlineOn1DotThick, UnderlineOn2DotsThick);
  TBlueBambooReversePrintingMode = (ReversePrintingOn, ReversePrintingOff);
  TBlueBambooKeypadMode = (KeypadOn, KeypadOff);
  TBlueBambooJustificationMode = (LeftJustification, CenterJustification, RightJustification);

  TBlueBambooBitImageMode = (Normal, DoubleWide, DoubleTal, Quadruple);


implementation

end.
