import 'dart:convert';
import 'dart:io';

import 'package:cowork_mobile/screens/login.dart';
import 'package:cowork_mobile/helpers/constants.dart';
import 'package:http/http.dart' as http;
String base ="openSpace";

class WorkspaceService {


  static dynamic read() async {
    var response;
    response = await http.get(URL_API+"/"+base+"/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
     );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;

    } else {
      throw Exception('Read error');
    }

  }

  static dynamic readOne(String id) async {
    var response;
    response = await http.get(URL_API+"/"+base+"/"+id,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;

    } else {
      throw Exception('Read error');
    }

  }


}