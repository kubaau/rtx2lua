from handle_command import *
from lxml import etree
from pathlib import Path
import codecs
import os
import sys

if len(sys.argv) < 3:
    print("Usage: python rtx2lua.py PATX_TO_RTX XML_FOLDER")
    exit(1)

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
xml_folder = sys.argv[2]
for xml_subfolder in os.listdir(xml_folder):
    xml_file = "{}/{}/MISS_0{:02}.XML".format(xml_folder, xml_subfolder, mission_texts[0])

    # awful
    if xml_subfolder == "de":
        xml_file_encoded = "{}{}".format(xml_file, "enc")
        with codecs.open(xml_file, "r", "cp1250") as src:
            with codecs.open(xml_file_encoded, "w", "utf-8") as dest:
                src.readline()
                dest.write('<?xml version="1.0" encoding="cp1250" standalone="yes" ?>\n')
                dest.write(src.read())
        xml_file = xml_file_encoded
    elif xml_subfolder == "pl":
        continue

    xml_tree = etree.parse(xml_file)
    texts = xml_tree.xpath('//text/text()')
    print("    {} = \n    {{".format(xml_subfolder))
    print("        Diary\t= 'Diary',")
    for i in range(0, len(texts), 2):
        print()
        extractedid = xml_tree.xpath('//text/@extractedid')[i]
        print("        msg{}\t= {},".format(extractedid, repr(texts[i].strip())))
        goal = texts[i + 1].strip()
        if goal:
            print("        msgh{}\t= {},".format(extractedid, repr(goal)))
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
