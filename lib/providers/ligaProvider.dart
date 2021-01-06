

import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/ligas";
class LigaProvider extends API with ChangeNotifier  {

  List<LigaDTO> ligas;

  getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setLigas((json.decode(response.body) as List).map((i) => LigaDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  List<LigaDTO> getLigas(){
    return this.ligas;
  }

  setLigas(List<LigaDTO> ligas){
    this.ligas = ligas;
    notifyListeners();
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
      print(e);
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