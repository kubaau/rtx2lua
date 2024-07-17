import constants

active = []
campaign = "roman"
end = []
oncontact = []
onexplored = []
ongameframe = []
onoccupied = []
onresourcefound = []
onstart = []
requirements = []

def add_as_act_event(args):
    global active
    eid = args[0]
    active += ["activeEvents[{:>2}] = true".format(eid)]

def is_event_valid(id):
    return id != 255

def is_msgid_valid(id):
    return id >= 0

def contact_to_player(args):
    global oncontact
    eid = args[0]
    end_eid = args[1]
    player = args[2]
    msgid = args[3]
    code = "elseif(activeEvents[{0}] and (p == 0 and o == {1}) or (p == {1} and o == 0)) then".format(eid, player)
    code += "\n        TriggerEndEvent({})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({})".format(end_eid)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    oncontact += [code]

def direct_event(args):
    global onstart
    msgid = args[2]
    onstart += ["MissionText({})".format(msgid)]

def end_event(args):
    global end, requirements
    eid = args[0]
    times_required = args[2]
    event_to_enable = args[3]
    msgid = args[7]

    code = "elseif(e == {:>2}".format(eid)
    if times_required > 1:
        code += " and endEvents[{}] >= {}".format(eid, times_required)
        requirements += ["endEvents[{:>2}] = 0".format(eid)]
    code += ") then"
    if is_event_valid(event_to_enable):
        code += "\n        activeEvents[{}] = true".format(event_to_enable)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    end += [code]

def found_resource(resource, args):
    global onresourcefound
    eid = args[0]
    end_eid = args[1]
    msgid = args[2]

    code = "    elseif(activeEvents[{:>2}] and r == RES_{}) then".format(eid, resource)
    code += "\n        TriggerEndEvent({})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({})".format(end_eid)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    code += "\n        activeEvents[{}] = false".format(eid)
    onresourcefound += [code]

def house_amount(args):
    global ongameframe
    eid = args[0]
    end_eid = args[1]
    building = constants.buildings[args[2]]
    amount = args[3]
    msgid = args[4]

    code = "if(activeEvents[{}] and rttr:GetPlayer(0):GetBuildingCount({}) >= {}) then".format(eid, building, amount)
    code += "\n        TriggerEndEvent({})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({})".format(end_eid)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    code += "\n        activeEvents[{}] = false".format(eid)
    code += "\n    end"
    ongameframe += [code]

def house_enabling(args):
    global end
    eid = args[0]
    building = constants.buildings[args[1]]
    end += ["elseif(e == {:>2}) then\n        rttr:GetPlayer(0):EnableBuilding({}, true)".format(eid, building)]

def land_size(args):
    global ongameframe
    eid = args[0]
    end_eid = args[1]
    size = args[2]
    msgid = args[3]

    code = "if(activeEvents[{}] and rttr:GetPlayer(0).GetStatisticsValue ~= nil and rttr:GetPlayer(0):GetStatisticsValue(STAT_COUNTRY) >= {}) then".format(eid, size)
    code += "\n        TriggerEndEvent({})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({})".format(end_eid)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    code += "\n        activeEvents[{}] = false".format(eid)
    code += "\n    end"
    ongameframe += [code]

def position_explored_or_occupied(args, eo):
    eid = args[0]
    end_eid = args[1]
    x = args[2]
    y = args[3]
    msgid = args[4]

    code = "elseif(activeEvents[{}] and x == {} and y == {}) then".format(eid, x, y)
    code += "\n        TriggerEndEvent({})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({})".format(end_eid)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    code += "\n        activeEvents[{}] = false".format(eid)
    eo += [code]

def position_explored(args):
    position_explored_or_occupied(args, onexplored)

def position_occupied(args):
    position_explored_or_occupied(args, onoccupied)

def set_final_event(args):
    global end
    eid = args[0]
    chapter = args[1]
    code = "elseif(e == {:>2}) then".format(eid)
    code += "\n        rttr:SetCampaignChapterCompleted({}, {})".format(repr(campaign), chapter)
    code += "\n        rttr:EnableCampaignChapter({}, {})".format(repr(campaign), chapter + 1)
    end += [code]

def set_map_element(args):
    global end
    eid = args[0]
    x = args[1]
    y = args[2]
    code = "elseif(e == {:>2}) then".format(eid)
    code += "\n        rttr:GetWorld():AddStaticObject({}, {}, 561, 0xFFFF, 2)".format(x, y)
    end += [code]

def ware_amount(args):
    global ongameframe
    eid = args[0]
    end_eid = args[1]
    ware = constants.wares[args[2]]
    amount = args[3]
    msgid = args[4]

    code = "if(activeEvents[{}] and rttr:GetPlayer(0):GetWareCount({}) >= {}) then".format(eid, ware, amount)
    code += "\n        TriggerEndEvent({})".format(eid)
    if is_event_valid(end_eid):
        code += "\n        TriggerEndEvent({})".format(end_eid)
    if is_msgid_valid(msgid):
        code += "\n        MissionText({})".format(msgid)
    code += "\n        activeEvents[{}] = false".format(eid)
    code += "\n    end"
    ongameframe += [code]

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
