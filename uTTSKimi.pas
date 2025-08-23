unit uTTSKimi;
interface
uses
  System.SysUtils, REST.Client, REST.Types;
procedure SpeakText(const Text: string);
implementation
procedure SpeakText(const Text: string);
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  Stream: TMemoryStream;
begin
  Client := TRESTClient.Create('https://api.moonshot.cn/v1');
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  Stream := TMemoryStream.Create;
  try
    Request.Client := Client;
    Request.Response := Response;
    Request.Resource := 'audio/speech';
    Request.Method := rmPOST;
    Request.AddParameter('Authorization', 'Bearer sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', pkHTTPHEADER);
    Request.AddParameter('Content-Type', 'application/json', pkHTTPHEADER);
    Request.AddBody('{"model":"tts-1","input":"' + Text + '","voice":"alloy"}');
    Request.Execute;
    Stream.WriteBuffer(Response.RawBytes[0], Length(Response.RawBytes));
    Stream.SaveToFile('output.mp3');
  finally
    Stream.Free; Client.Free; Request.Free; Response.Free;
  end;
end;
end.
