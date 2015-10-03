# DvgApps

## DvgFiles <sup><sub>`v1.0`</sub></sup>
For many programs I've made, you will need a DvgFiles installation. It comes with **one** invisible folder, you don't need to worry about many folders created. And, it gives all the apps that need it a place to put their own folder, all inside a single folder, `.DvgFiles`.

#### Installation
Pastebin: [`SKTUK0rb`](http://pastebin.com/SKTUK0rb)

Before you start, make sure the [`http`](http://www.computercraft.info/wiki/HTTP_(API)) api is enabled.
Then, type in the console:

    > pastebin run SKTUK0rb

#### Contents
The folder structure is as follows:

```
.DvgFiles / data / Dvg /
          / APIs / dvg
                   ti
                   dvgapps
          / boot / BIOS
                   config.cfg
```


## Read global <sup><sub>`v1.0`</sub></sup>
Read is a global program, that means you can access it from anyehere on your computer, like `edit`, `ls`, `mv` and `cp`.
It lets you read a file. Just read. No editing and such.

And as a nice ~~little~~ addition, if you have an advanced computer, you can make readme files with color markup!

#### Usage
To use normal read mode, type anywhere in the console:

    > read <file>

To use markup read mode, type:

    > read <file> markup

#### Installation
Pastebin: [`bw8EKigW`](http://pastebin.com/bw8EKigW)
