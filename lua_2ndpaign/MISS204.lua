-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0004.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'V - Indien, von Michael Lorenz \n\nWie allseits bekannt gehen in Indien die Uhren anders. Dies mussten wir auch in dieser Welt erkennen. Ein Platz für ein Tor ist im Osten vorhanden. Doch das Tor fehlt darauf. Erst wer die Baupläne für das Tor findet, kann selber ein Tor bauen, das es dann noch gilt zu aktivieren. Unglücklicherweise befinden sich die Pläne jedoch tief unterhalb eines Hauptquartieres im Norden von uns. Das Zerstören des HQs reicht jedoch nicht aus. Wir müssen uns lange genug halten, um auch die Baupläne ausgraben zu können. \n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Zerstört das nördlich von Euch gelegene Hauptquartier und nehmt das dazugehörende Land in Besitz. Nur so habt Ihr die benötigte Zeit, um an die Pläne zu kommen! ',
        msg2    = 'Wir haben die Pläne für das Tor gefunden. Wie von Zauberhand baute sich das Tor jedoch selbst. Nun müssen wir es nur noch aktivieren. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Dringt nach Osten vor und aktiviert das neu erbaute Tor!',
        msg4    = 'Wir haben das Tor aktiviert. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Ihr habt diese Mission bestanden! Weitere Abenteuer warten auf Euch!',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'V - India, by Michael Lorenz \n\nAs everbody knows, things run different in India. This we had to find out in this world. There is a spot for a Gate in the east. But the Gate itself is missing on it. Only who finds out the blueprints for the Gate may build one himself and activate it afterwards. \n\nUnforunatily, the plans are to be found buried deeply under the headquarters to our north. It is not sufficient only to destroy this HQ. We have to keep it long enough to unearth the blueprints.\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Destroy the headquarters in the north and occupy the surrounding area. Only this way you will have the time to lay hands on the plans.',
        msg2    = 'We have found the plans for the Gate. Like a miracle, however,  the Gate was built all by itself. No we only have to activate it.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Proceed eastwards and activate the newly built Gate.',
        msg4    = 'We have activated the Gate.\n\nAnd our scientists have learned something more about the Gates:\nYou can find out where the last users have landed. That means we have the possibility to follow our enymies even if the link has closed already. By this we can follow our enemies and delete the threat for us. Our position, however, can also be fond out; we need full control over the Gates as soon as possible...\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'You have succeeded in this mission. New adventures are in store for you.',
    },
})

