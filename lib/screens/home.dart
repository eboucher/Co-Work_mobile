import 'package:cowork_mobile/data/crypto.dart';
import 'package:cowork_mobile/models/user.dart';
import 'package:cowork_mobile/tools/flush_bar_message.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cowork_mobile/screens/booking.dart';
import 'package:cowork_mobile/screens/bookings.dart';

import 'login.dart';

import 'package:flutter/cupertino.dart';

import 'package:cowork_mobile/helpers/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons.dart';

var imgList = ['coworking-1.jpg','coworking-2.jpg','coworking-3.jpg','coworking-4.jpg','coworking-5.jpg','coworking-6.jpg'];
var nameOpen = ['Bastille','République','Odéon','Beaubourg',"Place d'italie",'Ternes'];

class Home extends StatelessWidget {

  var cryptoData = CryptoData.getData;
  final String title;
  User user;
  Home({Key key, this.title, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color(0xFF283593),title: Text(title)),
        body: Container(
          child: Container(
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
                Expanded(
                  child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                      shrinkWrap : true,
                      itemCount: cryptoData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 300,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: cryptoData[index]['iconColor']),
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
                                            padding: const EdgeInsets.only(left: 10, top: 5),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    cryptoIcon(cryptoData[index]),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    cryptoNameSymbol(cryptoData[index]),
                                                    Spacer(),
                                                    cryptoChange(cryptoData[index]),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    changeIcon(cryptoData[index]),
                                                    SizedBox(
                                                      width: 20,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    cryptoAmount(cryptoData[index])
                                                  ],
                                                )
                                              ],
                                            )
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


  Widget cryptoIcon(data) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            data['icon'],
            color: data['iconColor'],
            size: 40,
          )),
    );
  }
  Widget cryptoNameSymbol(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: '${data['name']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${data['symbol']}',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  Widget cryptoChange(data) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '${data['change']}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n${data['changeValue']}',
                style: TextStyle(
                    color: data['changeColor'],
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  Widget changeIcon(data) {
    return Align(
        alignment: Alignment.topRight,
        child: data['change'].contains('-')
        ? Icon(
      Typicons.arrow_sorted_down,
      color: data['changeColor'],
      size: 30,
    )
        : Icon(
      Typicons.arrow_sorted_up,
      color: data['changeColor'],
      size: 30,
    ));
  }
  Widget cryptoAmount(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n${data['value']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n0.1349',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
