unit uPushNotif;
interface
uses
  System.SysUtils, System.JSON, REST.Client, REST.Types;
procedure Send(const Title, Msg: string);
implementation
procedure Send(const Title, Msg: string);
var
  Client: TRESTClient;
  Request: TRESTRequest;
begin
  Client := TRESTClient.Create('https://fcm.googleapis.com/fcm/send');
  Request := TRESTRequest.Create(nil);
  try
    Request.Client := Client;
    Request.Method := rmPOST;
    Request.AddParameter('Authorization', 'key=YOUR_FIREBASE_SERVER_KEY', pkHTTPHEADER);
    Request.AddParameter('Content-Type', 'application/json', pkHTTPHEADER);
    Request.AddBody('{"to":"/topics/wolvox","notification":{"title":"' + Title + '","body":"' + Msg + '"}}');
    Request.Execute;
  finally
    Client.Free; Request.Free;
  end;
end;
end.
