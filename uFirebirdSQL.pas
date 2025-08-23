unit uFirebirdSQL;
interface
uses
  System.SysUtils, FMX.ListBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Comp.Client;
procedure QueryToList(const SQL: string; LB: TObject);
implementation
procedure QueryToList(const SQL: string; LB: TObject);
var
  Conn: TFDConnection;
  Query: TFDQuery;
  List: TListBox;
  I: Integer;
begin
  List := LB as TListBox;
  List.Clear;
  Conn := TFDConnection.Create(nil);
  Query := TFDQuery.Create(nil);
  try
    Conn.Params.DriverID := 'FB';
    Conn.Params.Database := 'C:\Wolvox\DATA\WOLVOX.FDB';
    Conn.Params.UserName := 'SYSDBA';
    Conn.Params.Password := 'masterkey';
    Conn.Connected := True;
    Query.Connection := Conn;
    Query.SQL.Text := SQL;
    Query.Open;
    for I := 0 to Query.FieldCount - 1 do
      List.Items.Add(Query.Fields[I].AsString);
  finally
    Query.Free; Conn.Free;
  end;
end;
end.
