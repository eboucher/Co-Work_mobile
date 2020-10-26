import 'package:cowork_mobile/component/flush_bar_message.dart';
import 'package:cowork_mobile/models/location_model.dart';
import 'package:cowork_mobile/models/workspace_model.dart';
import 'package:cowork_mobile/services/workspace_service.dart';
import 'package:cowork_mobile/services/booking_service.dart';
import 'package:cowork_mobile/helpers/constants.dart';
import 'package:cowork_mobile/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_select/smart_select.dart';
import 'package:time_range/time_list.dart';
import 'package:time_range/time_range.dart';


class Booking extends StatefulWidget {
  final Location location;

  Booking({Key key, @required this.location}) : super(key: key);

  @override
  _BookingState createState() => _BookingState(location);
}

class _BookingState extends State<Booking> {

  final Location _location;
  DateTime pickeDate;
  List<S2Choice<Workspace>> options = [];
  List<S2Choice<Room>> roomOption = [];
  Available available;
  Workspace locationSelected;
  List<Room> availableRoom = [];
  SortedTool availableTool = new SortedTool();
  Room roomSelected;
  bool showFromTP = true;
  bool showToTP = true;
  bool showRoomSelection = true;
  bool noHourAvailable = true;

  var hourArray = [
    '8:00', '9:00', '10:00', '11:00', '12:00', '13:00', '14:00',
    '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00'
  ];

  var availableHour = {
    8: { "available": false },
    9: { "available": false },
    10: { "available": false },
    11: { "available": false },
    12: { "available": false },
    13: { "available": false },
    14: { "available": false },
    15: { "available": false },
    16: { "available": false },
    17: { "available": false },
    18: { "available": false },
    19: { "available": false },
    20: { "available": false },
    21: { "available": false }
  };

  var pcNumber = 0.0;
  var printerNumber = 0.0;

  TimeOfDay fromStartTP = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay fromEndTP = TimeOfDay(hour: 21, minute: 00);
  TimeOfDay startHour;
  TimeOfDay endHour;

  TimeOfDay toStartTP = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay toEndTP = TimeOfDay(hour: 21, minute: 00);

  var foodNumber = 0.0;

  _BookingState(this._location);

  @override
  void initState() {
    super.initState();
    //pickeDate = DateTime.now();
    _getWorkspace();
  }

  _pickDate() async {
    pickeDate = DateTime.now();
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate:pickeDate,
    );

    if(date != null) {
      setState(() {
        pickeDate = date;
      });
      if(locationSelected != null) {
        print("getAvailable");
        var availableJSON = await BookingService.getAvailable(
            locationSelected.id,
            pickeDate.toString()
        );
        available = Available.convert(availableJSON);
        showFromTP = true;
        setState(() {
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2446a6),
          title: Text(APP_TITLE),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context),
          ),
        ),

      body: Column(
        children:[

          Text(
            "Chosen location: ${_location.name}",
            style: GoogleFonts.openSans(
              color: Colors.blueGrey,
              fontSize: 12,
              fontWeight: FontWeight.w900
            )
          ),

          Flexible(
            child: ListTile(
              title: Text( "Date: "+ getResDate()),
              trailing:Icon(Icons.keyboard_arrow_down),
              onTap: _pickDate,
            ),
          ),

          Flexible(
            child: Column(
              children:[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Start date',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TimeList(
                  firstTime: fromStartTP,
                  lastTime: fromEndTP,
                  timeStep: 60,
                  padding: 20,
                  onHourSelected: _startHourChanged,
                  borderColor: Colors.black54,
                  activeBorderColor: Colors.orange,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Colors.orange,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87
                  ),
                  activeTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                )
              ]
            )
          ),

          RaisedButton(
            child: Text('Choose start time'),
            onPressed: _chooseStartTime,
          ),

