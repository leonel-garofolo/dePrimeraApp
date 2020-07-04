import 'dart:convert';

import 'package:ag/enviroments/config.dart';
import 'package:ag/services/http/api.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:http/http.dart' as http;

class Authentication extends API{
  Future<UserApp> login(UserApp user) async{
    final response = await super.postHttp("/user/validate", user);
    if (response.statusCode == 200) {
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return UserApp.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } else {
      // Si esta respuesta no fue OK
      return null;
    }
  }

  Future<http.Response> logout() {
    return super.getHttp(Config.value.urlBase  + "/user/validate");
  }

  Future<bool> changePassword(UserApp user) async{
    try{
      final response = await super.postHttp("/user/changepassword", user);
      if (response.statusCode == 200) {
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body == 'true';
      } else {
        // Si esta respuesta no fue OK
        return null;
      }
    } on Exception catch(e){
      print(e);
      return null;
    }
  }
}