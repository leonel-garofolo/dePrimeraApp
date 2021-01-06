
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/campeonatos";
class CampeonatosProvider extends API with ChangeNotifier {

  List<CampeonatoDTO> campeonatos;

  getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setCampeonatos((json.decode(response.body) as List).map((i) => CampeonatoDTO.fromJson(i)).toList());
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  List<CampeonatoDTO> getCampeonatos(){
    return campeonatos;
  }

  setCampeonatos(List<CampeonatoDTO> campeonatos){
    this.campeonatos= campeonatos;
    notifyListeners();
  }

  Future<CampeonatoDTO> get(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return  CampeonatoDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<PartidosFromDateDTO>> getFixture(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/fixture/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => PartidosFromDateDTO.fromJson(i)).toList();
      } on Exception catch(e) {
        print(e);
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<EquipoTablePosDTO>> getTablePosition(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/table/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => EquipoTablePosDTO.fromJson(i)).toList();
      } on Exception catch(e) {
        print(e);
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<SancionesJugadoresFromCampeonatoDTO>> getTableSanciones(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/sanciones/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => SancionesJugadoresFromCampeonatoDTO.fromJson(i)).toList();
      } on Exception catch(e) {
        print(e);
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String> save(CampeonatoDTO dto) async{
    try{
      final response = await super.postHttp(endPoint, dto);
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
      print(e);
      return null;
    }
  }
}