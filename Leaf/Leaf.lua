--[[

      Executable Lua Archive File (.leaf)
      by DvgCraft

      DATE  02-02-2016

]]--

-- Variables
local version = "1.0"
local arg = {...}
local fileFunc = [[
local oldDir = shell.dir()
local function unpack()
  local path = shell.getRunningProgram()..".tmp"
  if fs.isDir( "/.DvgFiles" ) then path = "/.DvgFiles/TEMP/"..shell.getRunningProgram()..".tmp" end
  fs.makeDir( path )
  shell.setDir( path )
  for var, val in pairs( files ) do
    local file = fs.open( path.."/"..var, "w" )
    for i = 1, #val do
      file.writeLine( val[i] )
    end
    file.close()
  end
end
unpack()
if runPath and fs.exists( runPath ) then shell.run( runPath ) else shell.run( "run" ) end
shell.setDir( oldDir )
fs.delete( path )
]]

local log = false
local dirPath = ""
local runPath = ""
local filePath = ""
local oldDir = shell.dir()

local leafFile = {}

-- Functions
function printUsage()
  printError( "Usage:" )
  printError( "Leaf <path/to/folder> [main run path relative] <new file path> [-log]" )
  return
end

function readFolder( path ) --From archive v2.1.b.3
  folder = fs.list( dirPath.."/"..path )
  for _, name in ipairs( folder ) do
    folder = fs.list( dirPath.."/"..path )
    if fs.isDir( dirPath.."/"..path.."/"..name ) then
      readFolder( #path > 0 and path.."/"..name or name )
    else
      leafFile[ #path > 0 and path.."/"..name or name ] = {}
      local file = fs.open( dirPath.."/"..path.."/"..name, "r" )
      local line = file.readLine()
      while line do
        table.insert( leafFile[ #path > 0 and path.."/"..name or name ], line )
        line = file.readLine()
      end
      file.close()
      if log then
        write( "Read file: " )
        print( #path > 0 and path.."/"..name or name )
      end
    end
  end
end

function pack()
  assert( fs.isDir( dirPath ), "No such folder: "..dirPath ) --Main folder exists
  if #runPath > 0 then --Main run file exists and is not folder
    assert( fs.exists( dirPath.."/"..runPath ) and not fs.isDir( dirPath.."/"..runPath ), "No such file: "..dirPath.."/"..runPath )
  else
    runPath = "run"
  end

  if string.sub( filePath, -5 ) ~= ".leaf" then --Add extension
    filePath = filePath..".leaf"
  end

  shell.setDir( dirPath )
  folder = fs.list( dirPath )
  if #folder < 1 then
    error( "Empty project folder" )
  end

  readFolder( "" )
  shell.setDir( oldDir )
  local file = fs.open( filePath, "w" )
  file.writeLine( "local runPath = \""..runPath.."\"" )
  file.write( "local files = "..textutils.serialize( leafFile ) )
  file.writeLine()
  file.write( fileFunc )
  file.close()
end

-- Run
if #arg < 3 then
  printUsage()
else
  dirPath = arg[1]
  if arg[3] == "-log" or arg[4] == "-log" then -- arg "-log" given
    log = true
    if #arg >= 4 then -- arg "main run path" also given
      runPath = arg[2]
      filePath = arg[3]
    else
      filePath = arg[2]
    end
  end
  pack()
end
