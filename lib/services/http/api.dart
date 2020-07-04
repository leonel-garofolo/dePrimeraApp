import 'dart:convert';
import 'dart:io';

import 'package:ag/enviroments/config.dart';
import 'package:http/http.dart' as http;

const int TIMEOUT_GET = 10;
const int TIMEOUT_POST = 10;

Future<http.Response> Get(final String endpoint){
  Duration d = new Duration(seconds: TIMEOUT_GET);
  print(Config.value.urlBase + endpoint);
  return http.get(Config.value.urlBase  + endpoint).timeout(d);
}

Future<http.Response> Post(final String endpoint, final Object body){
  print(Config.value.urlBase + endpoint);
  print(jsonEncode(body));
  try{
    return http.post(Config.value.urlBase + endpoint, headers: {"Content-Type": "application/json"}, body: jsonEncode(body))
        .timeout(const Duration(seconds: TIMEOUT_POST));
  }on HttpException {
    return null;
  }
}

Future<http.Response> Delete(final String endpoint){
  Duration d = new Duration(seconds: TIMEOUT_GET);
  print(Config.value.urlBase + endpoint);
  return http.delete(Config.value.urlBase  + endpoint).timeout(d);
}


