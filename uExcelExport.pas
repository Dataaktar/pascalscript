unit uExcelExport;
interface
uses
  System.SysUtils, FMX.ListBox;
procedure ExportListBox(const LB: TObject; const FileName: string);
implementation
uses ComObj;
procedure ExportListBox(const LB: TObject; const FileName: string);
var
  Excel, Workbook, Range: OleVariant;
  List: TListBox;
  I: Integer;
begin
  List := LB as TListBox;
  Excel := CreateOleObject('Excel.Application');
  Excel.Visible := False;
  Workbook := Excel.Workbooks.Add;
  Range := Workbook.WorkSheets[1].Range['A1'];
  for I := 0 to List.Items.Count - 1 do
    Range.Offset[I, 0].Value := List.Items[I];
  Workbook.SaveAs(FileName);
  Workbook.Close;
  Excel.Quit;
end;
end.
