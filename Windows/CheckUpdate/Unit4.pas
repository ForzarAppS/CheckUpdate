unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, Buttons, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdIPWatch, Sockets, SHELLAPI;

//типы соединения с интернетом
const
  INTERNET_CONNECTION_MODEM      = 1;
  INTERNET_CONNECTION_LAN        = 2;
  INTERNET_CONNECTION_PROXY      = 4;
  INTERNET_CONNECTION_MODEM_BUSY = 8;

type
  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Image1: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Image2: TImage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TIdHTTP;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

  //функция для проверки соединения с интернетом
  function InternetGetConnectedState(lpdwFlags: LPDWORD; dwReserved:DWORD):BOOL; stdcall; external 'wininet.dll' name 'InternetGetConnectedState';

{$R *.dfm}

{===============СВОИ ПРОЦЕДУРЫ===============}

//проверка на наличие интернета
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

{===============КНОПКИ===============}

procedure TForm4.BitBtn1Click(Sender: TObject);
var
  str: string;
begin
  str:= '';

  {str := str+'v1.0 (1 апреля 2020)'+#13#10;
  str := str+'▶ Релизная версия'+#13#10+#13#10;}

  str := str+'v1.0 (1 апреля 2020)'+#13#10;
  str := str+'▶ Релизная версия';

  //вывод сообщения
  ShowMessage(str);
end;

procedure TForm4.Button1Click(Sender: TObject);
const
  FileUpdate:string = 'https://yadi.sk/d/Mt8vcTD_a34Q5g';
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
    //загрузка библиотек
    //при отсутствии файла SSL
    if not(FileExists('ssleay32.dll')) then
      LoadFromResource('ssleay32');
    //при отсутствии файла LIB
    if not(FileExists('libeay32.dll')) then
      LoadFromResource('libeay32');

    try
      //получение данных
      Data:=IdHTTP1.Get(FileUpdate);
      //название файла без расширения
      Data:=Copy(Data, Pos('<title>',Data)+7, Pos('</title>',Data)-Pos('<title>',Data)+1-26);
      //название файла без расширения и названия проекта
      Data:=Copy(Data, Pos('_v_',Data)+3);
      //проверка на незаполненность ссылки на новую версию
      if Pos('_',Data) > 0 then
      begin
        //проверка на новую версию
        if Copy(Label6.Caption,2,Pos(' ',Label6.Caption)-2) <> Copy(Data, 1, Pos('_',Data)-1) then
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
        else//Label6
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
  else//isNetwork
    //вывод сообщения
    ShowMessage('Отсутствует интернет-соединение!');
end;

{===============ССЫЛКИ===============}

//почта
procedure TForm4.Label11Click(Sender: TObject);
begin
  ShellExecute(application.Handle,'Open',PChar('mailto:'+Label11.Caption),Nil,Nil,SW_SHOWDEFAULT);
end;

//вк
procedure TForm4.Label12Click(Sender: TObject);
begin
  if (Sender is TLabel) then
    with (Sender as Tlabel) do
      ShellExecute(Application.Handle,PChar('open'),PChar(Hint),PChar(0),nil,SW_NORMAL);
end;

end.
