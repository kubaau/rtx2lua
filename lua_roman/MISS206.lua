-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0006.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = '4. im 11. des 6. Jahres.\n\nUnsere Halbinsel scheint nur durch zwei schmale Täler mit dem Rest des Kontinents verbunden zu sein. Spuren weisen auf ein barbarisches Wikingervolk im Süden hin.\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Suchen Sie nach einem Tor.',
        msg2    = 'Ein gefangener Wikinger erzählte uns, daß auf der Halbinsel westlich der unseren noch ein weiterer Stamm lebt, der sehr reich sei, da er über große Goldvorräte verfüge. Genaueres war nicht zu erfahren, außer, daß der Zugang zu ihrem Gebiet im Westen der großen Bucht stark befestigt ist.',
        msg4    = '19. im 4. des 7. Jahres\n\nDie Wikinger scheinen sehr stark zu sein. Wir müssen diese Festung irgendwie knacken.\nInteressant ist, daß auch auch dieser Stamm einen Walfriedhof hat. Auf einer kleinen Halbinsel im Norden ihrer Goldminen. Ob auch sie Angst vor den Walgeistern haben ?',
        msg6    = 'Wir haben das Tor gefunden und besetzt.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'The Fourth Day of the 11th Month of the Sixth Year.\n\nIt appears that our peninsula is linked to the rest of the continent only by two narrow valleys. Tracks suggest there is a barbarian race of Vikings in the south.\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Search for the gateway.',
        msg2    = 'A captured Viking told us that another extremely wealthy tribe lives on the peninsula to the west of us. They have large stocks of Gold. Access to their region to the west of the large bay is heavily fortified. More precise details could not be obtained.',
        msg4    = '19th Day of the Fourth Month of the Seventh Year\n\nThe Vikings appear to be extremely strong. Somehow we must gain access to their fortress.\nIt is interesting that this tribe also has a whale graveyard on a small peninsula to the north of their gold mines. I wonder if they are afraid of the spirits of the whales as well?',
        msg6    = 'We have found the gateway and occupied it.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'You have completed this mission. The next Chapter awaits you...',
    },
    pl =
    {
        Diary   = 'Dziennik',
        msg0    = 'Czwarty Dzień Jedenastego Miesiąca Szóstego Roku.\n\nNajwyraźniej nasz półwysep jest połączony z resztą kontynentu jedynie dwoma dolinami. Ślady wskazują, że na południu stacjonuje barbarzyńskie plemię Wikingów.\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Szukaj bramy.',
        msg2    = 'Pojmany Wiking zdradził nam, że inne wyjątkowo silne plemię żyje na półwyspie położonym na zachód od nas. Posiada ponoć duże złoża złota. Wejście na ich tereny usytuowane na zachód od dużej zatoki jest ciężko ufortyfikowane. Nie byliśmy w stanie zdobyć więcej szczegółów.',
        msg4    = '19 Dzień Czwartego Miesiąca Siódmego Roku\n\nWikingowie są bardzo silni. Musi istnieć jakiś sposób na wejście do ich fortecy!\nCo ciekawe, plemię to także posiada cmentarz wielorybów na małym półwyspie, na północ od ich kopalni złota. Ciekawym, czy lud ten także lęka się duchów tych zwierząt?',
        msg6    = 'Znaleźliśmy bramę i zajęliśmy ją.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'Ukończyłeś misję. Następny Rozdział oczekuje...',
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
    rttr:GetPlayer(2):SetName('Olof')
 -- rttr:GetPlayer(2):SetPortrait(5)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(10, 51, 22)
    rttr:GetWorld():SetComputerBarrier(10, 36, 23)
    rttr:GetWorld():SetComputerBarrier(8, 50, 60)
    rttr:GetWorld():SetComputerBarrier(8, 49, 64)
    rttr:GetWorld():SetComputerBarrier(8, 47, 68)

    -- player 0 always commands
    rttr:GetPlayer(0):DisableAllBuildings()
    rttr:GetPlayer(0):EnableBuilding(BLD_WOODCUTTER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_FORESTER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_QUARRY, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_FISHERY, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_HUNTER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_SAWMILL, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_FARM, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_PIGFARM, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_DONKEYBREEDER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_SLAUGHTERHOUSE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_MILL, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_BAKERY, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_IRONSMELTER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_METALWORKS, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_ARMORY, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_MINT, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_BREWERY, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_GOLDMINE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_IRONMINE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_COALMINE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_GRANITEMINE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_STOREHOUSE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_BARRACKS, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_GUARDHOUSE, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_WATCHTOWER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_FORTRESS, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_LOOKOUTTOWER, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_WELL, false)
    rttr:GetPlayer(0):EnableBuilding(BLD_CATAPULT, false)

    -- player 1 always commands
    rttr:GetPlayer(1):EnableAllBuildings()

    -- player 2 always commands
    rttr:GetPlayer(2):EnableAllBuildings()

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[10] = true
    activeEvents[20] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(90, 18)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(1):PlaceHQ(112, 82)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(2):PlaceHQ(40, 54)
        rttr:GetPlayer(2):AIConstructionOrder(43, 59, BLD_FORTRESS)
        rttr:GetPlayer(2):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 30,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 46,
            [GD_MEAT      ] = 6,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 8,
            [GD_FISH      ] = 4,
            [GD_HAM       ] = 3,
            [GD_BREAD     ] = 6,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 8,
            [GD_COAL      ] = 30,
            [GD_IRONORE   ] = 15,
            [GD_GOLD      ] = 15,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 4,
            [GD_TONGS     ] = 1,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 2,
            [GD_SHOVEL    ] = 1,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 3,
            [GD_SCYTHE    ] = 3,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 4,
            [GD_SHIELD    ] = 4,
            [GD_BOAT      ] = 15,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 90,
            [GD_STONES    ] = 90,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 40,
            [GD_IRONORE   ] = 15,
            [GD_GOLD      ] = 35,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 4,
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
            [GD_STONES    ] = 120,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 30,
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
            [JOB_WOODCUTTER       ] = 6,
            [JOB_FISHER           ] = 4,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 4,
            [JOB_MILLER           ] = 2,
            [JOB_BAKER            ] = 2,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 6,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 2,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 4,
            [JOB_GEOLOGIST        ] = 4,
            [JOB_PRIVATE          ] = 24,
            [JOB_PRIVATEFIRSTCLASS] = 4,
            [JOB_SERGEANT         ] = 3,
            [JOB_OFFICER          ] = 2,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 7,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 10,
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
            [JOB_BREWER           ] = 5,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 35,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 8,
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
            [JOB_BREWER           ] = 5,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 8,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 40,
            [JOB_PRIVATEFIRSTCLASS] = 9,
            [JOB_SERGEANT         ] = 3,
            [JOB_OFFICER          ] = 2,
            [JOB_GENERAL          ] = 1,
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
        rttr:GetWorld():AddStaticObject(13, 66, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(6)
        rttr:SetCampaignChapterCompleted('roman', 7)
        rttr:EnableCampaignChapter('roman', 8)
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
    elseif activeEvents[10] and ((p == 0 and o == 1) or (p == 1 and o == 0)) then
        showMissionText(2)
        triggerEndEvent(10, 10)
    end

    if p ~= 0 then return
    elseif activeEvents[20] and x == 43 and y == 59 then
        showMissionText(4)
        triggerEndEvent(20, 20)
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[30] and x == 13 and y == 66 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
