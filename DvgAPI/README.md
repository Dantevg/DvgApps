# Dvg API <sup><sub>`v2.12`</sub></sup>
### Installation
This API will automatically be installed together with `.DvgFiles`.

### Documentation
#### `dvg.sides`
Table with all sides of the computer `{ "right", "left", "top", "bottom", "back", "front" }`.

#### `dvg.colorToName` and `dvg.nameToColor`
Tables with color values and names (like in `colors.*`, the `*` replaces the name in these tables).

#### `dvg.setTextColor, setBackgroundcolor( color )`
These just set the background/text color, but they also return the API, for further use, like:
```lua
dvg.setTextColor( colors.black ).setBackgroundColor( colors.white ).center( "Blah" )
```

#### `dvg.bg( color )`
Creates a background with `color`.

#### `dvg.printColor, writeColor( string, color )` and `dvg.centerColor( string, color [, y] )`
Prints, writes or centers a `string` with given `color`. `centerColor` also accepts a third, optional parameter `y`, like in the original function.

#### `dvg.printPos, writePos( string, x, y )`
Prints or writes `string` at given positions.

#### `dvg.center( text [, y] )`
Centers given `text` horizontally. If `y` is given, centers at given `y`, else centers at current position.

#### `dvg.fill( text, to [, char] )`
Fills `text` length to `to`, with spaces or `char`.

#### `dvg.box:new( x, y, w, h, bgcolor )`
Returns a table with given box properties, to be drawn later with `myBox:draw()`. Note the use of a colon instead of a dot. You can edit the given values in the table returned. Ex: `myBox.x = 30`.

#### `box:draw()`
Draws a box on given coordinates (`x` and `y`) with the given size (`w` and `h`) and sets the given `bgcolor`. To use, replace `box` with the variable you stored `box:new()`'s returned values. Note the use of a colon instead of a dot.

#### `dvg.scroll( text, height, offset )`
Retorns table `text` with stripped ends, so it fits in the `height`. `Offset` specifies the height already scrolled.

#### `dvg.checkupdate( url [, current] )`
Checks if there is an update available on the `url` given.  
If `current` is defined, it will return `true` or `false`, meaning there is an update avaliable (`true`) or not (`false`).  
If `current` is omitted, it will return the latest version (the contents of the url).

#### `dvg.compareVersions( v1, v2 )` <sup><sub>`2.12`</sub></sup>
Compares the two versions given. It checks if `v1 > v2`.  
Returns `true` or `false` wether the comparison stated succeeded. Also returns the number of comparisons needed:
```lua
dvg.compareVersions( "1.0.32", "1.2.8" ) -- False, 2
dvg.compareVersions( "2.7.1", "2.7" )    -- True, 3
```

#### `dvg.toBool( var )` and `dvg.toInt( var )`
Converts the `var` to a boolean or a number (`0` or `1`).
They both accept a boolean (`true` or `false`), boolean string (`"true"` or `"false"`), number (`0` or `1`) and number string (`"0"` or `"1"`) as an input.

#### `dvg.isSide( side )`
Checks wether the string is a side.

#### `dvg.isBool( var, txt )`
Returns `true` if the `val` given is a boolean. If `txt` is given and `true`, a boolean string (`"true"` or `"false"`) will also return `true`.

#### `dvg.isInt( num )`
Checks wether the value given is a whole number (`46` and `1180` till return `true`, `1.5` and `673.139` will return false).

#### `dvg.switchBool( bool )`
Switches `bool`. If `bool == true`, returns `false`. If `bool == false`, returns `true`.

#### `dvg.inAny( checkIn, checkFor )`
Checks if `checkFor` exists as value in `checkIn`. Returns the number of `checkIn` inside `checkFor`.

#### `dvg.compass()`
**Turtle function** Returns the direction the turtle is facing. (north, east, south, west).
