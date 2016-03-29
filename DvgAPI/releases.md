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

<br>

## Version 2.9.1
### Changelog
- Fixed leftover from old code

<br>

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

## Versio 2.0
Initial official version
