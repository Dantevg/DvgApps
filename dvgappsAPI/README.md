# Dvgapps API <sup><sub>`v0.9.18`</sub></sup>
### Installation
*Release version coming soon...*

### Documentation
#### `dvgapps.header( text, opt )`
Creates a header with a title `text` and options `opt`.
You don't have to set all options. The table `opt` has the following options:
```lua
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
```
Returns: if buttons specified, table with starting and ending position of each button, else nil.

#### `dvgapps.cfg.loadFile( path )`
Returns a prepared table from `path` for use with other `cfg` functions. After the file is loaded, you can set `menu.valPos` (number x-position of values, default `40`) and `menu.indicator` (boolean `>` indicator, default `true`).  
The table file is constructed so that you can open the file with your own program easily. Table file contents:
```lua
{
  ["exit"] = {
      type = "exit",
      name = "Exit", -- Not required here
      val = true, -- True for save before exit, false for not save.
    },
    ["sometext"] = {
      type = "text",
      name = "Some text",
      description = "E.g. Hello World!", -- Not required
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
      val = "print('Hello there!'); os.sleep(1)", -- Notice this is a string
    },
    ["hidden"] = {
      type = "hidden", -- Will be ignored by cfg.printMenu, no name field required
      val = "Random hidden field", -- Can be any type
    }
}
```

#### `dvgapps.cfg.saveFile( menu, path )`
Saves a menu table to `path` and removes fields that were added by `cfg.loadFile()` for internal use.

#### `dvgapps.cfg.printMenu( menu [, headeropt] )`
Prints the `menu`. Nothing special. Example output:

      Switch me!                    xx-
    > Me too!                       -oo
      I contain text, look:         here it is!

#### `dvgapps.cfg.keyPressed( menu, key [, headeropt] )`
Handles the `os.pullEvent()` output when pressed on a key.

#### `dvgapps.dvg.mouseClicked( menu, x, y [, headeropt] )`

#### `dvgapps.cfg.action( menu [, headeropt] )`
Does something when pressed on the enter key.

#### `dvgapps.cfg.doMenu( menu )`
Basically this is the only function you will need if you are just going to create a menu. `menu` can be a string or a table.
* If `menu` is a table, it assumes that you already have loaded a file with `cfg.loadFile()`.  
* If it is a string, it assumes that you have given it a path and it will load that path itself.
