program test_parser;

{$mode objfpc}{$H+}

uses
  SysUtils, laz_synapse, rd_protocol, rd_commands
  { you can add units after this };

const
  s1 = '+PONG'#13#10;
  s2 = '*3'#13#10'$3'#13#10'foo'#13#10'$-1'#13#10'$3'#13#10'bar'#13#10;

function GetAnswerType(const s : string) : TRedisAnswerType;
var
  c : char;
begin
  if s = '' then Exit(ratUnknown);

  c := copy(s, 1,1)[1];
  case c of
    RPLY_SINGLE_CHAR     : Result := ratStatus;
    RPLY_ERROR_CHAR      : Result := ratError;
    RPLY_BULK_CHAR       : Result := ratBulk;
    RPLY_MULTI_BULK_CHAR : Result := ratMultiBulk;
    else Result := ratUnknown;
  end;
end;

begin
  writeln(s1, ' ', GetAnswerType(s1));
  writeln(s2, ' ', GetAnswerType(s2));
end.

