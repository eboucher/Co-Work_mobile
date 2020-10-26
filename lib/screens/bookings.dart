import 'package:cowork_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {

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

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Text(
          "Bookings",
          style: GoogleFonts.openSans(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.w900
            )
          ),
        ])
      ),
    );
  }
}