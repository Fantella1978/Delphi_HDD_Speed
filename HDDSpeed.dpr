program HDDSpeed;

{Используются библиотеки: RXLibrary 2,75 	}
{			  Cool Controls 2,05	}

uses
  Forms,
  Windows,
  Registry,
  Speed in 'Speed.pas' {FormCD};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormCD, FormCD);
  Application.Run;
end.
