# DvgApps

### Contents
* [DvgFiles](#dvgfiles)
* [Read global](#read-global)
* [Archive](#archive)

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

<br>
<hr>
<br>

## Read global <sup><sub>`v1.0`</sub></sup>
Read is a global program, that means you can access it from anyehere on your computer, like `edit`, `ls`, `mv` and `cp`.
It lets you read a file. Just read. No editing and such.

And as a nice ~~little~~ addition, if you have an advanced computer, you can make readme files with color markup!

#### Usage
To use normal read mode, type anywhere in the console:

    > read <file>

To use markup read mode, type:

    > read <file> markup

The format of a marked up file is as follows. In this version, no spaces are allowed between the color and the `:`. This will be added in the future.

    color:string

#### Installation
1. Download the file and place it in the following folder: `.DvgFiles/programs`. Pastebin: [`bw8EKigW`](http://pastebin.com/bw8EKigW).
2. Every time you startup the computer, this program will become global.

<br>
<hr>
<br>

## Archive <sup><sub>`v2.1`</sub></sup>
With archive, you can put all your files and folders (inside folders inside folders...) in one singe file. It works a bit like winrar of 7zip. This is very useful for downloading and installing many files and folders, so you only need to download **one single file!**

#### Usage
To pack a folder, type in the console:

    > archive pack <path to folder> <path to file>

To unpack, just change `pack` to `unpack`.
The `path to folder` is the folder with your files, and the `path to file` is the archive file.

For unpacking, only the archive file has to exist and for packing, only the folder has to exist. The rest doesn't **have** to exist, but it may exist.

Archive is also able to add files to an archive, without unpacking and re-packing. The syntax for this function is:

    > archive add <path to archive> [folder in archive] <path to file>

Here, path to file means the path to the file to add.

#### Examples
This is the folder `afolder`:

    file1
    file2
    folder1:    fldfile1
                fldfile2
                fldfld:     fldfldfile

To make an archive of it and create the file `thefile`, we type:

    > archive pack afolder thefile

To unpack it in the folder `blah`, we type:

    > archive unpack blah thefile

To add the file `foo` to the folder `folder1/fldfld` inside `thefile`, we type:

    > archive add thefile folder1/fldfld foo


#### Installation
*Coming soon...*
