--[[

      Dvg API
      by DvgCraft

      VERSION 2.17.1
      DATE    23-06-2016
      GITHUB  github.com/Dantevg/DvgApps (/tree/master/DvgAPI)

]]--

version = "2.17.1"


sides = { "right", "left", "top", "bottom", "back", "front" }
colorToName = {
  [1] = "white",
  [2] = "orange",
  [4] = "magenta",
  [8] = "lightBlue",
  [16] = "yellow",
  [32] = "lime",
  [64] = "pink",
  [128] = "gray",
  [256] = "lightGray",
  [512] = "cyan",
  [1024] = "purple",
  [2048] = "blue",
  [4096] = "brown",
  [8192] = "green",
  [16384] = "red",
  [32768] = "black",
}
nameToColor = {
  ["white"] = 1,
  ["orange"] = 2,
  ["magenta"] = 4,
  ["lightBlue"] = 8,
  ["yellow"] = 16,
  ["lime"] = 32,
  ["pink"] = 64,
  ["gray"] = 128,
  ["lightGray"] = 256,
  ["cyan"] = 512,
  ["purple"] = 1024,
  ["blue"] = 2048,
  ["brown"] = 4096,
  ["green"] = 8192,
  ["red"] = 16384,
  ["black"] = 32768,
}
toName = colorToName -- Deprecated
toColor = nameToColor -- Deprecated

function setTextColor( color )
  term.setTextColor( color )
  return dvg
end
function setBackgroundColor( color )
  term.setBackgrundColor( color )
  return dvg
end

function bg( color )
  term.setBackgroundColor( color )
  term.clear()
end
function writeColor( string, color )
  term.setTextColor( color )
  write( string )
end
function printColor( string, color )
  term.setTextColor( color )
  print( string )
end
function centerColor( string, color, y )
  term.setTextColor( color )
  center( string, y )
end
function writePos( string, x,y )
  term.setCursorPos( x, y )
  write( string )
end
function printPos( string, x,y )
  term.setCursorPos( x, y )
  print( string )
end

function center( text, y )
  local curX, curY = term.getCursorPos()
  local w, _ = term.getSize()
  x = math.ceil( ( w/2 ) - ( string.len(text)/2 ) + 1 )
  term.setCursorPos( math.max(x,1), y and y or curY )
  write( text )
  term.setCursorPos( curX,curY )
end

function fill( text, to, char )
  if type( text ) ~= "string" or type( to ) ~= "number" then
    error( "Expected string, number [,string]" )
  end
  if char and type( char ) ~= "string" then
    error( "Expected string, number [,string]" )
  end
  while #text <= to do
    if char then
      text = (to < 0 and char..text or text..char)
    else
      text = (to < 0 and " "..text or text.." ")
    end
  end
  return text
end

function sub( txt, pos )
  return string.sub( txt, pos, pos )
end

function box( x, y, w, h, bgcolor )
  term.setBackgroundColor( bgcolor )
  for i = 1, h do
    term.setCursorPos( x, y-1+i )
    write( string.rep(" ", w) )
  end
end

function scroll( text, height, offset )
  if type( text ) ~= "table" or type( height ) ~= "number" or type( offset ) ~= "number" then
    error( "Expected table text, number height, number offset" )
  end
  for i = 1, offset do
    if #text <= height then break end
    table.remove( text, 1 )
  end
  while #text > height do
    table.remove( text )
  end
  return text
end

function read( input, exitEvent, exitParam, exitVal )
  if ( input and type(input) ~= "string" ) or ( exitEvent and type( exitEvent ) ~= "string" ) or (exitParam and (type(exitParam)~="number" or exitParam>5) ) then
    error( "Expected [string input [,string exitEvent [,number exitParam, any exitVal]]" )
  end -- Input: string,  exitEvent: string,  exitParam: number < 6,  exitVal: any

  local input = input or ""
  while true do
    local p = {os.pullEvent()}
    local event = p[1]
    table.remove( p, 1 )

    if event == "key" then

      if exitEvent == "key" and (not exitParam or p[exitParam] == exitVal) then
        return input, false, false, p
      else
        if p[1] == keys.backspace then
          return input:sub( 1,-2 ), false, true, event, p
        elseif p[1] == keys.enter then
          return input, true, false, event, p
        end
      end -- End if exitEvent

    elseif event == "char" then

      if exitEvent == "char" then
        if not exitParam or p[exitParam] == exitVal then return input, false, false, event, p end
      else
        return input..p[1], false, true, event, p
      end

    elseif event == exitEvent then

      if not exitParam or p[exitParam] == exitVal then return input, false, false, event, p end

    else

      return input, false, true, event, p

    end -- End if event
  end -- End while true
