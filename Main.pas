unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses APIRuCaptcha;

function Recognize(const Key, FileName: string): string;
begin
  Result := TAPIRuCaptcha.UploadFile(Key, FileName);
  if Pos('ERROR', Result) = 0 then
  begin
    Result := TAPIRuCaptcha.GetAnswer(Key, Result);
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit2.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  Key: string;
  FileName: string;
  CaptchaText: string;
begin
  Key := Edit1.Text;
  FileName := Edit2.Text;

  ShowMessage(Format('Balance: %s', [TAPIRuCaptcha.GetBalance(Key)]));
  CaptchaText := Recognize(Key, FileName);
  ShowMessage(Format('Captcha Text: %s', [CaptchaText]));
end;

end.
