import 'package:flutter/material.dart';


//final URL_API = "http://localhost:1337";
final URL_API = "http://10.0.2.2:1337";

final PRIMARY_COLOR = Color(0xFF283593);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF607D8B),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class Utilities{
  static convertArray(var map ,Function convert){
    List<Object> list = [];
    print(map);
    for(Object element in map){
      list.add(convert(element));
    }
    return list;
  }
}