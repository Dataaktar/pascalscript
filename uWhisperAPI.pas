unit uWhisperAPI;
interface
uses
  System.SysUtils, System.Classes, REST.Client, REST.Types;
function TranscribeFromMic: string;
implementation
function TranscribeFromMic: string;
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
begin
  Client := TRESTClient.Create('https://api.openai.com/v1');
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := Client;
    Request.Response := Response;
    Request.Resource := 'audio/transcriptions';
    Request.Method := rmPOST;
    Request.AddParameter('Authorization', 'Bearer sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', pkHTTPHEADER);
    Request.AddParameter('Content-Type', 'multipart/form-data', pkHTTPHEADER);
    Request.AddFile('file', 'input.wav', 'audio/wav');
    Request.AddParameter('model', 'whisper-1');
    Request.Execute;
    Result := Response.Content;
  finally
    Client.Free; Request.Free; Response.Free;
  end;
end;
end.
