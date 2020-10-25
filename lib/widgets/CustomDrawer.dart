import 'package:cowork_mobile/component/flush_bar_message.dart';
import 'package:cowork_mobile/screens/bookings.dart';
import 'package:cowork_mobile/screens/locations.dart';
import 'package:cowork_mobile/screens/login.dart';
import 'package:flutter/material.dart';

class CustonDrawer extends StatefulWidget {
  @override
  _CustonDrawerState createState() => _CustonDrawerState();
}

class _CustonDrawerState extends State<CustonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Locations()),
                );
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
    );
  }
}
