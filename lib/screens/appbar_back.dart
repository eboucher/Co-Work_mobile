import 'package:flutter/material.dart';

class AppBarBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('AppBar Back Button'),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          )
      ),
      body: Center(
        child: Text("Main Screen"),
      ),
    );
  }
}