
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/jugadores";
class JugadoresProvider extends API with ChangeNotifier  {

  List<JugadorDTO> jugadores;

  getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setJugadores((json.decode(response.body) as List).map((i) => JugadorDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setJugadores(List<JugadorDTO> jugadores){
      this.jugadores = jugadores;
      notifyListeners();
  }

  List<JugadorDTO> getJugadores(){
    return this.jugadores;
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