unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TForm2 = class(TForm)
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  //начальное значение
  AutoUpdate:boolean;
  //флаг изменения
  FlagChange:boolean;

implementation

uses Unit1;

{$R *.dfm}

{===============СВОЯ ПРОЦЕДУРА ЗАГРУЗКИ===============}

//загрузка позиций
procedure LoadPos;
var
  F: TIniFile;
  ValueAutoUpdateInFile: boolean;
begin
  ValueAutoUpdateInFile := false;

  //загрузка настроек
  if FileExists(ExtractFilePath(ParamStr(0)) + 'settings.ini') then
  begin
    F :=  TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');

    ValueAutoUpdateInFile := F.ReadBool('Update','Auto',false);
  end;

  //настройка позиций
  with Form2 do
    CheckBox1.Checked := ValueAutoUpdateInFile;

  //сохранение первоначальных настроек
  AutoUpdate := ValueAutoUpdateInFile;
  FlagChange:=true;
end;

{===============КНОПКА===============}

//сохранение
procedure TForm2.Button1Click(Sender: TObject);
var
  F: TIniFile;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0)));
  F := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');

  with Form1 do
    F.WriteBool('Update','Auto',CheckBox1.Checked);

  //очистка переменной объекта
  F.Free;

  ShowMessage('Настройки сохранены');
  //проверка на изменения в настройках
  FlagChange:=true;
  //повторное сохранение значений
  AutoUpdate := CheckBox1.Checked;
end;

{===============ЧЕКБОКС===============}

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  //проверка на изменение
  if CheckBox1.Checked <> AutoUpdate then
    FlagChange:=false
  else
    FlagChange:=true;
end;

{===============ФОРМА===============}

//активация формы
procedure TForm2.FormActivate(Sender: TObject);
begin
  //загрузить значения
  LoadPos;
end;

//закрытие формы
procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  str: string;
begin
  //настройки не были сохранены
  if not FlagChange then
  begin
    str := 'Вы не сохранили настройки!' + #13#10 + 'Вы действительно хотите выйти из настроек без сохранения?';
    //проверка выхода без сохранения настроек
    if MessageBox(Handle, PChar(str), 'Внимание!', MB_ICONWARNING+MB_YESNO+MB_DEFBUTTON2) = ID_YES then
    begin
      CanClose := true;
    end
    else
      CanClose := false;
  end;
end;

end.
