import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatelessWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Color(0xFF283593),title: Text(title)),
      body:
        Container(
          child:
            SingleChildScrollView()),

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
              )
            ],
          ),
        ),
      )
    );
  }
}