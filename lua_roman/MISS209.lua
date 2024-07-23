-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0009.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = '17.Tag im 6.Monat des 10.Jahres\n\nRömer. Vor dem zehnten Tor stehen tatsächlich Römer. Aber sie sind uns keineswegs freundlich gesinnt. Vielleicht sind sie die andere Seite derselben Münze, der verfeindete Bruder Remus. Vielleicht ist ihr Tor dasjenige, welches uns in unser geliebtes Rom zurückbringt.\nEs ist wie die alte Sage:\nUm Roms Willen müssen wir den Bruderkampf aufnehmen. Seit fast zehn Jahren träumen wir tagtäglich von unserer Heimat. Wir werden jetzt nicht aufgeben.\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Sammeln Sie Ihre Kräfte um durchzubrechen! Suchen Sie nach dem Tor!',
        msg2    = 'Letzter Tag des 10.Jahres.\nDes Octavius letzter Eintrag in dieses Tagebuch\n\nWir haben es geschafft. Morgen werden wir nach Rom zurückkehren. Genau zehn Jahre, nachdem es uns in diese Inselwelt verschlagen hat. Zehn Jahre, in denen wir auf den Spuren unserer Väter wandelten. Zehn Jahre, in denen wir lernten, was Rom groß gemacht hat. Wir werden den Göttern ein großes Dankesfest bieten und unsere Familien und Freunde wiedersehen.\nIch kann es kaum erwarten.\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Sie haben es geschafft!',
        msg4    = 'Die Aura der Entscheidung liegt über diesem Ort. Werden wir Rom jemals wiedersehen? Wir müssen alle unsere Kraft zusammennehmen, denn diese Insel scheint unsere große Chance zu sein...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Seien Sie vorsichtig. Sie sollten den Feind erst angreifen, wenn sie es mit beiden Gegnern aufnehmen können.',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'The 17th Day of the Sixth Month of the 10th Year.\n\nRomans are actually standing in front of the tenth gateway. They are not at all friendly. Perhaps they are the other side of the coin, the enemy brother Remus. Maybe their gateway is the one that will take us back to our beloved Rome.\nAs the old legend says:\n"For the sake of Rome brother shall fight against brother." For almost ten years we have been constantly dreaming of our homeland. We shall not give up now.\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Muster all of your forces in order to break through! Capture the gateway!',
        msg2    = 'Last Day of the 10th Year.\nLast entry of Octavius in this Diary\n\n We have succeeded. Tomorrow we shall return to Rome exactly ten years after becoming castaways on this island. Ten years during which we traveled in the footsteps of our forefathers. Ten years during which we learned what made Rome so great. We shall offer a great feast of thanks to the gods and will see our families and friends again.\nI can hardly wait.\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'You have succeeded!',
        msg4    = 'The air is filled with anticipation and even a little reluctance, as we prepare to embark on the final and most dangerous chapter of our long journey home. Will we ever see Rome again?  We must summon all our strength because this island seems to be our best chance...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Be careful. Do not attack until you are sure you can defeat both enemies.',
    },
    pl =
    {
        Diary   = 'Dziennik',
        msg0    = 'Siedemnasty Dzień Szóstego Miesiąca Dziesiątego Roku.\n\nRzymianie stoją tuż przed naszą dziesiątą bramą. Nadmienić muszę, że wcale nie są przyjacielscy. Być może reprezentują drugą stronę monety - złego brata Remusa. Być może też, ich brama zawiedzie nas z powrotem do naszego ukochanego Rzymu.\nStara legenda mówi:\n"Dla dobra Rzymu, brat stanie przeciwko bratu." Przez prawie dziesięć lat wciąż śniliśmy o naszej ojczyźnie. Nie poddamy się przecież teraz!\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Zbierz wszystkie siły, aby przebić się! Przejmij bramę!',
        msg2    = 'Ostatni Dzień 10 Roku.\nOstatni wpis do dziennika Oktawiana\n\nUdało nam się. Jutro powrócimy do Rzymu - dokładnie dziesięć lat po tym, jak zostaliśmy rzuceni na te wyspy. Dziesięć lat, podczas których podążaliśmy śladami naszych przodków. Dziesięć lat, podczas których nauczyliśmy się, co uczyniło Rzym wielkim. Zorganizujemy wielką fiestę, aby podziękować bogom za możliwość ponownego ujrzenia naszych rodzin i przyjaciół.\nNie mogę się doczekać.\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Udało ci się!',
        msg4    = 'Powietrze nasycone jest oczekiwaniem oraz odrobiną niechęci, podczas gdy przygotowujemy się do ostatniego i chyba najniebezpieczniejszego rozdziału naszej opowieści o powrocie do domu. Czy zobaczymy znów Rzym? Musimy zebrać nasze wszystkie siły, gdyż ta wyspa zdaje się być naszą najpewniejszą szansą...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Bądź ostrożny. Nie atakuj, dopóki nie będziesz pewien, że uda ci się pokonać obu przeciwników.',
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
    rttr:GetPlayer(1):SetNation(NAT_ROMANS)
    rttr:GetPlayer(1):SetName('Brutus')
 -- rttr:GetPlayer(1):SetPortrait(2)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(2):SetName('Olof')
 -- rttr:GetPlayer(2):SetPortrait(5)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(10, 57, 73)
    rttr:GetWorld():SetComputerBarrier(10, 39, 29)

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
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(101, 98)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(1):PlaceHQ(57, 67)
        rttr:GetPlayer(1):AIConstructionOrder(57, 73, BLD_FORTRESS)
        rttr:GetPlayer(1):AIConstructionOrder(61, 68, BLD_FORTRESS)
        rttr:GetPlayer(1):AIConstructionOrder(53, 71, BLD_FORTRESS)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):PlaceHQ(107, 26)
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
            [GD_BOAT      ] = 2,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 120,
            [GD_STONES    ] = 120,
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
            [GD_STONES    ] = 60,
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
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 7,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 40,
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
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
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
        showMissionText(4)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(75, 40, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('roman', 10)
        rttr:SetCampaignCompleted('roman')
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
        showMissionText(0)
        triggerEndEvent(10, 10)
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[30] and x == 75 and y == 40 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
