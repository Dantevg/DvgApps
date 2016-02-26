# Dvgapps API <sup><sub>`v0.9.17.10`</sub></sup>
### Installation
*Release version coming soon...*

### Documentation
#### `dvgapps.header( text, opt )`
Creates a header with a title `text` and options `opt`.
You don't have to set all options. The table `opt` has the following options:
```lua
{
  bgcolor = colors.blue,     -- color value for the background color
  txtcolor = colors.white,   -- color value for the text color
  size = 1,                  -- number (1 or 3) for the height of the header
  action = "x",              -- string for the action icon; ("x", "<" or " ")
  btncolor = colors.lightBlue-- the background color for the buttons
  btntxtcolor = colors.white -- the text color for the buttons
  btns = {
    top = {}                 -- table with optional button names, number for space
    bottom = {}              -- same as above, but underneath the title. Only for size = 5
  }
}
```
Returns: if buttons specified, table with starting and ending position of each button, else [nil].

#### `dvgapps.cfg.loadFile( path )`
Returns a prepared table from `path` for use with other `cfg` functions.  
The table file is constructed so that you can open the file with your own program easily. Table file contents:
```lua
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
```

#### `dvgapps.cfg.saveFile( menu, path )`
Saves a menu table to `path` and removes fields that were added by `cfg.loadFile()` for internal use.

#### `dvgapps.cfg.printMenu( menu )`
Prints the `menu`. Nothing special. Example output:

      Switch me!                    xx-
    > Me too!                       -oo
      I contain text, look:         here it is!

#### `dvgapps.cfg.keyPressed( menu, key )`
Handles the `os.pullEvent()` output when pressed on a key.

#### `dvgapps.cfg.action( menu )`
Does something when pressed on the enter key.

#### `dvgapps.cfg.doMenu( menu )`
Basically this is the only function you will need if you are just going to create a menu. `menu` can be a string or a table.
* If `menu` is a table, it assumes that you already have loaded a file with `cfg.loadFile()`.  
* If it is a string, it assumes that you have given it a path and it will load that path itself.

[nil]: http://www.computercraft.info/wiki/Nil_(type)
[string]: http://www.computercraft.info/wiki/String_(type)
[table]: http://www.computercraft.info/wiki/Table_(type)
