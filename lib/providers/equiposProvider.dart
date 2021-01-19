
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/equipos";
class EquiposProvider extends API with ChangeNotifier  {
  List<JugadorPlantelDTO> jugadores;
  List<EquipoDTO> equipos;

  getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setEquipos((json.decode(response.body) as List).map((i) => EquipoDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);      
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  getEquiposFromUser(String idUser, int idGrupo) async{
    try{
      final response = await super.getHttp(endPoint + "/user/" + idUser + "/" + idGrupo.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setEquipos((json.decode(response.body) as List).map((i) => EquipoDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  getPlantel(int idEquipo) async{
    try{
      final response = await super.getHttp(endPoint + "/plantel/" + idEquipo.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setJugadores((json.decode(response.body) as List).map((i) => JugadorPlantelDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  List<JugadorPlantelDTO> getJugadores(){
    return this.jugadores;
  }

  setJugadores(List<JugadorPlantelDTO> jugadores){
    this.jugadores = jugadores;
    notifyListeners();
  }

  List<EquipoDTO> getEquipos(){
    return this.equipos;
  }

  setEquipos(List<EquipoDTO> equipos){
    this.equipos = equipos;
    notifyListeners();
  }


  Future<EquipoDTO> get(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return  EquipoDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String> save(EquipoDTO dto) async{
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