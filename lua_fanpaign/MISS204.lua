-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0004.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Ozeanien - Mission von Heiko Bieger\n\nWir können es kaum glauben: Der Zorn der Götter muß sich gelegt haben! Endlich wieder sattes Grün vor Augen, einen Wald in der Nähe mit Wild zum Jagen. In der Luft liegt der angenehme Geruch des Meeres! Im Nordosten haben Späher auch schon einen günstigen Hafenbauplatz entdeckt. Das Gebirge im Westen verspricht reichlich Erze. Und bisher habe wir noch keine Feinde entdecken können. Nutzen wir also unbedingt die Gunst der Stunde. Wer weiß, wie lange uns die Götter derart wohlgesonnen sind.                                                                                                               \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Hoffe nicht auf ewige Gnade. Die Götter sind nur den fleißigen wohlgesonnen. Sieh Dich vor, und lasse Dich nicht überraschen!',
        msg2    = 'Barbaren!\n\nWikinger von der übelsten Sorte! Es scheint so als wollten sie alles und jeden vernichten. Uns bleibt wahrscheinlich nur der Rückzug über das Meer. Wollen wir hoffen, daß wir schnell einen günstigen Hafen finden, wo es dann friedlichere Nachbarn gibt! Wir sollten so viel wie möglich von unserer Ausrüstung retten, wer weiß ob wir wieder zurückkommen können!                                                                                                        \n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Nutze die Zeit sinnvoll!',
        msg4    = 'Endlich der richtige Hafen? Wir hoffen es!\n\nArtefakte und Felszeichnungen deuten darauf hin. Die Bilder zeigen ein Gebilde, ähnlich der uns bekannten Tore. Wir konnten nur noch nicht verstehen warum sich bei den jeweiligen Zeichnungen immer wieder Boote befanden. Sollten wir etwa im Innern der Insel nochmals Schiffe bauen müssen, um weiter zu kommen?? Auch scheinen die Felszeichnungen darauf hinzuweisen, daß der Weg nur hier über das Gebirge führt.                                  \n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Suche den Paß über das Gebirge, sei auf alles vorbereitet.   ',
        msg6    = 'Wir haben das Tor erreicht und aktiviert. Der Weg ist frei.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n ',
        msgh6   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet schon auf Sie...',
        msg8    = 'Achtung    MISSION - CD    Besitzer!\n         ***********************\n       **      W A R N U N G !     **\n         ***********************\nBitte vergewissern Sie sich, daß das Update installiert ist! Ohne Update lassen sich gespeicherte Spiekstände dieser Mission nicht wieder aufrufen (wie einst bei "Im Ödland"). Speichern sie "JETZT" ab, und rufen Sie den abgespeicherten Spielstand wieder auf. Läßt sich der Spielstand wieder laden, ist alles OK. Kommt eine Fehlermeldung muß zuerst das Update installiert werden. Nach dem Update muß nochmals die FANpaign installiert werden, da wichtige Teile der Daten überschrieben wurden. Bei Gold Edition gibt es keine Probleme!',
        msgh8   = 'Update ist zu erhalten bei:\n\nhttp://www.Siedler3.de/Siedler2\n\noder:     http://www.Bluebyte.de',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = "Oceania \na mission by Heiko Bieger\n\nWe just can't believe it: The wrath of the gods must have subsided. Again lavish green caresses our eyes, forests nearby are teeming with game. The air carries the pleasant smell of the sea! Scouts detected a convenient spot for a harbour in the Northeast. To the West, the mountains promise ores abundandly. And still we haven't detected enemies. Let's take advantage of the favourable condition. Who knows, how long this generous mood of the gods will last!                                                                                                               \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh0   = "Don't hope for endless mercy. The Gods only love the diligent. Take care and let yourself not be caught unawares! ",
        msg2    = "Savages!\n\nVikings of the worst kind! Looks like they are set on demolishing each and everything. We probably are only able to retreat by sea. Let's hope, that we can find a convenient harbour very soon, where there are more friendly neigh- bours! We also should save as much of our equipment as possible, who knows, whether we will be able to return!                                                                                                      \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh2   = 'Use your time wisely!',
        msg4    = "The right harbour at last? We hope so.\nArtefacts and drawings on the rock hint that much. The pictures show an object resembling the well known Arches. \nWe just don't understand, why there are always boats on these drawings. Should we have to build ships again in the midst of this island to go on? Also the drawings seem to convey, that only here a passage crosses the mountains.                                  \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh4   = 'Search the passage across the mountains and be prepared for everything. ',
        msg6    = 'We have reached The Arc and activated it. We are free to go.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n ',
        msgh6   = 'You successfully fulfilled this misson. The next chapter is already waiting ...',
        msg8    = 'Attention    MISSION - CD    owners!!\n       ***********************\n       **    W A R N I N G !    **\n       ***********************\nPleace make sure you have installed the Update! Without update saved games of this mission cannot be loaded again (as in the original mission "Wasteland"). Save the game " N O W " and try to load the saved game again. If the game loads ok, then everything is allright. If you got an error message, you must installed the update first. After the Update you will have to install this FANpaign again, since some files will have been overwritten.\nhttp://www.Bluebyte.com\nhttp://Siedler3.de/Siedler2',
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
    rttr:GetPlayer(5):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(5):SetName('Yamauchi')
 -- rttr:GetPlayer(5):SetPortrait(6)

    rttr:GetPlayer(6):SetAI(3)
    rttr:GetPlayer(6):SetColor(6)
    rttr:GetPlayer(6):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(6):SetName('Hakirawashi')
 -- rttr:GetPlayer(6):SetPortrait(8)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(12, 131, 173)
    rttr:GetWorld():SetComputerBarrier(15, 196, 127)
    rttr:GetWorld():SetComputerBarrier(12, 54, 82)
    rttr:GetWorld():SetComputerBarrier(12, 93, 159)

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
    activeEvents[ 1] = true
    activeEvents[ 2] = true
    activeEvents[ 3] = true
    activeEvents[ 4] = true
    activeEvents[23] = true
    activeEvents[50] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(122, 181)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):PlaceHQ(162, 127)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):PlaceHQ(177, 60)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(3):PlaceHQ(89, 199)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(4):PlaceHQ(77, 168)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(6)
        rttr:GetPlayer(5):PlaceHQ(239, 216)
        rttr:GetPlayer(5):ClearResources()

        -- player 6 firststart commands
        rttr:GetPlayer(6):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(6):PlaceHQ(15, 129)
        rttr:GetPlayer(6):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 20,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 15,
            [GD_IRONORE   ] = 15,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 5,
            [GD_COINS     ] = 0,
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
            [GD_BOARDS    ] = 70,
            [GD_STONES    ] = 50,
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

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
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
            [GD_STONES    ] = 120,
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
            [JOB_PRIVATE          ] = 45,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
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
            [JOB_PRIVATEFIRSTCLASS] = 15,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 5,
            [JOB_GENERAL          ] = 55,
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
            [JOB_GEOLOGIST        ] = 1,
            [JOB_PRIVATE          ] = 32,
            [JOB_PRIVATEFIRSTCLASS] = 16,
            [JOB_SERGEANT         ] = 8,
            [JOB_OFFICER          ] = 4,
            [JOB_GENERAL          ] = 2,
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
            [JOB_PRIVATE          ] = 32,
            [JOB_PRIVATEFIRSTCLASS] = 16,
            [JOB_SERGEANT         ] = 8,
            [JOB_OFFICER          ] = 4,
            [JOB_GENERAL          ] = 2,
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
            [JOB_GENERAL          ] = 30,
            [JOB_SCOUT            ] = 10,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- events which are triggered right from the start
        triggerEndEvent(0, 0)
        triggerEndEvent(4, 4)
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
    elseif e == 4 then
        showMissionText(8)
    elseif e == 50 then
        rttr:GetWorld():AddStaticObject(181, 61, 560, 0xFFFF, 2)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(181, 61, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(6)
        rttr:SetCampaignChapterCompleted('fanpaign', 5)
        rttr:EnableCampaignChapter('fanpaign', 6)
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
    elseif activeEvents[1] and ((p == 0 and o == 3) or (p == 3 and o == 0)) then
        showMissionText(2)
        triggerEndEvent(1, 1)
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[2] and x == 116 and y == 43 then
        showMissionText(4)
        triggerEndEvent(2, 2)
        triggerEndEvent(2, 2)
    elseif activeEvents[3] and x == 181 and y == 61 then
        triggerEndEvent(3, 3)
        triggerEndEvent(99, 3)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
