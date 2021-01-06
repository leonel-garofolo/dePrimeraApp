
import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/asistentes";
class AsistentesProvider extends API with ChangeNotifier  {

  List<AsistenteDTO> asistentes;
  getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setAsistentes((json.decode(response.body) as List).map((i) => AsistenteDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setAsistentes(List<AsistenteDTO> asistentes){
    this.asistentes = asistentes;
    notifyListeners();
  }

  List<AsistenteDTO> getAsistentes(){
    return this.asistentes;
  }

  Future<String> save(AsistenteDTO dto) async{
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