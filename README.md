Script for converting The Settlers 2 RTX files into [RTTR](https://github.com/Return-To-The-Roots/s25client) LUA scripts.

`git clone git@github.com:kubaau/rtx2lua.git`

## Requires

Python 3

## Usage

```
python rtx2lua.py RTX_FILE [CAMPAIGN_NAME {roman}] [TXT_FOLDER {TXT}] [> OUTPUT_FILE]

# examples
python rtx2lua.py RTX/MIS_0000.RTX
python rtx2lua.py RTX/MIS_0001.RTX my_campaign_name my_txt_folder > temp.lua
```
