unit Speed;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CoolTools, CoolCtrls, StdCtrls, FileCtrl, RzFilSys, ExtCtrls, Mask,
  ToolEdit, RzLaunch, RzDlgBtn, Menus,Registry, RzLabel, FileUtil, Abcbusy,
  Gauges, Abclabel, ComCtrls, BUDirectories;

type
  TFormCD = class(TForm)
    CoolGroupBox1: TCoolGroupBox;
    CoolLabel1: TCoolLabel;
    RzDriveComboBox1: TRzDriveComboBox;
    CoolLabel2: TCoolLabel;
    Gauge1: TGauge;
    CoolLabel3: TCoolLabel;
    CoolLabel4: TCoolLabel;
    CoolLabel5: TCoolLabel;
    Timer1: TTimer;
    Gauge2: TGauge;
    CoolLabel6: TCoolLabel;
    CoolLabel7: TCoolLabel;
    CoolLabel8: TCoolLabel;
    CoolLabel9: TCoolLabel;
    CoolLabel10: TCoolLabel;
    CoolLabel12: TCoolLabel;
    CoolLabel11: TCoolLabel;
    CoolLabel13: TCoolLabel;
    Panel1: TPanel;
    Button3: TButton;
    Button1: TButton;
    Button2: TButton;
    abcURLLabel1: TabcURLLabel;
    Label1: TLabel;
    procedure N1Click(Sender: TObject);
    procedure ReadTestFile(Path:string);
    procedure Button1Click(Sender: TObject);
    procedure TestDrive(Path:string);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCD:TFormCD;
  AverageSpeed,MaxSpeed,FilesRead:longint;
  SizeBT,OldSizeBT:int64;
  UsedFileName:String;
  Stopped:boolean;
  OldTime:TDateTime;
  TimeS:Double;
 
implementation

{$R *.DFM}

procedure TFormCD.TestDrive(Path:string);
var
  SR:TSearchRec;
begin
  if Stopped then Exit;
  try
    if FindFirst(Path,faAnyFile,SR) = 0
    then
      begin
        if (SR.Attr and faDirectory) = faDirectory
        then
          begin
            if (SR.Name <> '.')and(SR.Name <> '..') then TestDrive(copy(Path,0,Length(Path)-3)+SR.Name+'\*.*');
          end
        else ReadTestFile(copy(Path,0,Length(Path)-3)+SR.Name);
        while (FindNext(SR) = 0)and not Stopped do
          begin
            if (SR.Attr and faDirectory) = faDirectory
            then
              begin
                if (SR.Name <> '.')and(SR.Name <> '..') then TestDrive(copy(Path,0,Length(Path)-3)+SR.Name+'\*.*');
              end
            else ReadTestFile(copy(Path,0,Length(Path)-3)+SR.Name);
          end;
      end;
  except
    on EInOutError do;
  end;

end;

procedure TFormCD.N1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormCD.ReadTestFile(Path:string);
const
  BufS = 262144;
var
  File1:File of Char;
  Buf:array[0..BufS-1]of Char;
  BytesTransfered:integer;
  FS,CurPosF,BytesToEnd:longint;
begin
  UsedFileName:=Path;
  CoolLabel2.Caption:=UsedFileName;
  FS:=GetFileSize(UsedFileName);
  Gauge2.Progress:=0;
  Application.ProcessMessages;
  if FileExists(UsedFileName)
  then
    begin
      try
      AssignFile(File1,UsedFileName);
      Reset(File1);
      inc(FilesRead);
      if FS > BufS
      then
        begin
          CurPosF:=0;
          BytesToEnd:=FS;
          While (BytesToEnd>0)and not Stopped do
            begin
              BlockRead(File1,Buf,BufS,BytesTransfered);
              CurPosF:=CurPosF+BytesTransfered;
              BytesToEnd:=FS-CurPosF;
              Gauge2.Progress:=100-Round(BytesToEnd/FS*100);
              SizeBT:=SizeBT+BytesTransfered;
              if TimeS>0
                then AverageSpeed:=Round(SizeBT/1024/TimeS)
                else AverageSpeed:=0;
              Application.ProcessMessages;
            end;
        end
      else
        begin
          BlockRead(File1,Buf,GetFileSize(UsedFileName),BytesTransfered);
          SizeBT:=SizeBT+BytesTransfered;
          if TimeS>0
            then AverageSpeed:=Round(SizeBT/1024/TimeS)
            else AverageSpeed:=0;
          Application.ProcessMessages;
        end;
      CloseFile(File1);
      Gauge2.Progress:=0;
      CoolLabel2.Caption:='';
      Application.ProcessMessages;
      except
        on EInOutError do;
      end;
    end;
