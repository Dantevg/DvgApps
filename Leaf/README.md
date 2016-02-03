# Leaf <sup><sub><sub>`v1.0`</sub></sub></sup>
Executable Lua Archive File (.leaf) is a program to make an executable file from your project folder. It uses functions from [archive](https://github.com/Dantevg/DvgApps/tree/master/Archive) to pack and temporary unpack your folder into a single, runnable file.

### Installation
To install leaf, type in the shell:

    > pastebin get 8nfm71ms leaf

or the minified version (minified using https://mothereff.in/lua-minifier):

    > pastebin get 3Ut3TdsF leaf

### Usage

    > leaf <path/to/folder> [main relative run path] <new file path> [-log]

1. The `path/to/folder` means the path to the project folder that you want to pack.
2. The `main relative run path` is an optional argument. If specified, leaf will use that **relative (!)** path to run if the newly created file is ran.
3. The `new file path` is the path where the new `.leaf` file will be created.
4. The fourth, optional argument, `-log` specifies wether leaf will print a log. Leaf will print a log if specified (surprise!).

### Example
If, for example, this is typed into the terminal:

    leaf programs/myProgram blahblah.lua /blahProg -log

Leaf will, while logging, search for a folder named `myProgram` in the directory `programs`, creating a new file `blahProg.leaf` which, if ran, will run `blahblah.lua` in a temporary folder.
