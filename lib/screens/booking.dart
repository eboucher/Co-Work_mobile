import 'package:cowork_mobile/component/flush_bar_message.dart';
import 'package:cowork_mobile/models/workspace_model.dart';
import 'package:cowork_mobile/services/workspace_service.dart';
import 'package:cowork_mobile/services/booking_service.dart';
import 'package:cowork_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_select/smart_select.dart';
import 'package:time_range/time_list.dart';
import 'package:time_range/time_range.dart';


class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime pickeDate;
  List<S2Choice<OpenSpace>> options = [];
  List<S2Choice<Room>> roomOption = [];
  Available available;
  OpenSpace openSpaceSelected;
  List<Room> availableRoom = [];
  SortedTool availableTool = new SortedTool();
  Room roomSelected;
  bool showFromTP = false;
  bool showToTP = false;
  bool showRoomSelection = false;
  bool noHourAvailable = false;
  var hourArray = ['8:00', '9:00', '10:00', '11:00', '12:00', '13:00',
    '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00'];
  var availableHour= {
    8:{"available":false},
    9:{"available":false},
    10:{"available":false},
    11:{"available":false},
    12:{"available":false},
    13:{"available":false},
    14:{"available":false},
    15:{"available":false},
    16:{"available":false},
    17:{"available":false},
    18:{"available":false},
    19:{"available":false},
    20:{"available":false},
    21:{"available":false}
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


  @override
  void initState() {
    super.initState();
    //pickeDate = DateTime.now();
    _getOpenSpace();
  }



  _pickDate() async {
    pickeDate = DateTime.now();
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+2),
      initialDate:pickeDate,
    );


    if(date != null){
      setState((){
        pickeDate = date;
      });
      if(openSpaceSelected!=null){
        print("getAvailable");
        var availableJSON = await BookingService.getAvailable(openSpaceSelected.id, pickeDate.toString());
        available = Available.convert(availableJSON);
        showFromTP = true;
        setState(() {

        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: PRIMARY_COLOR,title: Text("Reservation")),
        body:Column(children:[
          Flexible(
            child:SmartSelect<OpenSpace>.single(
                title: 'Openspace',
                value: openSpaceSelected,
                choiceItems: options,
                onChange: (state) => setState(()  {openSpaceSelected = state.value;})
            ),
          ),
          Flexible(
            child: ListTile(
              title: Text( "Date : "+ getResDate()),
              trailing:Icon(Icons.keyboard_arrow_down),
              onTap: _pickDate,
            ),

          ),Visibility(
              visible:showFromTP ,
              child:Column(children:[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Date de début', style: TextStyle(fontSize: 18, color: Colors.grey),),
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
                  textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )
              ])),

          Visibility(
            visible:noHourAvailable ,
            child:Text(
              "Il n'y a aucune salle disponible pour cet horaire",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
              visible:showToTP ,
              child:Column(children:[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Date de fin', style: TextStyle(fontSize: 18, color: Colors.grey),),
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
                  textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ])),
          Visibility(
              visible:showRoomSelection,
              child: Column(children:[

                SmartSelect<Room>.single(
                    title: 'Salle',
                    value: roomSelected,
                    choiceItems: roomOption,
                    onChange: (state) => setState(() => roomSelected = state.value)
                ),
                Icon(
                  Icons.laptop,
                  color: Colors.black,
                  size: 48.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                Visibility(
                  visible: availableTool.laptops.length>0,
                  child: Slider(
                    value:pcNumber,
                    min : 0,
                    max : availableTool.laptops.length +.0,
                    onChanged: (newRating){ setState( ()=> pcNumber = newRating);},
                    divisions:getDivisions(availableTool.laptops),
                    label:"$pcNumber",
                  ),),
                Visibility(
                    visible:availableTool.laptops.length==0 ,
                    child:Text(
                      "Il n'y a plus d'ordinateur disponible",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                ),
                Icon(
                  Icons.local_printshop,
                  color: Colors.black,
                  size: 48.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),

                Visibility(
                    visible: availableTool.printers.length>0,
                    child:Slider(
                        value:printerNumber,
                        label:"$printerNumber",
                        max : availableTool.printers.length +.0,
                        divisions: getDivisions(availableTool.printers),
                        onChanged: (newRating){ setState( ()=> printerNumber = newRating);}
                        ,min:0.0)
                ),
                Visibility(
                    visible:availableTool.printers.length==0 ,
                    child:Text(
                      "Il n'y a plus d'imprimante disponible",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                ),
                Icon(
                  Icons.fastfood,
                  color: Colors.black,
                  size: 48.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                Slider(
                    value:foodNumber,
                    label:"$foodNumber",
                    max : 20.0,
                    divisions: 20,
                    onChanged: (newRating){ setState( ()=> foodNumber = newRating);}
                    ,min:0.0)
                ,
                FlatButton(
                  color: PRIMARY_COLOR,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: !isButtonAble() ? null: () {
                    reserve();
                  },
                  child: Text(
                    "Réserver !",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ] )
          )

        ]),

        drawer: Container( width:200 ,child:Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 85.0,
                child:DrawerHeader(
                  child: Text('Co\'Work'),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                  ),
                ),
              ),
              ListTile(
                title: Text('Reserver une salle'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Mes réservations'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Mon compte'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        )
    );
  }


  _getOpenSpace() async {
    var openSpaces = await OpenSpaceService.read();
    for (var openSpaceJSON in openSpaces){
      OpenSpace openSpace = OpenSpace.convert(openSpaceJSON);
      options.add(S2Choice<OpenSpace>(value: openSpace, title: openSpace.name));
    }
  }

  void _startHourChanged(TimeOfDay hour) {
    noHourAvailable = false;
    this.showRoomSelection = false;
    this.startHour = hour;
    this.roomSelected=null;

    if(available.availableHour[hour.hour.toString()] == openSpaceSelected.rooms.length){
      print("nothin");
      noHourAvailable = true;
      showToTP=false;
      setState(() =>{});
      return;
    }
    showToTP=true;
    var possibleEnd =  findNextHourAvailable(hour.hour,available.availableHour);

    toStartTP = hour.add(minutes: 60);
    toEndTP = TimeOfDay(hour: possibleEnd+1, minute: 00);

    print("start"+toStartTP.toString());
    print("end"+toEndTP.toString());
    setState(() =>{});
  }

  void _endHourChanged(TimeOfDay hour) async {
    print("blabla");
    this.roomOption = [];
    this.endHour = hour;
    availableRoom = this.getAvailableRoom();
    for (var room in availableRoom){
      roomOption.add(S2Choice<Room>(value: room, title: room.name));
    }
    this.showRoomSelection = true;
    availableTool = SortedTool.fromListTool(this.getAvailableTool());
    print(availableTool.laptops.length);
    print(availableTool.printers.length);
    setState(() {

    });
  }

  findNextHourAvailable(start,availableHour) {
    start++;
    while(start<21){

      if(available.availableHour[start.toString()] == openSpaceSelected.rooms.length){
        return start;
      }
      start++;
    }
    return 21;
  }

  List<Room> getAvailableRoom(){
    List<Room> rooms = [];
    for (Room room in this.openSpaceSelected.rooms){
      if(this.isRoomAvailable(room.id))
      {
        rooms.add(room);
      }
    }
    return rooms;
  }

  bool isRoomAvailable(String id) {
    DateTime start = new DateTime(this.pickeDate.year,this.pickeDate.month,this.pickeDate.day,this.startHour.hour,1);
    DateTime end = new DateTime(this.pickeDate.year,this.pickeDate.month,this.pickeDate.day,this.endHour.hour);

    for (Reservation reservation in  this.available.reservations){

      if (reservation.room.id == id ){
        if (this.isDateOverLapping(reservation.start, reservation.end, start, end))
        {
          print(start.toString());
          print(end.toString());
          print("comparewith old");
          print(reservation.start.toString());
          print(reservation.end.toString());

          print("Overlapping");
          return false;
        }
      }
    }
    return true;
  }


  List<Tool> getAvailableTool(){
    List<Tool> tools = [];
    for (Tool tool in this.openSpaceSelected.tools){
      if(this.isToolAvailable(tool.id))
      {
        tools.add(tool);
      }
    }
    return tools;
  }

  bool isToolAvailable(String id) {
    DateTime start = new DateTime(this.pickeDate.year,this.pickeDate.month,this.pickeDate.day,this.startHour.hour,1);
    DateTime end = new DateTime(this.pickeDate.year,this.pickeDate.month,this.pickeDate.day,this.endHour.hour);

    for (Reservation reservation in  this.available.reservations){
      for(Tool tool in reservation.tools){
        if (tool.id == id ){
          if (this.isDateOverLapping(reservation.start, reservation.end, start, end))
          {
            return false;
          }
        }
      }
    }
    return true;
  }

  isDateOverLapping(DateTime startDate1, DateTime endDate1, DateTime startDate2,  DateTime endDate2){
    return (startDate1.isBefore(endDate2) || startDate1.isAtSameMomentAs(endDate2) ) && (endDate1.isAfter(startDate2) || endDate1.isAtSameMomentAs(startDate2) );
  }
  getDivisions(List<Object> list){
    if(list.length<=0){
      return 1;
    }
    return list.length;
  }

  reserve() async {
    DateTime start = new DateTime(this.pickeDate.year,this.pickeDate.month,this.pickeDate.day,this.startHour.hour);
    DateTime end = new DateTime(this.pickeDate.year,this.pickeDate.month,this.pickeDate.day,this.endHour.hour);
    ReservationCreation reservationCreation = new ReservationCreation();
    reservationCreation.room = roomSelected.id;
    reservationCreation.start = start.toString();
    reservationCreation.end = end.toString();
    reservationCreation.food = (foodNumber).toInt();
    reservationCreation.tools = pickSomeToolToReserve((pcNumber).toInt(),(printerNumber).toInt(),availableTool);
    try {
      await BookingService.create(reservationCreation.toJson());
      Navigator.pop(context);
      Navigator.pop(context);
      FlushBarMessage.goodMessage(content: "Reservation effectué").showFlushBar(context);

    }catch  (exception) {
      print(exception);
      FlushBarMessage.errorMessage(content: "Erreur lors de l'inscription").showFlushBar(context);
    }
  }


  pickSomeToolToReserve(int pcNumber, int printerNumber,SortedTool available){
    List<String> res = [];
    int pcRetrieve = 0;
    int  printerRetrieve = 0;
    for (Tool laptop in available.laptops){
      if( pcRetrieve == pcNumber){
        break;
      }
      res.add(laptop.id);
    }

    for (Tool printer in available.printers){
      if( printerRetrieve == printerNumber){
        break;
      }
      res.add(printer.id);
    }
    return res;
  }


  isButtonAble(){
    if(null==roomSelected){
      return false;
    }
    return true;
  }
  updateGetAvailable() async {
    if(openSpaceSelected!= null && pickeDate != null){
      print("getAvailable");
      var availableJSON = await BookingService.getAvailable(openSpaceSelected.id, pickeDate.toString());
      available = Available.convert(availableJSON);
      showFromTP = true;
    }
    setState(() {

    });
  }

  getResDate(){
    if(pickeDate != null){
      return '${pickeDate.day} ${pickeDate.month} ${pickeDate.year}';
    }
    return '';
  }
}
