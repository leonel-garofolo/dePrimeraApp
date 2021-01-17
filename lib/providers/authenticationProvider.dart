
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/authentication";
class AuthenticationProvider extends API with ChangeNotifier {

  Future<UserDTO> login(UserDTO dto) async{
    try{
      final response = await super.postHttp(endPoint + "/login", dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return UserDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String> createAccount(UserDTO dto) async{
    try{
      final response = await super.postHttp(endPoint + "/register", dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body;
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String> forgot(UserDTO dto) async{
    try{
      final response = await super.postHttp(endPoint + "/forgot", dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body;
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<bool> logout(UserDTO dto) async{
    try{
      final response = await super.postHttp(endPoint + "/logout", dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body.toLowerCase() == 'true';
      } on Exception {
        return false;
      }
    } on Exception catch(e) {
      print(e);
      return false;
    }
  }

  Future<AppGruposDTO> getUserPermission(String user) async{
    try{
      final response = await super.getHttp(endPoint + "/permiso/"+ user);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return AppGruposDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
}