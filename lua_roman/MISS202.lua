-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0002.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = '17.Tag im dritten Monat des 3.Jahres.\n\nInzwischen haben wir eine gewisse Routine im Aufbau einer lebensfähigen Siedlung entwickelt. Es sollte eigentlich alles wie am Schnürchen klappen.\n\nWir sind wieder auf einen Schiffbrüchigen getroffen. Er warnt uns vor aggressiven nubischen Stämmen im Osten der Insel. Dort gibt es ein Gebirge, in dem man angeblich große Mengen Gold finden kann. Von einem Tor wußte der Mann allerdings nichts. Er kennt aber auch nur einen kleinen Teil der Insel.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Rücken Sie weiter nach Osten vor.',
        msg2    = '23.Tag im 12.Monat des 3.Jahres.\n\nWir sind auf die Nubier getroffen. Sie verhalten sich sehr drohend, aber noch nicht offen aggressiv. Das wird wahrscheinlich nicht lange so bleiben. Wir sollten einen Spähturm bauen, um ihr Land besser überwachen zu können.\n\nDie Berichte von den reichen Goldvorkommen scheinen zu stimmen. Ihr Häuptling stolziert in seinem Goldschmuck einher wie ein Pfau.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Suchen Sie nach dem Tor.',
        msg4    = 'Erster Tag des zweiten Monats \nim 4.Jahr der Landung. \n\nDer Stamm im Norden versperrt uns den Weg zu einem weiteren Tor. Auch er betrachtet dieses als sein Heiligtum. Uns bleibt wieder nichts anderes übrig, als zu kämpfen.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Suchen Sie nach dem Tor im Norden.',
        msg6    = 'Wir haben das Tor erreicht und aktiviert. Wir wissen nicht, wohin uns der nächste Schritt führt, aber wir werden ihn gehen. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet schon auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = '17th Day of the Third Month of the 3rd Year.\n\nWe have now created something of a routine in establishing a viable settlement. Everything should now work like clockwork.\n\nWe came across another castaway. He warned us against hostile Nubian tribes in the east of the island. The mountains in the east also allegedly have large quantities of gold. The man knew nothing about a gateway but he was only familiar with a small part of the island.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Move eastwards.',
        msg2    = '23rd Day of the 12th Month of the 3rd Year.\n\nWe came into contact with the Nubians. Their behavior is very threatening but not openly aggressive. Their behavior will probably change before long. We should build a lookout tower so that we can keep a closer eye on their lands.\n\nThe reports of rich gold deposits seem to be true. The Nubian chieftain struts around in his gold jewelry like a peacock.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Search for the gateway.',
        msg4    = 'First Day of the Second Month \nof the 4th Year of Coming Ashore. \n\nThe tribe in the north is blocking our path to another gateway. They also regard it as their holy relic. We have no alternative but to fight.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Obtain access to the gateway in the north.',
        msg6    = 'We have reached the gateway and activated it. We know not where our next step will take us, but we shall go on.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'You have completed this mission. The next Chapter awaits you...',
    },
    pl =
    {
        Diary   = 'Dziennik',
        msg0    = '17 Dzień Trzeciego Miesiąca Trzeciego Roku.\n\nPopadliśmy już w coś na kształt rutyny w przygotowywaniu nowej osady. Mam nadzieję, że tym razem wszystko pójdzie jak należy.\n\nNapotkaliśmy kolejnego rozbitka. Ostrzegł nas przed wojowniczymi plemionami nubiańskimi, które upodobały sobie wschodnią część wyspy. Znajdujące się na wschodzie góry kryją rzekomo duże złoża złota. Jest tylko jeden sposób, aby sprawdzić, ile warte są te plotki. Napotkany rozbitek nie wiedział nic o bramach, z racji na marną wiedzę na temat co bardziej oddalonych terenów wyspy.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Poruszaj się na wschód.',
        msg2    = '23 Dzień Dwunastego Miesiąca Trzeciego Roku.\n\nNawiązaliśmy kontakt z Nubianami. Ich zachowanie jest złowrogie, lecz Nubianie dotychczas nie zaatakowali nas wprost. Gotowym iść o zakład, że ich zachowanie wkrótce zmieni się. Na gorsze. Powinniśmy wybudować wieżę obserwacyjną, aby móc lepiej kontrolować ich poczynania.\n\nPogłoski o bogatych złożach złota wydają się być prawdziwe. Wódz Nubian paraduje w swej złotej biżuterii, dumny niczym paw.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Szukaj bramy.',
        msg4    = '1 Dzień Drugiego Miesiąca\nCzwartego Roku od Wylądowania.\n\nPlemię na północy stoi na naszej drodze do kolejnej bramy. Oni także pojmują ją jako swe święte miejsce. Nie mamy wyboru. Będziemy walczyć.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Zdobądź dostęp do bramy na północy.',
        msg6    = 'Udało nam się dotrzeć do bramy i uaktywnić ją. Nie wiemy, gdzie dotrzemy tym razem, lecz nie zamierzamy też zatrzymać się.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'Ukończyłeś misję. Kolejny Rozdział oczekuje...',
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
    rttr:GetWorld():SetComputerBarrier(6, 70, 71)
    rttr:GetWorld():SetComputerBarrier(6, 59, 60)

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
    activeEvents[11] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands
        rttr:GetWorld():AddAnimal(70, 72, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(71, 71, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(37, 100, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(37, 104, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(35, 104, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(26, 86, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(26, 87, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(27, 88, SPEC_FOX)
        rttr:GetWorld():AddAnimal(30, 88, SPEC_STAG)
        rttr:GetWorld():AddAnimal(31, 86, SPEC_DEER)
        rttr:GetWorld():AddAnimal(26, 101, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(22, 102, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(31, 104, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(32, 106, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(30, 102, SPEC_FOX)
        rttr:GetWorld():AddAnimal(30, 106, SPEC_STAG)
        rttr:GetWorld():AddAnimal(35, 108, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(44, 78, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(45, 76, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(42, 77, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(46, 77, SPEC_FOX)
        rttr:GetWorld():AddAnimal(45, 76, SPEC_STAG)
        rttr:GetWorld():AddAnimal(87, 26, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(86, 26, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(109, 53, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(54, 70, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(49, 75, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(79, 39, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(58, 28, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(29, 94, SPEC_SHEEP)
        rttr:GetWorld():AddAnimal(29, 94, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(29, 94, SPEC_DEER)
        rttr:GetWorld():AddAnimal(29, 94, SPEC_DEER)
        rttr:GetWorld():AddAnimal(26, 93, SPEC_FOX)
        rttr:GetWorld():AddAnimal(109, 94, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(109, 93, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(103, 89, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(104, 87, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(96, 106, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(97, 103, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(98, 105, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(100, 105, SPEC_FOX)
        rttr:GetWorld():AddAnimal(100, 100, SPEC_SHEEP)

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(25, 97)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(1):PlaceHQ(66, 34)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(2):PlaceHQ(87, 96)
        rttr:GetPlayer(2):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 20,
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
            [GD_GOLD      ] = 8,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 4,
            [GD_TONGS     ] = 4,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 5,
            [GD_PICKAXE   ] = 4,
            [GD_HAMMER    ] = 3,
            [GD_SHOVEL    ] = 4,
            [GD_CRUCIBLE  ] = 5,
            [GD_RODANDLINE] = 2,
            [GD_SCYTHE    ] = 3,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 3,
            [GD_SWORD     ] = 3,
            [GD_SHIELD    ] = 4,
            [GD_BOAT      ] = 15,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 80,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 10,
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

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 80,
            [GD_STONES    ] = 80,
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
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 2,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 4,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 2,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 1,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 6,
            [JOB_BREWER           ] = 3,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 2,
            [JOB_GEOLOGIST        ] = 3,
            [JOB_PRIVATE          ] = 16,
            [JOB_PRIVATEFIRSTCLASS] = 6,
            [JOB_SERGEANT         ] = 4,
            [JOB_OFFICER          ] = 2,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 5,
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
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 10,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 5,
            [JOB_DONKEYBREEDER    ] = 5,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 1,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 8,
            [JOB_SERGEANT         ] = 4,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 0,
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
            [JOB_DONKEYBREEDER    ] = 5,
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 10,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 1,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 6,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 0,
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
    elseif e == 10 then
        enableBuilding(BLD_LOOKOUTTOWER)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(89, 20, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(6)
        rttr:SetCampaignChapterCompleted('roman', 3)
        rttr:EnableCampaignChapter('roman', 4)
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
    elseif activeEvents[10] and ((p == 0 and o == 2) or (p == 2 and o == 0)) then
        showMissionText(2)
        triggerEndEvent(10, 10)
    elseif activeEvents[11] and ((p == 0 and o == 1) or (p == 1 and o == 0)) then
        showMissionText(4)
        triggerEndEvent(11, 11)
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[30] and x == 89 and y == 20 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
