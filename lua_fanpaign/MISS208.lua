-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0008.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Intermezzo - Mission von Achim Ruziczka\n\nEin kleines Zwischenspiel, vor dem Finale. So hatten es uns die Götter versprochen. Als Dank für unsere Treue zu ihnen, trotz der uns auferlegten Prüfungen. Wollen wir nur hoffen, daß das Intermezzo kein Fiasko wird. Die äußeren Umstände scheinen bisher gut zu sein. Hinter unserem Hauptquartier gibt es reichlich Erze. Vor uns ist Bau- material, und in der fruchtbaren Senke dahinter, gibt es das Schlaraffenland pur! Leichtsinnig sollten wir aber nicht werden!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Beobachte das Baumaterial',
        msg2    = 'Trügerisch war der erste Anschein!\n\nSo einfach machen es uns die Götter doch wieder nicht. Das Baumaterial ist zwar reichlich aber nicht üppig. Leider ist der Untergrund am Berghang nicht gut zum Bauen geeignet. Der Boden ist derart locker, daß sämliche Versuche größere Gebäude zu errichten fehlschlugen. Auch leben in der Senke kriegerische Völker, die alles andere im Schilde führen, als uns friedlich durch ihr Land zum Tor ziehen zu lassen. Wir sollten unbedingt das Gebirge genauer ansehen. Hoffen wir, daß es einen Übergang gibt. Was uns dann erwartet ist nicht vorherzusehen, aber schlimmer als der Weg nach Süden kann es nicht sein.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Suche den Paß über das Gebirge! Baue in sicherer Entfernung einen Hafen, oder ein Lagerhaus. Sei auf alles vorbereitet!',
        msg4    = 'Gute Nachrichten erreichen mich soeben!\n\nMeine Männer kamen ganz aufgeregt zu mir zurück. Sehr weit oben im Norden gibt es einen Ort, an dem man große Gebäude bauen kann. Direkt am Meer! Sollte es stimmen, was der erste Eindruck verspricht, so ist dort sogar eine Fahrrinne für große Schiffe im Wasser vorhanden. Wir könnten also einen Hafen bauen. Dieser Weg scheint sinnvoller zu sein als der Landweg, direkt durch das Gebiet der kriegerischen Völker! Hoffen wir das Beste für uns!  \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Nutze die Möglichkeit zum Hafenbau! Baue ebenfalls eine Werft. Starte so bald als möglich eine Expedition! ',
        msg6    = 'Wir haben das Tor erreicht und aktiviert. Der Weg ist frei.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n ',
        msgh6   = 'Sie haben diese Mission erfüllt. Das letzte Kapitel wartet schon auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = "Intermezzo\nA short interlude before the Final.\n\nA grace the Gods had promised for keeping our trust in them, in spite of  the duress imposed on us. Let's only hope, it will not become a disaster. Circumstances seem favourably enough, however. In the back of our headquarter ores are abundant. In front we have building material and in the fertile valley beyond lies the very Land of Plenty!\n\nBut let's not become careless!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh0   = 'Have an eye on the building material!',
        msg2    = "Deceptive was the first look!\n\nThe Gods are not that generous! There is enough buiding material, but not abundant. Regrettably the ground on the slope of the mountain is not suited for building. It's that loose that any attempt failed to build larger buildings.\nIn the valley also dwell warlike tribes, intending nothing less than letting us travel to The Arc peacefully. We should have a close look at the mountain. Hopefully there is some sort of pass. We don't know, what to expect, but anything will be better than the way to the South!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh2   = 'Scout for a pass through the mountains!  Build a harbour or a storehouse in safe distance. Be prepared for anything!',
        msg4    = "Good news I received!\n\nAll exited my men came back. In the extreme North there is a place where large buildings can be built. Next to the sea! If this survey proves true, there is even a channel allowing large vessels to reach open sea!  We can build a harbour. This route seems more promising than by land, directly through the area of those hostile nations. Let's hope for the best!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh4   = 'Make use of the chance to build a harbour, also build a shipyard. As soon as possible start an expedition! ',
        msg6    = 'We have reached and activated The Arc! The passage is open.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n ',
        msgh6   = 'You have succeded in this mission. The last part lies before you. ',
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
    rttr:GetPlayer(3):SetNation(NAT_ROMANS)
    rttr:GetPlayer(3):SetName('Brutus')
 -- rttr:GetPlayer(3):SetPortrait(2)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(4):SetName('Mnga Tscha')
 -- rttr:GetPlayer(4):SetPortrait(11)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(11, 97, 118)

    -- player 0 always commands
    rttr:GetPlayer(0):DisableAllBuildings()
    rttr:GetPlayer(0):EnableAllBuildings()
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
    activeEvents[ 1] = true
    activeEvents[ 2] = true
    activeEvents[23] = true
    activeEvents[30] = true
    activeEvents[50] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(91, 50)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(1):PlaceHQ(70, 80)
        rttr:GetPlayer(1):AIConstructionOrder(64, 80, BLD_FORTRESS)
        rttr:GetPlayer(1):AIConstructionOrder(76, 80, BLD_FORTRESS)
        rttr:GetPlayer(1):AIConstructionOrder(73, 74, BLD_WATCHTOWER)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(2):PlaceHQ(119, 75)
        rttr:GetPlayer(2):AIConstructionOrder(125, 75, BLD_FORTRESS)
        rttr:GetPlayer(2):AIConstructionOrder(113, 75, BLD_GUARDHOUSE)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(3):PlaceHQ(70, 110)
        rttr:GetPlayer(3):AIConstructionOrder(64, 110, BLD_FORTRESS)
        rttr:GetPlayer(3):AIConstructionOrder(76, 110, BLD_FORTRESS)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(4):PlaceHQ(130, 100)
        rttr:GetPlayer(4):AIConstructionOrder(136, 100, BLD_FORTRESS)
        rttr:GetPlayer(4):AIConstructionOrder(127, 106, BLD_FORTRESS)
        rttr:GetPlayer(4):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 80,
            [GD_STONES    ] = 30,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 30,
            [GD_IRONORE   ] = 15,
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
            [GD_BOAT      ] = 0,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 60,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 100,
            [GD_IRONORE   ] = 50,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 60,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 100,
            [GD_IRONORE   ] = 50,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 60,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 100,
            [GD_IRONORE   ] = 50,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 40,
            [GD_HAM       ] = 60,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 40,
            [GD_COAL      ] = 100,
            [GD_IRONORE   ] = 50,
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
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 15,
            [JOB_FISHER           ] = 8,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 5,
            [JOB_STONEMASON       ] = 5,
            [JOB_HUNTER           ] = 3,
            [JOB_FARMER           ] = 8,
            [JOB_MILLER           ] = 5,
            [JOB_BAKER            ] = 4,
            [JOB_BUTCHER          ] = 3,
            [JOB_MINER            ] = 10,
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
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 5,
            [JOB_SHIPWRIGHT       ] = 1,
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
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 15,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 6,
            [JOB_PLANER           ] = 2,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 4,
            [JOB_SERGEANT         ] = 2,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 30,
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
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 6,
            [JOB_PLANER           ] = 2,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 10,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 20,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
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
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 8,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 10,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 20,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 4 people
        rttr:GetPlayer(4):AddPeople({
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
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 8,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 10,
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
    elseif e == 50 then
        rttr:GetWorld():AddStaticObject(97, 118, 560, 0xFFFF, 2)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(97, 118, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(6)
        rttr:SetCampaignChapterCompleted('fanpaign', 9)
        rttr:EnableCampaignChapter('fanpaign', 10)
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
    elseif activeEvents[2] and x == 79 and y == 17 then
        showMissionText(4)
        triggerEndEvent(2, 2)
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[30] and x == 97 and y == 118 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
