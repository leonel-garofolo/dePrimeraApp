import 'package:ag/enviroments/config.dart';


void main() => Dev();

class Dev extends Config{
  final String appDisplayName= "De Primera";
  final String  version= "1.0.0 [ DEV ]";
  final String urlBase= "http://10.0.2.2:8081/api";
}