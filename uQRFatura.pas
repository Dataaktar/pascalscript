unit uQRFatura;
interface
uses
  System.SysUtils, FMX.Objects, ZXing.BarCodeFormat, ZXing.QRCode;
procedure GenerateQR(const FaturaNo: string; Img: TObject);
implementation
procedure GenerateQR(const FaturaNo: string; Img: TObject);
var
  QR: TQRCode;
  Bitmap: TBitmap;
begin
  QR := TQRCode.Create;
  Bitmap := TBitmap.Create(200, 200);
  try
    QR.Text := '{"fatura":"' + FaturaNo + '"}';
    QR.Draw(Bitmap);
    (Img as TImage).Bitmap := Bitmap;
  finally
    QR.Free;
  end;
end;
end.
