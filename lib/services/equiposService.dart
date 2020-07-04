
import 'dart:convert';

import 'package:ag/services/http/api.dart';
import 'package:ag/services/model/dtos.dart';

const String endPoint = "/equipos";
class EquiposServices{

  Future<List<EquipoDTO>> getAll() async{
    try{
      final response = await Get(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => EquipoDTO.fromJson(i)).toList();
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }

  Future<EquipoDTO> get(int id) async{
    try{
      final response = await Get(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return  EquipoDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      return null;
    }
  }

  Future<String> save(EquipoDTO equipo) async{
    try{
      final response = await Post(endPoint, equipo);
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
      final response = await Delete(endPoint + "/" + id.toString());
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