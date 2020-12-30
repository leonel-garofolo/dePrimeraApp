
import 'dart:convert';

import 'package:ag/network//http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/app_grupos";
class AppGruposProvider extends API with ChangeNotifier  {

Future<List<AppGruposDTO>> getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => AppGruposDTO.fromJson(i)).toList();
      } on Exception catch(e){
        print(e);
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }
}