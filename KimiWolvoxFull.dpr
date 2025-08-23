program KimiWolvoxFull;
{$APPTYPE GUI}
uses
  System.StartUpCopy,
  FMX.Forms,
  uMainForm in 'uMainForm.pas' {frmMain},
  uKimiAPI in 'uKimiAPI.pas',
  uWhisperAPI in 'uWhisperAPI.pas',
  uTTSKimi in 'uTTSKimi.pas',
  uFirebirdSQL in 'uFirebirdSQL.pas',
  uExcelExport in 'uExcelExport.pas',
  uQRFatura in 'uQRFatura.pas',
  uFirebaseSync in 'uFirebaseSync.pas',
  uPushNotif in 'uPushNotif.pas',
  uRPAFatura in 'uRPAFatura.pas';
{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
