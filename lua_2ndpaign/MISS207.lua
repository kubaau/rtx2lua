-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0007.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'VIII - Der Aufstand, von Christian\n\nDie Leute hatten recht - diese Welt ist unwirtlich. Und es warten jede Menge Feinde auf uns.\n\nAlso, es gibt viel zu tun - packen wir es an!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Achtet auf die Bündnisverhältnisse!',
        msg2    = 'Wir haben das Tor gefunden, das uns in das Machtzentrum des Dominion führt. Wir haben noch eine Zeremonie gefeiert, damit die Götter uns wohlgesonnen sind...morgen werden meine Mannen das Tor durchschreiten und dann werden wir sehen, was die letzte Schlacht uns bringt - Ihr Ausgang entscheidet über Sieg oder Niederlage.',
        msgh2   = 'Veni, vidi et utinam vincam!',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'VIII - Rebellion, by Christian\n\nPeople were right - this world is an unfriendly one. And lots of enemies are waiting for us.\n\nAll right, there is much to do, lets get it started!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Consider the alliances.',
        msg2    = 'We found the Gate that leads to the center of power of the Dominion. We have held a ceremony to influence the gods in our favour... tomorrow my men will enter the Gate and then we will see what the final struggle brings to us - The result will make all the difference between victory or defeat. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Veni, vidi et utinam vincam!\nI came, I saw and finally have won!',
    },
})

function getNumPlayers()
    return 7
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
    rttr:GetPlayer(1):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(1):SetName('Erik')
 -- rttr:GetPlayer(1):SetPortrait(3)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(2):SetName('Knut')
 -- rttr:GetPlayer(2):SetPortrait(4)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(3):SetName('Olof')
 -- rttr:GetPlayer(3):SetPortrait(5)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(4):SetName('Yamauchi')
 -- rttr:GetPlayer(4):SetPortrait(6)

    rttr:GetPlayer(5):SetAI(3)
    rttr:GetPlayer(5):SetColor(5)
    rttr:GetPlayer(5):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(5):SetName('Tsunami')
 -- rttr:GetPlayer(5):SetPortrait(7)

    rttr:GetPlayer(6):SetAI(3)
    rttr:GetPlayer(6):SetColor(6)
    rttr:GetPlayer(6):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(6):SetName('Hakirawashi')
 -- rttr:GetPlayer(6):SetPortrait(8)
end

