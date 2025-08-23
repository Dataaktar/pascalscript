unit uKimiAPI;
interface
uses
  System.SysUtils, System.Classes, System.JSON,
  REST.Client, REST.Types;
function GenerateSQLPrompt(const Prompt: string): string;
implementation
function GenerateSQLPrompt(const Prompt: string): string;
var
  Client: TRESTClient;
  Request: TRESTRequest;
  Response: TRESTResponse;
  J: TJSONObject;
begin
  Client := TRESTClient.Create('https://api.moonshot.cn/v1');
  Request := TRESTRequest.Create(nil);
  Response := TRESTResponse.Create(nil);
  try
    Request.Client := Client;
    Request.Response := Response;
    Request.Resource := 'chat/completions';
    Request.Method := rmPOST;
    Request.AddParameter('Authorization', 'Bearer sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', pkHTTPHEADER);
    Request.AddParameter('Content-Type', 'application/json', pkHTTPHEADER);
    Request.AddBody('{"model":"kimi-k2-0711-preview","messages":[{"role":"user","content":"Wolvox Firebird SQL: ' + Prompt + '"}]}');
    Request.Execute;
    Result := (TJSONObject.ParseJSONValue(Response.Content) as TJSONObject)
               .GetValue<TJSONArray>('choices')[0]
               .GetValue<TJSONObject>('message')
               .GetValue<string>('content');
  finally
    Client.Free; Request.Free; Response.Free;
  end;
end;
end.
