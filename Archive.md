# Archive
`version: 2.1 beta` &nbsp;&nbsp;
`pastebin: `[`coming...`](http://pastebin.com/coming00) &nbsp;&nbsp;
`date: 09-09-2015`

### Contents
* [Usage](#usage)
* [Examples](#examples)
* [Installation](#installation)

With archive, you can put all your files and folders (inside folders inside folders...) in one singe file. It works a bit like winrar of 7zip. This is very useful for downloading and installing many files and folders, so you only need to download **one single file!**

### Usage
To pack a folder, type in the console:

    > archive pack <path to folder> <path to file>

To unpack, just change `pack` to `unpack`.
The `path to folder` is the folder with your files, and the `path to file` is the archive file.  
For unpacking, only the archive file has to exist and for packing, only the folder has to exist. The rest doesn't **have** to exist, but it may exist.

Archive is also able to add files to an archive, without unpacking and re-packing. The syntax for this function is:

    > archive add <path to archive> [folder in archive] <path to file>

Here, path to file means the path to the file to add.

### Examples
This is the folder `program`:

    run
    src:        settings.cfg
                images:     icon
                            logo

To make an archive of it and create the file `download`, we type:

    > archive pack program download

To unpack it in the folder `thefolder`, we type:

    > archive unpack thefolder download

To add the file `background` to the folder `src/images` inside `download`, we type:

    > archive add download src/images background


### Installation
*Coming soon...*
