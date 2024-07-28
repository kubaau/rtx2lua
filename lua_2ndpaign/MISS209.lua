-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0009.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'X - Smoorland, von Heiko Bieger\n\n8. Tag im 7. Monat des 8. Jahres\n\nDas Schicksal führte uns in diese moorige Einöde. Kann man den Inschriften hier glauben, ist das Tor, das uns nach Hause bringt, nicht weit von hier. Doch die Pfade im Moor sind verschlungen. Vielleicht wäre der Wasserweg der bessere. Aber auf unseren Steinvorrat sollten wir gut achten!!!\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Sammelt Eure Kräfte um durchzubrechen! Sucht nach dem letzten Tor!',
        msg2    = 'Letzter Tag des 8. Jahres.\n\nTagebuch des Marcus:\n\nWir haben es geschafft. Morgen werden wir nach Rom zurückkehren. Wir werden den Göttern ein großes Dankesfest bieten und unsere Familien und Freunde wiedersehen.\nIch kann es kaum erwarten.\n\nAllerdings muß ich auch seiner Familie die traurige Nachricht über Octavianus\' Tod überbringen. Und auch viele andere von uns haben ihr Leben für das Vaterland, für die "patria", gelassen... \n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'Ihr habt es geschafft!',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'X - Smoorland, by Heiko Bieger\n\nDay 8 in the 7th month of the eighth year \n\nFate led us to this swampy desolation. If the inscriptions here is to be trusted, the Gate leading homeward is not far from here. But the paths in the moors are maeandering. Perhaps it would be better to travel by water. in any case we should have a wary eye on our stone supplies.\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Gather your forces to break through.\nLook out for the last Gate.',
        msg2    = 'Last day of the 8th year.\n\nDiary of Marcus:\n\nWe have succeeded! Tomorrow we will returne to Rome. Lets make a generous and thankful sacrifice to the Gods, for we will see again our families and friends.\nI can hardly wait for it!\n\nBut sadly I also have to report the death of Octavianus to his family. He and many others of us have given their lives for the love of their fathers counry.... \n\n\n\n\n\n\n\n\n\n',
        msgh2   = 'You have succeeded!',
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
    rttr:GetPlayer(1):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(1):SetName('Olof')
 -- rttr:GetPlayer(1):SetPortrait(5)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(2):SetName('Tsunami')
 -- rttr:GetPlayer(2):SetPortrait(7)

    rttr:GetPlayer(3):SetAI(3)
    rttr:GetPlayer(3):SetColor(3)
    rttr:GetPlayer(3):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(3):SetName('Erik')
 -- rttr:GetPlayer(3):SetPortrait(3)

    rttr:GetPlayer(4):SetAI(3)
    rttr:GetPlayer(4):SetColor(4)
    rttr:GetPlayer(4):SetNation(NAT_JAPANESE)
    rttr:GetPlayer(4):SetName('Hakirawashi')
 -- rttr:GetPlayer(4):SetPortrait(8)

    rttr:GetPlayer(5):SetAI(3)
    rttr:GetPlayer(5):SetColor(5)
    rttr:GetPlayer(5):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(5):SetName('Shaka')
 -- rttr:GetPlayer(5):SetPortrait(9)

    rttr:GetPlayer(6):SetAI(3)
    rttr:GetPlayer(6):SetColor(6)
    rttr:GetPlayer(6):SetNation(NAT_AFRICANS)
    rttr:GetPlayer(6):SetName('Mnga Tscha')
 -- rttr:GetPlayer(6):SetPortrait(11)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(13, 140, 130)
    rttr:GetWorld():SetComputerBarrier(10, 59, 73)
    rttr:GetWorld():SetComputerBarrier(10, 134, 102)
    rttr:GetWorld():SetComputerBarrier(10, 93, 84)
    rttr:GetWorld():SetComputerBarrier(12, 64, 126)

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
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(92, 52)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):PlaceHQ(86, 22)
        rttr:GetPlayer(1):AIConstructionOrder(82, 19, BLD_CATAPULT)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):PlaceHQ(72, 80)
        rttr:GetPlayer(2):ClearResources()

        -- player 3 firststart commands
        rttr:GetPlayer(3):PlaceHQ(97, 96)
        rttr:GetPlayer(3):AIConstructionOrder(95, 94, BLD_CATAPULT)
        rttr:GetPlayer(3):AIConstructionOrder(97, 92, BLD_CATAPULT)
        rttr:GetPlayer(3):ClearResources()

        -- player 4 firststart commands
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(6)
        rttr:GetPlayer(4):MakeOneSidedAllianceTo(7)
        rttr:GetPlayer(4):PlaceHQ(144, 99)
        rttr:GetPlayer(4):AIConstructionOrder(140, 105, BLD_CATAPULT)
        rttr:GetPlayer(4):AIConstructionOrder(141, 102, BLD_CATAPULT)
        rttr:GetPlayer(4):AIConstructionOrder(142, 100, BLD_CATAPULT)
        rttr:GetPlayer(4):ClearResources()

        -- player 5 firststart commands
        rttr:GetPlayer(5):PlaceHQ(17, 82)
        rttr:GetPlayer(5):ClearResources()

        -- player 6 firststart commands
        rttr:GetPlayer(6):MakeOneSidedAllianceTo(7)
        rttr:GetPlayer(6):PlaceHQ(37, 97)
        rttr:GetPlayer(6):ClearResources()

        -- player 7 firststart commands
        rttr:GetPlayer(7):MakeOneSidedAllianceTo(6)
        rttr:GetPlayer(7):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 40,
            [GD_BOARDS    ] = 50,
            [GD_STONES    ] = 50,
            [GD_MEAT      ] = 6,
            [GD_GRAIN     ] = 10,
            [GD_FLOUR     ] = 8,
            [GD_FISH      ] = 4,
            [GD_HAM       ] = 3,
            [GD_BREAD     ] = 6,
            [GD_WATER     ] = 20,
            [GD_BEER      ] = 8,
            [GD_COAL      ] = 15,
            [GD_IRONORE   ] = 5,
            [GD_GOLD      ] = 5,
            [GD_IRON      ] = 5,
            [GD_COINS     ] = 2,
            [GD_TONGS     ] = 2,
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
            [GD_SWORD     ] = 2,
            [GD_SHIELD    ] = 2,
            [GD_BOAT      ] = 4,
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
            [GD_STONES    ] = 90,
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

        -- player 3 wares
        rttr:GetPlayer(3):AddWares({
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

        -- player 4 wares
        rttr:GetPlayer(4):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 200,
            [GD_STONES    ] = 200,
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

        -- player 5 wares
        rttr:GetPlayer(5):AddWares({
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
            [JOB_PRIVATE          ] = 30,
            [JOB_PRIVATEFIRSTCLASS] = 1,
            [JOB_SERGEANT         ] = 1,
            [JOB_OFFICER          ] = 1,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 7,
            [JOB_SHIPWRIGHT       ] = 3,
            [JOB_PACKDONKEY       ] = 6,
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
            [JOB_GENERAL          ] = 6,
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

        -- player 3 people
        rttr:GetPlayer(3):AddPeople({
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
            [JOB_PRIVATE          ] = 50,
            [JOB_PRIVATEFIRSTCLASS] = 40,
            [JOB_SERGEANT         ] = 30,
            [JOB_OFFICER          ] = 20,
            [JOB_GENERAL          ] = 10,
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
            [JOB_PRIVATE          ] = 40,
            [JOB_PRIVATEFIRSTCLASS] = 20,
            [JOB_SERGEANT         ] = 10,
            [JOB_OFFICER          ] = 8,
            [JOB_GENERAL          ] = 6,
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
            [JOB_PRIVATE          ] = 100,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 8,
            [JOB_OFFICER          ] = 5,
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
        showMissionText(0)
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(91, 97, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(2)
        rttr:SetCampaignChapterCompleted('2NDpaign', 10)
        rttr:SetCampaignCompleted('2NDpaign')
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
    elseif activeEvents[30] and x == 91 and y == 97 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
