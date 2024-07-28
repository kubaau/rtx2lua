-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0001.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'II - Magic Isles, von Freddy\n\nTagebuch des Octavianus:\n\nDiesmal hatten wir eine ungewöhnlich rauhe Landung!\nFür einige meiner Mannen endete die Reise durch das Tor tödlich, wir haben die Baupläne für zahlreiche Gebäude verloren.\nEin Tor scheint es auf dieser Insel nicht zu geben. Wir müssen wohl wieder auf Seefahrt gehen, doch dazu fehlen uns Baupläne für die Werft und ein geeigneter Hafenplatz. \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh0   = 'Erkundet die Insel und beachtet die Weisungen der Götter!\nVersucht, mehr über  die Bedrohung für das Imperium Romanum herauszufinden!',
        msg2    = 'Wir treffen auf Römer:\n\nSie berichten uns von einem alten Mann hoch im Norden, der die Kunst des Werftbaus beherrschen soll.\n\nVon einem Hafenplatz jedoch wollen sie noch nie etwas gehört haben...\nAuch von den Angreifern wissen sie nichts!\n\nKönnen wir ihnen trauen oder sind sie selbst auf der Suche nach dem Platz ?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Sucht den Hafenplatz und besucht den alten Mann im Norden. Beeilt Euch!',
        msg4    = 'Werft\n\nDie Römer hatten recht. Der alte Mann lehrte uns die Kunst des Schiffbaus.\n\nLaßt uns sobald als möglich in See stechen und uns auf die Suche nach dem Tor machen.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh4   = 'Baut eine Werft und Schiffe in der Nähe des Hafens.',
        msg6    = 'Hafenplatz\n\nEndlich !\n\nGerade noch rechtzeitig vor den Römern haben wir den Hafenplatz in gefunden und können nun zur See fahren um das Tor zu finden.\n\nHoffen wir, daß unsere Nachbarn weiterhin friedlich bleiben.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh6   = 'Baut Werft und Schiffe und erkundet die anderen Inseln.\nSeid auf der Hut!',
        msg8    = 'Festung:\n\nIn einem kleinen Zelt finden wir einen Eingeborenen der einen Plan von den Römern gefunden hat.\n\nEs sind Konstruktionen einer Festung.\n\nEndlich sind auch wir wieder in der Lage, große Militärgebäude zu bauen. Hoffen wir, daß sich damit ein Weg zum Tor für uns eröffnet.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh8   = 'Platziert Eure Festungen an günstigen Stellen.',
        msg10   = 'Dieses Mal scheinen wir wirklich eine unbewohnte Insel gefunden zu haben.\n\nDie Berge deuten auf reiche Erzvorkommen hin. Wir wollen diese rasch erschließen um unsere Kampfkraft zu stärken.\n\nWenn wir nur endlich die Pläne für das Herstellen von Münzen finden würden...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@\t',
        msgh10  = 'Erkundet die Insel und sucht nach Bauplänen. Werdet dabei nicht allzu übermütig!',
        msg12   = 'Geschafft...\n\nWir finden ein verlassenes Zelt und darin die Pläne einer Münzprägerei.\n\nEndlich können wir Goldmünzen herstellen.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh12  = 'Befördert Eure Soldaten.',
        msg14   = 'Der weise Mann in dem Zelt rührt ein Gebräu zusammen und läßt uns davon kosten. Er verrät uns bereitwillig das Rezept zur Herstellung.\n\nEndlich können wir weitere Soldaten ausbilden, die wir so dringend benötigen.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh14  = 'Bildet weitere Soldaten aus.',
        msg16   = 'Eine weitere Insel...\n\nDie Bewohner trinken einen Saft, hergestellt aus Getreide.\n\nSollte dies das Getränk sein um unsere Soldaten zu motivieren ?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh16  = 'Sucht das Rezept zur Bierherstellung.',
        msg18   = 'Nubier...\n\nWir treffen auf ein kleines Inselvölkchen des Nubierstammes.\n\nSie erzählen uns von einer Sage, nach der im Hinterland riesige Goldvorkommen liegen sollen.\n\nDa die Nubier kein Interesse am Gold haben, dürfte doch die kleine, mit Schützen besetze Baracke kein Hindernis sein !?!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh18  = 'Wenn es an der Zeit ist, dringt ins Hinterland vor und erschließt die Goldvorkommen.',
        msg20   = 'In dem Zelt treffen wir auf eine junge Frau, die zwischen die Fronten zweier Inselvölker geraten und hierher geflüchtet ist.\n\nSie möchte gerne wieder zurück in ihr Haus am anderen Ende der Insel.\n\nAls Dank zeigt sie uns die Pläne einer von ihr entwickelten Geheimwaffe, mit der wir im Kampf besser bestehen können.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msg22   = 'Wir haben die ganze Inselwelt abgegrast, aber von den Angreifern fehlt jede Spur! Vielleicht hat sie das Tor, welches uns auf diese Insel verschlagen hat, ganz woanders hingebracht.\nMöglicherweise gibt es sogar eine Steuerungsfunktion für diese Dinger, mit der man bestimmen kann, wohin man gelangt?!?\n\n\n\n\n\n\n\n',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'II - Magic Isles, by Freddy\n\nDiary of Octavianus\n\nThis time we had an extremely hard landing!\nTo some of my men the voyage through the Gate was fatal, we have lost the blueprints for many buildings.\nThere seems to be no Gate on this island. Obviously, we have to take to sea again, but we are lacking the plans for the shipyard and a suitable place for the harbour building. \n\n\n\n\n\n\n\n\n\n\n@',
        msgh0   = 'Explore the island and observe the words of the Gods.\nTry to find out more about the threat to the Roman Empire.',
        msg2    = 'We meet Romans:\n\nThey tell us about an old man far in the north, who is said to have knowledge in ship building.\n\nThey say to have never heard anything about a place for a harbour...\nThey also know nothing about the aggressors.\n\nDare we trust them or are they looking for that place themselves?\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Search for a place where to build a harbour and pay a visit to that old man in the north.\nMake haste!',
        msg4    = 'Shipyard\n\nThe Romans were right, the old man taught us the art of ship building.\n\nNow lets take to sea as fast as possible and set out to look for the Gate.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh4   = 'Build a shipyard and ships nearby the harbour.',
        msg6    = 'Harbour\n\nFinally!\n\nJust in time before those other Romans we found a place for the harbour. Now we can take to sea in search for the Gate.\n\nLets hope, that our neighbours keep staying friendly.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh6   = 'Build a shipyard and ships and explore the other islands.\nBut take care.',
        msg8    = "Fortress:\n\nWe met a man living in a little tent, who had found a Roman blueprint.\n\nIt describes the building of a fortress.\n\nNow we are able to build large military buildings again. Let's hope, that this helps us to open a way to the Gate.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh8   = 'Place your fortifications at the most suitable spots.',
        msg10   = 'This time we seem to have found an uninhabited island.\n\nThe mountains promise to yield plenty of ore. We should prospect them as fast as possible to enhance our fighting strength.\n\nIf only we could find out how to manufacture coins ...\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh10  = "Scout the island and look for blueprints. But don't get heady.",
        msg12   = 'We did it ...\n\nWe have found a deserted tent and in it was the design for a mint!\n\nFinally we can mint our own coins!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh12  = 'Upgrade your soldiers.',
        msg14   = 'The sage in the tent has concocted a brew and we taste it at length. He also gave us willingly the recipe so we can produce it ourselves.\n\nNow we can recruit more soldiers, which we so dearly need.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh14  = 'Recruit more soldiers.',
        msg16   = 'And another island...\n\nThe inhabitants drink a potion which is made of grain.\n\nMaybe this is the right beverage to motivate our soldiers.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh16  = 'Search for the recipe to produce beer.',
        msg18   = 'Nubics...\n\nWe met a small tribe of the Nubic people.\n\nThey told us about a legend, which has it, that there are golden mountains in the hinterland.\n\nSince the Nubics are not interested in the gold, this small watch hut manned by privates should not be an obstacle.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh18  = 'As soon as it is time, proceed to the hinterland and prospect for gold.',
        msg20   = 'In a tent we met a young woman, that has somehow gotten herself in between the fronts of two tribes of this island and has fled here.\n\nShe wants to go back to her home at the far end of the island.\n\nIn return for our help, she shows plans of a secret weapon to us, that she has invented. With it we will stand a better chance in our strife.\n\n\n\n\n\n\n\n\n\n\n\n\n@',
        msgh20  = 'Use the catapult sensibly.',
        msg22   = 'We now have searched this whole archipelago from end to end, but we found no trace of the aggressors! \n\nMaybe the Gate by which we ended up here has dumped them somewhere else?\n\nMaybe there is even a control mechanism for those contraptions that allows to choose where one is transferred?!?\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
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
    rttr:GetPlayer(1):SetNation(NAT_ROMANS)
    rttr:GetPlayer(1):SetName('Julius')
 -- rttr:GetPlayer(1):SetPortrait(1)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(2):SetName('Olof')
 -- rttr:GetPlayer(2):SetPortrait(5)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(3):SetName('Shaka')
 -- rttr:GetPlayer(3):SetPortrait(9)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_ROMANS)
    rttr:GetPlayer(4):SetName('Brutus')
 -- rttr:GetPlayer(4):SetPortrait(2)

    rttr:GetPlayer(5):SetAI(3)
    rttr:GetPlayer(5):SetColor(5)
    rttr:GetPlayer(5):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(5):SetName('Erik')
 -- rttr:GetPlayer(5):SetPortrait(3)

    rttr:GetPlayer(6):SetAI(3)
    rttr:GetPlayer(6):SetColor(6)
    rttr:GetPlayer(6):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(6):SetName('Tsunami')
 -- rttr:GetPlayer(6):SetPortrait(7)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(15, 186, 38)
    rttr:GetWorld():SetComputerBarrier(8, 58, 59)
    rttr:GetWorld():SetComputerBarrier(15, 39, 94)
    rttr:GetWorld():SetComputerBarrier(20, 224, 40)
    rttr:GetWorld():SetComputerBarrier(20, 191, 154)
    rttr:GetWorld():SetComputerBarrier(15, 209, 159)
    rttr:GetWorld():SetComputerBarrier(15, 135, 100)
    rttr:GetWorld():SetComputerBarrier(20, 106, 128)
    rttr:GetWorld():SetComputerBarrier(20, 150, 67)
    rttr:GetWorld():SetComputerBarrier(15, 138, 118)

    -- player 0 always commands
    rttr:GetPlayer(0):DisableAllBuildings()
    rttr:GetPlayer(0):EnableAllBuildings()
    rttr:GetPlayer(0):DisableBuilding(BLD_MINT)
    rttr:GetPlayer(0):DisableBuilding(BLD_SHIPYARD)
    rttr:GetPlayer(0):DisableBuilding(BLD_BREWERY)
    rttr:GetPlayer(0):DisableBuilding(BLD_FORTRESS)
    rttr:GetPlayer(0):DisableBuilding(BLD_CATAPULT)

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
    activeEvents[ 5] = true
    activeEvents[ 6] = true
    activeEvents[ 7] = true
    activeEvents[ 8] = true
    activeEvents[ 9] = true
    activeEvents[10] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(0):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(0):PlaceHQ(36, 39)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(1):PlaceHQ(44, 57)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):PlaceHQ(46, 117)
        rttr:GetPlayer(2):AIConstructionOrder(51, 112, BLD_BARRACKS)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(0)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):PlaceHQ(202, 151)
        rttr:GetPlayer(3):AIConstructionOrder(202, 158, BLD_BARRACKS)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(4):PlaceHQ(108, 105)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(5):PlaceHQ(148, 82)
        rttr:GetPlayer(5):ClearResources()

        -- player 6 firststart commands
        rttr:GetPlayer(6):PlaceHQ(44, 57)
        rttr:GetPlayer(6):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 20,
            [GD_BOARDS    ] = 20,
            [GD_STONES    ] = 20,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 0,
            [GD_HAM       ] = 0,
            [GD_BREAD     ] = 0,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 0,
            [GD_IRONORE   ] = 0,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 2,
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
            [GD_BOAT      ] = 2,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 60,
            [GD_BOARDS    ] = 60,
            [GD_STONES    ] = 30,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 1,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 1,
            [GD_SHOVEL    ] = 1,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 1,
            [GD_SCYTHE    ] = 1,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 2,
        })

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 60,
            [GD_STONES    ] = 60,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 0,
            [GD_SHOVEL    ] = 2,
            [GD_CRUCIBLE  ] = 0,
            [GD_RODANDLINE] = 2,
            [GD_SCYTHE    ] = 2,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 0,
        })

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 60,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 0,
            [GD_IRONORE   ] = 0,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 1,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 2,
            [GD_SHOVEL    ] = 2,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 1,
            [GD_SCYTHE    ] = 1,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 2,
        })

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
            [GD_WOOD      ] = 60,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 1,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 1,
            [GD_SHOVEL    ] = 1,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 1,
            [GD_SCYTHE    ] = 1,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 2,
        })

        -- player 5 wares
        rttr:GetPlayer(5):AddWares({
            [GD_WOOD      ] = 60,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 80,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 1,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 1,
            [GD_SHOVEL    ] = 1,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 1,
            [GD_SCYTHE    ] = 1,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 2,
        })

        -- player 6 wares
        rttr:GetPlayer(6):AddWares({
            [GD_WOOD      ] = 60,
            [GD_BOARDS    ] = 100,
            [GD_STONES    ] = 90,
            [GD_MEAT      ] = 10,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 10,
            [GD_FISH      ] = 10,
            [GD_HAM       ] = 10,
            [GD_BREAD     ] = 10,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 10,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 1,
            [GD_AXE       ] = 1,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 1,
            [GD_HAMMER    ] = 1,
            [GD_SHOVEL    ] = 1,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 1,
            [GD_SCYTHE    ] = 1,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 2,
        })

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 2,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 1,
            [JOB_STONEMASON       ] = 2,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 2,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 1,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 5,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 1,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 4,
            [JOB_PLANER           ] = 3,
            [JOB_GEOLOGIST        ] = 3,
            [JOB_PRIVATE          ] = 50,
            [JOB_PRIVATEFIRSTCLASS] = 5,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 4,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 3,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 2,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 3,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 1,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 5,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 1,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 5,
            [JOB_PLANER           ] = 4,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 60,
            [JOB_PRIVATEFIRSTCLASS] = 5,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 60,
            [JOB_SCOUT            ] = 3,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 20,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 3,
            [JOB_CARPENTER        ] = 3,
            [JOB_STONEMASON       ] = 0,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 5,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 3,
            [JOB_MINER            ] = 2,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 3,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 0,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 4,
            [JOB_PRIVATE          ] = 50,
            [JOB_PRIVATEFIRSTCLASS] = 1,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 15,
            [JOB_SCOUT            ] = 2,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 20,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 3,
            [JOB_FISHER           ] = 2,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 1,
            [JOB_STONEMASON       ] = 2,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 2,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 1,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 3,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 2,
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 4,
            [JOB_GEOLOGIST        ] = 4,
            [JOB_PRIVATE          ] = 40,
            [JOB_PRIVATEFIRSTCLASS] = 0,
            [JOB_SERGEANT         ] = 0,
            [JOB_OFFICER          ] = 0,
            [JOB_GENERAL          ] = 0,
            [JOB_SCOUT            ] = 2,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 4 people
        rttr:GetPlayer(4):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 6,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 5,
            [JOB_CARPENTER        ] = 3,
            [JOB_STONEMASON       ] = 1,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 6,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 5,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 3,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 60,
            [JOB_PRIVATEFIRSTCLASS] = 5,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 30,
            [JOB_SCOUT            ] = 3,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 10,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 5 people
        rttr:GetPlayer(5):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 6,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 5,
            [JOB_CARPENTER        ] = 3,
            [JOB_STONEMASON       ] = 3,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 6,
            [JOB_MILLER           ] = 3,
            [JOB_BAKER            ] = 3,
            [JOB_BUTCHER          ] = 3,
            [JOB_MINER            ] = 5,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 3,
            [JOB_DONKEYBREEDER    ] = 3,
            [JOB_IRONFOUNDER      ] = 3,
            [JOB_MINTER           ] = 3,
            [JOB_METALWORKER      ] = 3,
            [JOB_ARMORER          ] = 3,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 60,
            [JOB_PRIVATEFIRSTCLASS] = 5,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 30,
            [JOB_SCOUT            ] = 3,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 20,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 6 people
        rttr:GetPlayer(6):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 3,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 2,
            [JOB_HUNTER           ] = 1,
            [JOB_FARMER           ] = 3,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 1,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 5,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 1,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 5,
            [JOB_PLANER           ] = 4,
            [JOB_GEOLOGIST        ] = 5,
            [JOB_PRIVATE          ] = 40,
            [JOB_PRIVATEFIRSTCLASS] = 5,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 3,
            [JOB_SHIPWRIGHT       ] = 1,
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
    elseif e == 3 then
        enableBuilding(BLD_SHIPYARD)
    elseif e == 4 then
        enableBuilding(BLD_FORTRESS)
    elseif e == 6 then
        enableBuilding(BLD_MINT)
    elseif e == 7 then
        enableBuilding(BLD_BREWERY)
    elseif e == 10 then
        enableBuilding(BLD_CATAPULT)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(224, 41, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(22)
        rttr:SetCampaignChapterCompleted('2NDpaign', 2)
        rttr:EnableCampaignChapter('2NDpaign', 3)
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
    elseif activeEvents[1] and ((p == 0 and o == 1) or (p == 1 and o == 0)) then
        showMissionText(2)
        triggerEndEvent(1, 1)
    end

    if p ~= 0 then return
    elseif activeEvents[3] and x == 38 and y == 12 then
        showMissionText(4)
        triggerEndEvent(3, 3)
    elseif activeEvents[6] and x == 94 and y == 35 then
        showMissionText(12)
        triggerEndEvent(6, 6)
    elseif activeEvents[9] and x == 196 and y == 157 then
        showMissionText(18)
        triggerEndEvent(9, 9)
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[2] and x == 13 and y == 56 then
        showMissionText(6)
        triggerEndEvent(2, 2)
    elseif activeEvents[4] and x == 58 and y == 59 then
        showMissionText(8)
        triggerEndEvent(4, 4)
    elseif activeEvents[5] and x == 81 and y == 37 then
        showMissionText(10)
        triggerEndEvent(5, 5)
    elseif activeEvents[7] and x == 55 and y == 107 then
        showMissionText(14)
        triggerEndEvent(7, 7)
    elseif activeEvents[8] and x == 39 and y == 94 then
        showMissionText(16)
        triggerEndEvent(8, 8)
    elseif activeEvents[10] and x == 124 and y == 145 then
        showMissionText(20)
        triggerEndEvent(10, 10)
    elseif activeEvents[30] and x == 224 and y == 41 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
