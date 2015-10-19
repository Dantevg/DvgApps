# Dvgapps API <sup><sub>`v1.0`</sub></sup>
### Installation
*Release version coming soon...*

### Documentation
#### `dvgapps.header( text, opt )`
Creates a header with a title `text` and options `opt`.
You don't have to set all options. The table `opt` has the following options:
```lua
{
  bgcolor = colors.blue,  -- color value for the background color
  txtcolor = colors.white,-- color value for the text color
  size = 1,               -- number (1 or 3) for the height of the header
  action = "exit",        -- string for the action icon;
}
```
The exit action accepts 3 inputs:
- "back"  for `<`,
- "empty" for (wait, do I have to explain this?),
- "exit"  for `x`, this is the standard setting.

#### `dvgapps.checkupdate( url [, current] )`
Checks if there is an update available on the `url` given.  
If `current` is defined, it will return `true` or `false`, meaning there is an update avaliable (`true`) or not (`false`).  
If `current` is omitted, it will return the latest version (the contents of the url).

#### `cfg.loadFile( path )`
Returns a prepared table from `path` for use with other `cfg.x()` functions.

#### `cfg.saveFile( menu, path )`
Saves a menu table to `path` and removes fields that were added by `cfg.loadFile()` for internal use.

#### `cfg.printMenu( menu )`
Prints the `menu`. Nothing special. Example output:

      Switch me!                    xx-
    > Me too!                       -oo
      I contain text, look:         here it is!

#### `cfg.keyPressed( menu, key )`
Handles the `os.pullEvent()` output when pressed on a key.

#### `cfg.action( menu )`
Does something when pressed on the enter key.

#### `cfg.doMenu( menu )`
Basically this is the only function you will need if you are just going to create a menu. `menu` can be a string or a table.  
If `menu` is a table, it assumes that you already have loaded a file with `cfg.loadFile()`.  
If it is a string, it assumes that you have given it a path and it will load that path itself.
