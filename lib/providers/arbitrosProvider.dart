import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/arbitros";
class ArbitrosProvider extends API with ChangeNotifier {

  ArbitrosProvider(){
    getAll();
  }

  bool isLoading;
  List<ArbitroDTO> arbitros;

   getAll() async{
     this.isLoading = true;
     notifyListeners();
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.arbitros = (json.decode(response.body) as List).map((i) => ArbitroDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
      } on Exception catch(e){
        print(e);
        return null;
      }
    } on Exception catch(e) {
      print(e);
      return null;
    }
  }

  getArbitros(){
    return this.arbitros;
  }

  save(ArbitroDTO dto) async{
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