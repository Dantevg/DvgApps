--[[

      ti API
      by DvgCraft

      Requirements:
      - Advanced computer

      VERSION 1.2
      DATE    XX-08-2015

]]--

--[[ txtimg.loadImg( string path,  num x,  num y )

     Draws an image to given coordinates, works the
     same as paintutils.

     File extension: .ti or .txtimg.
     - First page: background colors.
     - Second page: text.
     Page is the part before and after the ~.
--]]

-- Variables
local bg = {}
local txt = {}

local colors = {
  ["0"] = colors.white,
  ["1"] = colors.orange,
  ["2"] = colors.magenta,
  ["3"] = colors.lightBlue,
  ["4"] = colors.yellow,
  ["5"] = colors.lime,
  ["6"] = colors.pink,
  ["7"] = colors.gray,
  ["8"] = colors.lightGray,
  ["9"] = colors.cyan,
  ["a"] = colors.purple,
  ["b"] = colors.blue,
  ["c"] = colors.brown,
  ["d"] = colors.green,
  ["e"] = colors.red,
  ["f"] = colors.black,
}

-- Functions
function fill(txt, till)
  if not txt then
    return txt
  end
  if till <= #txt then
    return txt
  end
  for i = 1, till - #txt do
    txt = txt.." "
  end
  return txt
end

function drawImg(path, xPos, yPos)
  if type(path) ~= "string" then --Check path
    error("Expected path", 2)
  end

  if fs.exists(path) then --File exists
    local file = fs.open(path, "r")

    line = file.readLine() --Background colors
    while line ~= "~" and line ~= nil do
      table.insert( bg, line )
      line = file.readLine()
    end

    line = file.readLine() --Text
    while line ~= nil do
      table.insert( txt, line )
      line = file.readLine()
    end

    file.close()

    term.setCursorPos(xPos, yPos)
    for y = 1, math.max(#bg, #txt) do
      txt[y] = fill(txt[y], #bg[y])

      if txt[y] ~= nil and bg[y] ~= nil then
        maxlen = math.max( string.len(bg[y]), string.len(txt[y]) )
      elseif txt[y] == nil and bg[y] ~= nil then
        maxlen = #bg[y]
      elseif bg[y] == nil and txt[y] ~= nil then
        maxlen = #txt[y]
      else
        maxlen = 0
      end

      for x = 1, maxlen do
        term.setBackgroundColor( colors[string.sub(bg[y],x,x)] or 32768)
        if txt[y] == nil then
          write(" ")
        else
          write( string.sub(txt[y],x,x) )
        end
      end

      local _, cY = term.getCursorPos()
      term.setCursorPos( xPos, cY+1 )
    end
    bg = nil
    txt = nil
    bg = {}
    txt = {}
  end
  return nil
end
