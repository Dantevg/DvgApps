--[[
      
      General shortcut for DvgFiles v2
      by DvgCraft
      
]]--

local path = string.lower( shell.getRunningProgram() )

for cProg in string.gmatch( path, "(%l+)" ) do
  print( cProg )
  shell.run( "/.DvgFiles/data/"..cProg.."/"..cProg )
end
