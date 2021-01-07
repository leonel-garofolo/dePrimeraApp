
import 'dart:convert';

import 'package:ag/network//http/api.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:flutter/cupertino.dart';

const String endPoint = "/query";
class QueryProvider extends API with ChangeNotifier  {

  QueryConfiguracionSize queryConfiguracion;
  callConfiguracionSize() async{
    try{
      final response = await super.getHttp(endPoint + "/configuraciones");
      try{
        // Si el servidor devuelve una repuesta OK, parseamos el JSON
        this.queryConfiguracion = QueryConfiguracionSize.fromJson(json.decode(response.body));
        notifyListeners();
      } on Exception catch(e){
        print(e);
      }
    } on Exception catch(e) {
      print(e);
    }
  }

  QueryConfiguracionSize getQueryConfiguracion(){
    return this.queryConfiguracion;
  }
}