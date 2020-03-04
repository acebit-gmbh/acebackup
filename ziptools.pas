unit ziptools;

interface

uses
  Windows, SysUtils, Classes, ZLib;

type
  TZipProgress = procedure(CurBlock, TotBlock: integer; var AClose: Boolean) of object;

procedure CompressStream(AStreamInp: TStream; AStreamOut: TStream; AEvent: TZipProgress; Compression: byte); //stdcall;
procedure DecompressStream(AStreamInp: TStream; AStreamOut: TStream; AEvent: TZipProgress); // stdcall;


implementation
 //TCompressionLevel = (clNone, clFastest, clDefault, clMax);
 // clNone means out = in
 // so it looks like should be used either clFastest or clMax



 // Gaivans 03.01.2004 - New realization to handle large files
 // Size of the buffer must be exactly MAXWORD for backward compatibily !)

var
  lpBuffer: array[word] of char;

procedure CompressStream(AStreamInp: TStream; AStreamOut: TStream; AEvent: TZipProgress; Compression: byte); //stdcall;
var
  ZStrm: TCompressionStream;
  ComprLevel: TCompressionLevel;
  nBytesRead: integer;
  NeedClose: Boolean;
  nSize: integer;
  nRead: integer;
begin
  ComprLevel := TCompressionLevel(Compression);
  ZStrm := TCompressionStream.Create(ComprLevel, AStreamOut);
  try
    nSize := AStreamInp.Size div MAXWORD;
    nRead := 0;
    repeat
      nBytesRead := AStreamInp.Read(lpBuffer, MAXWORD);
      Inc(nRead);
      ZStrm.Write(lpBuffer, nBytesRead);
      if Assigned(AEvent) then
      begin
        AEvent(nRead, nSize, NeedClose);
        if NeedClose then
          Abort;
      end;
    until nBytesRead = 0;
  finally
    ZStrm.Free;
  end;
end;

procedure DecompressStream(AStreamInp: TStream; AStreamOut: TStream; AEvent: TZipProgress); // stdcall;
var
  ZStrm: TDecompressionStream;
  //  lpBuffer: array[Word] of Char;
  nBytesRead: integer;
  NeedClose: Boolean;
  nSize: integer;
  nRead: integer;
begin
  ZStrm := TDecompressionStream.Create(AStreamInp);
  try
    nSize := AStreamInp.Size div MAXWORD;
    nRead := 0;
    repeat
      nBytesRead := ZStrm.Read(lpBuffer, MAXWORD);
      Inc(nRead);
      AStreamOut.Write(lpBuffer, nBytesRead);
      if Assigned(AEvent) then
      begin
        AEvent(nRead, nSize, NeedClose);
        if NeedClose then
          Abort;
      end;
    until nBytesRead = 0;
  finally
    ZStrm.Free;
  end;
end;

end.
