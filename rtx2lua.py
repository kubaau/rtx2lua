from pathlib import Path
from txt2dict import txt2dict
import commands
import constants
import events
import os
import sys

if len(sys.argv) < 2:
    print("Usage: python rtx2lua.py RTX_FILE [CAMPAIGN_NAME {roman}] [TXT_FOLDER {TXT}] [> OUTPUT_FILE]")
    exit(1)

if len(sys.argv) >= 3:
    events.campaign = sys.argv[2]

def interpret_rtx():
    rtx_file = sys.argv[1]
    with open(rtx_file, encoding = "cp852") as rtx:
        for line in rtx.readlines():
            words = line.replace(',', '').split()
            if not words:
                continue

            instruction = words[0]
            if instruction.startswith('['):
                section = instruction.strip("[]")
                if section == "ENDE":
                    break
            elif instruction.startswith('!'):
                commands.handle(instruction.strip('!').replace("GLOBAL_", ""), [int(i) for i in words[1:]])
            elif instruction.startswith('#'):
                pass #print("comment {}".format(line[1:].strip()))
            else:
                pass #print("unknown command {}".format(words))

def print_header():
    print("-- Generation begin (https://github.com/kubaau/rtx2lua)")
    print("\n-- Original map script: {}".format(Path(sys.argv[1]).name))

def print_RegisterTranslations():
    txt_folder = "TXT_roman"
    if len(sys.argv) >= 4:
        txt_folder = sys.argv[3]

    print("\nrttr:RegisterTranslations(\n{")
    for txt_subfolder in os.listdir(txt_folder):
        diary = "Diary"
        encoding = "cp852"
        extension = "ENG"
        match txt_subfolder:
            case "de":
                diary = "Tagebuch"
                extension = "GER"
            case "pl":
                diary = "Dziennik"
                encoding = "cp1250"

        txt_file = Path("{}/{}/MISS_{:03}.{}".format(txt_folder, txt_subfolder, commands.chapter, extension))
        texts = txt2dict(txt_file, encoding)

        print("    {} =\n    {{".format(txt_subfolder))
        print("        Diary   = '{}',".format(diary))
        for key, value in texts.items():
            print("        {:7} = {}".format(key, value), end = ",\n")
        print("    },")
    print("})")

def print_boilerplate():
    with open("boilerplate.lua") as file:
        print("\n{}".format(file.read()))

def print_ai_settings():
    ais = [*commands.portraits.keys()]
    ais.sort()
    for ai in ais:
        portrait = commands.portraits[ai]
        print("\n    rttr:GetPlayer({}):SetAI(3)".format(ai))
        print("    rttr:GetPlayer({0}):SetColor({0})".format(ai))
        print("    rttr:GetPlayer({}):SetNation({})".format(ai, constants.nations[int(portrait / 3)]))
        print("    rttr:GetPlayer({}):SetName({})".format(ai, repr(constants.portraits[portrait])))
        print(" -- rttr:GetPlayer({}):SetPortrait({})".format(ai, portrait))
    print("\n -- TODO: Close() players in Mission 1")
    print("end")

def print_globals():
    print("\nactiveEvents = {}")
    print("endEvents = {}")

def print_always_commands():
    players = [*commands.player_always]
    players.sort()
    for player in players:
        print("\n    -- player {} always commands".format(player))
        if player == 0:
            print("    rttr:GetPlayer(0):DisableAllBuildings()")
        for command in commands.player_always[player]:
            print("    rttr:GetPlayer({}):{}".format(player, command))

def print_world_commands():
    print("        -- world commands")
    for command in commands.world:
        print("        rttr:GetWorld():{}".format(command))

def print_firststart_commands():
    players = [*commands.player_firststart]
    players.sort()
    for player in players:
        print("\n        -- player {} firststart commands".format(player))
        for command in commands.player_firststart[player]:
            print("        rttr:GetPlayer({}):{}".format(player, command))
        print("        rttr:GetPlayer({}):ClearResources()".format(player))

