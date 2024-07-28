-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0006.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Neue Seewege - Mission von Achim Ruziczka\n\nSpäher berichteten mir von einem übermächtigem Feind im Westen.\n\nWir müssen versuchen, uns hier solange wie möglich zu halten. Zur Not können wir die Passage gut verteidigen, und so lange warten bis wir stark genug sind, um weiter zu kommen.\n\nUnbegrenzt Zeit haben wir aber nicht!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Nutze den Hafenbauplatz im Südosten!\nBesetze die Inseln und baue die nötigen Erze ab. Warte nicht zu lange, denn auch die Gegner haben die Möglichkeit \nsich zu stärken.',
        msg2    = 'Wir haben das Tor gefunden und besetzt.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'Scouts reported a very powerful enemy to the West.\n\nWe must try to stay here as long as possible. If need be, we can defend the passage well enough and wait till we are strong enough to proceed.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = "Build a harbour in the East!\nOccupy the islands and mine for ores. \nDon't wait too long - the enemy will gain strength in the meantime as well!",
        msg2    = 'We have found and occupied The Arc.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'You fulfilled this mission, the next chapter is waiting for you!',
    },
})

function getNumPlayers()
    return 5
end

-- boilerplate begin
function getRequiredLuaVersion()
    return 1
end

function isMapPreviewEnabled()
    return false
end

local requiredFeature = 4
function checkVersion()
    local featureLevel = rttr:GetFeatureLevel()
    if featureLevel < requiredFeature then
        rttr:MsgBox("LUA-Version Error", "Your Return to the Roots version is outdated. The required LUA-Feature level is " .. requiredFeature .. ", your version is " .. featureLevel .. ". The script can possibly crash or run unexpectedly!\n\nPlease update the game!", true)
    end
end

local isLoading = false
function showMissionText(e)
    if isLoading then return end

    local msg = _('msg' .. tostring(e))

    if msg ~= ('msg' .. tostring(e)) then
        local msgh = _('msgh' .. tostring(e))
        if msgh ~= ('msgh'.. tostring(e)) then
            rttr:MissionStatement(0, _('Diary'), msg .. '\n\n\n\n' .. msgh)
            rttr:SetMissionGoal(0, msgh)
        else
            rttr:MissionStatement(0, _('Diary'), msg)
        end
    else
        rttr:Log("Error: no Translation found: " .. msg)
    end
end

function enableBuilding(b)
    rttr:GetPlayer(0):EnableBuilding(b, not isLoading)
end

function getAllowedChanges()
    return
    {
        ["addonsAll"]   = false,
        ["ownNation"]   = false,
        ["ownColor"]    = false,
        ["ownTeam"]     = false,
        ["aiNation"]    = false,
        ["aiColor"]     = false,
        ["aiTeam"]      = false,
    }
end

local activeEvents = {}
local eventHistory = {}
local timesTriggered = {}