function getNumPlayers()
    return 4
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
    rttr:GetPlayer(1):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(1):SetName('Yamauchi')
 -- rttr:GetPlayer(1):SetPortrait(6)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(2):SetName('Tsunami')
 -- rttr:GetPlayer(2):SetPortrait(7)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(3):SetName('Hakirawashi')
 -- rttr:GetPlayer(3):SetPortrait(8)
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

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[80] = true
    activeEvents[88] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(26, 61)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):PlaceHQ(76, 74)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):PlaceHQ(56, 127)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):PlaceHQ(38, 40)
        rttr:GetPlayer(3):AIConstructionOrder(36, 47, BLD_FORTRESS)
        rttr:GetPlayer(3):AIConstructionOrder(41, 45, BLD_FORTRESS)
        rttr:GetPlayer(3):AIConstructionOrder(39, 43, BLD_CATAPULT)
        rttr:GetPlayer(3):AIConstructionOrder(36, 42, BLD_CATAPULT)
        rttr:GetPlayer(3):AIConstructionOrder(39, 37, BLD_WOODCUTTER)
        rttr:GetPlayer(3):AIConstructionOrder(34, 44, BLD_WOODCUTTER)
        rttr:GetPlayer(3):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 24,
            [GD_BOARDS    ] = 44,
            [GD_STONES    ] = 67,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 4,
            [GD_HAM       ] = 6,
            [GD_BREAD     ] = 8,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 16,
            [GD_IRONORE   ] = 16,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 2,
            [GD_HAMMER    ] = 16,
            [GD_SHOVEL    ] = 4,
            [GD_CRUCIBLE  ] = 4,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 8,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 6,
            [GD_SHIELD    ] = 6,
            [GD_BOAT      ] = 12,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 24,
            [GD_BOARDS    ] = 44,
            [GD_STONES    ] = 67,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 4,
            [GD_HAM       ] = 6,
            [GD_BREAD     ] = 8,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 16,
            [GD_IRONORE   ] = 16,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 2,
            [GD_HAMMER    ] = 16,
            [GD_SHOVEL    ] = 4,
            [GD_CRUCIBLE  ] = 4,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 8,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 6,
            [GD_SHIELD    ] = 6,
            [GD_BOAT      ] = 12,
        })

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 24,
            [GD_BOARDS    ] = 44,
            [GD_STONES    ] = 67,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 4,
            [GD_HAM       ] = 6,
            [GD_BREAD     ] = 8,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 16,
            [GD_IRONORE   ] = 16,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 2,
            [GD_HAMMER    ] = 16,
            [GD_SHOVEL    ] = 4,
            [GD_CRUCIBLE  ] = 4,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 8,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 6,
            [GD_SHIELD    ] = 6,
            [GD_BOAT      ] = 12,
        })

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 80,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 4,
            [GD_HAM       ] = 6,
            [GD_BREAD     ] = 8,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 16,
            [GD_IRONORE   ] = 16,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 2,
            [GD_HAMMER    ] = 16,
            [GD_SHOVEL    ] = 4,
            [GD_CRUCIBLE  ] = 4,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 8,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 6,
            [GD_SHIELD    ] = 6,
            [GD_BOAT      ] = 12,
        })

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 52,
            [JOB_WOODCUTTER       ] = 8,
            [JOB_FISHER           ] = 0,
            [JOB_FORESTER         ] = 4,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 0,
            [JOB_MILLER           ] = 0,
            [JOB_BAKER            ] = 0,
            [JOB_BUTCHER          ] = 0,
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 0,
            [JOB_PIGBREEDER       ] = 0,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 0,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 45,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 2,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 52,
            [JOB_WOODCUTTER       ] = 8,
            [JOB_FISHER           ] = 0,
            [JOB_FORESTER         ] = 4,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 0,
            [JOB_MILLER           ] = 0,
            [JOB_BAKER            ] = 0,
            [JOB_BUTCHER          ] = 0,
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 0,
            [JOB_PIGBREEDER       ] = 0,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 0,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 45,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 2,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 52,
            [JOB_WOODCUTTER       ] = 8,
            [JOB_FISHER           ] = 0,
            [JOB_FORESTER         ] = 4,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 0,
            [JOB_MILLER           ] = 0,
            [JOB_BAKER            ] = 0,
            [JOB_BUTCHER          ] = 0,
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 0,
            [JOB_PIGBREEDER       ] = 0,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 0,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 45,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 2,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
            [JOB_HELPER           ] = 52,
            [JOB_WOODCUTTER       ] = 8,
            [JOB_FISHER           ] = 0,
            [JOB_FORESTER         ] = 4,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 0,
            [JOB_MILLER           ] = 0,
            [JOB_BAKER            ] = 0,
            [JOB_BUTCHER          ] = 0,
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 0,
            [JOB_PIGBREEDER       ] = 0,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 0,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 50,
            [JOB_SCOUT            ] = 2,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 0,
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
    elseif e == 88 then
        activeEvents[89] = true
        activeEvents[90] = true
        showMissionText(2)
    elseif e == 89 then
        rttr:GetWorld():AddStaticObject(93, 89, 560, 0xFFFF, 2)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(93, 89, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(4)
        rttr:SetCampaignChapterCompleted('2NDpaign', 5)
        rttr:EnableCampaignChapter('2NDpaign', 6)
    end

    if not isLoading then
        local n = #eventHistory
        eventHistory[n + 1] = e
        eventHistory[n + 2] = trigger
    end

    activeEvents[trigger] = false
end

function onGameFrame(gf)
    if activeEvents[89] then
        triggerEndEvent(89, 89)
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
    elseif activeEvents[80] and x == 38 and y == 40 then
        triggerEndEvent(80, 80)
        triggerEndEvent(88, 80)
    elseif activeEvents[90] and x == 93 and y == 89 then
        triggerEndEvent(90, 90)
        triggerEndEvent(99, 90)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
