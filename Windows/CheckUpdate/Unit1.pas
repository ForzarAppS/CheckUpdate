unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  ShellApi, Menus, IniFiles;

  //типы соединения с интернетом
const
  INTERNET_CONNECTION_MODEM      = 1;
  INTERNET_CONNECTION_LAN        = 2;
  INTERNET_CONNECTION_PROXY      = 4;
  INTERNET_CONNECTION_MODEM_BUSY = 8;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4;

  //функция для проверки соединения с интернетом
  function InternetGetConnectedState(lpdwFlags: LPDWORD; dwReserved:DWORD):BOOL; stdcall; external 'wininet.dll' name 'InternetGetConnectedState';

{$R *.dfm}

{===============СВОИ ПРОЦЕДУРЫ===============}

//проверка соединения с интернетом
function isNetwork: Boolean;
var
  ConnectionTypes: DWORD;
begin
  ConnectionTypes := INTERNET_CONNECTION_MODEM or INTERNET_CONNECTION_LAN or INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@ConnectionTypes, 0);
end;

//загрузка библиотек
procedure LoadFromResource(idDLL: String);
var
  rs: TResourceStream;
begin
  rs:=TResourceStream.Create(HInstance, idDLL, RT_RCDATA);
  rs.SaveToFile(ExtractFilePath(ParamStr(0))+idDLL+'.dll');
  rs.Free;
end;

//загрузка настроек
procedure LoadSet;
const
  FileUpdate:string = 'https://yadi.sk/d/Mt8vcTD_a34Q5g';
var
  F: TIniFile;
  ValueAutoUpdateInFile: boolean;
  //вспомогательная переменная
  Data: String;
  //выходные данные
  //ссылка на обновление
  LinkUpdate: String;
  //новая версия
  NewVersion: String;
begin
  ValueAutoUpdateInFile := false;

  //загрузка настроек
  if FileExists(ExtractFilePath(ParamStr(0)) + 'settings.ini') then
  begin
    F :=  TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');

    ValueAutoUpdateInFile := F.ReadBool('Update','Auto',false);
  end;

  if ValueAutoUpdateInFile = true then
  begin
    if isNetwork then
    begin
      //загрузка библиотек
      //при отсутствии файла SSL
      if not(FileExists('ssleay32.dll')) then
        LoadFromResource('ssleay32');
      //при отсутствии файла LIB
      if not(FileExists('libeay32.dll')) then
        LoadFromResource('libeay32');

      try
        //получение данных
        with Form1 do
          Data:=IdHTTP1.Get(FileUpdate);
        //название файла без расширения
        Data:=Copy(Data, Pos('<title>',Data)+7, Pos('</title>',Data)-Pos('<title>',Data)+1-26);
        //название файла без расширения и названия проекта
        Data:=Copy(Data, Pos('_v_',Data)+3);
        //проверка на незаполненность ссылки на новую версию
        if Pos('_',Data) > 0 then
        begin
          //проверка на новую версию
          with Form4 do
            if Copy(Label6.Caption,2,Pos(' ',Label6.Caption)-2) <> Copy(Data, 1, Pos('_',Data)-1) then
            begin
              //ссылка на обновление
              LinkUpdate:=Copy(Data, Pos('_',Data)+1);
              //новая версия
              NewVersion:=Copy(Data, 0, Pos('_',Data)-1);

              //вывод диалога
              case MessageBox(Handle,PWideChar('Выпущена новая версия программы (v'+NewVersion+'). Перейти на страницу для скачивания?'),'Внимание!',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1) of
                IDYES: ShellExecute( Handle, 'open', PWideChar('https://yadi.sk/d/'+LinkUpdate), nil, nil, SW_NORMAL );
              end;
            end;
        end;
      except on e:Exception do
        //вывод сообщения
        ShowMessage('Ошибка: '+e.Message);
      end;
    end;
  end;
end;

{===============КНОПКА===============}

