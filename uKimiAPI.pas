unit uKimiAPI;
interface
function GenerateSQLPrompt(const Prompt: string): string;
implementation
uses System.SysUtils;
function GenerateSQLPrompt(const Prompt: string): string;
begin
  Result := 'SELECT * FROM STOK WHERE URUN_ADI LIKE ''%' + Prompt + '%''';
end;
end.
