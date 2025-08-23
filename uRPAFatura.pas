unit uRPAFatura;
interface
uses
  System.SysUtils, FireDAC.Comp.Client;
procedure CreateInvoice(const CariKod, UrunKod: string; Miktar: Double);
implementation
procedure CreateInvoice(const CariKod, UrunKod: string; Miktar: Double);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  FaturaNo: string;
begin
  Conn := TFDConnection.Create(nil);
  Query := TFDQuery.Create(nil);
  try
    Conn.Params.DriverID := 'FB';
    Conn.Params.Database := 'C:\Wolvox\DATA\WOLVOX.FDB';
    Conn.Params.UserName := 'SYSDBA';
    Conn.Params.Password := 'masterkey';
    Conn.Connected := True;
    Query.Connection := Conn;
    FaturaNo := 'FAT-' + FormatDateTime('yyyymmddhhnnss', Now);
    // Fatura başlık
    Query.SQL.Text :=
      'INSERT INTO FATURA_BASLIK (FATURANO, CARIKOD, TARIH, TOPLAM) ' +
      'VALUES (:FATURANO, :CARIKOD, :TARIH, :TOPLAM)';
    Query.ParamByName('FATURANO').AsString := FaturaNo;
    Query.ParamByName('CARIKOD').AsString := CariKod;
    Query.ParamByName('TARIH').AsDateTime := Now;
    Query.ParamByName('TOPLAM').AsFloat := Miktar * 100;
    Query.ExecSQL;
    // Fatura satır
    Query.SQL.Text :=
      'INSERT INTO FATURA_SATIR (FATURANO, URUNKOD, MIKTAR, FIYAT) ' +
      'VALUES (:FATURANO, :URUNKOD, :MIKTAR, :FIYAT)';
    Query.ParamByName('FATURANO').AsString := FaturaNo;
    Query.ParamByName('URUNKOD').AsString := UrunKod;
    Query.ParamByName('MIKTAR').AsFloat := Miktar;
    Query.ParamByName('FIYAT').AsFloat := 100;
    Query.ExecSQL;
    WriteLn('Fatura oluşturuldu: ' + FaturaNo);
  finally
    Query.Free; Conn.Free;
  end;
end;
end.
