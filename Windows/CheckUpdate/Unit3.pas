unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, SHELLAPI, PNGImage;

const
  //размеры формы
  FH=175;
  FW=610;
  //размеры панели
  PH=250;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Label6: TLabel;
    Polosa1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel2: TPanel;
    Label14: TLabel;
    Button2: TButton;
    ScrollBox2: TScrollBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Polosa2: TPanel;
    Panel3: TPanel;
    Label19: TLabel;
    Button3: TButton;
    ScrollBox3: TScrollBox;
    Label20: TLabel;
    Label22: TLabel;
    Polosa3: TPanel;
    Label24: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
      var Handled: Boolean);
    procedure ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
      var Handled: Boolean);
    procedure Label7Click(Sender: TObject);
    procedure Label31DblClick(Sender: TObject);
    procedure Label29DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

{===============СВОИ ПРОЦЕДУРЫ===============}

//количество панелей
procedure FindMax(var CountPanel:byte);
var
  i:byte;
begin
  for i := 1 to MAXBYTE do
    //поиск по кнопкам
    if (Form3.FindComponent('Button'+IntToStr(i)) as TButton) = nil then
    begin
      CountPanel:=i-1;
      break;
    end;
end;

//спойлер
procedure Spoiler(k:byte);
var
  i:byte;
  CountPanel:byte;
begin
  FindMax(CountPanel);

  with Form3 do
    if (FindComponent('Panel'+IntToStr(k)) as TPanel).Height = 40 then
    begin
      (FindComponent('Panel'+IntToStr(k)) as TPanel).Height := 40+PH+10;
      (FindComponent('Button'+IntToStr(k)) as TButton).Caption:='∧';

      if Height=FH then
      begin
        //высота формы
        Height:=Height+PH+10;
        //централизовать форму
        Position:=poDesktopCenter;
      end;

      //возврат в начало и фокус
      (FindComponent('ScrollBox'+IntToStr(k)) as TScrollBox).VertScrollBar.Position:=0;
      (FindComponent('ScrollBox'+IntToStr(k)) as TScrollBox).SetFocus;

      //отступ
      for i := 1 to CountPanel do
        (FindComponent('Panel'+IntToStr(i)) as TPanel).Top:=46*(i-1)+8;

        //отступ
      for i := k+1 to CountPanel do
        (FindComponent('Panel'+IntToStr(i)) as TPanel).Top:=(FindComponent('Panel'+IntToStr(i)) as TPanel).Top+PH+10;

      for i := 1 to CountPanel do
        if i<>k then
        begin
          (FindComponent('Button'+IntToStr(i)) as TButton).Caption:='∨';
          (FindComponent('Panel'+IntToStr(i)) as TPanel).Height := 40;
        end;
    end
    else
    begin
      (FindComponent('Panel'+IntToStr(k)) as TPanel).Height := 40;
      (FindComponent('Button'+IntToStr(k)) as TButton).Caption:='∨';

      //высота формы
      Height:=Height-PH-10;
      //централизовать форму
      Position:=poDesktopCenter;

      //отступ
      for i := 1 to CountPanel do
        (FindComponent('Panel'+IntToStr(i)) as TPanel).Top:=46*(i-1)+8;
    end;
end;

//прокрутка
procedure ScrollMouseWheel(Sender: TObject; str: string);
begin
  with (Form3.FindComponent((Sender as TComponent).Name) as TScrollBox).VertScrollBar do
  begin
    if str = 'down' then
      Position:= Position+(Range div 100);

    if str = 'up' then
      Position:= Position-(Range div 100);
  end;
end;

//создание формы с пасхалкой
procedure CreateForm(id: string);
var
  FormPicture: TForm;
  Pic: TImage;
  PNG: TPNGImage;
begin
  FormPicture:=TForm.Create(Form3);

  //настройки
  FormPicture.BorderIcons := FormPicture.BorderIcons - [biMaximize] - [biMinimize];
  FormPicture.BorderStyle := bsSingle;
  FormPicture.Position := poMainFormCenter;
  FormPicture.Height := 150;
  FormPicture.Width := 150;

  Pic:=TImage.Create(FormPicture);

  //настройки
  Pic.Proportional := true;
  Pic.Parent := FormPicture;
  Pic.Height := 125;
  Pic.Width := 125;
  Pic.Left := 10;

  PNG := TPNGImage.Create;

  //загрузка картинки
  try
    PNG.LoadFromResourceName(HInstance, id);
    Pic.Picture.Graphic := PNG;
  finally
    PNG.Free;
  end;

  //показать форму
  FormPicture.ShowModal;
end;

{===============КНОПКА===============}

procedure TForm3.Button1Click(Sender: TObject);
var
  str:string;
begin
  //определение номера спойлера
  str:=(Sender as TButton).Name;
  Delete(str,1,6);

  //вызов процедуры
  Spoiler(strtoint(str));
end;

{===============ФОРМА===============}

procedure TForm3.FormActivate(Sender: TObject);
var
  i:byte;
  CountPanel:byte;
begin
  //определение количества панелей
  FindMax(CountPanel);

  //начальное состояние
  for i := 1 to CountPanel do
  begin
    (FindComponent('Panel'+IntToStr(i)) as TPanel).Top:=46*(i-1)+8;
    (FindComponent('ScrollBox'+IntToStr(i)) as TScrollBox).VertScrollBar.Position:=0;
    (FindComponent('ScrollBox'+IntToStr(i)) as TScrollBox).Height:=PH;
    (FindComponent('Button'+IntToStr(i)) as TButton).Caption:='∨';
    (FindComponent('Panel'+IntToStr(i)) as TPanel).Height := 40;
  end;

  //высота и ширина формы
  Form3.Height:=FH;
  Form3.Width:=FW;

  //централизовать форму
  Form3.Position:=poDesktopCenter;
end;

{===============ПАСХАЛКА===============}

//создание формы с пасхалкой
procedure TForm3.Label29DblClick(Sender: TObject);
begin
  CreateForm('PngImage_a');
end;

//создание формы с пасхалкой
procedure TForm3.Label31DblClick(Sender: TObject);
begin
  CreateForm('PngImage_w');
end;

{===============ССЫЛКА===============}

//я.диск
procedure TForm3.Label7Click(Sender: TObject);
begin
  if (Sender is TLabel) then
    with (Sender as Tlabel) do
      ShellExecute(Application.Handle,PChar('open'),PChar(Hint),PChar(0),nil,SW_NORMAL);
end;

{===============ПРОКРУТКА===============}

//обработчик колёсика вниз
procedure TForm3.ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollMouseWheel(Sender, 'down');
end;

//обработчик колёсика вверх
procedure TForm3.ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollMouseWheel(Sender, 'up');
end;

end.
