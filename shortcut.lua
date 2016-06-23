--[[
      
      General shortcut for DvgFiles v2
      by DvgCraft
      
]]--

local prog = fs.getName( string.lower(shell.getRunningProgram()) )
shell.run( "/.DvgFiles/data/"..prog.."/"..prog )
