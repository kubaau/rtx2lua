-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0004.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Um uns herum nur öde Wildnis. Die Ränder dieser Welt scheinen unüberwindliche Gebirge oder Lavaströme zu sein.\n\nEs ist unmöglich, hier die Zeit zu bestimmen. Ein diffuses, immerwährendes Zwielicht liegt über allem als gäbe es weder Sonne noch Gestirne.\n\nWelche Wunder und Gefahren liegen hier verborgen?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Halten Sie Ausschau nach dem Tor. Der Platz zum Bauen ist begrenzt; überlegen Sie gut, wie Sie Ihre Resourcen ausnutzen.',
        msg2    = 'Wir haben Menschen getroffen, die noch viel seltsamer ausschauen, als die blonden Riesen, denen unser Schiffsbauer angehört. \nSie nennen sich "Söhne Nippons", sind klein und schmal, aber offensichtlich von großer Gewandheit und Zähigkeit. Das Seltsame an ihnen ist aber ihre Hautfarbe. Sie ist ockergelb und ihre Augen sind nur kleine Schlitze. Sie wirken freundlich, obwohl ihr Blick sehr beunruhigend ist, da man die Augen nicht sieht.',
        msg4    = 'Die "Söhne Nippons" im Süden haben noch Verwandte im Norden. Ihre Beziehungen untereinander sind anscheinend sehr freundschaftlich. Krieg mit dem einen Volk bedeutet auch Krieg mit dem anderen. Wir müssen uns etwas einfallen lassen...',
        msg6    = 'Wir haben das Tor gefunden und besetzt. Wir können es betreten, wann immer wir wollen!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet schon auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'We are surrounded by nothing but barren wilderness. The edges of this world seem to be either impenetrable mountains or lava flows.\n\nIt is impossible to keep track of time here. A dim, perpetual twilight hangs over everything and there is neither sunlight nor starlight.\n\nWhat wonders and dangers lie hidden here?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Keep looking for the gateway. There is limited space for buildings; carefully consider how to exploit your resources.',
        msg2    = 'We have met humans of much stranger appearance than our Viking shipwright. \nThey call themselves "Sons of Nippon." They are short and thin but obviously skilled and tenacious. Their strangest feature is their skin color. It is yellow ochre and their eyes are just small slits. They act in a friendly manner although they are unsettling to behold because of their strange appearance.',
        msg4    = 'The "Sons of Nippon" in the south have relatives in the north. Their relationship with each other appears very friendly. War with one race means war with the other. We must consider the prospect of war carefully...',
        msg6    = 'We have found the gateway and occupied it. We can go through it whenever we want!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'You have completed this mission. The next Chapter awaits you...',
    },
    pl =
    {
        Diary   = 'Dziennik',
        msg0    = 'Otacza nas dzika, niezbadana okolica. Krawędź świata to albo niemożliwa do przekroczenia góra albo płynąca lawa.\n\nNiemożliwe okazuje się także śledzenie upływu czasu. Mrok zasłonił niebo. Nie sposób wypatrzeć słońca czy gwiazd.\n\nNa jakie cuda i na jakie niebezpieczeństwa możemy się tutaj natknąć?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Nie przestawaj poszukiwać bramy. Masz ograniczone miejsce na budynki; z rozwagą decyduj jak wykorzystywać będziesz surowce.',
        msg2    = 'Spotkaliśmy ludzi jeszcze dziwniejszych od naszego szkutnika z północy.\nNazywają siebie Synami Nipponu. Są niscy i chudzi, lecz najwyraźniej uzdolnieni i sprytni. Najbardziej zadziwia jednak kolor ich skóry. Jest to bowiem barwa żółtej ochry, zaś oczy ich osadzone są jedynie w wąskich szparkach. Są nastawieni pokojowo, lecz obserwowanie ich jest bardzo nieprzyjemne. Przede wszystkim, ze względu na ich osobliwy wygląd.',
        msg4    = 'Synowie Nipponu z południa mają krewnych na północy. Ich wzajemne stosunki określić można mianem bardzo przyjacielskich. Wojna z jednymi oznacza wojnę z drugimi. Tak też, ewentualność konfliktu zbrojnego musimy rozważać niezwykle ostrożnie.',
        msg6    = 'Odnaleźliśmy bramę i zajęliśmy ją. Możemy rozpocząć przemarsz, kiedy tylko zechcemy!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
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
    rttr:GetPlayer(1):SetName('Hakirawashi')
 -- rttr:GetPlayer(1):SetPortrait(8)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(2):SetName('Tsunami')
 -- rttr:GetPlayer(2):SetPortrait(7)
end

function onStart(isFirstStart)
    -- world always commands

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
    activeEvents[ 1] = true
    activeEvents[10] = true
    activeEvents[20] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(78, 24)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(1):PlaceHQ(28, 37)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(2):PlaceHQ(45, 95)
        rttr:GetPlayer(2):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 10,
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

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 60,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 10,
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
            [GD_BOAT      ] = 15,
        })

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 50,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 10,
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
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 15,
            [JOB_FISHER           ] = 8,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 5,
            [JOB_STONEMASON       ] = 2,
            [JOB_HUNTER           ] = 3,
            [JOB_FARMER           ] = 8,
            [JOB_MILLER           ] = 5,
            [JOB_BAKER            ] = 4,
            [JOB_BUTCHER          ] = 3,
            [JOB_MINER            ] = 8,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 5,
            [JOB_DONKEYBREEDER    ] = 2,
            [JOB_IRONFOUNDER      ] = 3,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 4,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 5,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 15,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 5,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 5,
            [JOB_BAKER            ] = 5,
            [JOB_BUTCHER          ] = 5,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 5,
            [JOB_PIGBREEDER       ] = 5,
            [JOB_DONKEYBREEDER    ] = 5,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 15,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 15,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 4,
            [JOB_SERGEANT         ] = 2,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 20,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 15,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 5,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 5,
            [JOB_BAKER            ] = 5,
            [JOB_BUTCHER          ] = 5,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 5,
            [JOB_PIGBREEDER       ] = 5,
            [JOB_DONKEYBREEDER    ] = 5,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 15,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 1,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 20,
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
        rttr:GetWorld():AddStaticObject(19, 37, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(6)
        rttr:SetCampaignChapterCompleted('roman', 5)
        rttr:EnableCampaignChapter('roman', 6)
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
    elseif activeEvents[20] and ((p == 0 and o == 2) or (p == 2 and o == 0)) then
        showMissionText(4)
        triggerEndEvent(20, 20)
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[1] and x == 19 and y == 37 then
        triggerEndEvent(1, 1)
        triggerEndEvent(99, 1)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
