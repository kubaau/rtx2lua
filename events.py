from collections import defaultdict
import constants

active = []
campaign = "roman"
end = defaultdict(list)
oncontact = defaultdict(list)
onexplored = defaultdict(list)
ongameframe = defaultdict(list)
onoccupied = defaultdict(list)
onresourcefound = defaultdict(list)
onstart = defaultdict(list)
requirements = {}

def is_event_valid(id):
    return id != 255

def is_msgid_valid(id):
    return id >= 0

def is_house_valid(id):
    return id <= 32

def get_common_code(msgid, eid, end_eid):
    code = ""
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    code += "\n        TriggerEndEvent({0}, {0})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({}, {})".format(end_eid, eid)
    return code

def add_as_act_event(args):
    global active
    eid = args[0]

    active += [eid]

def contact_to_player(args):
    global oncontact
    eid = args[0]
    end_eid = args[1]
    player = args[2]
    msgid = args[3]

    code = "elseif(activeEvents[{0}] and (p == 0 and o == {1}) or (p == {1} and o == 0)) then".format(eid, player)
    code += get_common_code(msgid, eid, end_eid)
    oncontact[eid] += [code]

def direct_event(args):
    global end, onstart
    eid = args[0]
    end_eid = args[1]
    msgid = args[2]

    if is_msgid_valid(msgid):
        end[eid] += ["        MissionText({})".format(msgid)]
    onstart[eid] += ["    TriggerEndEvent({0}, {0})".format(eid)]
    if is_event_valid(end_eid):
        onstart[eid] += "    TriggerEndEvent({}, {})".format(end_eid, eid)

def end_event(args):
    global end, requirements
    eid = args[0]
    times_required = args[2]
    events_to_activate = args[3:7]
    msgid = args[7]

    if times_required > 1:
        requirements[eid] = times_required

    for e in events_to_activate:
        if is_event_valid(e):
            end[eid] += ["        activeEvents[{}] = true".format(e)]
    if is_msgid_valid(msgid):
        end[eid] += ["        MissionText({})".format(msgid)]

def found_resource(resource, args):
    global onresourcefound
    eid = args[0]
    end_eid = args[1]
    msgid = args[2]

    code = "elseif(activeEvents[{:>2}] and r == RES_{}) then".format(eid, resource)
    code += get_common_code(msgid, eid, end_eid)
    onresourcefound[eid] += [code]

def house_amount(args):
    global ongameframe
    eid = args[0]
    end_eid = args[1]
    building = constants.buildings[args[2]]
    amount = args[3]
    msgid = args[4]

    code = "if(activeEvents[{}] and rttr:GetPlayer(0):GetBuildingCount({}) >= {}) then".format(eid, building, amount)
    code += get_common_code(msgid, eid, end_eid)
    code += "\n    end"
    ongameframe[eid] += [code]

def house_enabling(args):
    global end
    eid = args[0]
    buildings_to_enable = []
    for i in range(1, 7):
        if is_house_valid(args[i]):
            buildings_to_enable += [args[i]]
    for b in buildings_to_enable:
        end[eid] += ["        rttr:GetPlayer(0):EnableBuilding({}, true)".format(constants.buildings[b])]

def land_size(args):
    global ongameframe
    eid = args[0]
    end_eid = args[1]
    size = args[2]
    msgid = args[3]

    code = "if(activeEvents[{}] and rttr:GetPlayer(0).GetStatisticsValue ~= nil and rttr:GetPlayer(0):GetStatisticsValue(STAT_COUNTRY) >= {}) then".format(eid, size)
    code += get_common_code(msgid, eid, end_eid)
    code += "\n    end"
    ongameframe[eid] += [code]

def position_explored_or_occupied(args, eo):
    eid = args[0]
    end_eid = args[1]
    x = args[2]
    y = args[3]
    msgid = args[4]

    code = "elseif(activeEvents[{}] and x == {} and y == {}) then".format(eid, x, y)
    code += get_common_code(msgid, eid, end_eid)
    eo[eid] += [code]

def position_explored(args):
    position_explored_or_occupied(args, onexplored)

def position_occupied(args):
    position_explored_or_occupied(args, onoccupied)

def set_final_event(args):
    global end
    eid = args[0]
    chapter = args[1]
    code = "        rttr:SetCampaignChapterCompleted({}, {})".format(repr(campaign), chapter)
    code += "\n        rttr:EnableCampaignChapter({}, {})".format(repr(campaign), chapter + 1)
    end[eid] += [code]

def set_map_element(args):
    global end, ongameframe
    eid = args[0]
    x = args[1]
    y = args[2]

    code = "if(activeEvents[{}]) then".format(eid)
    code += "\n        TriggerEndEvent({0}, {0})".format(eid)
    code += "\n    end"
    ongameframe[eid] += [code]
    end[eid] += ["        rttr:GetWorld():AddStaticObject({}, {}, 561, 0xFFFF, 2)".format(x, y)]

def ware_amount(args):
    global ongameframe
    eid = args[0]
    end_eid = args[1]
    ware = constants.wares[args[2]]
    amount = args[3]
    msgid = args[4]

    code = "if(activeEvents[{}] and rttr:GetPlayer(0):GetWareCount({}) >= {}) then".format(eid, ware, amount)
    code += get_common_code(msgid, eid, end_eid)
    code += "\n    end"
    ongameframe[eid] += [code]

def handle(event, args):
    match event:
        case "ADD_AS_ACT_EVENT":
            add_as_act_event(args)
        case "CONTACT_TO_PLAYER":
            contact_to_player(args)
        case "DIRECT_EVENT":
            direct_event(args)
        case "END_EVENT":
            end_event(args)
        case e if event.startswith("FOUND_"):
            found_resource(e.replace("FOUND_", ""), args)
        case "HOUSE_AMOUNT":
            house_amount(args)
        case "HOUSE_ENABLING":
            house_enabling(args)
        case "LAND_SIZE":
            land_size(args)
        case "POSITION_EXPLORED":
            position_explored(args)
        case "POSITION_OCCUPIED":
            position_occupied(args)
        case "SET_FINAL_EVENT":
            set_final_event(args)
        case "SET_MAP_ELEMENT":
            set_map_element(args)
        case "WARE_AMOUNT":
            ware_amount(args)
        case _:
            print("! unhandled event {} args {}".format(event, args))
    return
