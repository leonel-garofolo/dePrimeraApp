import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/provincias";
class ProvinciasProvider extends API with ChangeNotifier {
  List<ProvinciaDTO> provincias;

   getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setProvincias((json.decode(response.body) as List).map((i) => ProvinciaDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setProvincias(List<ProvinciaDTO> provincias){
    this.provincias = provincias;
    notifyListeners();
  }

  getProvincias(){
    return this.provincias;
  }
}