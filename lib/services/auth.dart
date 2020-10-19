import 'dart:convert';
import 'package:cowork_mobile/helpers/constants.dart';
import 'package:http/http.dart' as http;

class Auth {
  static dynamic login(String username, String password) async {
    var response;
    response = await http.post(URL_API+"/auth/local",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'identifier': username,
        'password': password,
      }),);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      //print("DAMN !" + response.statusCode.toString());
      throw Exception('Incorrect email or password');
    }
  }
  static dynamic register(String username, String password) async {
    var response;
    response = await http.post(URL_API+"/users/register",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email' : 'user@mail.com',
      }),);
    //print("response.body = " + response.body);
    if (response.statusCode == 201) {
      return ;
    } else {
      throw Exception('A user with this name already exists');
    }
  }

}
