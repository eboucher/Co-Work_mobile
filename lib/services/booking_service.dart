import 'package:cowork_mobile/screens/login.dart';
import 'package:cowork_mobile/helpers/constants.dart';
import 'package:cowork_mobile/helpers/constants.dart';
import 'package:cowork_mobile/screens/login.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


String base = "booking";
class BookingService {


  static dynamic read() async {
    var response;
    response = await http.get(URL_API+"/"+base+"/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Error read');
    }
  }


  static dynamic create( Map<String,dynamic> bookingCreation) async{
    var response;
    response = await http.post(URL_API+"/"+base+"/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode(bookingCreation)
    );
    //print(response.body);
    if (response.statusCode == 201) {
      return ;
    } else {
      print(json.decode(response.body));
      throw Exception('Error create');
    }
  }

  static dynamic getAvailable(String openSpaceId,String date) async{
    var response;
    response = await http.get("$URL_API/booking/available/$openSpaceId/$date",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Error getAvailable');
    }
  }

  static dynamic changeFood(String bookingId, int foodNumber) async{
    var response;
    response = await http.post("$URL_API/booking/$bookingId/changeFood/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode({'food':foodNumber}),
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Error changeFood');
    }
  }


  static dynamic addToolToBooking(String bookingId, List<String> toolsId) async{
    var response;
    response = await http.post("$URL_API/booking/$bookingId/addTools/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode({'tools':toolsId}),
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Error addToolToBooking');
    }
  }

  static dynamic removeToolsToBooking(String bookingId, List<String> toolsId) async{
    var response;
    response = await http.post("$URL_API/booking/$bookingId/removeTools/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode({'tools':toolsId})
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Error removeToolsToBooking');
    }
  }

  static dynamic delete(String bookingId) async{
    var response;
    response = await http.delete("$URL_API/booking/$bookingId/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Error delete');
    }
  }

}