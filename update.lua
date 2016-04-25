local arg = {...}

if not arg[1] then error( "Usage: update <API>" ) end
if not http then error( "Http API must be enabled" ) end

write( "Downloading updater... " )
local response = http.get( "https://raw.githubusercontent.com/Dantevg/DvgApps/master/updater.lua" )
if not response then error( "Could not connect to Github" ) end
loadstring( response.readAll() )( arg[1] )