function onStart(isFirstStart)
    -- world always commands

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

    -- player 5 always commands
    rttr:GetPlayer(5):EnableAllBuildings()

    -- player 6 always commands
    rttr:GetPlayer(6):EnableAllBuildings()

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(6)
        rttr:GetPlayer(0):PlaceHQ(89, 29)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):PlaceHQ(126, 208)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):PlaceHQ(126, 208)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):PlaceHQ(105, 61)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(4):PlaceHQ(92, 172)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(5):PlaceHQ(35, 168)
        rttr:GetPlayer(5):ClearResources()

        -- player 6 firststart commands
        rttr:GetPlayer(6):PlaceHQ(46, 97)
        rttr:GetPlayer(6):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 30,
            [GD_STONES    ] = 25,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 25,
            [GD_IRONORE   ] = 7,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 2,
            [GD_COINS     ] = 4,
            [GD_TONGS     ] = 2,
            [GD_AXE       ] = 4,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 6,
            [GD_HAMMER    ] = 6,
            [GD_SHOVEL    ] = 6,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 2,
            [GD_SCYTHE    ] = 6,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 9,
            [GD_SHIELD    ] = 9,
            [GD_BOAT      ] = 0,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 9,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 9,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 9,
            [GD_HAMMER    ] = 9,
            [GD_SHOVEL    ] = 9,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 6,
            [GD_ROLLINGPIN] = 4,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 12,
            [GD_SHIELD    ] = 12,
            [GD_BOAT      ] = 0,
        })

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 9,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 9,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 9,
            [GD_HAMMER    ] = 9,
            [GD_SHOVEL    ] = 9,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 6,
            [GD_ROLLINGPIN] = 4,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 12,
            [GD_SHIELD    ] = 12,
            [GD_BOAT      ] = 0,
        })

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 9,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 9,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 9,
            [GD_HAMMER    ] = 9,
            [GD_SHOVEL    ] = 9,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 6,
            [GD_ROLLINGPIN] = 4,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 12,
            [GD_SHIELD    ] = 12,
            [GD_BOAT      ] = 0,
        })

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 9,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 9,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 9,
            [GD_HAMMER    ] = 9,
            [GD_SHOVEL    ] = 9,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 6,
            [GD_ROLLINGPIN] = 4,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 12,
            [GD_SHIELD    ] = 12,
            [GD_BOAT      ] = 0,
        })

        -- player 5 wares
        rttr:GetPlayer(5):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 9,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 9,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 9,
            [GD_HAMMER    ] = 9,
            [GD_SHOVEL    ] = 9,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 6,
            [GD_ROLLINGPIN] = 4,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 12,
            [GD_SHIELD    ] = 12,
            [GD_BOAT      ] = 0,
        })

        -- player 6 wares
        rttr:GetPlayer(6):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 9,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 9,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 9,
            [GD_HAMMER    ] = 9,
            [GD_SHOVEL    ] = 9,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 6,
            [GD_ROLLINGPIN] = 4,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 12,
            [GD_SHIELD    ] = 12,
            [GD_BOAT      ] = 0,
        })

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 3,
            [JOB_FISHER           ] = 2,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 1,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 3,
            [JOB_MILLER           ] = 0,
            [JOB_BAKER            ] = 0,
            [JOB_BUTCHER          ] = 0,
            [JOB_MINER            ] = 1,
            [JOB_BREWER           ] = 0,
            [JOB_PIGBREEDER       ] = 0,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 1,
            [JOB_METALWORKER      ] = 0,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 6,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 4,
            [JOB_PRIVATE          ] = 18,
            [JOB_PRIVATEFIRSTCLASS] = 9,
            [JOB_SERGEANT         ] = 9,
            [JOB_OFFICER          ] = 9,
            [JOB_GENERAL          ] = 6,
            [JOB_SCOUT            ] = 3,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 14,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 12,
            [JOB_FISHER           ] = 6,
            [JOB_FORESTER         ] = 6,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 9,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 12,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 12,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 9,
            [JOB_PLANER           ] = 9,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 25,
            [JOB_PRIVATEFIRSTCLASS] = 25,
            [JOB_SERGEANT         ] = 25,
            [JOB_OFFICER          ] = 25,
            [JOB_GENERAL          ] = 15,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 30,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 12,
            [JOB_FISHER           ] = 6,
            [JOB_FORESTER         ] = 6,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 9,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 12,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 12,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 9,
            [JOB_PLANER           ] = 9,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 25,
            [JOB_PRIVATEFIRSTCLASS] = 25,
            [JOB_SERGEANT         ] = 25,
            [JOB_OFFICER          ] = 25,
            [JOB_GENERAL          ] = 15,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 30,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 12,
            [JOB_FISHER           ] = 6,
            [JOB_FORESTER         ] = 6,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 9,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 12,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 12,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 9,
            [JOB_PLANER           ] = 9,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 15,
            [JOB_PRIVATEFIRSTCLASS] = 15,
            [JOB_SERGEANT         ] = 15,
            [JOB_OFFICER          ] = 15,
            [JOB_GENERAL          ] = 5,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 30,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 4 people
        rttr:GetPlayer(4):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 12,
            [JOB_FISHER           ] = 6,
            [JOB_FORESTER         ] = 6,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 9,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 12,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 12,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 9,
            [JOB_PLANER           ] = 9,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 15,
            [JOB_PRIVATEFIRSTCLASS] = 15,
            [JOB_SERGEANT         ] = 15,
            [JOB_OFFICER          ] = 15,
            [JOB_GENERAL          ] = 10,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 15,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 5 people
        rttr:GetPlayer(5):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 12,
            [JOB_FISHER           ] = 6,
            [JOB_FORESTER         ] = 6,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 9,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 12,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 12,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 9,
            [JOB_PLANER           ] = 9,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 15,
            [JOB_PRIVATEFIRSTCLASS] = 15,
            [JOB_SERGEANT         ] = 15,
            [JOB_OFFICER          ] = 15,
            [JOB_GENERAL          ] = 30,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 15,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 6 people
        rttr:GetPlayer(6):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 12,
            [JOB_FISHER           ] = 6,
            [JOB_FORESTER         ] = 6,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 9,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 12,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 12,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 9,
            [JOB_PLANER           ] = 9,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 15,
            [JOB_PRIVATEFIRSTCLASS] = 15,
            [JOB_SERGEANT         ] = 15,
            [JOB_OFFICER          ] = 15,
            [JOB_GENERAL          ] = 30,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 15,
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
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(76, 215, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('2NDpaign', 7)
        rttr:EnableCampaignChapter('2NDpaign', 8)
    end

    if not isLoading then
        local n = #eventHistory
        eventHistory[n + 1] = e
        eventHistory[n + 2] = trigger
    end

    activeEvents[trigger] = false
end

function onGameFrame(gf)
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
    elseif activeEvents[30] and x == 76 and y == 215 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
