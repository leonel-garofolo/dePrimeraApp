import 'package:ag/enviroments/config.dart';

//void main() => runApp(MyApp());

void main() => Prod();

class Prod extends Config {
  final String appDisplayName= "De primera ";
  final String version= "1.0.0 ";
  final String urlBase= "http://encanta.ddns.net:9090/encantaweb/api";
}