//проверка обновления
procedure TForm1.Button1Click(Sender: TObject);
var
  //вспомогательная переменная
  Data: String;
  //выходные данные
  //ссылка на обновление
  LinkUpdate: String;
  //новая версия
  NewVersion: String;
begin
  //проверка соединения с интернетом
  if isNetwork then
  begin
    //пустое поле ввода ссылки
    if Edit1.Text <> '' then
    begin
      //пустое поле ввода версии
      if Edit2.Text <> '' then
      begin
        //загрузка библиотек
        //при отсутствии файла SSL
        if not(FileExists('ssleay32.dll')) then
          LoadFromResource('ssleay32');
        //при отсутствии файла LIB
        if not(FileExists('libeay32.dll')) then
          LoadFromResource('libeay32');

        try
          //получение данных
          Data:=IdHTTP1.Get(Edit1.Text);
          //название файла без расширения
          Data:=Copy(Data, Pos('<title>',Data)+7, Pos('</title>',Data)-Pos('<title>',Data)+1-26);
          //название файла без расширения и названия проекта
          Data:=Copy(Data, Pos('_v_',Data)+3);
          //проверка на незаполненность ссылки на новую версию
          if Pos('_',Data) > 0 then
          begin
            //проверка на новую версию
            if Edit2.Text <> Copy(Data, 1, Pos('_',Data)-1) then
            begin
              //ссылка на обновление
              LinkUpdate := 'https://yadi.sk/d/'+Copy(Data, Pos('_',Data)+1);
              //новая версия
              NewVersion := Copy(Data, 0, Pos('_',Data)-1);

              //вывод диалога
              case MessageBox(Handle,PWideChar('Выпущена новая версия программы (v'+NewVersion+'). Перейти на страницу для скачивания?'),'Внимание!',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON1) of
                IDYES: ShellExecute( Handle, 'open', PWideChar(LinkUpdate), nil, nil, SW_NORMAL );
              end;
            end
            else//Edit2
              //вывод сообщения
              ShowMessage('Обновление не требуется.');
          end
          else//Pos
            //вывод сообщения
            ShowMessage('Обновлений нет.');
        except on e:Exception do
          //вывод сообщения
          ShowMessage('Ошибка: '+e.Message);
        end;
      end
      else//Edit2
        //вывод сообщения
        ShowMessage('Заполните текущую версию.');
    end
    else//Edit1
      //вывод сообщения
      ShowMessage('Заполните ссылку для проверки.');
  end
  else//isNetwork
    //вывод сообщения
    ShowMessage('Отсутствует интернет-соединение!');
end;

{===============ФОРМА===============}

//создание формы
procedure TForm1.FormActivate(Sender: TObject);
begin
  Edit2.Text := Copy(Form4.Label6.Caption,2,Pos(' ',Form4.Label6.Caption)-2);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //загрузка настроек
  LoadSet;
end;

//разрушение формы
procedure TForm1.FormDestroy(Sender: TObject);
begin
  //освободить память
  IdHTTP1.Destroy;
  IdSSLIOHandlerSocketOpenSSL1.Destroy;
  IdSSLOpenSSL.UnLoadOpenSSLLibrary();

  //при наличии файла SSL
  if FileExists('ssleay32.dll') then
  begin
    //освободить память
    FreeLibrary(GetModuleHandle('ssleay32.dll'));
    //удалить файл
    DeleteFile('ssleay32.dll');
  end;

  //при наличии файла LIB
  if FileExists('libeay32.dll') then
  begin
    //освободить память
    FreeLibrary(GetModuleHandle('libeay32.dll'));
    //удалить файл
    DeleteFile('libeay32.dll');
  end;
end;

{===============МЕНЮ===============}

//настройки
procedure TForm1.N1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

//помощь
procedure TForm1.N2Click(Sender: TObject);
begin
  Form3.ShowModal;
end;

//о программе
procedure TForm1.N3Click(Sender: TObject);
begin
  Form4.ShowModal;
end;

end.
