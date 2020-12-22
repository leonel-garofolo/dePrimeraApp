import 'dart:convert';
import 'dart:io';

import 'package:ag/enviroments/config.dart';
import 'package:http/http.dart' as http;

const int TIMEOUT_GET = 10;
const int TIMEOUT_POST = 10;

class API {
  Future<http.Response> getHttp(final String endpoint) async{
    Duration d = new Duration(seconds: TIMEOUT_GET);
    print(Config.value.urlBase + endpoint);
    try {
      return http.get(Config.value.urlBase  + endpoint).timeout(d);
    } on Exception catch(e){
      print(e);
      return null;
    }
  }

  Future<http.Response> postHttp(final String endpoint, final Object body) async{
    print(Config.value.urlBase + endpoint);
    print(jsonEncode(body));
    try{
      return http.post(Config.value.urlBase + endpoint, headers: {"Content-Type": "application/json"}, body: jsonEncode(body))
          .timeout(const Duration(seconds: TIMEOUT_POST));
    } on HttpException catch(e){
      print(e);
      return null;
    }
  }

  Future<http.Response> deleteHttp(final String endpoint){
    Duration d = new Duration(seconds: TIMEOUT_GET);
    print(Config.value.urlBase + endpoint);
    return http.delete(Config.value.urlBase  + endpoint).timeout(d);
  }
}