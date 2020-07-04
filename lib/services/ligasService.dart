
import 'dart:convert';

import 'package:ag/services/http/api.dart';
import 'package:ag/services/model/dtos.dart';

class LigasServices{

  Future<List<LigaDTO>> getAll() async{
    try{
      final response = await Get("/ligas");
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => LigaDTO.fromJson(i)).toList();
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }

  Future<LigaDTO> get(int id) async{
    try{
      final response = await Get("/ligas/" + id.toString());
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

  Future<String> save(LigaDTO liga) async{
    try{
      final response = await Post("/ligas", liga);
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
      final response = await Delete("/ligas/" + id.toString());
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