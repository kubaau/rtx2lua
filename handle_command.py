from collections import defaultdict
from constants import *
from handle_event import *

computer_portraits = {}
mission_texts = []
player = 0
player_commands_always = defaultdict(list)
player_commands_firststart = defaultdict(list)
player_people = defaultdict(list)
player_wares = defaultdict(list)
world_commands = []

def handle_command(command, args):
    global mission_texts
    global player
    global world_commands
    match command:
        case "ADD_ANIMAL":
            for _ in range(int(args[1])):
                world_commands += ["AddAnimal({}, {}, {})".format(args[2], args[3], animals[int(args[0])])]
        case "ADD_COMPUTER_PLAYER":
            computer_portraits[int(args[0])] = int(args[1])
        case "ADD_PEOPLE":
            person_id = people[int(args[0])]
            for person in player_people[player]:
                if person_id in person.keys():
                    person[person_id] += int(args[1])
                    return
            player_people[player] += [{person_id: int(args[1])}]
        case "ADD_WARE":
            ware_id = wares[int(args[0])]
            for ware in player_wares[player]:
                if ware_id in ware.keys():
                    ware[ware_id] += int(args[1])
                    return
            player_wares[player] += [{ware_id: int(args[1])}]
        case "DISABLE_HOUSE":
            player_commands_always[player] += ["DisableBuilding({})".format(buildings[int(args[0])])]
        case "ENABLE_ALL_HOUSES":
            player_commands_always[player] += ["EnableAllBuildings()"]
        case "ENABLE_HOUSE":
            player_commands_always[player] += ["EnableBuilding({})".format(buildings[int(args[0])])]
        case "LOAD_MISSION_TEXTS":
            mission_texts += [int(args[0])]
        case command if command.startswith("MET_"):
            handle_event(command.replace("MET_", ""), args)
        case "SET_ACT_PLAYER":
            player = int(args[0])
        case "SET_BOBS":
            pass
        case "SET_COMPUTER_ALLIANCE":
            player_commands_firststart[int(args[0])] += ["MakeOneSidedAllianceTo({})".format(args[1])]
        case "SET_COMPUTER_BARRIER":
            world_commands += ["{}(radius={}, x={}, y={})".format(command, args[0], args[1], args[2])]
        case "SET_HOUSE":
            if int(args[0]) == 24:
                player_commands_firststart[player] += ["PlaceHQ({}, {})".format(args[1], args[2])]
            else:
                player_commands_firststart[player] += ["AIConstructionOrder({}, {}, {})".format(args[1], args[2], buildings[int(args[0])])]
        case "SET_HQ_BOBS":
            if args == ['6', '7', '0']:
                player_commands_firststart[0] += ["ModifyHQ(1)"]
            else:
                pass # don't know how to handle this
        case "SET_MAP":
            pass
        case _:
            print("! unhandled command {} args {}".format(command, args))
