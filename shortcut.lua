--[[
      
      General shortcut for DvgFiles v2
      by DvgCraft
      
]]--

local path = string.lower( shell.getRunningProgram() )

for prog in string.gmatch( path, "(%l+)" ) do
  shell.run( "/.DvgFiles/data/"..prog.."/"..prog )
end
