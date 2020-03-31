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
  //��������� ��������
  AutoUpdate:boolean;
  //���� ���������
  FlagChange:boolean;

implementation

uses Unit1;

{$R *.dfm}

{===============���� ��������� ��������===============}

//�������� �������
procedure LoadPos;
var
  F: TIniFile;
  ValueAutoUpdateInFile: boolean;
begin
  ValueAutoUpdateInFile := false;

  //�������� ��������
  if FileExists(ExtractFilePath(ParamStr(0)) + 'settings.ini') then
  begin
    F :=  TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');

    ValueAutoUpdateInFile := F.ReadBool('Update','Auto',false);
  end;

  //��������� �������
  with Form2 do
    CheckBox1.Checked := ValueAutoUpdateInFile;

  //���������� �������������� ��������
  AutoUpdate := ValueAutoUpdateInFile;
  FlagChange:=true;
end;

{===============������===============}

//����������
procedure TForm2.Button1Click(Sender: TObject);
var
  F: TIniFile;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0)));
  F := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'settings.ini');

  with Form1 do
    F.WriteBool('Update','Auto',CheckBox1.Checked);

  //������� ���������� �������
  F.Free;

  ShowMessage('��������� ���������');
  //�������� �� ��������� � ����������
  FlagChange:=true;
  //��������� ���������� ��������
  AutoUpdate := CheckBox1.Checked;
end;

{===============�������===============}

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  //�������� �� ���������
  if CheckBox1.Checked <> AutoUpdate then
    FlagChange:=false
  else
    FlagChange:=true;
end;

{===============�����===============}

//��������� �����
procedure TForm2.FormActivate(Sender: TObject);
begin
  //��������� ��������
  LoadPos;
end;

//�������� �����
procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  str: string;
begin
  //��������� �� ���� ���������
  if not FlagChange then
  begin
    str := '�� �� ��������� ���������!' + #13#10 + '�� ������������� ������ ����� �� �������� ��� ����������?';
    //�������� ������ ��� ���������� ��������
    if MessageBox(Handle, PChar(str), '��������!', MB_ICONWARNING+MB_YESNO+MB_DEFBUTTON2) = ID_YES then
    begin
      CanClose := true;
    end
    else
      CanClose := false;
  end;
end;

end.
