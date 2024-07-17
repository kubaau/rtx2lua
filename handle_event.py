from constants import *

active_events = []
end_event_requirements = []
end_events = []
oncontact_events = []
onexplored_events = []
ongameframe_events = []
onoccupied_events = []
onresourcefound_events = []
onstart_events = []

def create_onresource_case(res, args):
    event_id = int(args[0])
    end_event_id = int(args[1])
    text_id = int(args[2])

    ret = "    elseif(activeEvents[{:>2}] and r == RES_{}) then".format(event_id, res)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    return ret

def create_house_enabling_case(e, bld):
    return "elseif(e == {:>2}) then\n        rttr:GetPlayer(0):EnableBuilding({}, true)".format(e, bld)

def create_position_explored_or_occupied_case(args):
    event_id = int(args[0])
    end_event_id = int(args[1])
    x = int(args[2])
    y = int(args[3])
    text_id = int(args[4])

    ret = "elseif(activeEvents[{}] and x == {} and y == {}) then".format(event_id, x, y)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    return ret

def create_end_event_case(args):
    event_id = int(args[0])
    times_required = int(args[2])
    enable_event = int(args[3])
    text_id = int(args[7])

    ret = "elseif(e == {:>2}".format(event_id)
    if times_required > 1:
        ret += " and endEvents[{}] >= {}".format(event_id, times_required)
    ret += ") then"
    if enable_event != 255:
        ret += "\n        activeEvents[{}] = true".format(enable_event)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    return ret

def create_final_event_case(args):
    event_id = int(args[0])
    chapter = int(args[1])
    ret = "elseif(e == {:>2}) then".format(event_id)
    ret += "\n        rttr:SetCampaignChapterCompleted('roman', {})".format(chapter)
    ret += "\n        rttr:EnableCampaignChapter('roman', {})".format(chapter + 1)
    return ret

def create_map_element_case(args):
    event_id = int(args[0])
    x = int(args[1])
    y = int(args[2])
    ret = "elseif(e == {:>2}) then".format(event_id)
    ret += "\n        rttr:GetWorld():AddStaticObject({}, {}, 561, 0xFFFF, 2)".format(x, y)
    return ret

def create_house_amount_case(args):
    event_id = int(args[0])
    end_event_id = int(args[1])
    building = buildings[int(args[2])]
    amount = int(args[3])
    text_id = int(args[4])

    ret = "if(activeEvents[{}] and rttr:GetPlayer(0):GetBuildingCount({}) >= {}) then".format(event_id, building, amount)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    ret += "\n    end"
    return ret

def create_ware_amount_case(args):
    event_id = int(args[0])
    end_event_id = int(args[1])
    ware = wares[int(args[2])]
    amount = int(args[3])
    text_id = int(args[4])

    ret = "if(activeEvents[{}] and rttr:GetPlayer(0):GetWareCount({}) >= {}) then".format(event_id, ware, amount)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    ret += "\n    end"
    return ret

def create_contact_to_player_case(args):
    event_id = int(args[0])
    end_event_id = int(args[1])
    other_player = int(args[2])
    text_id = int(args[3])
    ret = "elseif(activeEvents[{0}] and (p == 0 and o == {1}) or (p == {1} and o == 0)) then".format(event_id, other_player)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    return ret

def create_land_size_case(args):
    event_id = int(args[0])
    end_event_id = int(args[1])
    size = int(args[2])
    text_id = int(args[3])

    ret = "if(activeEvents[{}] and rttr:GetPlayer(0).GetStatisticsValue ~= nil and rttr:GetPlayer(0):GetStatisticsValue(STAT_COUNTRY) >= {}) then".format(event_id, size)
    ret += "\n        TriggerEndEvent({})".format(event_id)
    if end_event_id != 255:
        ret += "\n        TriggerEndEvent({})".format(end_event_id)
    if text_id >= 0:
        ret += "\n        MissionText({})".format(text_id)
    ret += "\n        activeEvents[{}] = false".format(event_id)
    ret += "\n    end"
    return ret

def handle_event(event, args):
    global active_events
    global end_event_requirements
    global end_events
    global oncontact_events
    global onexplored_events
    global ongameframe_events
    global onoccupied_events
    global onresourcefound_events
    global onstart_events
    match event:
        case "ADD_AS_ACT_EVENT":
            active_events += ["activeEvents[{:>2}] = true".format(args[0])]
        case "CONTACT_TO_PLAYER":
            oncontact_events += [create_contact_to_player_case(args)] #["{}(id={}, player={}, txt={})".format(event, args[0], args[2], args[3])]
        case "DIRECT_EVENT":
            onstart_events += ["MissionText({})".format(args[2])]
        case "END_EVENT":
            if int(args[2]) > 1:
                end_event_requirements += ["endEvents[{:>2}] = 0".format(args[0])]
            end_events += [create_end_event_case(args)]
        case event if event.startswith("FOUND_"):
            onresourcefound_events += [create_onresource_case(event.replace("FOUND_", ""), args)]
        case "HOUSE_AMOUNT":
            ongameframe_events += [create_house_amount_case(args)]
        case "HOUSE_ENABLING":
            end_events += [create_house_enabling_case(args[0], buildings[int(args[1])])]
        case "LAND_SIZE":
            ongameframe_events += [create_land_size_case(args)] #["{}(id={}, size={}, txt={})".format(event, args[0], args[2], args[3])]
        case "POSITION_EXPLORED":
            onexplored_events += [create_position_explored_or_occupied_case(args)]
        case "POSITION_OCCUPIED":
            onoccupied_events += [create_position_explored_or_occupied_case(args)]
        case "SET_FINAL_EVENT":
            end_events += [create_final_event_case(args)]
        case "SET_MAP_ELEMENT":
            end_events += [create_map_element_case(args)]
        case "WARE_AMOUNT":
            ongameframe_events += [create_ware_amount_case(args)]
        case _:
            print("! unhandled event {} args {}".format(event, args))
    return
