import 'package:cowork_mobile/screens/login.dart';
import 'package:flutter/material.dart';

void main() => ((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}