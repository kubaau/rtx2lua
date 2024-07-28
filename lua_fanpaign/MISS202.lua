-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0002.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Der Limes - Mission von Achim Ruziczka\n\nDer augenblickliche Zustand:\n\nNoch sind die Götter uns nicht wohlgesonnen. Wieder trafen wir auf eine düstere Welt. Weiterhin kam, was kommen mußte. Es kam zur Trennung. Viele der Unzufriedenen versuchen nun Ihr Glück selbst zu meistern. Noch bestehen zwar Verbindungen, auch konnte ein Bruch im Zorn vermieden werden. Wie lange dieser Zustand anhält ist nicht vorherzusehen. Mit meinen mir verbliebenen Mannen werden wir versuchen uns für alle Fälle zu wappnen!\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Beobachte Deine Träger, der Aderlaß durch die Teilung war doch enorm! Baue nur sinnvolle Straßen, die auch besetzt werden können. Weniger kann hier mehr bedeuten!',
        msg2    = 'Angst geht umher!\n\nIm Osten haben Späher haben riesige Ruinen von alten Verteidigungsanlagen gesichtet. Welche Mächte waren in der Lage, solche Wehrburgen einfach zu zerstören. Die Abtrünnigen provozieren die an uns grenzenden Asiaten, wir wissen nicht, wie lange dies noch gut geht. Im Norden leben wehrhafte Wickinger, von Ihnen haben wir erfahren, daß die Asiaten die Wehranlagen zerstört haben, weil unsere "Vorgänger" nur auf das Gold der Asisaten aus gewesen seien. Etwas Gutes haben wir flüchtig mitbekommen, die Gewässer sind für Schifffahrt geeignet, und im Süden muß es Inseln mit Rohstoffen geben.\n\n\n\n\n\n\n\n\n\n  ',
        msgh2   = 'Schütze Dich gegen alle Seiten! Suche die Inseln, auf denen die Erze lagern. Bedenke aber, Lagerhäuser und Häfen sind bevorzugte Angriffsziele! Achte darauf, was die anderen Völker tun!',
        msg4    = 'Wir haben das Tor gefunden und besetzt. Wollen wir hoffen, daß uns die Götter die Freveltaten der Abtrünnigen nicht zur Last legen. Schön wäre es,  wenn  wir uns in einer friedlicheren und freundlicheren Welt wiederfinden würden.\n\nAuch der Zorn der Götter sollte sich legen!\n\nHoffen wir das Beste für uns. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet schon mit neuen Abenteuern auf Sie!',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'The Limes - Mission by Achim Ruziczka\n\nOur present Situation:\n\nStill the Gods are not in our favour. Once again we were dumped onto a dark world.\nAbove all - as foreseeable, segregation split our forces. Many of the incontent now try to master their luck on their own. Still there are connections and a wrathful separation has been avoided. However, one does not know, how long this fallible truce may last.\nIn any case, we will try with those few men, who kept their faith, to prepare for whatever there may be in store for us.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Observe your carriers, the drain caused by the separation has been enormous! Only build roads, that can be manned. \nSelf-restriction may be more\neffective in the end!',
        msg2    = 'Anxiety spreads!\n\nIn the East, scouts have seen enormous ruins of ancient fortifications. What forces may have been able to simply destroy such bulwarks. \nThe renegades are provoking the Asians bordering on us. We don\'t know, how long this will go on in peace. In the North there live warlike Vikings. They told us that the Asians have destroyed the fortresses, because our "predecessors" had been just too greedy for their gold. \nVaguely we heard something good: the seas can be sailed and in the South there must be islands, that have minerals and ore.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n  ',
        msgh2   = 'Guard yourself to all sides! Try to detect the Islands, where ore  can be found. But mind, stores and harbours are prone to be attacked!\nWatch out for what the other\npeoples are doing!',
        msg4    = "We have found The Arc and occupied it. Let's hope, that the Gods don't hold against us the outrages the renegades committed. \n\nHow delightful would it be, to find a World more pleasant and peaceful!\n\nAlso the ire of the Gods should subside!\n\nLet's hope for the best. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh4   = 'You have mastered this mission. The next chapter is already waiting for you with more adventures!',
    },
})

function getNumPlayers()
    return 6
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
    rttr:GetPlayer(2):SetName('Erik')
 -- rttr:GetPlayer(2):SetPortrait(3)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(3):SetName('Yamauchi')
 -- rttr:GetPlayer(3):SetPortrait(6)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(4):SetName('Hakirawashi')
 -- rttr:GetPlayer(4):SetPortrait(8)

    rttr:GetPlayer(5):SetAI(3)
    rttr:GetPlayer(5):SetColor(5)
    rttr:GetPlayer(5):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(5):SetName('Tsunami')
 -- rttr:GetPlayer(5):SetPortrait(7)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(15, 113, 68)
    rttr:GetWorld():SetComputerBarrier(15, 178, 27)
    rttr:GetWorld():SetComputerBarrier(15, 145, 9)
    rttr:GetWorld():SetComputerBarrier(15, 100, 5)

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

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[ 1] = true
    activeEvents[23] = true
    activeEvents[24] = true
    activeEvents[30] = true
    activeEvents[50] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(0):PlaceHQ(53, 72)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):PlaceHQ(61, 98)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(2):PlaceHQ(38, 39)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):PlaceHQ(86, 64)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(4):PlaceHQ(151, 45)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(5):PlaceHQ(114, 17)
        rttr:GetPlayer(5):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 70,
            [GD_BOARDS    ] = 70,
            [GD_STONES    ] = 70,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 10,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 10,
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
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 80,
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
            [GD_IRONORE   ] = 20,
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

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 80,
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
            [GD_IRONORE   ] = 20,
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

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 80,
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
            [GD_IRONORE   ] = 20,
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

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 80,
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
            [GD_IRONORE   ] = 20,
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

        -- player 5 wares
        rttr:GetPlayer(5):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 80,
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
            [GD_IRONORE   ] = 20,
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
            [JOB_HELPER           ] = 15,
            [JOB_WOODCUTTER       ] = 5,
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
            [JOB_DONKEYBREEDER    ] = 5,
            [JOB_IRONFOUNDER      ] = 5,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 5,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 50,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 10,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 100,
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
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 100,
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
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
            [JOB_HELPER           ] = 100,
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
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 4 people
        rttr:GetPlayer(4):AddPeople({
            [JOB_HELPER           ] = 100,
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
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 5 people
        rttr:GetPlayer(5):AddPeople({
            [JOB_HELPER           ] = 100,
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
            [JOB_MINER            ] = 10,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 10,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 10,
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
        rttr:GetWorld():AddStaticObject(165, 58, 560, 0xFFFF, 2)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(165, 58, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(4)
        rttr:SetCampaignChapterCompleted('FANpaign', 3)
        rttr:EnableCampaignChapter('FANpaign', 4)
    end

    if not isLoading then
        local n = #eventHistory
        eventHistory[n + 1] = e
        eventHistory[n + 2] = trigger
    end

    activeEvents[trigger] = false
end

function onGameFrame(gf)
    if activeEvents[1] and rttr:GetPlayer(0).GetStatisticsValue ~= nil and rttr:GetPlayer(0):GetStatisticsValue(STAT_COUNTRY) >= 300 then
        showMissionText(2)
        triggerEndEvent(1, 1)
    end
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
    elseif activeEvents[30] and x == 165 and y == 58 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
