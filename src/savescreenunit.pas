unit SaveScreenUnit;

{$mode delphi}{$H+}
interface
uses Console;
function SaveScreen(Console:PConsoleDevice;const Filename:String;X,Y,Width,Height,BPP:LongWord):Boolean;

implementation
uses
 {network, filesystem etc}
 {$ifdef BUILD_RPI}
  RaspberryPi,
 {$endif}
 {$ifdef BUILD_RPI2}
  RaspberryPi2,
 {$endif}
 GlobalConst,
 GlobalTypes,
 GraphicsConsole, {Include the GraphicsConsole unit so we can create a graphics window}
 BMPcomn,         {Include the BMPcomn unit from the fpc-image package to give the Bitmap headers}
 Classes,         {Include the Classes unit for the TFileStream class}
 SysUtils;

{A function for saving all or part of an Ultibo console screen to a standard bitmap file}
function SaveScreen(Console:PConsoleDevice;const Filename:String;X,Y,Width,Height,BPP:LongWord):Boolean;
var
 Size:LongWord;
 Count:LongWord;
 Offset:LongWord;
 Format:LongWord;
 Buffer:Pointer;
 LineSize:LongWord;
 ReadSize:LongWord;
 MemoryStream:TMemoryStream;
 
 BitMapFileHeader:TBitMapFileHeader;
 BitMapInfoHeader:TBitMapInfoHeader;
begin
 {}
 Result:=False;
 try
  {Check the parameters}
  if Console = nil then Exit;
  if Length(Filename) = 0 then Exit;
  if (Width = 0) or (Height = 0) then Exit;
 
  {Check the BPP (Bits Per Pixel) value. It must be 16, 24 or 32 for this function}
  if BPP = 16 then
   begin
    {Get the color format}
    Format:=COLOR_FORMAT_RGB15;
    {Work out the number of bytes per line}
    LineSize:=Width * 2;
    {And the actual number of bytes until the next line}
    ReadSize:=(((Width * 8 * 2) + 31) div 32) shl 2;
   end
  else if BPP = 24 then
   begin
    {Color format, bytes per line and actual bytes again}
    Format:=COLOR_FORMAT_RGB24;
    LineSize:=Width * 3;
    ReadSize:=(((Width * 8 * 3) + 31) div 32) shl 2;
   end
  else if BPP = 32 then
   begin
    {Color format, bytes per line and actual bytes as above}
    Format:=COLOR_FORMAT_URGB32;
    LineSize:=Width * 4;
    ReadSize:=(((Width * 8 * 4) + 31) div 32) shl 2;
   end
  else
   begin
    Exit;
   end;
   
  {Check the file does not exist}
  if FileExists(Filename) then Exit;
 
  {Create the TMemoryStream object}
  MemoryStream:=TMemoryStream.Create;
  try
   {Get the total size of the image in the file (not including the headers)}
   Size:=ReadSize * Height;
   
   {Set the size of the memory stream (Adding the size of the headers)}
   MemoryStream.Size:=Size + SizeOf(TBitMapFileHeader) + SizeOf(TBitMapInfoHeader);
   MemoryStream.Position:=0;
   
   {Create the Bitmap file header}
   FillChar(BitMapFileHeader,SizeOf(TBitMapFileHeader),0);
   BitMapFileHeader.bfType:=BMmagic;
   BitMapFileHeader.bfSize:=Size + SizeOf(TBitMapFileHeader) + SizeOf(TBitMapInfoHeader);
   BitMapFileHeader.bfReserved:=0;
   BitMapFileHeader.bfOffset:=SizeOf(TBitMapFileHeader) + SizeOf(TBitMapInfoHeader);
   if MemoryStream.Write(BitMapFileHeader,SizeOf(TBitMapFileHeader)) <> SizeOf(TBitMapFileHeader) then Exit;
   
   {And create the Bitmap info header}
   FillChar(BitMapInfoHeader,SizeOf(TBitMapInfoHeader),0);
   BitMapInfoHeader.Size:=SizeOf(TBitMapInfoHeader);
   BitMapInfoHeader.Width:=Width;
   BitMapInfoHeader.Height:=Height;
   BitMapInfoHeader.Planes:=1;
   BitMapInfoHeader.BitCount:=BPP;
   BitMapInfoHeader.Compression:=BI_RGB;
   BitMapInfoHeader.SizeImage:=Size;
   BitMapInfoHeader.XPelsPerMeter:=3780; {96 DPI} {(3780 / 1000) * 25.4}
   BitMapInfoHeader.YPelsPerMeter:=3780; {96 DPI} {(3780 / 1000) * 25.4}
   BitMapInfoHeader.ClrUsed:=0;
   BitMapInfoHeader.ClrImportant:=0;
   if MemoryStream.Write(BitMapInfoHeader,SizeOf(TBitMapInfoHeader)) <> SizeOf(TBitMapInfoHeader) then Exit;
 
   {Get the size of the pixels to be copied from the screen}
   Size:=LineSize * BitMapInfoHeader.Height;
     
   {Allocate a buffer to copy to}
   Buffer:=GetMem(Size);
   try
    Offset:=0;
     
    {Get the entire image from the screen into our buffer. The function will translate the colors into the format we asked for}
    if ConsoleDeviceGetImage(Console,X,Y,Buffer,BitMapInfoHeader.Width,BitMapInfoHeader.Height,Format,0) <> ERROR_SUCCESS then Exit;
   
    {Go through each row in the image starting at the bottom because bitmaps are normally upside down}
    for Count:=BitMapInfoHeader.Height - 1 downto 0 do
     begin
      {Update the position of the memory stream for the next row}
      MemoryStream.Position:=BitMapFileHeader.bfOffset + (Count * ReadSize);
     
      {Write a full line of pixels to the memory stream from our buffer}     
      if MemoryStream.Write((Buffer + Offset)^,LineSize) <> LineSize then Exit;
         
      {Update the offset of our buffer}   
      Inc(Offset,LineSize);
     end;
   
    {Write the memory stream to the file}
    MemoryStream.SaveToFile(Filename);
   
    Result:=True;
   finally
    FreeMem(Buffer);
   end;
  finally
   MemoryStream.Free;
  end;
 except
  on E: Exception do
   begin
    {Log an error or return a message etc}
   end;
 end;
end;
end.
