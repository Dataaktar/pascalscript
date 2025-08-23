unit uMainForm;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, FMX.ListBox, FMX.Memo, FMX.Objects,
  uKimiAPI, uWhisperAPI, uTTSKimi, uFirebirdSQL, uExcelExport,
  uQRFatura, uFirebaseSync, uPushNotif, uRPAFatura;
type
  TfrmMain = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    MemoPrompt: TMemo;
    MemoSQL: TMemo;
    ListBox1: TListBox;
    btnMic: TButton;
    btnKimi: TButton;
    btnExcel: TButton;
    btnFatura: TButton;
    btnQR: TButton;
    btnSync: TButton;
    btnNotify: TButton;
    imgQR: TImage;
    procedure btnMicClick(Sender: TObject);
    procedure btnKimiClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnFaturaClick(Sender: TObject);
    procedure btnQRClick(Sender: TObject);
    procedure btnSyncClick(Sender: TObject);
    procedure btnNotifyClick(Sender: TObject);
  private
    FKimi: TKimiAPI;
    FTTS: TTTSKimi;
    FWhisper: TWhisperAPI;
    FDB: TFirebirdSQL;
    FExcel: TExcelExport;
    FQR: TQRFatura;
    FSync: TFirebaseSync;
    FNotif: TPushNotif;
    FRPA: TRPAFatura;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;
var
  frmMain: TfrmMain;
implementation
{$R *.fmx}
constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;
  FKimi := TKimiAPI.Create;
  FTTS := TTTSKimi.Create;
  FWhisper := TWhisperAPI.Create;
  FDB := TFirebirdSQL.Create;
  FExcel := TExcelExport.Create;
  FQR := TQRFatura.Create;
  FSync := TFirebaseSync.Create;
  FNotif := TPushNotif.Create;
  FRPA := TRPAFatura.Create;
end;
destructor TfrmMain.Destroy;
begin
  FKimi.Free; FTTS.Free; FWhisper.Free; FDB.Free;
  FExcel.Free; FQR.Free; FSync.Free; FNotif.Free;
  FRPA.Free; inherited;
end;
procedure TfrmMain.btnMicClick(Sender: TObject); begin MemoPrompt.Text := FWhisper.TranscribeFromMic; end;
procedure TfrmMain.btnKimiClick(Sender: TObject); begin MemoSQL.Text := FKimi.GenerateSQLPrompt(MemoPrompt.Text); FDB.QueryToList(MemoSQL.Text, ListBox1); end;
procedure TfrmMain.btnExcelClick(Sender: TObject); begin FExcel.ExportListBox(ListBox1, 'rapor.xlsx'); end;
procedure TfrmMain.btnFaturaClick(Sender: TObject); begin FRPA.CreateInvoice('120.001', 'URUN123', 3); end;
procedure TfrmMain.btnQRClick(Sender: TObject); begin FQR.GenerateQR('FAT20250601', imgQR); end;
procedure TfrmMain.btnSyncClick(Sender: TObject); begin FSync.OfflineKaydet(MemoSQL.Text); FSync.SenkronizeEt; end;
procedure TfrmMain.btnNotifyClick(Sender: TObject); begin FNotif.Send('Rapor Hazır', 'Kimi ile oluşturuldu.'); end;
end.
