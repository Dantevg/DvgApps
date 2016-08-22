## [Version 2.20.1](https://github.com/Dantevg/DvgApps/commit/6c640adbab57a41f71f4844bed54c821f8b6719a)
### Changelog
- Added table `color` with color converting and manipulating functions:
  - `color.complementary`: `table` with all complementary colors.
  - `color.nearest()`: returns the nearest CC color in HSL. <br><br>
  - `color.colorToHex`: `table` with all HEX values for all CC colors.
  - `color.hexToColor`: `table` with CC color values for HEX values. <br><br>
  - `color.colorToRgb()`: converts a CC color value to RGB.
  - `color.rgbToColor()`: converts RGB to CC color value. <br><br>
  - `color.hexToRgb()`: converts HEX to RGB.
  - `color.rgbToHex()`: converts RGB to HEX. <br><br>
  - `color.rgbToHsl()`: converts RGB to HSL.
  - `color.hslToRgb()`: converts HSL to RGB. <br><br>
- Moved `colorToName()` and `nameToColor()` functions to `color` table.  
- Added function `nearest( values, value )`. Finds the nearest `value` of all number values in `values`.
- Function `writeFile()` now also accepts tables to be serialized as input.
- Bugfix: function `decToBase()` now returns a proper error when given a base value <2 or >36.
- Bugfix: function `decToBase()` now works with base 8 andd 16 numbers.
- Less errors
- Errors now show your program's line instead of the line in the API (e.g. [Line 286](https://github.com/Dantevg/DvgApps/commit/6c640adbab57a41f71f4844bed54c821f8b6719a#diff-58eb946d2b84534e0a342b7e3bc665a6R286))
- Added section markers inside code

<br>

## [Version 2.17](https://github.com/Dantevg/DvgApps/commit/81614d899c2f45551166ae101ed2da755dbaad4b)
### Changelog
- Added fucntion `sub( txt, pos )`. Returns the char at `pos` of `txt`.
- Added function `readFile( path, tbl )`. Returns the contents of the file at `path`, unserialized if `tbl` is true.
- Added function `writeFile( path, contents [, mode] )`. Opens the file at `path` in `mode` mode, and writes `contents`.
- Bugfix: function `isBool()` now returnt `true` even if the value is `false`. (used to be `false` at `false`)

<br>

## [Version 2.16](https://github.com/Dantevg/DvgApps/commit/6f46c81a7615f9d126404434c7fff7366cb1e6dd)
### Changelog
- Improved `center()` function
- Turn back `box()` function, wrong usage of metatables
- Improved `checkUpdate()` function
- Added `decToBase()` and `baseToDec()` functions

<br>

## Version 2.15.3
### Changelog
- Bugfix: Function `openRednet()` now works with broadcasting.

## Version ~~2.15.2~~ 2.15.2.2
### Changelog
- **2.15.2**: Function `read()` now returns a table with the parameters as a fourth value.
- **2.15.2.2**: Bugfix: function `read()` now returns the event as value 4 and the parameters in a table as value 5

## Version 2.15.1
### Changelog
- Function `read()` does now return `false` instead of `nil`.

## Version 2.15
### Changelog
- Added function: `read()`. Lets you get the input of an user. Like the standard `read()`, but more advanced.

<br>

## Version 2.14
### Changelog
- Added function: `openRednet()`. Opens all wireless modems it finds.

### Known bugs
- Function `openRednet()` does not work with broadcasting. Fixed in [version 2.15.3](#version-2153)

<br>

## Version 2.13
### Changelog
- Added markers for deprecated functions
- Updated function switchBool. It is more effective and shorter now: from 5 to 1 lines
- Function switchBool is now deprecated. It will still be usable in future releases, but will be removed some time. Instead, use the single line of code also used in the function: `bool = not bool` ([Line 234](https://github.com/Dantevg/DvgApps/blob/bcc30b0d51d3b84550d9df2316ea3524b5430115/DvgAPI/dvg.lua#L234))

<br>

## Version 2.12
### Changelog
- Added function: `compareVersions( v1, v2 )`. It checks if `v1 > v2`

<br>

## Version 2.11
### Changelog
- Added function: `fill`. Fills a string to given length with (optional) given character.
- Renamed tables: `toName` and `toColor` to `colorToName` and `nameToColor`. Old names are still usable.

<br>

## Version 2.10
### Changelog
- Changed `box` function. New usage:

  ```lua
  myBox = dvg.box:new( x,y,w,h, bgcolor )
  myBox:draw()
  ```

- New `version` variable, which contains the version number

<br>

## Version 2.9.2
### Changelog
- Function `centerColor` now accepts an optional, third argument, `y`, like the original function.

## Version 2.9.1
### Changelog
- Fixed leftover from old code

## Version 2.9 unstable
### Changelog
- Added functions: `setTextColor` and `setBackgroundColor`
- Cleaned code

### Known bugs
- Does not work at all

**This version is highly unstable and does *not* work!** Instead, use version 2.9.1

<br>

## Version 2.8.4
### Changelog
- Added function: checkupdate
- Changed `isBool` and `toBool` functions

<br>

## Version 2.7
### Changelog
- Added function: `printColor`. Sets the color and prints a line.

<br>

## Version 2.6
### Changelog
- Added function: `box`. Draws a box.
- Changed function: `bg`. Made it more efficient.
- Added turtle detection in turtle-only functions

<br>

## Version 2.4
### Changelog
- Added table: `toName`. Converts color values into string names
- Added table: `toColor`. Converts string names into color values

<br>

## Version 2.2
### Changelog
- Added function: `scroll`

<br>

## Version 2.1.5
### Changelog
- Added function: `switchBool`
- Cleaned up code a bit

<br>

## Version 2.0
Initial official version
