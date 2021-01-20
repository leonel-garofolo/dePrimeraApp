
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/equipos";
class EquiposProvider extends API with ChangeNotifier  {

  EquiposProvider(){
    getAll();
  }
  bool isLoading;
  List<JugadorPlantelDTO> jugadores;
  List<EquipoDTO> equipos;

  getAll() async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.equipos = (json.decode(response.body) as List).map((i) => EquipoDTO.fromJson(i)).toList();
        this.isLoading=false;
        notifyListeners();
      } on Exception catch(e){
        print(e);      
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  getEquiposFromUser(String idUser, int idGrupo) async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint + "/user/" + idUser + "/" + idGrupo.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.equipos = (json.decode(response.body) as List).map((i) => EquipoDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  getPlantel(int idEquipo) async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint + "/plantel/" + idEquipo.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.jugadores = (json.decode(response.body) as List).map((i) => JugadorPlantelDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
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

  List<EquipoDTO> getEquipos(){
    return this.equipos;
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

  save(EquipoDTO dto) async{
    try{
      final response = await super.postHttp(endPoint, dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        print( response.body);
        getAll();
      } on Exception {
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  delete(int id) async{
    try{
      final response = await super.deleteHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        print( response.body);
        getAll();
      } on Exception {

      }
    } on Exception catch(e) {
      print(e);

    }
  }
}