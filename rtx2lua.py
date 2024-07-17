from handle_command import *
from pathlib import Path
from txt2dict import txt2dict
import os
import sys

if len(sys.argv) < 2:
    print("Usage: python rtx2lua.py RTX_FILE [TXT_FOLDER {TXT}] [> OUTPUT_FILE]")
    exit(1)

txt_folder = "TXT"
if len(sys.argv) >= 3:
    txt_folder = sys.argv[2]

def print_file(filename):
    with open(filename) as file:
        for line in file.readlines():
            print(line, end = "")

# RTX interpretation begin
with open(sys.argv[1]) as rtx:
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
            handle_command(instruction.strip('!').replace("GLOBAL_", ""), words[1:])
        elif instruction.startswith('#'):
            pass #print("comment {}".format(line[1:].strip()))
        else:
            pass #print("unknown command {}".format(words))
# RTX interpretation end

print("-- Generation begin (https://github.com/kubaau/rtx2lua)")
print("\n-- Original map script: {}".format(Path(sys.argv[1]).name))

# RegisterTranslations begin
print("\nrttr:RegisterTranslations(\n{")
sys.stdout.reconfigure(encoding="utf-8")
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

    txt_file = Path("{}/{}/MISS_{:03}.{}".format(txt_folder, txt_subfolder, mission_texts[0], extension))
    texts = txt2dict(txt_file, encoding)

    print("    {} =\n    {{".format(txt_subfolder))
    print("        Diary\t= '{}',".format(diary))
    for key, value in texts.items():
        print("        {:7} = {}".format(key, value), end = ",\n")
    print("    },")
print("})\n")
# RegisterTranslations end

print_file("boilerplate.lua")

# Settings begin
keylist = [*computer_portraits.keys()]
keylist.sort()
for player in keylist:
    print()
    print("    rttr:GetPlayer({}):SetAI(3)".format(player))
    print("    rttr:GetPlayer({}):SetColor({})".format(player, player))
    portrait = int(computer_portraits[player])
    print("    rttr:GetPlayer({}):SetNation({})".format(player, nations[int(portrait / 3)]))
    print("    rttr:GetPlayer({}):SetName({})".format(player, repr(portraits[portrait])))
    print(" -- rttr:GetPlayer({}):SetPortrait({})".format(player, portrait))
print("end")
# Settings end

print("\nactiveEvents = {}")
print("endEvents = {}")

# onStart begin
print("\nfunction onStart(isFirstStart)", end = "")

keylist = [*player_commands_always]
keylist.sort()
for key in keylist:
    print("\n    -- player {} commands always".format(key))
    if key == 0:
        print("    rttr:GetPlayer(0):DisableAllBuildings()")
    for value in player_commands_always[key]:
        print("    rttr:GetPlayer({}):{}".format(key, value))

# isFirstStart begin
print("\n    if isFirstStart then")

print("        -- world commands")
for command in world_commands:
    print("        rttr:GetWorld():{}".format(command))

keylist = [*player_commands_firststart]
keylist.sort()
for key in keylist:
    print("\n        -- player {} commands firststart".format(key))
    for value in player_commands_firststart[key]:
        print("        rttr:GetPlayer({}):{}".format(key, value))

keylist = [*player_wares]
keylist.sort()
for player in keylist:
    print("\n        -- player {} wares".format(player))
    print("        rttr:GetPlayer({}):AddWares({{".format(player))
    for ware in wares:
        amount = 0
        for player_ware in player_wares[player]:
            if ware in player_ware.keys():
                amount = player_ware[ware]
        print("            [{:13}] = {}".format(ware, amount), end = ",\n")
    print("        })")

keylist = [*player_people]
keylist.sort()
for key in keylist:
    print("\n        -- player {} people".format(key))
    print("        rttr:GetPlayer({}):AddPeople({{".format(key))
    for person in people:
        amount = 0
        for player_person in player_people[player]:
            if person in player_person.keys():
                amount = player_person[person]
        print("            [{:21}] = {}".format(person, amount), end = ",\n")
    print("        })")

print("\n        -- end events which need to be triggered multiple times")
for event in end_event_requirements:
    print("        {}".format(event))

print("\n        -- activate events")
for event in active_events:
    print("        {}".format(event))

print("\n        -- onstart events")
for event in onstart_events:
    print("        {}".format(event))

print("    end\nend\n")
# isFirstStart end
# onStart end

# TriggerEndEvent begin
print("\nfunction TriggerEndEvent(e)")
print("    if(not activeEvents[e]) then return end")
print("    endEvents[e] = endEvents[e] + 1")
print("    if(false) then -- dummy if")
for event in end_events:
    print("    {}".format(event))
print("    end\nend\n")
# TriggerEndEvent end

# onGameFrame begin
print("function onGameFrame(gf)", end = "")
for event in ongameframe_events:
    print("\n    {}".format(event))
print("end\n")
# onGameFrame end

# onExplored begin
print("function onExplored(p, x, y, o)")
print("    -- onContact cases")
print("    if(false) then -- dummy if")
for event in oncontact_events:
    print("    {}".format(event))
print("    end\n")
print("    if(p ~= 0) then return")
for event in onexplored_events:
    print("    {}".format(event))
print("    end\nend\n")
# onExplored end

# onOccupied begin
print("function onOccupied(p, x, y)")
print("    if(p ~= 0) then return")
for event in onoccupied_events:
    print("    {}".format(event))
print("    end\nend\n")
# onOccupied end

# onResourceFound begin
print("function onResourceFound(p, x, y, r, q)")
print("    if(p ~= 0) then return")
for event in onresourcefound_events:
    print(event)
print("    end\nend")
# onResourceFound end

print("-- Generation end")
