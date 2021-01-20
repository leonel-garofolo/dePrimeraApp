
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/campeonatos";
class CampeonatosProvider extends API with ChangeNotifier {
  bool isLoading;
  CampeonatosProvider(){
    getAll();
  }

  List<CampeonatoDTO> campeonatos;
  List<PartidosFromDateDTO> partidos;
  List<EquipoTablePosDTO> equipos;
  List<SancionesJugadoresFromCampeonatoDTO> sancionesJugadores;

  getAll() async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.campeonatos= (json.decode(response.body) as List).map((i) => CampeonatoDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  getCampeonatoFromUser(String idUser, int idGrupo) async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint + "/user/" + idUser + "/" + idGrupo.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.campeonatos= (json.decode(response.body) as List).map((i) => CampeonatoDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
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

  getFixture(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/fixture/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setPartidos((json.decode(response.body) as List).map((i) => PartidosFromDateDTO.fromJson(i)).toList());
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setPartidos(List<PartidosFromDateDTO>  partidos){
    this.partidos = partidos;
    notifyListeners();
  }

  List<PartidosFromDateDTO> getPartidos(){
    return this.partidos;
  }

  getTablePosition(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/table/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setEquipos((json.decode(response.body) as List).map((i) => EquipoTablePosDTO.fromJson(i)).toList());
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setEquipos(List<EquipoTablePosDTO> equipos){
    this.equipos = equipos;
    notifyListeners();
  }

  List<EquipoTablePosDTO> getEquipos(){
    return this.equipos;
  }

 getTableSanciones(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/sanciones/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setSancionesJugadores((json.decode(response.body) as List).map((i) => SancionesJugadoresFromCampeonatoDTO.fromJson(i)).toList());
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setSancionesJugadores(List<SancionesJugadoresFromCampeonatoDTO> sancionesJugadores){
    this.sancionesJugadores = sancionesJugadores;
    notifyListeners();
  }

  List<SancionesJugadoresFromCampeonatoDTO> getSancionesJugadores(){
    return this.sancionesJugadores;
  }

  save(CampeonatoDTO dto) async{
    try{
      final response = await super.postHttp(endPoint, dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        print(response.body);
        getAll();
      } on Exception {

      }
    } on Exception catch(e) {
      print(e);
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