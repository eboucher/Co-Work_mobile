import 'package:cowork_mobile/data/crypto.dart';
import 'package:cowork_mobile/models/user.dart';
import 'package:cowork_mobile/data/locations_data.dart';
import 'package:cowork_mobile/tools/flush_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cowork_mobile/screens/booking.dart';
import 'package:cowork_mobile/screens/bookings.dart';

import 'login.dart';

import 'package:flutter/cupertino.dart';

import 'package:cowork_mobile/helpers/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons.dart';

class Locations extends StatelessWidget {

  final locations = LocationsData.getData;
  final String title;
  Locations({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2446a6),
          title: Text(title),
          centerTitle: true,
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
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 500,
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
                                                  locationName(locations[index]),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  locationImage(locations[index]),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Wrap(
                                                    children: [
                                                      addOns(locations[index]),
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
                                                    onPressed: () {},
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
                                                      const Text('Proceed to booking', style: TextStyle(fontSize: 16)),
                                                    ),
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

        drawer: Container(
          width:200,
          child:Drawer(
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
                      color: Color(0xFF283593),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Book room'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    print('eee');
                    Navigator.push(  context,
                      MaterialPageRoute(builder: (context) => Booking()),);
                    // Then close the drawer
                    //Navigator.pop(context);

                  },
                ),
                ListTile(
                  title: Text('My bookings'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.push(  context,
                      MaterialPageRoute(builder: (context) => Bookings()),);
                    //Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('My account'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    title: Text('Logout'),
                    onTap: () async {
                      await storage.write(key: "token", value: "");
                      //print("storage.read() = " + await storage.read(key: "token"));
                      FlushBarMessage.goodMessage(content: "You logged out of We'Work").showFlushBar(context).then((_) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => Login()),
                                (Route<dynamic> route) => false
                        );
                      });
                    }
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget locationName(location) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${location['name']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          children: <TextSpan>[
            TextSpan(
                text: '\n${location['city']}',
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
              'assets/'+'${location['avatar']}',
              width: 320,
              height: 180,
            )
        )
    );
  }

  Widget addOns(location) {
    const IconData network_wifi = IconData(0xe8a6, fontFamily: 'MaterialIcons');
    const IconData calendar_today = IconData(0xe623, fontFamily: 'MaterialIcons');

    return Wrap(
        direction: Axis.horizontal,
        children: <Widget>[

          Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30),
                width: 180,
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
                width: 180,
                child: Column(
                  children: <Widget>[
                    Icon(
                        calendar_today,
                        color: Colors.brown,
                        size: 12),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '\nBookable meeting rooms',
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
                        network_wifi,
                        color: Colors.orange,
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
                        network_wifi,
                        color: Colors.orange,
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

        ]
    );
  }
}
