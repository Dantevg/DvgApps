--[[

      Dvg API
      by DvgCraft

      VERSION 2.15
      DATE    05-04-2016
      GITHUB  github.com/Dantevg/DvgApps (/tree/master/DvgAPI)

]]--

version = "2.15"


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
  term.setCursorPos( x, y and y or curY )
  write( text )
  term.setCursorPos( curX,curY )
end

function fill( text, to, char )
  if type( text ) ~= "string" or type( to ) ~= "number" then
    error( "Expected string, number" )
  end
  if char and type( char ) ~= "string" then
    error( "Expected string, number [,string]" )
  end
  while #text <= to do
    if char then
      text = text..char
    else
      text = text.." "
    end
  end
  return text
end

box = {}
function box.new( self, x,y,w,h, bgcolor )
  if not tonumber(x) or not tonumber(y) or not tonumber(w) or not tonumber(h) or not tonumber(bgcolor) then
    error( "Expected x, y, width, height, bgcolor" )
  end
  return setmetatable( {x=x, y=y, w=w, h=h, bgcolor=bgcolor}, {__index = box} )
end
function box:draw()
  term.setBackgroundColor( self.bgcolor )
  for i = 1, self.h do
    term.setCursorPos( self.x, self.y-1+i )
    write( string.rep(" ", self.w) )
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
        return input, false, false
      else
        if p[1] == keys.backspace then
          return input:sub( 1,-2 ), false, true
        elseif p[1] == keys.enter then
          return input, true, false
        end
      end -- End if exitEvent

    elseif event == "char" then

      if exitEvent == "char" then
        if not exitParam or p[exitParam] == exitVal then return input, false, false end
      else
        return input..p[1], false, true
      end

    elseif event == exitEvent then

      if not exitParam or p[exitParam] == exitVal then return input, false, false end

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
        if current == version then
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
  if txt then
    if var == true or var == "true" then
      return true
    elseif var == false or var == "false" then
      return false
    end
  else
    if var == true or var == false then
      return true
    end
  end
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
