Script for converting Settlers 2 RTX files into [RTTR](https://github.com/Return-To-The-Roots/s25client) LUA scripts.

`git clone git@github.com:kubaau/rtx2lua.git`

## Requires

Python 3

`pip install lxml`

## Usage

```
python rtx2lua.py PATH_TO_RTX XML_FOLDER > PATH_TO_LUA

# examples
python rtx2lua.py rtx/MIS_0000.RTX xml > temp.lua
python rtx2lua.py rtx/MIS_0001.RTX xml > temp.lua
```
