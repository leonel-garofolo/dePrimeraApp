
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/asistentes";
class AsistentesProvider extends API with ChangeNotifier  {

  AsistentesProvider(){
    getAll();
  }

  bool isLoading;
  List<AsistenteDTO> asistentes;
  getAll() async{
    this.isLoading = true;
    notifyListeners();
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.asistentes = (json.decode(response.body) as List).map((i) => AsistenteDTO.fromJson(i)).toList();
        this.isLoading = false;
        notifyListeners();
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  List<AsistenteDTO> getAsistentes(){
    return this.asistentes;
  }

  save(AsistenteDTO dto) async{
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