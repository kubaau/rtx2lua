-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0005.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'VI - Irrwege, von Thomas Roth\n\nWir sind an einem merkwürdigen Ort gelandet. Die Wege scheinen überall und nirgendwo hinzuführen. Inschriften zufolge wird derjenige, welcher das Tor zu erreichen sucht, in die Irre geführt; da werden uns wohl auch die Erkenntnisse, die wir bereits über die Funktionsweisen gewonnen haben, nicht viel weiterhelfen.\nAber es gibt große Wasserwege...wir sollten vielleicht nach Hafenbaumöglichkeiten Ausschau halten.\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Sucht nach dem Tor, aber laßt Euch nicht täuschen. Ihr werdet viel Gedult beweisen müssen...',
        msg2    = 'Jetzt können wir die Warnungen deuten:\n\nEs gibt falsche Tore in diesem Inselsystem, die funktionsuntüchtig sind. Sie dienen wohl als Ablenkung, was für mich Beweis genug ist, daß wir unseren Feinden dicht auf den Fersen sind.\n\nDie Völker auf dieser Insel gehören Einheimischen zufolge nicht zum Dominion, wir sollten uns dennoch in acht nehmen.\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Laßt Euch durch Enttäuschungen und Irreführungen nicht entmutigen, denkt aber daran, daß die Zeit für das römische Volk, daß von der Bedrohung nichts weiß, knapp wird...',
        msg4    = 'Endlich haben wir das richtige Tor gefunden.\n\nMit unserem mittlerweile reichhaltigen Wissen über die Funktionsweise der Tore (An dieser Stelle danke ich unseren Gelehrten!) haben wir einen interessanten Ort ausgemacht, an dem wir unsere Feinde möglicherweise aufspüren und vernichten können...\n\nWir werden das Tor nun betreten...\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Ihr seid weit gekommen, aber es liegen noch einige Hürden vor Euch!',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = "VI - Meanders, by Thomas Roth\n\nWe have landed in a very strange place. Ways seem to lead at the same time everywhere and nowhere. \nInscriptions indicate, that he, who strives to reach the gate will be led astray; maybe even the knowledge we gathered on the function of things won't help us very far.\n\nBut there are wide waterways .... perhaps we should look out for a possibility to build a harbour.\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh0   = "Search for the Gate, but don't let yourself be misled. \nYou will need much patience...",
        msg2    = 'Now we can interpret the warnings:\n\nThere are fake but fully operable Gates on these islands.  Obviously they have been placed to distract us - which is enough of evidence to me, that we are hard by our enemies heels.\n\nPeoples of this island do not belong to the Dominion - according to inhabitants. We should, however, be cautious all the same.\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = "Don't be discouraged by disappointments and misdirections. Rather keep in mind, that time is running thin for the Roman people, still unaware of the threat...",
        msg4    = 'We finally found the correct Gate.\n\nUsing our knowledge about the functioning of these Gates - I have to express my thanks to our experts here! - we detected an interesting place, where we possibly may search and destroy our enemies...\n\nWe now will enter the Gate ...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'You have come a long way, but still some obstacles lie ahead.',
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
    rttr:GetPlayer(1):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(1):SetName('Tsunami')
 -- rttr:GetPlayer(1):SetPortrait(7)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(2):SetName('Hakirawashi')
 -- rttr:GetPlayer(2):SetPortrait(8)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(3):SetName('Erik')
 -- rttr:GetPlayer(3):SetPortrait(3)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(4):SetName('Knut')
 -- rttr:GetPlayer(4):SetPortrait(4)

    rttr:GetPlayer(5):SetAI(3)
    rttr:GetPlayer(5):SetColor(5)
    rttr:GetPlayer(5):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(5):SetName('Olof')
 -- rttr:GetPlayer(5):SetPortrait(5)

    rttr:GetPlayer(6):SetAI(3)
    rttr:GetPlayer(6):SetColor(6)
    rttr:GetPlayer(6):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(6):SetName('Yamauchi')
 -- rttr:GetPlayer(6):SetPortrait(6)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(15, 180, 106)
    rttr:GetWorld():SetComputerBarrier(15, 106, 27)

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
    activeEvents[31] = true
    activeEvents[32] = true
    activeEvents[33] = true
    activeEvents[34] = true
    activeEvents[35] = true
    activeEvents[36] = true
    activeEvents[93] = true
    activeEvents[94] = true
    activeEvents[95] = true
    activeEvents[96] = true
    activeEvents[97] = true
    activeEvents[98] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(0):PlaceHQ(181, 173)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):PlaceHQ(16, 7)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):PlaceHQ(203, 57)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):PlaceHQ(144, 24)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):PlaceHQ(86, 108)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):PlaceHQ(34, 223)
        rttr:GetPlayer(5):ClearResources()

        -- player 6 firststart commands
        rttr:GetPlayer(6):PlaceHQ(136, 229)
        rttr:GetPlayer(6):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 80,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 0,
            [GD_HAM       ] = 0,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 0,
            [GD_IRONORE   ] = 0,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 20,
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
            [GD_BOAT      ] = 10,
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

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
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

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
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

        -- player 5 wares
        rttr:GetPlayer(5):AddWares({
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

        -- player 6 wares
        rttr:GetPlayer(6):AddWares({
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

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 10,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 3,
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
            [JOB_DONKEYBREEDER    ] = 5,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 5,
            [JOB_BUILDER          ] = 15,
            [JOB_PLANER           ] = 10,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 10,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 5,
            [JOB_PACKDONKEY       ] = 0,
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
            [JOB_PRIVATEFIRSTCLASS] = 2,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 40,
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
            [JOB_GENERAL          ] = 30,
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
            [JOB_PRIVATEFIRSTCLASS] = 2,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 40,
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
            [JOB_GENERAL          ] = 30,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 5 people
        rttr:GetPlayer(5):AddPeople({
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
            [JOB_PRIVATEFIRSTCLASS] = 2,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 40,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 6 people
        rttr:GetPlayer(6):AddPeople({
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
            [JOB_GENERAL          ] = 30,
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
    elseif e == 80 then
        rttr:GetWorld():AddStaticObject(44, 155, 561, 0xFFFF, 2)
    elseif e == 81 then
        rttr:GetWorld():AddStaticObject(113, 114, 561, 0xFFFF, 2)
    elseif e == 82 then
        rttr:GetWorld():AddStaticObject(189, 31, 561, 0xFFFF, 2)
    elseif e == 83 then
        rttr:GetWorld():AddStaticObject(113, 45, 561, 0xFFFF, 2)
    elseif e == 84 then
        rttr:GetWorld():AddStaticObject(42, 64, 561, 0xFFFF, 2)
    elseif e == 85 then
        rttr:GetWorld():AddStaticObject(40, 221, 561, 0xFFFF, 2)
    elseif e == 86 then
        rttr:GetWorld():AddStaticObject(144, 120, 561, 0xFFFF, 2)
    elseif e == 93 then
        activeEvents[86] = true
        showMissionText(1)
    elseif e == 94 then
        activeEvents[85] = true
        showMissionText(1)
    elseif e == 95 then
        activeEvents[84] = true
        showMissionText(1)
    elseif e == 96 then
        activeEvents[83] = true
        showMissionText(1)
    elseif e == 97 then
        activeEvents[82] = true
        showMissionText(1)
    elseif e == 98 then
        activeEvents[81] = true
        showMissionText(1)
    elseif e == 99 then
        activeEvents[80] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('2NDpaign', 6)
        rttr:EnableCampaignChapter('2NDpaign', 7)
    end

    if not isLoading then
        local n = #eventHistory
        eventHistory[n + 1] = e
        eventHistory[n + 2] = trigger
    end

    activeEvents[trigger] = false
end

function onGameFrame(gf)
    if activeEvents[80] then
        triggerEndEvent(80, 80)
    end
    if activeEvents[81] then
        triggerEndEvent(81, 81)
    end
    if activeEvents[82] then
        triggerEndEvent(82, 82)
    end
    if activeEvents[83] then
        triggerEndEvent(83, 83)
    end
    if activeEvents[84] then
        triggerEndEvent(84, 84)
    end
    if activeEvents[85] then
        triggerEndEvent(85, 85)
    end
    if activeEvents[86] then
        triggerEndEvent(86, 86)
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
    elseif activeEvents[30] and x == 44 and y == 155 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    elseif activeEvents[31] and x == 113 and y == 114 then
        triggerEndEvent(31, 31)
        triggerEndEvent(98, 31)
    elseif activeEvents[32] and x == 189 and y == 31 then
        triggerEndEvent(32, 32)
        triggerEndEvent(97, 32)
    elseif activeEvents[33] and x == 113 and y == 45 then
        triggerEndEvent(33, 33)
        triggerEndEvent(96, 33)
    elseif activeEvents[34] and x == 42 and y == 64 then
        triggerEndEvent(34, 34)
        triggerEndEvent(95, 34)
    elseif activeEvents[35] and x == 40 and y == 221 then
        triggerEndEvent(35, 35)
        triggerEndEvent(94, 35)
    elseif activeEvents[36] and x == 144 and y == 120 then
        triggerEndEvent(36, 36)
        triggerEndEvent(93, 36)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
