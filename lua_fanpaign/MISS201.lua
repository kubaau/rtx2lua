-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0001.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Die Verbannung - von Achim Ruziczka\n\nNein! Nicht! ... Zu spät - einen Moment nur war ich unaufmerksam! Vom Hügel aus konnten wir schon die Tore Roms sehen. Da nahm das Unheil seinen Lauf. Der Zorn der Götter hat uns getroffen.  Die Erde tat sich auf - In einer feindlichen Welt fanden wir uns wieder. Vorbei der Traum von der Heimkehr nach Rom!\nWarum? DAS TOR! - Sie haben es zerstört! Aus reinem Übermut, diese Narren! Die Strafe folgte sofort. So wurden wir in diese Einöde verbannt. Aufs neue müssen wir uns wieder bewähren. Ob uns aber auch dieses Mal die Götter zur Seite stehen? Am Anfang bestimmt nicht... und dann... warten wir ab!\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Nach all dem Frevel die Deine Männer getan haben, kannst Du jetzt noch nicht mit der Hilfe der Götter rechnen! Später... !Vielleicht später einmal... !\nDie Gnade der Götter soll ja sehr groß sein.  ',
        msg2    = 'Du hast Dich für die Seefahrt entschieden?\n\nEine kluge Wahl! Nur sei vorsichtig, Hafenwelten haben eigene Gesetze! Und so lange die Gnade der Götter noch auf sich warten läßt, solltest Du keinen Fehler machen.\n\nSei aufmerksam und umsichtig!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Achte auf die Bestände in den Häfen!\nBaue nie mehr Gebäude wie Du besetzen kannst. Lege keine Straßen an, wenn es an Trägern mangelt, noch bist du der Spielball der Götter! Vergiß dies niemals!',
        msg4    = 'Wir haben das Tor erreicht und aktiviert. Der Weg ist frei.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet schon auf Sie...\nLangsam ist auch wieder mit der \nHilfe der Götter zu rechnen.\nJedoch helfen sie nur fleißigen \nSiedlern.',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = "In Exile\na mission by Achim Ruziczka\n\nNo! Stop it! - Too late...just a moment I was distracted...and disaster took its course. At first we didn't grasp what happened. We were hit by the wrath of the gods. To a hostile world we were transferred. Gone were the dreams of coming home.\nWhy?  -  The Arc! ... They deleted it in their licentious wantonness! Simply deleted it! The gods' wrath was instantaneous. We were banned to this desert. Once again we have to prove ourselves, but will the gods take side with us again? I doubt it ... not now ... later maybe ... \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh0   = 'After all the outrage your men have comitted, you cannot count on any support by the gods. \nMaybe at a later time ... \nTheir grace is said to be lavish.',
        msg2    = "You decided to take to the sea?\n\nVery wise a choice! But take care, harbour-worlds have their special laws! And as long you can't count on the support of the gods you shouldn't make any mistakes. Be wary and prudent!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
        msgh2   = "Have a wary eye on the ressources in your ports! Never order more buildings than you can man. \nDon't build roads, if carriers are wanting. Never forget, you are\nstill at mercy of the Devines!\n",
        msg4    = 'We have reached The Arc and activated it. We are free to go.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh4   = 'You have fulfilled your mission. The next chapter is waiting...\n\nGradually the gods will grant you\ntheir support again.\n\nBut they will succour the diligent settler only. ',
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
    rttr:GetPlayer(1):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(1):SetName('Todo')
 -- rttr:GetPlayer(1):SetPortrait(10)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_ROMANS)
    rttr:GetPlayer(2):SetName('Julius')
 -- rttr:GetPlayer(2):SetPortrait(1)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(3):SetName('Erik')
 -- rttr:GetPlayer(3):SetPortrait(3)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_ROMANS)
    rttr:GetPlayer(4):SetName('Brutus')
 -- rttr:GetPlayer(4):SetPortrait(2)

    rttr:GetPlayer(5):SetAI(3)
    rttr:GetPlayer(5):SetColor(5)
    rttr:GetPlayer(5):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(5):SetName('Mnga Tscha')
 -- rttr:GetPlayer(5):SetPortrait(11)
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

    -- player 4 always commands
    rttr:GetPlayer(4):EnableAllBuildings()

    -- player 5 always commands
    rttr:GetPlayer(5):EnableAllBuildings()

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[ 1] = true
    activeEvents[ 3] = true
    activeEvents[ 4] = true
    activeEvents[23] = true
    activeEvents[24] = true
    activeEvents[30] = true
    activeEvents[50] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(103, 49)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(1):PlaceHQ(109, 86)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(2):PlaceHQ(157, 66)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(3):PlaceHQ(60, 62)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(5)
        rttr:GetPlayer(4):PlaceHQ(141, 158)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(5):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(5):PlaceHQ(25, 127)
        rttr:GetPlayer(5):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 80,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 20,
            [GD_GRAIN     ] = 20,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 20,
            [GD_IRONORE   ] = 20,
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
            [GD_BOARDS    ] = 200,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 200,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 200,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 250,
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
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 200,
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
            [JOB_HELPER           ] = 50,
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
            [JOB_PRIVATE          ] = 60,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 2,
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
            [JOB_BUILDER          ] = 7,
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
            [JOB_GENERAL          ] = 30,
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
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 10,
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
            [JOB_FISHER           ] = 15,
            [JOB_FORESTER         ] = 15,
            [JOB_CARPENTER        ] = 15,
            [JOB_STONEMASON       ] = 15,
            [JOB_HUNTER           ] = 15,
            [JOB_FARMER           ] = 15,
            [JOB_MILLER           ] = 15,
            [JOB_BAKER            ] = 15,
            [JOB_BUTCHER          ] = 15,
            [JOB_MINER            ] = 15,
            [JOB_BREWER           ] = 15,
            [JOB_PIGBREEDER       ] = 15,
            [JOB_DONKEYBREEDER    ] = 15,
            [JOB_IRONFOUNDER      ] = 15,
            [JOB_MINTER           ] = 15,
            [JOB_METALWORKER      ] = 15,
            [JOB_ARMORER          ] = 15,
            [JOB_BUILDER          ] = 15,
            [JOB_PLANER           ] = 15,
            [JOB_GEOLOGIST        ] = 15,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 20,
            [JOB_SCOUT            ] = 15,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 15,
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
            [JOB_BUILDER          ] = 8,
            [JOB_PLANER           ] = 5,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 10,
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
        rttr:GetWorld():AddStaticObject(105, 125, 560, 0xFFFF, 2)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(105, 125, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(4)
        rttr:SetCampaignChapterCompleted('FANpaign', 2)
        rttr:EnableCampaignChapter('FANpaign', 3)
    end

    if not isLoading then
        local n = #eventHistory
        eventHistory[n + 1] = e
        eventHistory[n + 2] = trigger
    end

    activeEvents[trigger] = false
end

function onGameFrame(gf)
    if activeEvents[1] and rttr:GetPlayer(0):GetBuildingCount(BLD_SHIPYARD) >= 1 then
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
    elseif activeEvents[30] and x == 105 and y == 125 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
