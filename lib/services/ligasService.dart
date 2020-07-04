
import 'dart:convert';

import 'package:ag/services/http/api.dart';
import 'package:ag/services/model/dtos.dart';

const String endPoint = "/ligas";
class LigasServices extends API{

  Future<List<LigaDTO>> getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        List<LigaDTO> list = (json.decode(response.body) as List).map((i) => LigaDTO.fromJson(i)).toList();
        return list;
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }

  Future<LigaDTO> get(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return  LigaDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }

  Future<String> save(LigaDTO dto) async{
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