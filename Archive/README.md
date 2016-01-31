# Archive <sup><sub>`v2.1`</sub></sup>
With archive, you can put all your files and folders (inside folders inside folders...) in one singe file. It works a bit like winrar of 7zip. This is very useful for downloading and installing many files and folders, so you only need to download one single file!

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


### Installation
*Coming soon...*
