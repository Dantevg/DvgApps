--[[

      Dvg Apps framework
      by DvgCraft

      VERSION  0.9.17.20
      DATE     26-02-2016

]]--

version = "0.9.17.20"

-- Start config
--[[ Docs for cfg.x() config file
  config file (table) format:
  {
    ["exit"] = {
      type = "exit",
      name = "Exit",
      val = true, -- True for save before exit, false for not save.
    },
    ["sometext"] = {
      type = "text",
      name = "Some text",
      val = "your text",
    },
    ["aBoolean"] = {
      type = "boolean", -- "bool" is also accepted
      name = "A boolean",
      val = true,
    },
    ["helloFunction"] = {
      type = "function",
      name = "Do this",
      val = "print('Hello there!'); os.sleep(1)",
    },
    ["hidden"] = {
      type = "hidden", -- Will be ignored by cfg.printMenu, no name field required
      val = "Random hidden field", -- Can be any type
    }
  }
]]--

cfg = {}

function cfg.loadFile( path ) -- v1.0
  if not fs.exists( path ) then
    error( "File does not exist" )
  end

  local file = fs.open( path, "r" )
  local tStart = textutils.unserialize( file.readAll() )
  file.close()

  if not tStart then
    error( "File does not contain correct table" )
  end

  local t = {}
  local i = 1
  for var, val in pairs( tStart ) do
    t[i] = val
    t[i].key = var
    i = i+1
  end


  t.s = 1
  t.running = true
  t.path = path
  return t
end
function cfg.saveFile( menu, path ) -- v1.0
  if not fs.exists( path ) then
    error( "Path does not exist" )
  end
  if type( menu ) ~= "table" then
    error( "Expected table, string" )
  end

  menu.s = nil
  menu.running = nil
  menu.path = nil
  local t = {}

  for i = 1, #menu do
    t[ menu[i].key ] = menu[i]
    t[ menu[i].key ].key = nil
  end

  local file = fs.open( path, "w" )
  file.write( textutils.serialize( t ) )
  file.close()
end

function cfg.printMenu( menu, headeropt ) -- v1.0
  if (type( menu ) ~= "table") or (headeropt and type( headeropt ) ~= "table") then
    error( "Expected table [, table]" )
  end

  term.setCursorPos( 1,3 )
  for i = 1, #menu do
    term.setBackgroundColor( colors.white )
    term.setTextColor( colors.black )
    local _, y = term.getCursorPos()

    if i == 1 and headeropt then
      term.setBackgroundColor( headeropt.bgcolor and headeropt.bgcolor or colors.blue )
      term.setTextColor( headeropt.txtcolor and headeropt.txtcolor or colors.white )
      if headeropt.size == 5 or headeropt.size == 3 then
        term.setCursorPos( 1,2 )
      else
        term.setCursorPos( 1,1 )
      end
      if i == menu.s then
        write( "> ", headeropt.action and headeropt.action or "x" )
      else
        write( "  ", headeropt.action and headeropt.action or "x" )
      end
      if headeropt.size == 5 then
        term.setCursorPos( 1,6 )
      elseif headeropt.size == 3 then
        term.setCursorPos( 1,4 )
      else
        term.setCursorPos( 1,2 )
      end
    else
      if i == menu.s then
        write( "> "..menu[i].name )
      else
        write( "  "..menu[i].name )
      end
      term.setCursorPos( 40,y )

      if menu[i].type == "text" then
        write( menu[i].val )

      elseif menu[i].type == "boolean" or menu[i].type == "bool" then
        term.setBackgroundColor( colors.lightGray )
        write( "   " )
        if menu[i].val == true then
          term.setCursorPos( 41,y )
          term.setBackgroundColor( colors.green )
          write( "  " )
        elseif menu[i].val == false then
          term.setCursorPos( 40,y )
          term.setBackgroundColor( colors.red )
          write( "  " )
        end
      end --End type if
    end --End header if
    print()
  end --End for loop
end

function cfg.keyPressed( menu, key, headeropt ) -- v1.0
  if type( key ) ~= "number" or type( menu ) ~= "table" then
    error( "Expected table, number" )
  end

  if key == keys.up and menu.s > 1 then
    menu.s = menu.s - 1
  elseif key == keys.down and menu.s < #menu then
    menu.s = menu.s + 1
  elseif key == keys.enter then
    cfg.action( menu, headeropt )
  end

  return menu
end

