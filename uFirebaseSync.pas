unit uFirebaseSync;
interface
uses
  System.SysUtils, System.Classes, System.JSON, REST.Client, REST.Types;
procedure OfflineKaydet(const SQL: string);
procedure SenkronizeEt;
implementation
uses System.IOUtils;
procedure OfflineKaydet(const SQL: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Add(SQL);
    SL.SaveToFile(TPath.Combine(TPath.GetDocumentsPath, 'offline.txt'));
  finally
    SL.Free;
  end;
end;
procedure SenkronizeEt;
var
  Client: TRESTClient;
  Request: TRESTRequest;
  SL: TStringList;
  I: Integer;
begin
  if FileExists(TPath.Combine(TPath.GetDocumentsPath, 'offline.txt')) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(TPath.Combine(TPath.GetDocumentsPath, 'offline.txt'));
      for I := 0 to SL.Count - 1 do
      begin
        Client := TRESTClient.Create('https://wolvox-ai-default-rtdb.firebaseio.com');
        Request := TRESTRequest.Create(nil);
        try
          Request.Client := Client;
          Request.Resource := '/raporlar.json';
          Request.Method := rmPOST;
          Request.AddBody('{"sql":"' + SL[I] + '"}');
          Request.Execute;
        finally
          Client.Free; Request.Free;
        end;
      end;
      DeleteFile(TPath.Combine(TPath.GetDocumentsPath, 'offline.txt'));
    finally
      SL.Free;
    end;
  end;
end;
end.
