import 'dart:convert';

import 'package:ag/network/http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/paises";
class PaisesProvider extends API with ChangeNotifier {
  List<PaisDTO> paises;

   getAll() async{
    try{
      final response = await super.getHttp(endPoint);
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        setPaises((json.decode(response.body) as List).map((i) => PaisDTO.fromJson(i)).toList());
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  setPaises(List<PaisDTO> paises){
    this.paises = paises;
    notifyListeners();
  }

  getPaises(){
    return this.paises;
  }
}