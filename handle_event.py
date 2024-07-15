from constants import *

active_events = []
oncontact_events = []
onexplored_events = []
ongameframe_events = []
onoccupied_events = []
onresourcefound_events = []
onstart_events = []

def handle_event(event, args):
    global active_events
    global oncontact_events
    global onexplored_events
    global ongameframe_events
    global onoccupied_events
    global onresourcefound_events
    global onstart_events
    match event:
        case "ADD_AS_ACT_EVENT":
            active_events += ["{}({})".format(event, args[0])]
        case "CONTACT_TO_PLAYER":
            oncontact_events += ["{}(id={}, player={}, txt={})".format(event, args[0], args[2], args[3])]
        case "DIRECT_EVENT":
            onstart_events += ["MissionText({})".format(args[2])]
        case "END_EVENT":
            ongameframe_events += ["{}(id={}, enableevent?={}, txt={})".format(event, args[0], args[3], args[7])]
        case event if event.startswith("FOUND_"):
            onresourcefound_events += ["{}(id={}, endevent?={}, txt={})".format(event, args[0], args[1], args[2])]
        case "HOUSE_AMOUNT":
            ongameframe_events += ["{}(id={}, endevent={}, {}, txt={})".format(event, args[0], args[1], buildings[int(args[2])], args[4])]
        case "HOUSE_ENABLING":
            ongameframe_events += ["{}(id={}, {})".format(event, args[0], buildings[int(args[1])])]
        case "LAND_SIZE":
            ongameframe_events += ["{}(id={}, size={}, txt={})".format(event, args[0], args[2], args[3])]
        case "POSITION_EXPLORED":
            onexplored_events += ["{}(id={}, jumptoevent?={}, x={}, y={}, txt={})".format(event, args[0], args[1], args[2], args[3], args[4])]
        case "POSITION_OCCUPIED":
            onoccupied_events += ["{}(id={}, jumptoevent?={}, x={}, y={}, txt={})".format(event, args[0], args[1], args[2], args[3], args[4])]
        case "SET_FINAL_EVENT":
            ongameframe_events += ["{}(id={}, mission_to_enable={})".format(event, args[0], args[1])]
        case "SET_MAP_ELEMENT":
            ongameframe_events += ["{}(id={}, x={}, y={}, elem={})".format(event, args[0], args[1], args[2], args[3])]
        case "WARE_AMOUNT":
            ongameframe_events += ["{}(id={}, type={}, amount={}, txt={})".format(event, args[0], args[2], args[3], args[4])]
        case _:
            print("! unhandled event {} args {}".format(event, args))
    return
