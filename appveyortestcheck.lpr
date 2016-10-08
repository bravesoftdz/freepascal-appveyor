program AppveyorTestCheck;
{$mode objfpc}
uses Adder,TestFramework,TextTestRunner;
type
 TChecks=class(TTestCase)
 published
  procedure All;
 end;
procedure TChecks.All;
begin
 Check(Add(1,1)=2,'a');
 Check(Add(1,1)=2,'b');
 Check(Add(1,1)=2,'c');
 Check(Add(1,1)=2,'d');
 Check(Add(1,1)=2,'e');
end;
begin
 TestFramework.RegisterTest(TChecks.Suite);
 RunRegisteredTests;
end.