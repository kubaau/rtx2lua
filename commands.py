from collections import defaultdict
import constants
import events

act_player = 0
people = defaultdict(list)
player_always = defaultdict(list)
player_firststart = defaultdict(list)
portraits = {}
wares = defaultdict(list)
world_always = []
world_firststart = []

def add_animal(args):
    global world_firststart

    animal = constants.animals[args[0]]
    amount = args[1]
    x = args[2]
    y = args[3]

    for _ in range(amount):
        world_firststart += ["AddAnimal({}, {}, {})".format(x, y, animal)]

def add_computer_player(args):
    player = args[0]
    portrait = args[1]

    portraits[player] = portrait
    player_always[player] +=  ["EnableAllBuildings()"] # in S2 AI always had all buildings enabled

def add_people_or_ware(pw, id, amount):
    for x in pw[act_player]:
        if id in x.keys():
            x[id] += amount
            return
    pw[act_player] += [{id: amount}]

def add_people(args):
    add_people_or_ware(people, constants.people[args[0]], args[1])

def add_ware(args):
    add_people_or_ware(wares, constants.wares[args[0]], args[1])

# these enable/disable houses seem to work only for the human player in S2, they never affect the AI
def disable_house(args):
    building = constants.buildings[args[0]]
    player_always[0] += ["DisableBuilding({})".format(building)]

def enable_all_houses(args):
    player_always[0] += ["EnableAllBuildings()"]

def enable_house(args):
    building = constants.buildings[args[0]]
    player_always[0] += ["EnableBuilding({}, false)".format(building)]

def load_mission_texts(args):
    events.chapter = args[0]

def set_act_player(args):
    global act_player
    act_player = args[0]

def set_bobs(args):
    pass # this must be handled to properly place stuff like ruins (e.g. FANpaign chapter 3)

def set_computer_alliance(args):
    alliance_from = args[0]
    alliance_to = args[1]
    player_firststart[alliance_from] += ["MakeOneSidedAllianceTo({})".format(alliance_to)]

def set_computer_barrier(args):
    global world_always

    radius = args[0]
    x = args[1]
    y = args[2]

    world_always += ["SetComputerBarrier({}, {}, {})".format(radius, x, y)]

def set_house(args):
    building = constants.buildings[args[0]]
    x = args[1]
    y = args[2]

    if building == "BLD_HEADQUARTERS":
        player_firststart[act_player] += ["PlaceHQ({}, {})".format(x, y)]
    else:
        player_firststart[act_player] += ["AIConstructionOrder({}, {}, {})".format(x, y, building)]

def set_hq_bobs(args):
    if args == [6, 7, 0]:
        player_firststart[0] += ["ModifyHQ(1)"]
    #else: # don't know how to handle this

def set_map(args):
    pass

def set_mapbobs(args):
    pass

def set_palette(args):
    pass

def set_pattern(args):
    pass

def handle(command, args):
    match command:
        case "ADD_ANIMAL":
            add_animal(args)
        case "ADD_COMPUTER_PLAYER":
            add_computer_player(args)
        case "ADD_PEOPLE":
            add_people(args)
        case "ADD_WARE":
            add_ware(args)
        case "DISABLE_HOUSE":
            disable_house(args)
        case "ENABLE_ALL_HOUSES":
            enable_all_houses(args)
        case "ENABLE_HOUSE":
            enable_house(args)
        case "LOAD_MISSION_TEXTS":
            load_mission_texts(args)
        case cmd if command.startswith("MET_"):
            events.handle(cmd.replace("MET_", ""), args)
        case "SET_ACT_PLAYER":
            set_act_player(args)
        case "SET_BOBS":
            set_bobs(args)
        case "SET_COMPUTER_ALLIANCE":
            set_computer_alliance(args)
        case "SET_COMPUTER_BARRIER":
            set_computer_barrier(args)
        case "SET_HOUSE":
            set_house(args)
        case "SET_HQ_BOBS":
            set_hq_bobs(args)
        case "SET_MAP":
            set_map(args)
        case "SET_MAPBOBS":
            set_mapbobs(args)
        case "SET_PALETTE":
            set_palette(args)
        case "SET_PATTERN":
            set_pattern(args)
        case _:
            print("-- ! unhandled command {} args {}".format(command, args))
