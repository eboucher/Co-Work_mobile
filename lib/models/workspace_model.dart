import 'package:cowork_mobile/helpers/constants.dart';
import 'package:enum_to_string/enum_to_string.dart';


class Workspace {
  String id;
  String description;
  String name;
  List<Room> rooms;
  List<Tool> tools;

  static convert(Map map) {
     Workspace openSpace = new Workspace();
     openSpace.id = map['id'];
     openSpace.description = map['description'];
     openSpace.name = map['name'];
     openSpace.rooms = new List<Room>.from(Utilities.convertArray(map['rooms'], Room.convert));
     openSpace.tools = new List<Tool>.from(Utilities.convertArray(map['tools'], Tool.convert));
     return openSpace;
  }

  static returnByID(List<Workspace> openSpaces,String id) {
    for (Workspace openSpace in openSpaces) {
      if (id==openSpace.id) {
        return openSpace;
      }
    }
  }
}

class WorkspaceId{
  String id;
  String name;
  static dynamic convert(Map map) {
    WorkspaceId openSpace = new WorkspaceId();
    openSpace.id = map['id'];
    openSpace.name = map['name'];
    return openSpace;
  }
}

class Room {
  String id;
  String description;
  String name;
  WorkspaceId openSpace;
  bool available = true;
  static dynamic convert(Map map) {
    Room room = new Room();
    room.id = map['id'];
    room.description = map['description'];
    room.name = map['name'];
    room.openSpace = WorkspaceId.convert(map['openSpace']);
    return room;
  }
}

enum ToolType {
  TOOL,
  PRINTER,
  LAPTOP,
}

class Tool {
  String id;
  String name;
  ToolType type;

  static dynamic convert(Map map) {
    Tool openSpace = new Tool();
    openSpace.id = map['id'];
    openSpace.name = map['name'];
    openSpace.type = EnumToString.fromString(ToolType.values,map['type']);
    return openSpace;
  }

}


class Booking {
  String id;
  DateTime start;
  DateTime end;
  int food;
  Room room;
  List<Tool> tools;
  String user;

  static dynamic convert(Map map) {
    Booking booking = new Booking();
    booking.id = map['id'];
    booking.start = DateTime.parse(map['start']);
    booking.end = DateTime.parse(map['end']);
    booking.food = map['food'];
    booking.room = Room.convert(map['room']);
    booking.tools =  new List<Tool>.from(Utilities.convertArray(map['tools'], Tool.convert));
    booking.user = map['user']['id'];
    return booking;
  }
}

class Available {
  List<Booking> bookings;
  var availableHour;

  static dynamic convert(Map map) {
    Available available = new Available();
    available.bookings =  new List<Booking>.from(Utilities.convertArray(map['bookings'], Booking.convert));
    available.availableHour = map['availableHour'];
    return available;
  }
}

class SortedTool {
  List<Tool> laptops = [];
  List<Tool> printers = [];
  List<Tool> others = [];

  static dynamic fromListTool(List<Tool> tools) {
    SortedTool res = new SortedTool();
    for(Tool tool in tools) {
      if(tool.type == ToolType.LAPTOP) {
        res.laptops.add(tool);
      } else if(tool.type == ToolType.PRINTER) {
        res.printers.add(tool);
      } else if(tool.type == ToolType.TOOL) {
        res.others.add(tool);
      }
    }
    return res;
  }
}

class BookingToJson {
  String start;
  String end;
  int food;
  String room;
  List<String> tools;

  toJson() {
    Map<String,dynamic> json = {
      'start': start,
      'end': end,
      'food': food,
      'room': room,
      'tools': tools
    };
    return json;
  }
}