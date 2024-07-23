-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0007.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Späher berichteten mir von einem übermächtigem Feind im Westen. Wir müssen versuchen, uns hier solange wie möglich zu halten. Aber im Notfall bliebe uns immer noch die Flucht nach Osten oder übers Meer...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Suchen Sie nach einem Tor. Achten Sie auf eventuell vorhandene Möglichkeiten zum Hafenbau.',
        msg2    = 'Wir haben das Tor gefunden und besetzt. Wann werden wir unser Ziel wohl erreichen?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'Scouts have told me of a mighty enemy in the west. We must try and stay here as long as possible. In an emergency we can always escape to the east or by sea...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Search for a gateway. Consider opportunities to build a harbor.',
        msg2    = 'We have found the gateway and occupied it. When will we reach our destination?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'You have completed this mission. The next Chapter awaits you...',
    },
    pl =
    {
        Diary   = 'Dziennik',
        msg0    = 'Zwiadowcy donieśli mi o potężnym przeciwniku na zachodzie. Musimy postarać się i wytrzymać tu jak najdłużej. W razie niepowodzenia, zawsze możemy uciec na wschód lub na morze...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Szukaj bramy. Rozważ też ewentualność budowy przystani.',
        msg2    = 'Znaleźliśmy i zajęliśmy bramę. Czy kiedykolwiek dotrzemy do celu?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Ukończyłeś misję. Kolejny rozdział oczekuje...',
    },
})

function getNumPlayers()
    return 3
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
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(10, 41, 122)
    rttr:GetWorld():SetComputerBarrier(10, 72, 111)
    rttr:GetWorld():SetComputerBarrier(15, 72, 97)
    rttr:GetWorld():SetComputerBarrier(10, 19, 100)

    -- player 0 always commands
    rttr:GetPlayer(0):DisableAllBuildings()
    rttr:GetPlayer(0):EnableAllBuildings()

    -- player 1 always commands
    rttr:GetPlayer(1):EnableAllBuildings()

    -- player 2 always commands
    rttr:GetPlayer(2):EnableAllBuildings()

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(76, 26)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):PlaceHQ(49, 60)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(2):PlaceHQ(59, 83)
        rttr:GetPlayer(2):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 20,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 12,
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
            [GD_COINS     ] = 2,
            [GD_TONGS     ] = 2,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 5,
            [GD_HAMMER    ] = 8,
            [GD_SHOVEL    ] = 4,
            [GD_CRUCIBLE  ] = 4,
            [GD_RODANDLINE] = 8,
            [GD_SCYTHE    ] = 4,
            [GD_CLEAVER   ] = 3,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 4,
            [GD_SWORD     ] = 9,
            [GD_SHIELD    ] = 9,
            [GD_BOAT      ] = 0,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 120,
            [GD_STONES    ] = 220,
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
            [GD_BOARDS    ] = 90,
            [GD_STONES    ] = 70,
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

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 100,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 4,
            [JOB_FORESTER         ] = 3,
            [JOB_CARPENTER        ] = 3,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 2,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 1,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 6,
            [JOB_BREWER           ] = 3,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 4,
            [JOB_GEOLOGIST        ] = 4,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 6,
            [JOB_SERGEANT         ] = 4,
            [JOB_OFFICER          ] = 2,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 7,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 15,
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
            [JOB_PRIVATE          ] = 20,
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
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(11, 125, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('roman', 8)
        rttr:EnableCampaignChapter('roman', 9)
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
