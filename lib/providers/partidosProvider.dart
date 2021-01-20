import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/partidos";
class PartidosProvider extends API with ChangeNotifier  {
  bool isLoading;
  List<PartidosFromDateDTO> partidosView;
  List<PartidoDTO> partidos;

  getAll() async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.partidos = (json.decode(response.body) as List).map((i) => PartidoDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  List<PartidoDTO> getPartidos(){
    return this.partidos;
  }

  getPartidosFromEquipo(int idEquipo) async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint + "/equipo/" + idEquipo.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        await Future.delayed(Duration(milliseconds: 3000), () {
          this.partidosView = (json.decode(response.body) as List).map((i) => PartidosFromDateDTO.fromJson(i)).toList();
          this.isLoading = false;
          notifyListeners();
        });

      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  List<PartidosFromDateDTO> getPartidosView(){
    return this.partidosView;
  }

  Future<PartidoDTO> get(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return  PartidoDTO.fromJson(json.decode(response.body));
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<PartidoDTO>> getHistory(int id) async{
    try{
      final response = await super.getHttp(endPoint + "/history/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => PartidoDTO.fromJson(i)).toList();
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<List<PartidosFromDateDTO>> getForDate(String date) async{
    try{
      final response = await super.getHttp(endPoint + "/date/" + date);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return (json.decode(response.body) as List).map((i) => PartidosFromDateDTO.fromJson(i)).toList();
      } on Exception {
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  Future<String> save(PartidoDTO dto) async{
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