import 'package:cowork_mobile/models/user.dart';
import 'package:cowork_mobile/tools/flush_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cowork_mobile/screens/booking.dart';
import 'package:cowork_mobile/screens/bookings.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:cowork_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

var imgList = ['coworking-1.jpg','coworking-2.jpg','coworking-3.jpg','coworking-4.jpg','coworking-5.jpg','coworking-6.jpg'];
var nameOpen = ['Bastille','République','Odéon','Beaubourg',"Place d'italie",'Ternes'];

class Home extends StatelessWidget {
  final String title;
  User user;
  Home({Key key, this.title, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: Color(0xFF283593),title: Text(title)),
        body:
        Container(
            child:
            SingleChildScrollView(
              child:
              Column(
                children: <Widget>[
                  Text(
                    "Co'Work",
                    style: GoogleFonts.openSans(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w900
                      )
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Welcome to Co'Work!",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300
                      )
                    ),
                  )
                ],
              ),
            )
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
                    print("storage.read() = " + await storage.read(key: "token"));
                    await storage.write(key: "token", value: "");
                    print("storage.read() = " + await storage.read(key: "token"));
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

  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset('assets/'+item),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '${nameOpen[imgList.indexOf(item)]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();
}