          Visibility(
            visible: noHourAvailable,
            child:Text(
              "There are no available rooms for this time",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Visibility(
              visible: showToTP,
              child: Column(
                children:[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'End date',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TimeList(
                  firstTime: toStartTP,
                  lastTime: toEndTP,
                  timeStep: 60,
                  padding: 20,
                  onHourSelected: _endHourChanged,
                  borderColor: Colors.black54,
                  activeBorderColor: Colors.orange,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Colors.orange,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87
                  ),
                  activeTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ]
            )
          ),

          Visibility(
            visible:showRoomSelection,
            child: Column(
              children:[

              SmartSelect<Room>.single(
                title: 'Room',
                value: roomSelected,
                choiceItems: roomOption,
                onChange: (state) =>
                    setState( () => roomSelected = state.value )
              ),
              Icon(
                Icons.laptop,
                color: Colors.black,
                size: 30.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),

              Visibility(
                visible: availableTool.laptops.length > 0,
                child: Slider(
                  value:pcNumber,
                  min : 0,
                  max : availableTool.laptops.length +.0,
                  onChanged: (newRating) {
                    setState( ()=> pcNumber = newRating );
                  },
                  divisions:getDivisions(availableTool.laptops),
                  label:"$pcNumber",
                ),
              ),

              Visibility(
                visible: availableTool.laptops.length == 0 ,
                child: Text(
                  "Laptops currently unavailable",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ),
              Icon(
                Icons.local_printshop,
                color: Colors.black,
                size: 30.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),

              Visibility(
                visible: availableTool.printers.length>0,
                child:Slider(
                    value:printerNumber,
                    label:"$printerNumber",
                    max : availableTool.printers.length +.0,
                    divisions: getDivisions(availableTool.printers),
                    onChanged: (newRating) {
                      setState( ()=> printerNumber = newRating);
                    },
                    min:0.0
                )
              ),

              Visibility(
                visible: availableTool.printers.length == 0,
                child: Text(
                  "Printers currently available",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ),

              Icon(
                Icons.fastfood,
                color: Colors.black,
                size: 30.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),

              Slider(
                value: foodNumber,
                label: "$foodNumber",
                max : 20.0,
                divisions: 20,
                onChanged: (newRating) {
                  setState( () => foodNumber = newRating );
                },
                min:0.0
              ),

              RaisedButton(
                  child: const Text(
                    'Book',
                    style: TextStyle(fontSize: 16)
                  ),
                  onPressed: !isButtonAble() ? null: () {
                    book();
                  },
                  disabledTextColor: Colors.white60,
                  disabledColor: Colors.blueAccent
              ),
            ]
          )
        )
      ]
    ),
        drawer: CustonDrawer()
    );
  }

