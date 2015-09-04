unit APIRuCaptcha;

interface

uses System.SysUtils, Vcl.Forms, IdHTTP, IdMultipartFormData, StrUtils,
  DateUtils;

type
  TAPIRuCaptcha = class
  public
    class function GetBalance(const Key: string): string;
    class function UploadFile(const Key, FileName: string): string;
    class function GetAnswer(const Key, CaptchaId: string): string;
    class function SendReport(const Key, CaptchaId: string): string;
  end;

implementation

procedure Wait(Seconds: Int64);
var
  Target: TTime;
begin
  Target := IncSecond(Now, Seconds);
  while (Target > Now) do
  begin
    Application.ProcessMessages;

    if Application.Terminated then
      Exit;

    System.SysUtils.Sleep(30);
  end;
end;

{ TAPIRuCaptcha }

class function TAPIRuCaptcha.GetAnswer(const Key, CaptchaId: string): string;
var
  URL: string;
  HTTP: TIdHTTP;
begin
  URL := Format('http://rucaptcha.com/res.php?key=%s&action=get&id=%s',
    [Key, CaptchaId]);

  HTTP := TIdHTTP.Create(nil);
  try
    Result := HTTP.Get(URL);
    if Result = 'CAPCHA_NOT_READY' then
    begin
      Wait(2);
      Result := GetAnswer(Key, CaptchaId);
    end;
    Result := ReplaceStr(Result, 'OK|', '');
  finally
    HTTP.Free;
  end;
end;

class function TAPIRuCaptcha.GetBalance(const Key: string): string;
var
  URL: string;
  HTTP: TIdHTTP;
begin
  URL := Format('http://rucaptcha.com/res.php?key=%s&action=getbalance', [Key]);

  HTTP := TIdHTTP.Create(nil);
  try
    Result := HTTP.Get(URL);
  finally
    HTTP.Free;
  end;
end;

class function TAPIRuCaptcha.SendReport(const Key, CaptchaId: string): string;
var
  URL: string;
  HTTP: TIdHTTP;
begin
  URL := Format('http://rucaptcha.com/res.php?key=%s&action=reportbad&id=%s',
    [Key, CaptchaId]);

  HTTP := TIdHTTP.Create(nil);
  try
    Result := HTTP.Get(URL);
  finally
    HTTP.Free;
  end;
end;

class function TAPIRuCaptcha.UploadFile(const Key, FileName: string): string;
var
  URL: string;
  HTTP: TIdHTTP;
  Data: TIdMultiPartFormDataStream;
begin
  URL := 'http://rucaptcha.com/in.php';

  HTTP := TIdHTTP.Create(nil);
  Data := TIdMultiPartFormDataStream.Create;
  try
    Data.AddFormField('key', Key);
    Data.AddFile('file', FileName);

    Result := HTTP.Post(URL, Data);
    if Pos('ERROR', Result) = 0 then
    begin
      Result := ReplaceStr(Result, 'OK|', '');
    end;
  finally
    Data.Free;
    HTTP.Free;
  end;
end;

end.
