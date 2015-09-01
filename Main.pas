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
  Balance: string;
  Captcha: string;
begin
  Key := Edit1.Text;
  FileName := Edit2.Text;

  Balance := TAPIRuCaptcha.GetBalance(Key);
  Captcha := TAPIRuCaptcha.Recognize(Key, 'C:\BTCFaucetClub_1239.png');
  ShowMessage(Format('Balance: %s' + #13#10 + 'Captcha: %s', [Balance, Captcha]));
end;

end.
