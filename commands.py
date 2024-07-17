from collections import defaultdict
import constants
import events

chapter = 0
people = defaultdict(list)
player_always = defaultdict(list)
player_firststart = defaultdict(list)
portraits = {}
wares = defaultdict(list)
world = []

def handle(command, args):
    global chapter
    global world

    match command:
        case "ADD_ANIMAL":
            for _ in range(int(args[1])):
                world += ["AddAnimal({}, {}, {})".format(args[2], args[3], constants.animals[int(args[0])])]
        case "ADD_COMPUTER_PLAYER":
            portraits[int(args[0])] = int(args[1])
            player_always[int(args[0])] +=  ["EnableAllBuildings()"] # in S2 AI always had all buildings enabled
        case "ADD_PEOPLE":
            person_id = constants.people[int(args[0])]
            for person in people[handle.player]:
                if person_id in person.keys():
                    person[person_id] += int(args[1])
                    return
            people[handle.player] += [{person_id: int(args[1])}]
        case "ADD_WARE":
            ware_id = constants.wares[int(args[0])]
            for ware in wares[handle.player]:
                if ware_id in ware.keys():
                    ware[ware_id] += int(args[1])
                    return
            wares[handle.player] += [{ware_id: int(args[1])}]
        # these enable/disable houses seem to work only for the human player in S2, they never affect the AI
        case "DISABLE_HOUSE":
            player_always[0] += ["DisableBuilding({})".format(constants.buildings[int(args[0])])]
        case "ENABLE_ALL_HOUSES":
            player_always[0] += ["EnableAllBuildings()"]
        case "ENABLE_HOUSE":
            player_always[0] += ["EnableBuilding({}, false)".format(constants.buildings[int(args[0])])]
        case "LOAD_MISSION_TEXTS":
            chapter = int(args[0])
        case command if command.startswith("MET_"):
            events.handle(command.replace("MET_", ""), args)
        case "SET_ACT_PLAYER":
            handle.player = int(args[0])
        case "SET_BOBS":
            pass # don't know how to handle this
        case "SET_COMPUTER_ALLIANCE":
            player_firststart[int(args[0])] += ["MakeOneSidedAllianceTo({})".format(args[1])]
        case "SET_COMPUTER_BARRIER":
            world += ["{}(radius={}, x={}, y={}) -- TODO".format(command, args[0], args[1], args[2])]
        case "SET_HOUSE":
            if int(args[0]) == 24:
                player_firststart[handle.player] += ["PlaceHQ({}, {})".format(args[1], args[2])]
            else:
                player_firststart[handle.player] += ["AIConstructionOrder({}, {}, {})".format(args[1], args[2], constants.buildings[int(args[0])])]
        case "SET_HQ_BOBS":
            if args == ['6', '7', '0']:
                player_firststart[0] += ["ModifyHQ(1)"]
            #else: # don't know how to handle this
        case "SET_MAP":
            pass
        case _:
            print("! unhandled command {} args {}".format(command, args))
handle.player = 0
