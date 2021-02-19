import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/partidos";

class Encuentro {
  String day;
  List<PartidosFromDateDTO> partidos;

  Encuentro({this.day, this.partidos});
}

class PartidosProvider extends API with ChangeNotifier  {
  bool isLoading;
  List<PartidosFromDateDTO> partidosView;
  List<PartidoDTO> partidos;
  List<Encuentro> encuentros;

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



  save(PartidoDTO dto) async{
    try{
      final response = await super.postHttp(endPoint, dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        print(response.body);

      } on Exception {

      }
    } on Exception catch(e) {
      print(e);
    }
  }

  Future<bool> saveStatePartido(PartidoResultDTO dto) async{
    try{
      final response = await super.postHttp(endPoint + '/result', dto);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        return response.body == "insertado"? true:false;
      } on Exception {
        return false;
      }
    } on Exception catch(e) {
      print(e);
      return false;
    }
  }

  delete(int id) async{
    try{
      final response = await super.deleteHttp(endPoint + "/" + id.toString());
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        print(response.body);
      } on Exception {
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  callGetDates() async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint + "/dates");
      try{
        encuentros = new List<Encuentro>();
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        List<String> dates = (json.decode(response.body) as List).cast<String>();
        int index = 0;
        for(String sDate in dates){
          if(index == 4){
            break;
          }
          Encuentro e = new Encuentro(day: sDate.substring(0, 10));
          e.partidos = await getForDate(e.day);
          encuentros.add(e);
          index++;
        }
        this.isLoading = false;
        notifyListeners();
      } on Exception catch(e) {
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  List<Encuentro> getEncuentros(){
    return this.encuentros;
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

  Future<List<PartidosFromDateDTO>> getForDate(String date) async{
    try{
      final response = await super.getHttp(endPoint + "/date/" + date);
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      List<PartidosFromDateDTO> partidos = (json.decode(response.body) as List).map((i) => PartidosFromDateDTO.fromJson(i)).toList();
      return partidos;
    } on Exception catch(e) {
      print("Error getForDate in day: " + date);
      print(e);
      return new List<PartidosFromDateDTO>();
    }
  }

  List<PartidosFromDateDTO> getPartidosView(){
    return this.partidosView;
  }
}


