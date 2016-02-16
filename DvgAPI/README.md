# Dvg API <sup><sub>`v2.10`</sub></sup>
### Installation
This API will automatically be installed together with `.DvgFiles`.

### Documentation
#### `dvg.bg( color )`
Creates a background with `color`.

#### `dvg.printColor( color, string )`
Prints a `string` with given `color`.

#### `dvg.box:new( x, y, w, h, bgcolor )`
Returns a table with given box properties, to be drawn later with `myBox:draw()`. Note the use of a colon instead of a dot. You can edit the given values in the table returned. Ex: `myBox.x = 30`.

#### `box:draw()`
Draws a box on given coordinates (`x` and `y`) with the given size (`w` and `h`) and sets the given `bgcolor`. To use, replace `box` with the variable you stored `box:new()`'s returned values. Note the use of a colon instead of a dot.

#### `dvg.checkupdate( url [, current] )`
Checks if there is an update available on the `url` given.  
If `current` is defined, it will return `true` or `false`, meaning there is an update avaliable (`true`) or not (`false`).  
If `current` is omitted, it will return the latest version (the contents of the url).

#### `dvg.toBool( var )` and `dvg.toInt( var )`
Converts the `var` to a boolean or a number (`0` or `1`).
They both accept a boolean (`true` or `false`), boolean string (`"true"` or `"false"`), number (`0` or `1`) and number string (`"0"` or `"1"`) as an input.

#### `dvg.isSide( side )`
Checks wether the string is a side.

#### `dvg.isBool( var, txt )`
Returns `true` if the `val` given is a boolean. If `txt` is given and `true`, a boolean string (`"true"` or `"false"`) will also return `true`.

#### `dvg.isInt( num )`
Checks wether the value given is a whole number (`46` and `1180` till return `true`, `1.5` and `673.139` will return false).
