import 'package:cowork_mobile/models/location_model.dart';
import 'package:cowork_mobile/models/user_model.dart';
import 'package:cowork_mobile/data/locations_data.dart';
import 'package:cowork_mobile/tools/flush_bar_message.dart';
import 'package:cowork_mobile/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cowork_mobile/screens/booking.dart';
import 'package:cowork_mobile/screens/bookings.dart';

import 'login.dart';

import 'package:flutter/cupertino.dart';

import 'package:cowork_mobile/helpers/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons.dart';

class Locations extends StatefulWidget {
  Locations({Key key}) : super(key: key);

  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  List<Location> _locations = List<Location>();

  @override
  void initState() {
    LocationsData.getData.forEach(
            (element) {
              this.setState(() {
                this._locations.add(Location.fromJson(element));
              });
            });
    // TODO: implement initState
    super.initState();
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
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Text(
                    "Locations",
                    style: GoogleFonts.openSans(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w900
                    )
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: ListView.builder(
                      primary : false,
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap : true,
                      itemCount: _locations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 520,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0,
                                      color: Colors.blue),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(7),
                                child: Stack(children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20, top: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  locationName(_locations[index]),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  locationImage(_locations[index]),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Wrap(
                                                    children: [
                                                      addOns(_locations[index]),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  //cryptoChange(locations[index]),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Spacer(),
                                                  RaisedButton(
                                                    textColor: Colors.white,
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: <Color>[
                                                            Color(0xFF0D47A1),
                                                            Color(0xFF1976D2),
                                                            Color(0xFF42A5F5),
                                                          ],
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:
                                                      const Text('Choose location', style: TextStyle(fontSize: 16)),
                                                    ),
                                                    onPressed: () async {
                                                      User updated = await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => Booking(location: _locations[index]))
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ]
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ]
          ),
        ),

        drawer: CustonDrawer()
    );
  }


  Widget locationName(location) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${location.name}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          children: <TextSpan>[
            TextSpan(
                text: '\n${location.city}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget locationImage(location) {
    return Align(
        child: Container(
            child: Image.asset(
              'assets/'+'${location.avatar}',
              width: 320,
              height: 180,
            )
        )
    );
  }

  Widget addOns(location) {
    const IconData network_wifi = IconData(0xe8a6, fontFamily: 'MaterialIcons');
    const IconData calendar_today = IconData(0xe623, fontFamily: 'MaterialIcons');
    const IconData airline_seat_recline_extra = IconData(0xe588, fontFamily: 'MaterialIcons');
    const IconData contact_phone_rounded = IconData(0xf136, fontFamily: 'MaterialIcons');

    return Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Column(
            children: [
              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 160,
                    child: Column(
                      children: <Widget>[
                        Icon(
                            network_wifi,
                            color: Colors.orange,
                            size: 12),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '\nHigh speed Wi-Fi',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 140,
                    child: Column(
                      children: <Widget>[
                        Icon(
                            calendar_today,
                            color: Colors.brown,
                            size: 12),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '\nMeeting rooms',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          Column(
            children: [
              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 160,
                    child: Column(
                      children: <Widget>[
                        Icon(
                            contact_phone_rounded,
                            color: Colors.blue,
                            size: 12),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '\nBookable call rooms',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 180,
                    child: Column(
                      children: <Widget>[
                        Icon(
                            airline_seat_recline_extra,
                            color: Colors.orangeAccent,
                            size: 12),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '\nCozy lounges',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ]
    );
  }
}
