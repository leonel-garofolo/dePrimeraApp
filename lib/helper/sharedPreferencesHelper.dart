import 'package:shared_preferences/shared_preferences.dart';
const SH_IS_LOGGED = 'IS_LOGGED';
const SH_USER_ID = 'ID_USER';
const SH_USER_NAME = 'USER_NAME';
const SH_USER_SURNAME = 'SH_USER_SURNAME';
const SH_USER_ROL = 'USER_ROL';
const SH_USER_TEL = 'USER_TEL';

getSH() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
Future<bool> getSHBoolValue(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool bValue = prefs.getBool(name);
  if(bValue == null){
    bValue = false;
  }
  return bValue;
}

Future<String> getSHStringValue(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String sValue = prefs.getString(name);
  if(sValue == null){
    sValue = "";
  }
  return sValue;
}

saveSHStringValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<double> getSHDoubleValue(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double dValue = prefs.getDouble(name);
  return dValue;
}

Future<int> getSHIntValue(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int dValue = prefs.getInt(name);
  return dValue;
}

Future<List<String>> getSHListValue(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> dValue = prefs.getStringList(name);
  return dValue;
}

saveSHDoubleValue(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

saveSHIntegerValue(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

saveSHListValue(String key, List<String> values) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, values);
}

removeSH(String key) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}