end


function checkupdate( url, current )
  if type( url ) ~= "string" then
    error( "Expected string URL, [string version]" )
  end

  http.request( url )
  while true do
    local event, url, source = os.pullEvent()
    if event == "http_success" then
      local version = source.readAll()
      if current then
        if current >= version then
          return false
        else
          return true
        end
      else
        return version
      end
    elseif event == "http_failure" then
      return "Could not connect to server"
    end
  end
end

function compareVersions( new, old )
  if not new or not old or type( new ) ~= "string" or type( old ) ~= "string" then
    error( "Expected string new, string old" )
  end
  local t1 = {}
  local t2 = {}
  for v in string.gmatch( new, "%P+" ) do table.insert( t1, v ) end
  for v in string.gmatch( old, "%P+" ) do table.insert( t2, v ) end
  for i = 1, math.max( #t1, #t2 ) do
    if not t2[i] or t1[i] > t2[i] then
      return true, i
    elseif not t1[i] or t1[i] < t2[i] then
      return false, i
    end
  end
  return false
end


function readFile( path, tbl )
  local file = fs.open( path, "r" )
  local contents = file.readAll()
  if tbl then contents = textutils.unserialize( contents ) end
  file.close()
  return contents
end
function writeFile( path, contents, mode )
  if fs.isReadOnly( path ) then return nil end
  local file = fs.open( path, mode and mode or "w" )
  file.write( contents )
  file.close()
  return true
end


function decToBase( n, base )
  if type( n ) ~= "number" or (base and type( base ) ~= "number") then
    error( "Expected number [, base]", 2 )
  elseif base < 2 or base > 36 then
    error( "Base can only be <= 10", 2 )
  end
  if base == 10 then
    return tostring( num )
  elseif base == 8 then
    return string.format( tostring(n), "%o" )
  elseif base == 16 then
    return string.format( tostring(n), "%X" )
  end

  local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local out = ""
  n = math.floor( n )

  if n < 0 then -- Negative
    out = "-"
    n = -n
  end
  while n > 0 do
    local d = ( n % base ) + 1
    n = math.floor( n / base )
    out = digits:sub( d,d ) .. out
  end
  return out
end
function baseToDec( n, base )
  if (type( n ) ~= "string" and type( n ) ~= "number") or (base and type( base ) ~= "number") then
    error( "Expected number [, base]", 2 )
  elseif base < 2 or base > 36 then
    error( "Base can only be <= 10", 2 )
  end
  return tonumber( n, base )
end


function toBool( var )
  if var == true or var == "true" or var == "1" or var == 1 then
    return true
  elseif var == false or var == "false" or var == "0" or var == 0 then
    return false
  end
end
function toInt( var )
  if var == true or var == "true" or var == "1" or var == 1 then
    return 1
  elseif var == false or var == "false" or var == "0" or var == 0 then
    return 0
  end
end

function isSide( side )
  for i = 1, 6 do
    if side == sides[i] then
      return i
    end
  end
  return false
end
function isBool( var, txt )
  if var == true or var == false or ( txt and (var == "true" or var == "false") ) then
    return true
  end
  return false
end
function isInt( num )
  if math.floor( num ) == num and math.ceil( num ) == num then
    return true
  else
    return false
  end
end

function switchBool( bool ) -- Deprecated, use code below
  return not bool
end

function inAny( checkIn, checkFor )
  if checkIn == nil or type( checkIn ) ~= "table" or checkFor == nil then
    error( "Expected table, value" )
  end
  for i = 1, #checkIn do
    if checkIn[i] == checkFor then
      return i
    end
  end
  return false
end


function openRednet()
  local modems = { peripheral.find( "modem" ) }
  for _, modem in pairs( modems ) do
    if modem.isWireless() then
      modem.open( os.getComputerID() ) -- Same as rednet.open()
      modem.open( 65535 ) -- For broadcasting
      return true
    end
    return false, "No wireless modems"
  end
  return false, "No modems"
end


function compass()
  if not turtle then
    error( "This function is only for turtles" )
  end
  local x1, y1, z1 = gps.locate()
  if not x1 then return nil end
  success = turtle.forward()
  if not success then return nil end
  x2, y2, z2 = gps.locate()
  if not x2 then return nil end
  turtle.back()

  if z2 > z1 then
    facing = "north"
  elseif z2 < z1 then
    facing = "south"
  elseif x2 > x1 then
    facing = "east"
  elseif x2 < x1 then
    facing = "west"
  else
    return nil
  end
  return facing
end
