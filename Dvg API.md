# Dvg API <sup><sub>`v2.8.3`</sub></sup>
### Installation
This API will automatically be installed together with `.DvgFiles`.

### Documentation
#### `dvgapps.checkupdate( url [, current] )`
Checks if there is an update available on the `url` given.  
If `current` is defined, it will return `true` or `false`, meaning there is an update avaliable (`true`) or not (`false`).  
If `current` is omitted, it will return the latest version (the contents of the url).
