
import 'dart:convert';

import 'package:ag/services/http/api.dart';
import 'package:ag/services/model/dtos.dart';

const String endPoint = "/app_grupos";
class AppGruposServices extends API{

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