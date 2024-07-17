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

def found(res, args):
    event_id = args[0]
    end_event_id = args[1]
    text_id = args[2]

    ret = "    elseif(activeEvents[{:>2}] and r == RES_{}) then".format(event_id, res)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    return ret

def house_enabling(e, bld):
    return "elseif(e == {:>2}) then\n        rttr:GetPlayer(0):EnableBuilding({}, true)".format(e, bld)

def position_explored_or_occupied(args):
    event_id = args[0]
    end_event_id = args[1]
    x = args[2]
    y = args[3]
    text_id = args[4]

    ret = "elseif(activeEvents[{}] and x == {} and y == {}) then".format(event_id, x, y)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    return ret

def end_event(args):
    event_id = args[0]
    times_required = args[2]
    enable_event = args[3]
    text_id = args[7]

    ret = "elseif(e == {:>2}".format(event_id)
    if times_required > 1:
        ret += " and endEvents[{}] >= {}".format(event_id, times_required)
    ret += ") then"
    if enable_event != 255:
        ret += "\n        activeEvents[{}] = true".format(enable_event)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    return ret

def set_final_event(args):
    event_id = args[0]
    chapter = args[1]
    ret = "elseif(e == {:>2}) then".format(event_id)
    ret += "\n        rttr:SetCampaignChapterCompleted({}, {})".format(repr(campaign), chapter)
    ret += "\n        rttr:EnableCampaignChapter({}, {})".format(repr(campaign), chapter + 1)
    return ret

def set_map_element(args):
    event_id = args[0]
    x = args[1]
    y = args[2]
    ret = "elseif(e == {:>2}) then".format(event_id)
    ret += "\n        rttr:GetWorld():AddStaticObject({}, {}, 561, 0xFFFF, 2)".format(x, y)
    return ret

def house_amount(args):
    event_id = args[0]
    end_event_id = args[1]
    building = constants.buildings[args[2]]
    amount = args[3]
    text_id = args[4]

    ret = "if(activeEvents[{}] and rttr:GetPlayer(0):GetBuildingCount({}) >= {}) then".format(event_id, building, amount)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    ret += "\n    end"
    return ret

def ware_amount(args):
    event_id = args[0]
    end_event_id = args[1]
    ware = constants.wares[args[2]]
    amount = args[3]
    text_id = args[4]

    ret = "if(activeEvents[{}] and rttr:GetPlayer(0):GetWareCount({}) >= {}) then".format(event_id, ware, amount)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    ret += "\n    end"
    return ret

def contact_to_player(args):
    event_id = args[0]
    end_event_id = args[1]
    other_player = args[2]
    text_id = args[3]
    ret = "elseif(activeEvents[{0}] and (p == 0 and o == {1}) or (p == {1} and o == 0)) then".format(event_id, other_player)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    return ret

def land_size(args):
    event_id = args[0]
    end_event_id = args[1]
    size = args[2]
    text_id = args[3]

    ret = "if(activeEvents[{}] and rttr:GetPlayer(0).GetStatisticsValue ~= nil and rttr:GetPlayer(0):GetStatisticsValue(STAT_COUNTRY) >= {}) then".format(event_id, size)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    ret += "\n    end"
    return ret

def handle(event, args):
    global active, end, oncontact, onexplored, ongameframe, onoccupied, onresourcefound, onstart, requirements

    match event:
        case "ADD_AS_ACT_EVENT":
            active += ["activeEvents[{:>2}] = true".format(args[0])]
        case "CONTACT_TO_PLAYER":
            oncontact += [contact_to_player(args)]
        case "DIRECT_EVENT":
            onstart += ["MissionText({})".format(args[2])]
        case "END_EVENT":
            if args[2] > 1:
                requirements += ["endEvents[{:>2}] = 0".format(args[0])]
            end += [end_event(args)]
        case event if event.startswith("FOUND_"):
            onresourcefound += [found(event.replace("FOUND_", ""), args)]
        case "HOUSE_AMOUNT":
            ongameframe += [house_amount(args)]
        case "HOUSE_ENABLING":
            end += [house_enabling(args[0], constants.buildings[args[1]])]
        case "LAND_SIZE":
            ongameframe += [land_size(args)]
        case "POSITION_EXPLORED":
            onexplored += [position_explored_or_occupied(args)]
        case "POSITION_OCCUPIED":
            onoccupied += [position_explored_or_occupied(args)]
        case "SET_FINAL_EVENT":
            end += [set_final_event(args)]
        case "SET_MAP_ELEMENT":
            end += [set_map_element(args)]
        case "WARE_AMOUNT":
            ongameframe += [ware_amount(args)]
        case _:
            print("! unhandled event {} args {}".format(event, args))
    return
