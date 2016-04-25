--[[

      Dvg Updater for DvgFiles v2
      by DvgCraft

      VERSION  1.0
      DATE     25-04-16

]]--

-- Variables
local arg = {...}

local loc = {
  dvg     = { repo = "DvgApps", path = "DvgAPI/dvg.lua"         },
  dvgapps = { repo = "DvgApps", path = "dvgappsAPI/dvgapps.lua" },
  ti      = { repo = "DvgApps", path = "ti-API/ti.lua"          },
  rw      = { repo = "RedWeb",  path = "API.lua"                },
}
local ghString = "https://raw.githubusercontent.com/Dantevg/{repo}/master/{path}"

local content = ""

-- Functions
function getFile( name )
  if not loc[name] then
    printError( "API "..name.." does not exist in database." )
    for k in ipairs( loc ) do printError( " - "..k ) end
    return
  end
  write( "Downloading file... " )
  local response = http.get( string.gsub( ghString, "{(%w+)}", function(k) return loc[name][k] end ) )
  if not response then error( "Could not connect to Github" ) end
  content = response.readAll()
end

-- Run
if arg[1] then -- Update API
  getFile( arg[1] )
  if content == nil or content == "" then error( "Empty file" ) end
  write( "Saving... " )
  local file = fs.open( "/.DvgFiles/APIs/"..arg[1], "w" )
  file.write( content )
  file.close()
  print( "Done." )
else
  error( "Usage: update <API>" )
end
