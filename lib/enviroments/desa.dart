import 'package:ag/enviroments/config.dart';


void main() => Dev();

class Dev extends Config{
  final String appDisplayName= "De Primera";
  final String  version= "1.0.0 [ DEV ]";
  final String urlBase= "http://localhost:8081/api";
}