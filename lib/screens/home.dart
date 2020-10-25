import 'package:cowork_mobile/data/locations_data.dart';
import 'package:cowork_mobile/models/user_model.dart';
import 'package:cowork_mobile/widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'locations.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {

  final locations = LocationsData.getData;
  final String title;
  final User user;
  Home({Key key, this.title, this.user}) : super(key: key);

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
                  Text(
                  "Welcome to Co'Work!",
                  style: GoogleFonts.openSans(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                  )
                ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Navigate through the app to find workspaces, book your"
                        " special place, organize meetings and more.",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300
                      )
                    ),
                  ),
                  Container(
                    child: RaisedButton(
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
                        const Text('Go to locations', style: TextStyle(fontSize: 16)),
                      ),
                      onPressed: () async {
                        User updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Locations())
                        );
                      },
                    )
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
