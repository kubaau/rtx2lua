from handle_command import *
from lxml import etree
#import codecs
import os
import sys

if len(sys.argv) < 3:
    print("Usage: python rtx2lua.py PATX_TO_RTX XML_FOLDER")
    exit(1)

def print_file(filename):
    with open(filename) as file:
        for line in file.readlines():
            print(line, end = "")

# RTX interpretation start
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
            pass#print("comment {}".format(line[1:].strip()))
        else:
            pass#print("unknown {}".format(words))
# RTX interpretation end

print_file("common_header.lua")

# RegisterTranslations start
print("\nrttr:RegisterTranslations(\n{")
xml_folder = sys.argv[2]
for xml_subfolder in os.listdir(xml_folder):
    xml_file = "{}/{}/MISS_0{:02}.XML".format(xml_folder, xml_subfolder, mission_texts[0])
    #xml_file_utf8 = "{}{}".format(xml_file, "u")

    #with codecs.open(xml_file, "r", "cp1250") as src:
        #with codecs.open(xml_file_utf8, "w", "utf-8") as dest:
            #dest.write(src.read())

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

print_file("common_events.lua")

# Settings start
print()
print_file("common_settings.lua")
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

# onStart start
print("\nfunction onStart(isFirstStart)", end = "")

keylist = [*player_commands_always]
keylist.sort()
for key in keylist:
    print("\n    -- player {} commands always".format(key))
    player_commands_always[key].sort()
    for value in player_commands_always[key]:
        print("    rttr:GetPlayer({}):{}".format(key, value))

# isFirstStart start
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

print("\n        -- activate events")
for event in active_events:
    print("        {}".format(event))

print("\n        -- onstart events")
for event in onstart_events:
    print("        {}".format(event))

print("    end\nend\n")
# isFirstStart end
# onStart end

# onGameFrame start
print("function onGameFrame(gf)")
for event in ongameframe_events:
    print("    {}".format(event))
print("end\n")
# onGameFrame end

# onExplored start
print("function onExplored(p, x, y)")
print("    if(p ~= 0) then return end")
for event in oncontact_events:
    print("    {}".format(event))
for event in onexplored_events:
    print("    {}".format(event))
print("end\n")
# onExplored end

# onOccupied start
print("function onOccupied(p, x, y)")
print("    if(p ~= 0) then return end")
for event in onoccupied_events:
    print("    {}".format(event))
print("end\n")
# onOccupied end

# onResourceFound start
print("function onResourceFound(p, x, y, rIdx, q)")
print("    if(p ~= 0) then return end")
for event in onresourcefound_events:
    print("    {}".format(event))
print("end")
# onResourceFound end

print("-- Generation end")
