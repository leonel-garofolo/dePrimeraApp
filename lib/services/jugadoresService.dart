
import 'dart:convert';

import 'package:ag/services/http/api.dart';
import 'package:ag/services/model/dtos.dart';

const String endPoint = "/jugadores";
class JugadoresServices extends API{

  Future<List<JugadorDTO>> getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => JugadorDTO.fromJson(i)).toList();
      } on Exception catch(e){
        print(e);
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String> save(JugadorDTO dto) async{
    try{
      final response = await super.postHttp(endPoint, dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body;
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }

  Future<String> delete(int id) async{
    try{
      final response = await super.deleteHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body;
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }
}