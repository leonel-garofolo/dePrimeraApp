import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:flutter/cupertino.dart';


class SharedPreferencesProvider  with ChangeNotifier {
  bool logged;

  String userId;
  String userName;
  String userSurName;
  String userRol;
  String userTel;

  getSharedPreference() async {
    this.logged = await getSHBoolValue(SH_IS_LOGGED);
    this.userId = await getSHStringValue(SH_USER_ID);
    this.userName = await getSHStringValue(SH_USER_NAME);
    this.userSurName = await getSHStringValue(SH_USER_SURNAME);
    this.userRol = await getSHStringValue(SH_USER_ROL);
    this.userTel = await getSHStringValue(SH_USER_TEL);
    notifyListeners();
  }

  bool isLogged(){
    return this.logged;
  }

  String getUserId(){
    return this.userId;
  }

  String getUserName(){
    return this.userName;
  }

  String getUserSurName(){
    return this.userSurName;
  }

  String getUserTelefono(){
    return this.userTel;
  }

  String getUserRol(){
    return this.userRol;
  }

  saveLogged(bool logged){
    this.logged = logged;
    notifyListeners();
  }

  saveUserId(String userId){
    this.userId = userId;
    notifyListeners();
  }

  saveUserName(String userName){
    this.userName = userName;
    notifyListeners();
  }

  saveUserSurName(String userSurName){
    this.userSurName = userSurName;
    notifyListeners();
  }

  saveUserRol(String userRol){
    this.userRol = userRol;
    notifyListeners();
  }

  saveUserTelefono(String userTel){
    this.userTel = userTel;
    notifyListeners();
  }
}