def print_wares():
    players = [*commands.wares]
    players.sort()
    for player in players:
        print("\n        -- player {} wares".format(player))
        print("        rttr:GetPlayer({}):AddWares({{".format(player))
        for ware in constants.wares:
            amount = 0
            for player_ware in commands.wares[player]:
                if ware in player_ware.keys():
                    amount = player_ware[ware]
            print("            [{:13}] = {}".format(ware, amount), end = ",\n")
        print("        })")

def print_people():
    players = [*commands.people]
    players.sort()
    for player in players:
        print("\n        -- player {} people".format(player))
        print("        rttr:GetPlayer({}):AddPeople({{".format(player))
        for person in constants.people:
            amount = 0
            for player_person in commands.people[player]:
                if person in player_person.keys():
                    amount = player_person[person]
            print("            [{:21}] = {}".format(person, amount), end = ",\n")
        print("        })")

def print_times_required():
    print("\n        -- events which need to be triggered multiple times")
    for eid in events.times_required.keys():
        print("        endEvents[{:>2}] = 0".format(eid))

def print_active():
    print("\n        -- events which are active right from the start")
    eids = [*events.active]
    eids.sort()
    for eid in eids:
        print("        activeEvents[{:>2}] = true".format(eid))

def print_direct():
    print("\n        -- events which are triggered right from the start")
    eids = [*events.direct]
    eids.sort()
    for eid in eids:
        for handler in events.direct[eid]:
            print("    {}".format(handler))

def print_firststart():
    print("\n    if isFirstStart then")
    print_world_commands()
    print_firststart_commands()
    print_wares()
    print_people()
    print_times_required()
    print_active()
    print_direct()
    print("    end")

def print_onStart():
# onStart begin
    print("\nfunction onStart(isFirstStart)", end = "")
    print_always_commands()
    print_firststart()
    print("end")

def print_TriggerEndEvent():
    print("\nfunction TriggerEndEvent(e, trigger) -- events triggered from other events")
    print("    if(not activeEvents[e]) then return end")
    print("\n    if(endEvents[e]) then endEvents[e] = endEvents[e] + 1 end")
    print("\n    if(false) then -- dummy if")

    eids = [*events.end]
    eids.sort()
    for eid in eids:
        print("    elseif(e == {}".format(eid), end = "")
        if events.times_required.get(eid, 1) > 1:
            print(" and endEvents[{}] >= {}".format(eid, events.times_required[eid]), end = "")
        print(") then")
        for handler in events.end[eid]:
            print("{}".format(handler))

    print("    end")
    print("\n    activeEvents[trigger] = false")
    print("end")

def print_handlers(edict):
    eids = [*edict]
    eids.sort()
    for eid in eids:
        for handler in edict[eid]:
            print("    {}".format(handler))

def print_onGameFrame():
    print("\nfunction onGameFrame(gf)")
    print_handlers(events.ongameframe)
    print("end")

def print_onExplored():
    print("\nfunction onExplored(p, x, y, o)")
    print("    if(false) then -- dummy if for onContact cases")
    print_handlers(events.oncontact)
    print("    end")
    print("\n    if(p ~= 0) then return")
    print_handlers(events.onexplored)
    print("    end")
    print("end")

def print_onOnccupied():
    print("\nfunction onOccupied(p, x, y)")
    print("    if(p ~= 0) then return")
    print_handlers(events.onoccupied)
    print("    end\nend\n")

def print_onResourceFound():
    print("function onResourceFound(p, x, y, r, q)")
    print("    if(p ~= 0) then return")
    print_handlers(events.onresourcefound)
    print("    end")
    print("end")

def main():
    sys.stdout.reconfigure(encoding = "utf-8")
    interpret_rtx()
    print_header()
    print_RegisterTranslations()
    print_boilerplate()
    print_ai_settings()
    print_globals()
    print_onStart()
    print_TriggerEndEvent()
    print_onGameFrame()
    print_onExplored()
    print_onOnccupied()
    print_onResourceFound()
    print("\n-- Generation end")

if __name__ == '__main__':
    main()