  _chooseStartTime() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Material Dialog"),
          content: Column(
              children:[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Start date',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TimeList(
                  firstTime: fromStartTP,
                  lastTime: fromEndTP,
                  timeStep: 60,
                  padding: 20,
                  onHourSelected: _startHourChanged,
                  borderColor: Colors.black54,
                  activeBorderColor: Colors.orange,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Colors.orange,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87
                  ),
                  activeTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                )
              ]
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close me!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        )
    );
  }


  _getWorkspace() async {
    var locations = await WorkspaceService.read();
    for (var locationJSON in locations) {
      Workspace location = Workspace.convert(locationJSON);
      options.add(S2Choice<Workspace>(value: location, title: location.name));
    }
  }

  void _startHourChanged(TimeOfDay hour) {
    noHourAvailable = true; //false actually
    this.showRoomSelection = true; //false actually
    this.startHour = hour;
    this.roomSelected = null;

    if(available.availableHour[hour.hour.toString()] == locationSelected.rooms.length) {
      print("nothing");
      noHourAvailable = true;
      showToTP = true; //false actually
      setState(() =>{});
      return;
    }

    showToTP = true;
    var possibleEnd = findNextHourAvailable(
        hour.hour,
        available.availableHour
    );

    toStartTP = hour.add(minutes: 60);
    toEndTP = TimeOfDay(hour: possibleEnd+1, minute: 00);

    print("start"+toStartTP.toString());
    print("end"+toEndTP.toString());
    setState(() => {});
  }

  void _endHourChanged(TimeOfDay hour) async {
    print("blabla");
    this.roomOption = [];
    this.endHour = hour;
    availableRoom = this.getAvailableRoom();

    for(var room in availableRoom) {
      roomOption.add(S2Choice<Room>(
          value: room,
          title: room.name)
      );
    }

    this.showRoomSelection = true;
    availableTool = SortedTool.fromListTool(this.getAvailableTool());
    print(availableTool.laptops.length);
    print(availableTool.printers.length);
    setState(() => {});
  }

  findNextHourAvailable(start, availableHour) {
    start++;
    while(start < 21) {
      if(available.availableHour[start.toString()] == locationSelected.rooms.length) {
        return start;
      }
      start++;
    }
    return 21;
  }

  List<Room> getAvailableRoom() {
    List<Room> rooms = [];
    for (Room room in this.locationSelected.rooms) {
      if(this.isRoomAvailable(room.id)) {
        rooms.add(room);
      }
    }
    return rooms;
  }

  bool isRoomAvailable(String id) {
    DateTime start = new DateTime(
        this.pickeDate.year,
        this.pickeDate.month,
        this.pickeDate.day,
        this.startHour.hour,
        1
    );
    DateTime end = new DateTime(
        this.pickeDate.year,
        this.pickeDate.month,
        this.pickeDate.day,
        this.endHour.hour
    );

    for (var booking in this.available.bookings) {

      if (booking.room.id == id ) {
        if (this.isDateOverLapping(booking.start, booking.end, start, end))
        {
          print(start.toString());
          print(end.toString());
          print("compare with old");
          print(booking.start.toString());
          print(booking.end.toString());

          print("Overlapping");
          return false;
        }
      }
    }
    return true;
  }


  List<Tool> getAvailableTool() {
    List<Tool> tools = [];
    for (Tool tool in this.locationSelected.tools) {
      if(this.isToolAvailable(tool.id)) {
        tools.add(tool);
      }
    }
    return tools;
  }

  bool isToolAvailable(String id) {
    DateTime start = new DateTime(
        this.pickeDate.year,
        this.pickeDate.month,
        this.pickeDate.day,
        this.startHour.hour,
        1
    );
    DateTime end = new DateTime(
        this.pickeDate.year,
        this.pickeDate.month,
        this.pickeDate.day,
        this.endHour.hour
    );

    this.available.bookings.forEach((booking) {
      for(Tool tool in booking.tools) {
        if (tool.id == id ) {
          if (this.isDateOverLapping(booking.start, booking.end, start, end)) {
            return false;
          }
        }
      }
      return true;
    });
  }

  isDateOverLapping(DateTime startDate1, DateTime endDate1,
      DateTime startDate2, DateTime endDate2)
  {
    return (startDate1.isBefore(endDate2) || startDate1.isAtSameMomentAs(endDate2) )
        && (endDate1.isAfter(startDate2) || endDate1.isAtSameMomentAs(startDate2) );
  }

  getDivisions(List<Object> list) {
    if(list.length <= 0) {
      return 1;
    }
    return list.length;
  }

  book() async {
    DateTime start = new DateTime(
        this.pickeDate.year,
        this.pickeDate.month,
        this.pickeDate.day,
        this.startHour.hour
    );

    DateTime end = new DateTime(
        this.pickeDate.year,
        this.pickeDate.month,
        this.pickeDate.day,
        this.endHour.hour
    );

    BookingToJson bookingToJson = new BookingToJson();
    bookingToJson.room = roomSelected.id;
    bookingToJson.start = start.toString();
    bookingToJson.end = end.toString();
    bookingToJson.food = (foodNumber).toInt();
    bookingToJson.tools = pickSomeToolToBook(
        (pcNumber).toInt(),
        (printerNumber).toInt(),
        availableTool
    );

    try {
      await BookingService.create(bookingToJson.toJson());
      Navigator.pop(context);
      Navigator.pop(context);
      FlushBarMessage.goodMessage(content: "Booking done").showFlushBar(context);

    } catch (exception) {
      print(exception);
      FlushBarMessage.errorMessage(content: "Error during registration").showFlushBar(context);
    }
  }


  pickSomeToolToBook(int pcNumber, int printerNumber, SortedTool available) {
    List<String> res = [];
    int pcRetrieve = 0;
    int  printerRetrieve = 0;
    for (Tool laptop in available.laptops) {
      if( pcRetrieve == pcNumber)
        break;
      res.add(laptop.id);
    }

    for (Tool printer in available.printers) {
      if(printerRetrieve == printerNumber)
        break;
      res.add(printer.id);
    }
    return res;
  }


  isButtonAble() {
    if(null == roomSelected)
      return false;
    return true;
  }
  updateGetAvailable() async {
    if(locationSelected!= null && pickeDate != null) {
      print("getAvailable");
      var availableJSON = await BookingService.getAvailable(
          locationSelected.id,
          pickeDate.toString()
      );
      available = Available.convert(availableJSON);
      showFromTP = true;
    }
    setState(() {
    });
  }

  getResDate() {
    if(pickeDate != null)
      return '${pickeDate.day} ${pickeDate.month} ${pickeDate.year}';
    return '';
  }
}
