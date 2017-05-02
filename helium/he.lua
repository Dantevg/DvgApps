--[[

      Helium (He) framework
      by DvgCraft

      DATE  02-05-2016

]]--

-- Initialize API
he = {}

he.version = "0.9"
he.path = ".DvgFiles/data/helium" 		 						-- Path to load modules

-- Register app
function new()
	local app = { modules = {} } 				 						-- Init app
	-- Loop through module files in folder and load them
  for _, name in ipairs( fs.list(path) ) do
    local file = fs.open( path.."/"..name, "r" )
    app.modules[name] = load( "return "..file.readAll() )()
    file.close()
  end
  return setmetatable( app, {__index = he} )			-- Return app and prototype
end

-- App functions
function he:add( object, data )
	table.insert( self, 1, self.modules[object]:add(data) )
	self[1].parent = self 					 							 	-- Add parent reference
	return setmetatable( self[1], {__index = self} )
end

function he:draw()
	-- Backwards loop through objects (for draw order)
	for i = #self, 1, -1 do
		self[i]:draw()
	end
end

function he:event( event, p1, p2, p3, p4, p5 )
	for i = 1, #self do
		if type( self[i].on[event] ) == "function" then self[i].on[event]( p1, p2, p3, p4, p5 ) end
	end
end

function he:shift(n)
	-- Get current pos inside parent
	local current;
	local pos;
	for i = 1, #self.parent do
		if self.parent[i] == self then current = i
	end
	
	-- Calculate new pos inside parent
	if n == true then pos = 1												-- To top
	elseif n == false then pos = #self.parent				-- To bottom
	elseif n == nil then pos = current-1						-- Up one level (standard)
	else pos = current-n														-- Up/down specified # of levels
	end
	
	-- Shift
	table.insert(self.parent, pos, table.remove(self.parent,current))
end