end;

procedure TFormCD.Button1Click(Sender: TObject);
begin
  if (rzDriveComboBox1.Drive<>'')
    then
      begin
        Timer1.Enabled:=True;
        OldTime:=Time;
        TimeS:=0;
        SizeBT:=0;
        OldSizeBT:=0;
        MaxSpeed:=0;
        Stopped:=False;
        Button3.Visible:=True;
        Button2.Enabled:=False;
        Button1.Enabled:=False;
        RzDriveComboBox1.Enabled:=False;
        CoolLabel12.Caption:='0';
        CoolLabel9.Caption:='0';
        if (rzDriveComboBox1.Drive='a') or (rzDriveComboBox1.Drive='b')
          then MessageDlg('Test drive is a removable drive. Please reinsert disk in drive.',mtConfirmation,[mbOk],0);
        TestDrive(rzDriveComboBox1.Drive+':\*.*');
        if (TimeS<1) or (AverageSpeed=0) or (Timer1.Enabled=false)
          then MessageDlg('Drive test error or canceled.',mtError,[mbOk],0)
          else MessageDlg('Drive test finished. Average drive speed: '+IntToStr(AverageSpeed)+' Kb/s.',mtInformation,[mbOk],0);
        Button3Click(FormCD);
      end;
end;

procedure TFormCD.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFormCD.Timer1Timer(Sender: TObject);
var
  Rez:Double;
  rH,rM,rS,rZ:Word;
begin
  Rez := OldTime - Time;
  OldTime:=Time;
  Label1.Caption:=TimeToStr(Rez);
  DecodeTime(Rez, rH, rM, rS, rZ);
  TimeS := TimeS + rS + rZ/1000;
  CoolLabel9.Caption:=IntToStr(FilesRead);
  CoolLabel13.Caption:=IntToStr(Round(((SizeBT-OldSizeBT)/(rS+rZ/1000))/1024));
  CoolLabel12.Caption:=IntToStr(Round(SizeBT/1024));
  if TimeS>2 then
    begin
      CoolLabel5.Caption:='Aver. '+IntToStr(AverageSpeed)+' Kb/s';
      if (Round((SizeBT-OldSizeBT)/1024)>=MaxSpeed)
      then
        begin
          MaxSpeed:=Round((SizeBT-OldSizeBT)/1024);
          if (AverageSpeed>=MaxSpeed)and(AverageSpeed<100000) then MaxSpeed:=AverageSpeed;
          Gauge1.MaxValue:=MaxSpeed;
          Application.ProcessMessages;
        end;
      CoolLabel4.Caption:=IntToStr(MaxSpeed)+' Kb/s ';
      Gauge1.Progress:=AverageSpeed;
      Application.ProcessMessages;
    end;
  OldSizeBT:=SizeBT;
end;

procedure TFormCD.Button3Click(Sender: TObject);
begin
  Timer1.Enabled:=False;
  Button3.Visible:=False;
  Button2.Enabled:=True;
  Button1.Enabled:=True;
  RzDriveComboBox1.Enabled:=True;
  Stopped:=True;
end;

procedure TFormCD.FormCreate(Sender: TObject);
begin
  CoolLabel2.Caption:='';
  LongTimeFormat:='hh:nn:ss:zz';
end;

end.