function onSave(saveGame)
    saveGame:PushInt(#eventHistory)
    for i = 1, #eventHistory do
        saveGame:PushInt(eventHistory[i])
    end
    return true
end

function onLoad(saveGame)
    local n = saveGame:PopInt()
    for i = 1, n do
        eventHistory[i] = saveGame:PopInt()
    end
    return true
end

function onSettingsReady()
    checkVersion()
    rttr:Log("-----------------------\n lua loaded... \n-----------------------\n")
    rttr:ResetAddons()
    rttr:SetAddon(ADDON_CATAPULTS_ATTACK_ALLIES, true)
    rttr:SetAddon(ADDON_FRONTIER_DISTANCE_REACHABLE, true)
    rttr:SetGameSettings({
        ["fow"] = EXP_CLASSIC,
        ["teamView"] = false,
        ["lockedTeams"] = false
    })

    rttr:GetPlayer(0):SetNation(NAT_ROMANS)
    rttr:GetPlayer(0):SetColor(0)
-- boilerplate end

    rttr:GetPlayer(1):SetAI(3)
    rttr:GetPlayer(1):SetColor(1)
    rttr:GetPlayer(1):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(1):SetName('Mnga Tscha')
 -- rttr:GetPlayer(1):SetPortrait(11)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(2):SetName('Todo')
 -- rttr:GetPlayer(2):SetPortrait(10)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(3):SetName('Mnga Tscha')
 -- rttr:GetPlayer(3):SetPortrait(11)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(4):SetName('Todo')
 -- rttr:GetPlayer(4):SetPortrait(10)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(15, 72, 97)
    rttr:GetWorld():SetComputerBarrier(15, 19, 29)

    -- player 0 always commands
    rttr:GetPlayer(0):DisableAllBuildings()
    rttr:GetPlayer(0):EnableAllBuildings()

    -- player 1 always commands
    rttr:GetPlayer(1):EnableAllBuildings()

    -- player 2 always commands
    rttr:GetPlayer(2):EnableAllBuildings()

    -- player 3 always commands
    rttr:GetPlayer(3):EnableAllBuildings()

    -- player 4 always commands
    rttr:GetPlayer(4):EnableAllBuildings()

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[23] = true
    activeEvents[30] = true
    activeEvents[50] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(118, 36)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(1):PlaceHQ(76, 26)
        rttr:GetPlayer(1):AIConstructionOrder(80, 31, BLD_GUARDHOUSE)
        rttr:GetPlayer(1):AIConstructionOrder(82, 24, BLD_GUARDHOUSE)
        rttr:GetPlayer(1):AIConstructionOrder(74, 32, BLD_FORTRESS)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(2):PlaceHQ(49, 60)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(3):PlaceHQ(30, 120)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(4):PlaceHQ(59, 83)
        rttr:GetPlayer(4):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 150,
            [GD_MEAT      ] = 20,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 8,
            [GD_FISH      ] = 14,
            [GD_HAM       ] = 13,
            [GD_BREAD     ] = 16,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 30,
            [GD_IRONORE   ] = 15,
            [GD_GOLD      ] = 15,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 10,
            [GD_TONGS     ] = 10,
            [GD_AXE       ] = 10,
            [GD_SAW       ] = 10,
            [GD_PICKAXE   ] = 10,
            [GD_HAMMER    ] = 10,
            [GD_SHOVEL    ] = 10,
            [GD_CRUCIBLE  ] = 10,
            [GD_RODANDLINE] = 10,
            [GD_SCYTHE    ] = 10,
            [GD_CLEAVER   ] = 10,
            [GD_ROLLINGPIN] = 10,
            [GD_BOW       ] = 10,
            [GD_SWORD     ] = 10,
            [GD_SHIELD    ] = 10,
            [GD_BOAT      ] = 0,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 150,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 40,
            [GD_BREAD     ] = 40,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 40,
            [GD_IRONORE   ] = 0,
            [GD_GOLD      ] = 25,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 0,
            [GD_SAW       ] = 0,
            [GD_PICKAXE   ] = 0,
            [GD_HAMMER    ] = 0,
            [GD_SHOVEL    ] = 0,
            [GD_CRUCIBLE  ] = 0,
            [GD_RODANDLINE] = 0,
            [GD_SCYTHE    ] = 0,
            [GD_CLEAVER   ] = 0,
            [GD_ROLLINGPIN] = 0,
            [GD_BOW       ] = 0,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 0,
        })

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 150,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 20,
            [GD_IRONORE   ] = 0,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 0,
            [GD_SAW       ] = 0,
            [GD_PICKAXE   ] = 0,
            [GD_HAMMER    ] = 0,
            [GD_SHOVEL    ] = 0,
            [GD_CRUCIBLE  ] = 0,
            [GD_RODANDLINE] = 0,
            [GD_SCYTHE    ] = 0,
            [GD_CLEAVER   ] = 0,
            [GD_ROLLINGPIN] = 0,
            [GD_BOW       ] = 0,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 0,
        })

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
            [GD_WOOD      ] = 100,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 120,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 40,
            [GD_BREAD     ] = 40,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 40,
            [GD_IRONORE   ] = 0,
            [GD_GOLD      ] = 25,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 0,
            [GD_SAW       ] = 0,
            [GD_PICKAXE   ] = 0,
            [GD_HAMMER    ] = 0,
            [GD_SHOVEL    ] = 0,
            [GD_CRUCIBLE  ] = 0,
            [GD_RODANDLINE] = 0,
            [GD_SCYTHE    ] = 0,
            [GD_CLEAVER   ] = 0,
            [GD_ROLLINGPIN] = 0,
            [GD_BOW       ] = 0,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 0,
        })

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
            [GD_WOOD      ] = 120,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 120,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 80,
            [GD_IRONORE   ] = 60,
            [GD_GOLD      ] = 20,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 0,
            [GD_SAW       ] = 0,
            [GD_PICKAXE   ] = 0,
            [GD_HAMMER    ] = 0,
            [GD_SHOVEL    ] = 0,
            [GD_CRUCIBLE  ] = 0,
            [GD_RODANDLINE] = 0,
            [GD_SCYTHE    ] = 0,
            [GD_CLEAVER   ] = 0,
            [GD_ROLLINGPIN] = 0,
            [GD_BOW       ] = 0,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 0,
        })

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 100,
            [JOB_WOODCUTTER       ] = 10,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 10,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 6,
            [JOB_SERGEANT         ] = 4,
            [JOB_OFFICER          ] = 2,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 29,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 20,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 20,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 8,
            [JOB_DONKEYBREEDER    ] = 2,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 6,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 16,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 4,
            [JOB_GENERAL          ] = 3,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 10,
            [JOB_FISHER           ] = 5,
            [JOB_FORESTER         ] = 5,
            [JOB_CARPENTER        ] = 5,
            [JOB_STONEMASON       ] = 5,
            [JOB_HUNTER           ] = 5,
            [JOB_FARMER           ] = 5,
            [JOB_MILLER           ] = 5,
            [JOB_BAKER            ] = 5,
            [JOB_BUTCHER          ] = 5,
            [JOB_MINER            ] = 5,
            [JOB_BREWER           ] = 5,
            [JOB_PIGBREEDER       ] = 5,
            [JOB_DONKEYBREEDER    ] = 2,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 5,
            [JOB_BUILDER          ] = 5,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 16,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 4,
            [JOB_GENERAL          ] = 3,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 20,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 20,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 8,
            [JOB_DONKEYBREEDER    ] = 2,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 6,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 16,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 4,
            [JOB_GENERAL          ] = 3,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 4 people
        rttr:GetPlayer(4):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 20,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 5,
            [JOB_DONKEYBREEDER    ] = 2,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 15,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 16,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 4,
            [JOB_GENERAL          ] = 3,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- events which are triggered right from the start
        triggerEndEvent(0, 0)
    else
        isLoading = true
        for i = 1, #eventHistory, 2 do
            triggerEndEvent(eventHistory[i], eventHistory[i + 1])
        end
        isLoading = false
    end
end

function triggerEndEvent(e, trigger) -- events triggered from other events
    if not activeEvents[e] then return end

    if timesTriggered[e] then timesTriggered[e] = timesTriggered[e] + 1 end

    if false then -- dummy if
    elseif e == 0 then
        showMissionText(0)
    elseif e == 50 then
        rttr:GetWorld():AddStaticObject(11, 125, 560, 0xFFFF, 2)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(11, 125, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('FANpaign', 7)
        rttr:EnableCampaignChapter('FANpaign', 8)
    end

    if not isLoading then
        local n = #eventHistory
        eventHistory[n + 1] = e
        eventHistory[n + 2] = trigger
    end

    activeEvents[trigger] = false
end

function onGameFrame(gf)
    if activeEvents[50] then
        triggerEndEvent(50, 50)
    end
    if activeEvents[98] then
        triggerEndEvent(98, 98)
    end
end

function onExplored(p, x, y, o)
    if false then -- dummy if for onContact cases
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[30] and x == 11 and y == 125 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
