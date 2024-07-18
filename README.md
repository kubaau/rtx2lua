Script for converting The Settlers 2 RTX files into [RTTR](https://github.com/Return-To-The-Roots/s25client) LUA scripts.

`git clone git@github.com:kubaau/rtx2lua.git`

## Requires

Python 3

## Usage

```
python rtx2lua.py RTX_FILE [CAMPAIGN_NAME {roman}] [TXT_FOLDER {TXT}] [> OUTPUT_FILE]

# examples
python rtx2lua.py MISSIONS/MIS_0000.RTX
python rtx2lua.py MISSIONS_fanpaign/MIS_0001.RTX fanpaign TXT_fanpaign > temp.lua
```

## Known issues

### Roman campaign chapter `I - Off we go` (MISSIONS/MIS_0000.RTX)

The following lines must be manually added to `onSettingsReady`:
```
    rttr:GetPlayer(1):Close()
    rttr:GetPlayer(2):Close()
    rttr:GetPlayer(3):Close()
    rttr:GetPlayer(4):Close()
    rttr:GetPlayer(5):Close()
    rttr:GetPlayer(6):Close()
```
This is because the original map header actually has 7 players but positions 2 to 7 are not set and these slots need to be closed. 

The line:  
`    elseif(activeEvents[15] and x == 34 and y == 29) then`  
should be changed to:  
`    elseif(activeEvents[15] and x == 34 and y == 28) then`  
This is because according to RTTR logic, {34, 29} is already occupied at the start.

### Roman campaign chapter `IX - The Gray Island` (MISSIONS/MIS_0008.RTX)

The line:  
`        MissionText(6)`  
should be changed to:  
`        MissionText(2)`  
This is because the original script is wrong, resulting in the `NO STRING WITH THIS ID` error in S2.

The line:  
`        rttr:GetWorld():AddStaticObject(19, 127, 561, 0xFFFF, 2)`  
should be changed to:  
`        rttr:GetWorld():AddStaticObject(127, 48, 561, 0xFFFF, 2)`  
Again, this is because the original script is wrong. In S2, due to an incorrect order of arguments for !MET_SET_MAP_ELEMENT, instead of activating the gate, a rock is placed in the middle of water north of the player's starting HQ.
