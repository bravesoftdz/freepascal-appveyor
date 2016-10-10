program AdderApp;
uses Adder,Console,SaveScreenUnit;
procedure Run;
begin
 WriteLn('1 + 1 = ',Add(1,1));
end;
begin
 Run;
 SaveScreen(ConsoleDeviceGetDefault,'screen.bmp',0,0,1600,900,24);
end.