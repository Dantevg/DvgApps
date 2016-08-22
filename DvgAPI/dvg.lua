--[[

      Dvg API
      by DvgCraft

      DATE    22-08-2016
      GITHUB  github.com/Dantevg/DvgApps (/tree/master/DvgAPI)

]]--

version = "2.20.1"


sides = { "right", "left", "top", "bottom", "back", "front" }



--     ██████  ██████  ██       ██████  ██████  ███████
--    ██      ██    ██ ██      ██    ██ ██   ██ ██
--    ██      ██    ██ ██      ██    ██ ██████  ███████
--    ██      ██    ██ ██      ██    ██ ██   ██      ██
--     ██████  ██████  ███████  ██████  ██   ██ ███████


color = {}
color.complementary = {
  [1] = 32768,
  [2] = 2048,
  [4] = 8192,
  [8] = 16,
  [16] = 8,
  [32] = 1024,
  [64] = 512,
  [128] = 256,
  [256] = 128,
  [512] = 16384,
  [1024] = 32,
  [2048] = 16384,
  [4096] = 2048,
  [8192] = 4,
  [16384] = 512,
  [32768] = 1,
}
color.colorToName = {
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
color.colorToHex = {
  [1] = "F0F0F0",
  [2] = "F2B233",
  [4] = "E57FD8",
  [8] = "99B2F2",
  [16] = "DEDE6C",
  [32] = "7FCC19",
  [64] = "F2B2CC",
  [128] = "4C4C4C",
  [256] = "999999",
  [512] = "4C99B2",
  [1024] = "B266E5",
  [2048] = "3366CC",
  [4096] = "7F664C",
  [8192] = "57A64E",
  [16384] = "CC4C4C",
  [32768] = "191919",
}
color.colorToRgb = function( color )
  return dvg.color.hexToRgb( dvg.color.colorToHex[color] )
end

color.nameToColor = {
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

color.hexToColor = {
  ["F0F0F0"] = 1,
  ["F2B233"] = 2,
  ["E57FD8"] = 4,
  ["99B2F2"] = 8,
  ["DEDE6C"] = 16,
  ["7FCC19"] = 32,
  ["F2B2CC"] = 64,
  ["4C4C4C"] = 128,
  ["999999"] = 256,
  ["4C99B2"] = 512,
  ["B266E5"] = 1024,
  ["3366CC"] = 2048,
  ["7F664C"] = 4096,
  ["57A64E"] = 8192,
  ["CC4C4C"] = 16384,
  ["191919"] = 32768,
}
color.hexToRgb = function( hex )
  if type( hex ) == "number" then
    hex = dvg.decToBase( hex, 16 )
  elseif type( hex ) == "string" then
    if not tonumber( hex, 16 ) then
      error( 2, "Expected string/number ([0-9A-F])", 2 )
    else
      hex = dvg.decToBase( tonumber(hex, 16), 16 )
    end
  else
    error( 2, "Expected string/number ([0-9A-F])", 2 )
  end

  local r = tonumber( hex:sub( 1,2 ), 16 )
  local g = tonumber( hex:sub( 3,4 ), 16 )
  local b = tonumber( hex:sub( 5,6 ), 16 )

  return r, g, b
end

color.rgbToHex = function( r, g, b )
  if not tonumber( r ) or not tonumber( g ) or not tonumber( b ) then
    error( 2, "Expected number, number, number or str/num", 2 )
  end

  r = dvg.decToBase( tonumber(r), 16 )
  g = dvg.decToBase( tonumber(g), 16 )
  b = dvg.decToBase( tonumber(b), 16 )

  local hex = ""
  hex = hex..dvg.fill( r, -2, "0" )
  hex = hex..dvg.fill( g, -2, "0" )
  hex = hex..dvg.fill( b, -2, "0" )

  return hex
end
color.rgbToColor = function( r,g,b )
  return dvg.color.hexToColor[ dvg.color.rgbToHex( r,g,b ) ]
end

-- Following hsl functions modified from Github (https://goo.gl/5MBnPw)
color.rgbToHsl = function( r, g, b )
  r, g, b = r / 255, g / 255, b / 255

  local max, min = math.max(r, g, b), math.min(r, g, b)

  local l = (max + min) / 2

  if max == min then
    h, s = 0, 0 -- achromatic
  else
    local d = max - min
    if l > 0.5 then s = d / (2 - max - min) else s = d / (max + min) end
    if max == r then
      h = (g - b) / d
      if g < b then h = h + 6 end
    elseif max == g then h = (b - r) / d + 2
    elseif max == b then h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h*360, s, l
end

color.hslToRgb = function( h, s, l )
  local r, g, b = 0,0,0
  h = h/360

  if s == 0 then
    r, g, b = l, l, l -- achromatic
  else
    function hue2rgb(p, q, t)
      if t < 0   then t = t + 1 end
      if t > 1   then t = t - 1 end
      if t < 1/6 then return p + (q - p) * 6 * t end
      if t < 1/2 then return q end
      if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
      return p
    end

    local q = 0
    if l < 0.5 then q = l * (1 + s) else q = l + s - l * s end
    local p = 2 * l - q

    r = hue2rgb(p, q, h + 1/3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1/3)
  end

  return r*255, g*255, b*255
end

color.nearest = function( h,s,l )
  local diff = {}
  local c = {}
  for i = 0, 15 do
    c[i] = { dvg.color.rgbToHsl( dvg.color.hexToRgb(dvg.color.colorToHex[2^i]) ) }
  end

  for color, values in ipairs( c ) do
    diff[color] = math.abs( c[color][1] - h )
    diff[color] = diff[color] + math.abs( c[color][2] - s )
    diff[color] = diff[color] + math.abs( c[color][3] - l )
  end -- End for color, values in c

  return table.unpack( c[ dvg.nearest(diff, 0) ] )
end



--     ██████  ██████   █████  ██████  ██   ██ ██  ██████  █████  ██
--    ██       ██   ██ ██   ██ ██   ██ ██   ██ ██ ██      ██   ██ ██
--    ██   ███ ██████  ███████ ██████  ███████ ██ ██      ███████ ██
--    ██    ██ ██   ██ ██   ██ ██      ██   ██ ██ ██      ██   ██ ██
--     ██████  ██   ██ ██   ██ ██      ██   ██ ██  ██████ ██   ██ ███████


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
  if not tostring( text ) or type( to ) ~= "number" then
    error( 2, "Expected string, number [,string]" )
  end
  if char and not tostring( char ) then
    error( 2, "Expected string, number [,string]" )
  end
  text = tostring( text )
  char = tostring( char )
  local inv = false
  if to < 0 then
    inv = true
    to = to * -1
  end
  while #text < to do
    if char then
      text = (inv and char..text or text..char)
    else
      text = (inv and " "..text or text.." ")
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
    error( 2, "Expected table text, number height, number offset" )
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



--    ███████ ██    ██ ███    ██  ██████ ████████ ██  ██████  ███    ██ ██ ███    ██  ██████
--    ██      ██    ██ ████   ██ ██         ██    ██ ██    ██ ████   ██ ██ ████   ██ ██
--    █████   ██    ██ ██ ██  ██ ██         ██    ██ ██    ██ ██ ██  ██ ██ ██ ██  ██ ██   ███
--    ██      ██    ██ ██  ██ ██ ██         ██    ██ ██    ██ ██  ██ ██ ██ ██  ██ ██ ██    ██
--    ██       ██████  ██   ████  ██████    ██    ██  ██████  ██   ████ ██ ██   ████  ██████


function read( input, exitEvent, exitParam, exitVal )
  if ( input and type(input) ~= "string" ) or ( exitEvent and type( exitEvent ) ~= "string" ) or (exitParam and (type(exitParam)~="number" or exitParam>5) ) then
    error( 2, "Expected [string input [,string exitEvent [,number exitParam, any exitVal]]" )
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
    error( 2, "Expected string URL, [string version]" )
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
    error( 2, "Expected string new, string old" )
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
function writeFile( path, contents, mode, tbl )
  if not tbl then
    if type(mode) == "boolean" then tbl = mode mode = nil end
  end
  if fs.isReadOnly( path ) then return nil end
  local file = fs.open( path, mode and mode or "w" )
  file.write( tbl and textutils.serialize(contents) or contents )
  file.close()
  return true
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



--    ██    ██  █████  ██      ██    ██ ███████ ███████
--    ██    ██ ██   ██ ██      ██    ██ ██      ██
--    ██    ██ ███████ ██      ██    ██ █████   ███████
--     ██  ██  ██   ██ ██      ██    ██ ██           ██
--      ████   ██   ██ ███████  ██████  ███████ ███████


function decToBase( n, base )
  if type( n ) ~= "number" or (base and type( base ) ~= "number") then
    error( 2, "Expected number [, base]", 2 )
  elseif base < 2 or base > 36 then
    error( 2, "Base can only be >2 and <36", 2 )
  end
  if base == 10 then
    return tostring( num )
  elseif base == 8 then
    return string.format( "%o", tostring(n) )
  elseif base == 16 then
    return string.format( "%X", tostring(n) )
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
    error( 2, "Expected number [, base]", 2 )
  elseif base < 2 or base > 36 then
    error( 2, "Base can only be <= 10", 2 )
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
    error( 2, "Expected table, value" )
  end
  for i = 1, #checkIn do
    if checkIn[i] == checkFor then
      return i
    end
  end
  return false
end

function nearest( values, value )
  if type( values ) ~= "table" or type( value ) ~= "number" then
    error( 2, "Expected table, number" )
  end

  local index, difference
  for k, v in ipairs(values) do
    if not difference or (math.abs(value-v) < difference) then
      index, difference = k, math.abs(value-v)
    end
  end
  return index, values[index], difference
end


--    ███    ███ ██ ███████  ██████
--    ████  ████ ██ ██      ██
--    ██ ████ ██ ██ ███████ ██
--    ██  ██  ██ ██      ██ ██
--    ██      ██ ██ ███████  ██████


function compass()
  if not turtle then
    error( 2, "This function is only for turtles" )
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
