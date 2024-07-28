-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0006.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'VII - Isle of War, von Nils von Rhein\n\nWir haben unsere Feinde gefunden, aber mehr davon, als uns lieb ist. Einheimische berichteten uns von gewaltigen Aufmärschen fremder Eindringlinge.\nWir werden alsbald damit beginnen, unsere Ressourcen zu stärken, und das ist auch bitter nötig, denn ein Teil meiner Männer hielt dem Druck nicht mehr Stand und ergriff die Flucht. Nur wenige Männer blieben uns. Aufgrund des Mangels an erfahrenen Offizieren habe ich meinen Freund Marcus zum stellvertretenden Befehlshaber erhoben.\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Setzt Eure Ressourcen wohlüberlegt ein. Achtet v.a. beim Wegebau auf Eure Gehilfen.',
        msg2    = 'Wir haben uns durchgekämpft und unsere Gefangenen verhört; unter ihnen war auch ein Gelehrter des Dominion.\n\nWir konnten ihn davon "überzeugen", die restlichen Geheimnisse, um die wir bisher noch nicht wußten, mit uns zu teilen. Er verriet uns nicht nur, wie man die Tore zielstrebig und vollständig kontrolliert, wir erfuhren sogar, wo wir die Hauptquartiere der führenden Stämme finden. \nDort wird der Schlüssel zur Rettung des Imperiums liegen. Allerdings müssen wir einen Umweg über eine unwirtliche Inselwelt nehmen...',
        msgh2   = 'Es wird haarig...\n\nDie nächste Mission wartet auf Euch!',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'VII - Isle of War, by Nils von Rhein\n\nWe have encountered enemies, but more of them, than we looked for. Indigenies reported tremendous assemblies of foreign intruders.\nWe will at once start to strengthen our ressources, which is utterly necessary, for some of our men have given way to the pressure and have taken to flight. Only a few men did stay. Due to the lack of experienced officers I have announced my friend Marcus to be vice-commander.\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Use your ressources deliberately. Especially supervise your assistants in the building of roads.',
        msg2    = 'We have fought this out and questioned our prisoners; among them we found a scientist of the Dominion. \n\nWe were able to "convince" him to share the remaining secrets we didn\'t know already. He not only told us how to purposefully and completely control the Gates, we also know now where the headquarters of the leading tribes are.\nThat\'s where the key to the saving of the Imperium lies. However, we will have to take a deviation through a vast archipelago...\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh2   = "It's going to be tough...\n\nThe next mission lies in wait.",
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
    rttr:GetPlayer(1):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(1):SetName('Erik')
 -- rttr:GetPlayer(1):SetPortrait(3)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(2):SetName('Knut')
 -- rttr:GetPlayer(2):SetPortrait(4)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(3):SetName('Olof')
 -- rttr:GetPlayer(3):SetPortrait(5)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(4):SetName('Yamauchi')
 -- rttr:GetPlayer(4):SetPortrait(6)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(15, 91, 74)
    rttr:GetWorld():SetComputerBarrier(15, 94, 78)

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

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(46, 149)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(1):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(1):PlaceHQ(87, 129)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(2):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(2):PlaceHQ(131, 36)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(3):MakeOneSidedAllianceTo(4)
        rttr:GetPlayer(3):PlaceHQ(157, 52)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(1)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(2)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(3)
        rttr:GetPlayer(4):PlaceHQ(63, 37)
        rttr:GetPlayer(4):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 15,
            [GD_BOARDS    ] = 15,
            [GD_STONES    ] = 15,
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
            [GD_IRON      ] = 0,
            [GD_COINS     ] = 0,
            [GD_TONGS     ] = 0,
            [GD_AXE       ] = 2,
            [GD_SAW       ] = 1,
            [GD_PICKAXE   ] = 5,
            [GD_HAMMER    ] = 6,
            [GD_SHOVEL    ] = 6,
            [GD_CRUCIBLE  ] = 1,
            [GD_RODANDLINE] = 2,
            [GD_SCYTHE    ] = 4,
            [GD_CLEAVER   ] = 1,
            [GD_ROLLINGPIN] = 1,
            [GD_BOW       ] = 1,
            [GD_SWORD     ] = 6,
            [GD_SHIELD    ] = 6,
            [GD_BOAT      ] = 0,
        })

        -- player 1 wares
        rttr:GetPlayer(1):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 20,
            [GD_GRAIN     ] = 20,
            [GD_FLOUR     ] = 20,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 0,
            [GD_COAL      ] = 12,
            [GD_IRONORE   ] = 9,
            [GD_GOLD      ] = 0,
            [GD_IRON      ] = 6,
            [GD_COINS     ] = 6,
            [GD_TONGS     ] = 2,
            [GD_AXE       ] = 5,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 12,
            [GD_HAMMER    ] = 12,
            [GD_SHOVEL    ] = 12,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 0,
            [GD_SHIELD    ] = 0,
            [GD_BOAT      ] = 0,
        })

        -- player 2 wares
        rttr:GetPlayer(2):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 15,
            [GD_GRAIN     ] = 15,
            [GD_FLOUR     ] = 15,
            [GD_FISH      ] = 15,
            [GD_HAM       ] = 15,
            [GD_BREAD     ] = 15,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 30,
            [GD_IRONORE   ] = 30,
            [GD_GOLD      ] = 20,
            [GD_IRON      ] = 20,
            [GD_COINS     ] = 20,
            [GD_TONGS     ] = 3,
            [GD_AXE       ] = 5,
            [GD_SAW       ] = 3,
            [GD_PICKAXE   ] = 12,
            [GD_HAMMER    ] = 12,
            [GD_SHOVEL    ] = 12,
            [GD_CRUCIBLE  ] = 3,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 20,
            [GD_SHIELD    ] = 20,
            [GD_BOAT      ] = 0,
        })

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 20,
            [GD_GRAIN     ] = 25,
            [GD_FLOUR     ] = 20,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 6,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 6,
            [GD_TONGS     ] = 2,
            [GD_AXE       ] = 5,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 12,
            [GD_HAMMER    ] = 12,
            [GD_SHOVEL    ] = 12,
            [GD_CRUCIBLE  ] = 2,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 10,
            [GD_SHIELD    ] = 10,
            [GD_BOAT      ] = 0,
        })

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
            [GD_WOOD      ] = 50,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 100,
            [GD_MEAT      ] = 20,
            [GD_GRAIN     ] = 25,
            [GD_FLOUR     ] = 20,
            [GD_FISH      ] = 20,
            [GD_HAM       ] = 20,
            [GD_BREAD     ] = 20,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 20,
            [GD_COAL      ] = 10,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 10,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 6,
            [GD_TONGS     ] = 2,
            [GD_AXE       ] = 5,
            [GD_SAW       ] = 2,
            [GD_PICKAXE   ] = 12,
            [GD_HAMMER    ] = 12,
            [GD_SHOVEL    ] = 12,
            [GD_CRUCIBLE  ] = 2,
            [GD_RODANDLINE] = 6,
            [GD_SCYTHE    ] = 12,
            [GD_CLEAVER   ] = 2,
            [GD_ROLLINGPIN] = 2,
            [GD_BOW       ] = 2,
            [GD_SWORD     ] = 30,
            [GD_SHIELD    ] = 30,
            [GD_BOAT      ] = 0,
        })

        -- player 0 people
        rttr:GetPlayer(0):AddPeople({
            [JOB_HELPER           ] = 15,
            [JOB_WOODCUTTER       ] = 1,
            [JOB_FISHER           ] = 1,
            [JOB_FORESTER         ] = 1,
            [JOB_CARPENTER        ] = 1,
            [JOB_STONEMASON       ] = 2,
            [JOB_HUNTER           ] = 0,
            [JOB_FARMER           ] = 2,
            [JOB_MILLER           ] = 0,
            [JOB_BAKER            ] = 0,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 2,
            [JOB_BREWER           ] = 0,
            [JOB_PIGBREEDER       ] = 0,
            [JOB_DONKEYBREEDER    ] = 0,
            [JOB_IRONFOUNDER      ] = 1,
            [JOB_MINTER           ] = 0,
            [JOB_METALWORKER      ] = 0,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 6,
            [JOB_PLANER           ] = 6,
            [JOB_GEOLOGIST        ] = 2,
            [JOB_PRIVATE          ] = 12,
            [JOB_PRIVATEFIRSTCLASS] = 12,
            [JOB_SERGEANT         ] = 12,
            [JOB_OFFICER          ] = 6,
            [JOB_GENERAL          ] = 9,
            [JOB_SCOUT            ] = 1,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 6,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 4,
            [JOB_MILLER           ] = 1,
            [JOB_BAKER            ] = 2,
            [JOB_BUTCHER          ] = 1,
            [JOB_MINER            ] = 9,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 1,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 1,
            [JOB_METALWORKER      ] = 1,
            [JOB_ARMORER          ] = 1,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 12,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 5,
            [JOB_SCOUT            ] = 5,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 25,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 2 people
        rttr:GetPlayer(2):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 6,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 4,
            [JOB_MILLER           ] = 2,
            [JOB_BAKER            ] = 2,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 9,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 2,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 2,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 12,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 35,
            [JOB_PRIVATEFIRSTCLASS] = 25,
            [JOB_SERGEANT         ] = 25,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 15,
            [JOB_SCOUT            ] = 5,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 6,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 4,
            [JOB_MILLER           ] = 2,
            [JOB_BAKER            ] = 2,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 9,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 2,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 2,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 12,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 20,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 10,
            [JOB_GENERAL          ] = 5,
            [JOB_SCOUT            ] = 5,
            [JOB_SHIPWRIGHT       ] = 0,
            [JOB_PACKDONKEY       ] = 40,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 4 people
        rttr:GetPlayer(4):AddPeople({
            [JOB_HELPER           ] = 99,
            [JOB_WOODCUTTER       ] = 4,
            [JOB_FISHER           ] = 3,
            [JOB_FORESTER         ] = 2,
            [JOB_CARPENTER        ] = 2,
            [JOB_STONEMASON       ] = 6,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 4,
            [JOB_MILLER           ] = 2,
            [JOB_BAKER            ] = 2,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 9,
            [JOB_BREWER           ] = 1,
            [JOB_PIGBREEDER       ] = 2,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 2,
            [JOB_BUILDER          ] = 12,
            [JOB_PLANER           ] = 12,
            [JOB_GEOLOGIST        ] = 6,
            [JOB_PRIVATE          ] = 36,
            [JOB_PRIVATEFIRSTCLASS] = 35,
            [JOB_SERGEANT         ] = 20,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 10,
            [JOB_SCOUT            ] = 5,
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
        rttr:GetWorld():AddStaticObject(156, 7, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('2NDpaign', 7)
        rttr:EnableCampaignChapter('2NDpaign', 8)
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
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[30] and x == 156 and y == 7 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
