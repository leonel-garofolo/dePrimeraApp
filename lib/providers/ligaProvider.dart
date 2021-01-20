

import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/ligas";
class LigaProvider extends API with ChangeNotifier  {

  LigaProvider(){
    getAll();
  }

  bool isLoading;
  List<LigaDTO> ligas;

  getAll() async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.ligas = (json.decode(response.body) as List).map((i) => LigaDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
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

  save(LigaDTO dto) async{
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

 delete(int id) async{
    try{
      final response = await super.deleteHttp(endPoint + "/" + id.toString());
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
}