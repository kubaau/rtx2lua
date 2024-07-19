-- Generation begin (https://github.com/kubaau/rtx2lua)

-- Original map script: MIS_0005.RTX

rttr:RegisterTranslations(
{
    de =
    {
        Diary   = 'Tagebuch',
        msg0    = 'Letzter Tag im 5.Jahr.\n\nFelszeichnungen deuten auf eine Insel im Südwesten. Dort scheint es große Goldvorkommen zu geben.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Finden und besetzen sie das Tor! Achten Sie auf Möglichkeiten zum Hafenbau.',
        msg2    = 'Wikinger. Sie siedeln hinter der großen Gebirgskette im Osten unserer Insel. Von den Gipfeln der Kette läßt sich eine weitere sehr große Landmasse im Nordosten erahnen.\n\n\n\n Wir haben noch keine Spur eines Tores gefunden und Kriegsgefangene behaupten, so etwas nicht zu kennen. Aber sie sind schlechte Lügner.',
        msg4    = 'Wir haben den kleinen Flecken Erde hinter dem Gebirgszug von den Wikingern erobert.\nWir nahmen einen weiteren Gefangenen, der uns verriet, wo sich das Tor befindet. Wie wir schon vermutet haben, liegt es weit im Nordosten.\nAber bis auf einen kleinen Fleck im Süden der Landmasse ist sie bereits komplett in der Hand der Wikinger. Wir müssen uns beeilen, dort einen Hafen errichten und den Nachschub gut organisieren.',
        msg6    = 'Wir haben das Tor gefunden und besetzt.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'Sie haben diese Mission erfüllt. Das nächste Kapitel wartet auf Sie...',
    },
    en =
    {
        Diary   = 'Diary',
        msg0    = 'Last Day of the Fifth Year.\n\nRock carvings suggest there is an island in the southwest. It appears there are large gold deposits there.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Find and occupy the gateway! Check out the opportunities for building a harbor.',
        msg2    = 'The Vikings have a settlement behind the large mountain range on the east of our island. From the peaks of the mountains, one can see another very large land mass in the northeast.\n\n\n\n We have not yet found any trace of a gateway and the prisoners of war claim they know of no such thing, but they are poor liars.',
        msg4    = 'We have captured the small area of land beyond the mountain chain from the Vikings.\nWe took further prisoners who told us where the gateway is. As we already suspected, it is in the far northeast.\nApart from a small area in the south of the land mass, it is entirely in the hands of the Vikings. We must quickly build a harbor there and acquire fresh supplies.',
        msg6    = 'We have found the gateway and occupied it.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh6   = 'You have completed this mission. The next Chapter awaits you...',
    },
    pl =
    {
        Diary   = 'Dziennik',
        msg0    = 'Ostatni Dzień Piątego Roku.\n\nInskrypcje na skale sugerują, że na południowym zachodzie znajduje się wyspa. Zdaje się, że znajdują się tam także niemałe złoża złota.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
        msgh0   = 'Znajdź i zajmij bramę! Rozejrzyj się także za okazją do budowy przystani.',
        msg2    = 'Wikingowie osiedlili się za dużym łańcuchem górskim na wschodzie naszej wyspy. Z górskich szczytów można dojrzeć rozległe równiny na północnym wschodzie.\n\n\n\nWciąż nie natknęliśmy się na żaden ślad bramy, zaś nasi jeńcy wojenni utrzymują, że nie wiedzą nic o podobnej rzeczy. Marni z nich kłamcy.',
        msg4    = 'Udało nam się przejąć od Wikingów niewielki skrawek lądu, poniżej łańcucha górskiego. \nWzięliśmy kolejnych jeńców. Dowiedzieliśmy się od nich, gdzie znajduje się brama. Tak jak przypuszczaliśmy, obiekt naszych poszukiwań stoi daleko, na północnym wschodzie.\nPoza małym terenem na południu wyspy, praktycznie cała reszta zajęta została przez Wikingów. Musimy szybko wybudować przystań i zdobyć posiłki.',
        msg6    = 'Znaleźliśmy bramę i zajęliśmy ją.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',
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
    rttr:GetPlayer(1):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(1):SetName('Erik')
 -- rttr:GetPlayer(1):SetPortrait(3)

    rttr:GetPlayer(2):SetAI(3)
    rttr:GetPlayer(2):SetColor(2)
    rttr:GetPlayer(2):SetNation(NAT_VIKINGS)
    rttr:GetPlayer(2):SetName('Olof')
 -- rttr:GetPlayer(2):SetPortrait(5)
end

function onStart(isFirstStart)
    -- world always commands
    rttr:GetWorld():SetComputerBarrier(16, 162, 69)
    rttr:GetWorld():SetComputerBarrier(17, 148, 107)
    rttr:GetWorld():SetComputerBarrier(15, 131, 71)
    rttr:GetWorld():SetComputerBarrier(16, 103, 40)
    rttr:GetWorld():SetComputerBarrier(13, 124, 93)
    rttr:GetWorld():SetComputerBarrier(13, 103, 49)
    rttr:GetWorld():SetComputerBarrier(12, 108, 66)
    rttr:GetWorld():SetComputerBarrier(14, 61, 111)
    rttr:GetWorld():SetComputerBarrier(13, 48, 41)
    rttr:GetWorld():SetComputerBarrier(14, 40, 52)
    rttr:GetWorld():SetComputerBarrier(14, 25, 45)

    -- player 0 always commands
    rttr:GetPlayer(0):DisableAllBuildings()
    rttr:GetPlayer(0):EnableAllBuildings()

    -- player 1 always commands
    rttr:GetPlayer(1):EnableAllBuildings()

    -- player 2 always commands
    rttr:GetPlayer(2):EnableAllBuildings()

    -- events which need to be triggered multiple times

    -- events which are active right from the start
    activeEvents[ 0] = true
    activeEvents[10] = true
    activeEvents[20] = true
    activeEvents[30] = true
    activeEvents[99] = true

    if isFirstStart then
        -- world firststart commands
        rttr:GetWorld():AddAnimal(126, 48, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(126, 48, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(141, 54, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(141, 54, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(141, 54, SPEC_DUCK)
        rttr:GetWorld():AddAnimal(153, 59, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(153, 59, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(154, 60, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(154, 60, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(72, 74, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(72, 74, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(40, 33, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(40, 33, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(92, 54, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(92, 54, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(82, 103, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(82, 103, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(82, 103, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(69, 81, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(69, 81, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(69, 81, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITWHITE)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)
        rttr:GetWorld():AddAnimal(31, 82, SPEC_RABBITGREY)

        -- player 0 firststart commands
        rttr:GetPlayer(0):PlaceHQ(39, 26)
        rttr:GetPlayer(0):ClearResources()

        -- player 1 firststart commands
        rttr:GetPlayer(1):PlaceHQ(140, 61)
        rttr:GetPlayer(1):ClearResources()

        -- player 2 firststart commands
        rttr:GetPlayer(2):PlaceHQ(86, 102)
        rttr:GetPlayer(2):ClearResources()

        -- player 0 wares
        rttr:GetPlayer(0):AddWares({
            [GD_WOOD      ] = 0,
            [GD_BOARDS    ] = 25,
            [GD_STONES    ] = 20,
            [GD_MEAT      ] = 0,
            [GD_GRAIN     ] = 0,
            [GD_FLOUR     ] = 0,
            [GD_FISH      ] = 7,
            [GD_HAM       ] = 7,
            [GD_BREAD     ] = 7,
            [GD_WATER     ] = 0,
            [GD_BEER      ] = 12,
            [GD_COAL      ] = 35,
            [GD_IRONORE   ] = 10,
            [GD_GOLD      ] = 15,
            [GD_IRON      ] = 10,
            [GD_COINS     ] = 5,
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
            [GD_BOARDS    ] = 90,
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
            [JOB_HELPER           ] = 25,
            [JOB_WOODCUTTER       ] = 8,
            [JOB_FISHER           ] = 2,
            [JOB_FORESTER         ] = 3,
            [JOB_CARPENTER        ] = 4,
            [JOB_STONEMASON       ] = 3,
            [JOB_HUNTER           ] = 2,
            [JOB_FARMER           ] = 8,
            [JOB_MILLER           ] = 2,
            [JOB_BAKER            ] = 2,
            [JOB_BUTCHER          ] = 2,
            [JOB_MINER            ] = 6,
            [JOB_BREWER           ] = 2,
            [JOB_PIGBREEDER       ] = 4,
            [JOB_DONKEYBREEDER    ] = 1,
            [JOB_IRONFOUNDER      ] = 2,
            [JOB_MINTER           ] = 2,
            [JOB_METALWORKER      ] = 2,
            [JOB_ARMORER          ] = 4,
            [JOB_BUILDER          ] = 14,
            [JOB_PLANER           ] = 12,
            [JOB_GEOLOGIST        ] = 8,
            [JOB_PRIVATE          ] = 35,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 5,
            [JOB_OFFICER          ] = 3,
            [JOB_GENERAL          ] = 1,
            [JOB_SCOUT            ] = 8,
            [JOB_SHIPWRIGHT       ] = 1,
            [JOB_PACKDONKEY       ] = 0,
            [JOB_BOATCARRIER      ] = 0,
            [JOB_CHARBURNER       ] = 0,
        })

        -- player 1 people
        rttr:GetPlayer(1):AddPeople({
            [JOB_HELPER           ] = 50,
            [JOB_WOODCUTTER       ] = 10,
            [JOB_FISHER           ] = 10,
            [JOB_FORESTER         ] = 10,
            [JOB_CARPENTER        ] = 10,
            [JOB_STONEMASON       ] = 10,
            [JOB_HUNTER           ] = 10,
            [JOB_FARMER           ] = 10,
            [JOB_MILLER           ] = 10,
            [JOB_BAKER            ] = 5,
            [JOB_BUTCHER          ] = 10,
            [JOB_MINER            ] = 20,
            [JOB_BREWER           ] = 10,
            [JOB_PIGBREEDER       ] = 10,
            [JOB_DONKEYBREEDER    ] = 10,
            [JOB_IRONFOUNDER      ] = 8,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 5,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 50,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 4,
            [JOB_OFFICER          ] = 2,
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
            [JOB_WOODCUTTER       ] = 10,
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
            [JOB_IRONFOUNDER      ] = 10,
            [JOB_MINTER           ] = 5,
            [JOB_METALWORKER      ] = 10,
            [JOB_ARMORER          ] = 10,
            [JOB_BUILDER          ] = 20,
            [JOB_PLANER           ] = 20,
            [JOB_GEOLOGIST        ] = 10,
            [JOB_PRIVATE          ] = 50,
            [JOB_PRIVATEFIRSTCLASS] = 10,
            [JOB_SERGEANT         ] = 2,
            [JOB_OFFICER          ] = 0,
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
    elseif e == 98 then
        rttr:GetWorld():AddStaticObject(148, 50, 561, 0xFFFF, 2)
    elseif e == 99 then
        activeEvents[98] = true
        showMissionText(6)
        rttr:SetCampaignChapterCompleted('roman', 6)
        rttr:EnableCampaignChapter('roman', 7)
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
    end

    if p ~= 0 then return
    end
end

function onOccupied(p, x, y)
    if p ~= 0 then return
    elseif activeEvents[20] and x == 102 and y == 50 then
        showMissionText(4)
        triggerEndEvent(20, 20)
    elseif activeEvents[30] and x == 148 and y == 50 then
        triggerEndEvent(30, 30)
        triggerEndEvent(99, 30)
    end
end

function onResourceFound(p, x, y, r, q)
    if p ~= 0 then return
    end
end

-- Generation end
