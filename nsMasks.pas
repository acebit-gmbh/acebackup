unit nsMasks;

interface

uses
  SysUtils, Classes, Masks;

type

  TMaskItem = class(TCollectionItem)
  private
    FMask: TMask;
    FMaskValue: string;
    procedure SetMaskValue(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function Matches(const AFileName: string): Boolean;
  published
    property MV: string read FMaskValue write SetMaskValue;
  end;

  TMaskItems = class(TCollection)
  private
  public
    constructor Create;
    procedure SetMask(const AValue: string);
    function GetMask: string;
    function Matches(const AFileName: string): Boolean;
  end;

implementation

{ TMaskItem }

constructor TMaskItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TMaskItem.Destroy;
begin
  if FMask <> nil then
    FreeAndNil(FMask);
  inherited Destroy;
end;

function TMaskItem.Matches(const AFileName: string): Boolean;
begin
  if FMask <> nil then
    Result := FMask.Matches(AFileName)
  else
    Result := False;
end;

procedure TMaskItem.SetMaskValue(const Value: string);
begin
  if (FMaskValue <> Value) and (Value <> EmptyStr) then
  begin
    if FMask <> nil then
      FreeAndNil(FMask);
    FMaskValue := Value;
    FMask := TMask.Create(FMaskValue);
  end;
end;

{ TMaskItems }

constructor TMaskItems.Create;
begin
  inherited Create(TMaskItem);
end;

function TMaskItems.GetMask: string;
var
  Index: integer;
begin
  for Index := 0 to Count - 1 do
    Result := Result + TMaskItem(Items[Index]).MV + #59;
  if Length(Result) > 0 then
    SetLength(Result, Length(Result) - 1);
end;

function TMaskItems.Matches(const AFileName: string): Boolean;
var
  Index: integer;
  Item:  TMaskItem;
begin
  Result := False;
  for Index := 0 to Count - 1 do
  begin
    Item := TMaskItem(Items[Index]);
    if Item.Matches(AFileName) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TMaskItems.SetMask(const AValue: string);
var
  S: string;
  iPos: integer;
  Item: TMaskItem;
  sMask: string;
begin
  Clear;
  if AValue = EmptyStr then
    Exit;
  S := AValue;
  repeat
    iPos := AnsiPos(#59, S);
    if iPos > 0 then
    begin
      sMask := System.Copy(S, 1, iPos - 1);
      System.Delete(S, 1, iPos);
    end
    else
    begin
      sMask := S;
      S := EmptyStr;
    end;
    if sMask <> EmptyStr then
    begin
      Item := TMaskItem(inherited Add);
      Item.MV := sMask;
    end;
  until S = EmptyStr;
end;

end.