function cfg.action( menu, headeropt ) -- v1.0
  if menu[menu.s].type == "exit" then
    if menu[menu.s].val then
      cfg.saveFile( menu, menu.path )
    end
    menu.running = false

  elseif menu[menu.s].type == "text" then
    local yPos = 1 + menu.s
    if headeropt.size == 5 then
      yPos = 5 + menu.s
    elseif headeropt.size == 3 then
      yPos = 3 + menu.s
    end
    term.setCursorPos( 40,yPos )
    term.setTextColor( colors.lightGray )
    write( menu[menu.s].val )
    term.setCursorPos( 40,yPos)
    term.setTextColor( colors.black )
    menu[menu.s].val = read()

  elseif menu[menu.s].type == "boolean" then
    menu[menu.s].val = dvg.switchBool( menu[menu.s].val )

  elseif menu[menu.s].type == "function" then
    loadstring( menu[menu.s].val )()

  end
end

function cfg.doMenu( menu ) -- v1.0
  if type( menu ) == "string" then
    menu = cfg.loadFile( menu )
  end
  while menu.running do
    cfg.printMenu( menu )
    local event, key = os.pullEvent( "key" )
    menu = cfg.keyPressed( menu, key )
  end
end

-- End config

--[[ Docs for header( text, opt )
  opt options: (you don't have to declare them all)
  {
    [name] = [standard setting]
    bgcolor = colors.blue,      -- the background color
    txtcolor = colors.white,    -- the text color
    size = 1,                   -- the header height, 1, 3 or 5 (for many btns)
    action = "x"                -- the action icon, "<", "x" or " " (space)
    btns = {
      top = {}                  -- table with optional button names, number for space
      bottom = {}               -- same as above, but underneath the title. Only for size = 5
      bgcolor = colors.lightBlue-- the background color for the buttons
      txtcolor = colors.white   -- the text color for the buttons
    }
  }

  Returns: if buttons specified, a table with starting and ending position of each button, else nil
]]--

function header( text, opt ) -- v1.0
  if type( text ) ~= "string" or type( opt ) ~= "table" then
    error( "Expected string, table" )
  end

  local w = term.getSize()
  term.setCursorPos( 1,1 )
  term.setBackgroundColor( opt.bgcolor and opt.bgcolor or colors.blue )
  term.setTextColor( opt.txtcolor and opt.txtcolor or colors.white )

  if not opt.size then opt.size = 1 end
  for i = 1, opt.size do
    print( string.rep(" ",w) )
  end
  if opt.size == 1 then
    term.setCursorPos( 1,1 )
  else
    term.setCursorPos( 1,2 )
  end
  if opt.action then
    write( "  "..opt.action.." "..text )
  else
    write( "  x "..text )
  end

  if opt.btns then
    local btnsPos = { top = {}, bottom = {} }
    term.setBackgroundColor( opt.btns.bgcolor and opt.btns.bgcolor or colors.lightBlue )
    term.setTextColor( opt.btns.txtcolor and opt.btns.txtcolor or colors.white )

    local function printBtns( place )
      local pos = w + 1
      if place == "bottom" then pos = 2 end
      for i = 1, #opt.btns[place] do
        if type( opt.btns[place][i] ) ~= "number" then
          if place ~= "bottom" then
            pos = pos - #opt.btns[place][i] - 3
          end
          if opt.size == 1 then
            term.setCursorPos( pos, 1 )
          elseif place == "top" then
            term.setCursorPos( pos, 2 )
          elseif place == "bottom" then
            term.setCursorPos( pos, 4 )
          end
          write( " "..opt.btns[place][i].." " )
          btnsPos[place][i] = {}
          btnsPos[place][i].s, btnsPos[place][i].e = pos, pos + #opt.btns[place][i] + 2
          if place == "bottom" then
            pos = pos + #opt.btns[place][i] + 3
          end
        else
          if place == "bottom" then
            pos = pos + opt.btns[place][i] - 1
          else
            pos = pos - opt.btns[place][i] + 1
          end
        end -- End if type
      end -- End for loop
    end -- End function
    local function turn()
      local t = opt.btns.top
      for i = 1, #t do
        opt.btns.top[ #t-i+1 ] = t[i]
      end
    end

    if opt.btns.top then turn() printBtns( "top" ) end
    if opt.size == 5 and opt.btns.bottom then printBtns( "bottom" ) end

    return btnsPos
  end -- End if opt.btns
end
