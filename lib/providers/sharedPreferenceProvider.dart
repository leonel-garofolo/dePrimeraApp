import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:flutter/cupertino.dart';


class SharedPreferencesProvider  with ChangeNotifier {
  bool logged;

  String userId;
  String userName;
  String userSurName;
  String userRol;
  String userTel;
  int idGrupo;

  getSharedPreference() async {
    this.logged = await getSHBoolValue(SH_IS_LOGGED);
    this.userId = await getSHStringValue(SH_USER_ID);
    this.userName = await getSHStringValue(SH_USER_NAME);
    this.userSurName = await getSHStringValue(SH_USER_SURNAME);
    this.userRol = await getSHStringValue(SH_USER_ROL);
    this.userTel = await getSHStringValue(SH_USER_TEL);
    this.idGrupo = await getSHIntValue(SH_USER_GRUPO);

    notifyListeners();
  }

  bool isLogged(){
    return this.logged;
  }

  String getUserId(){
    return this.userId;
  }

  String getUserName(){
    if(this.userName != null) {
      return this.userName.trim();
    }
    return "";
  }

  String getUserSurName(){
    if(this.userSurName != null) {
      return this.userSurName.trim();
    }
    return "";
  }

  String getUserTelefono(){
    return this.userTel;
  }

  String getUserRol(){
    return this.userRol;
  }

  int getUserGrupo(){
    return this.idGrupo;
  }

  String getUserGrupoName(){
    String permiso = "";
    if(this.idGrupo != null) {
      switch(idGrupo){
        case 1:
          permiso= "Administrador";
          break;
        case 2:
          permiso= "Delegado";
          break;
        case 3:
          permiso= "Jugador";
          break;
        case 4:
          permiso= "Arbitro";
          break;
      }
    }
    return permiso;
  }

  saveLogged(bool logged) {
    this.logged = logged;
    saveSHBoolValue(SH_IS_LOGGED, logged);
    notifyListeners();
  }

  saveUserId(String userId){
    this.userId = userId;
    saveSHStringValue(SH_USER_ID, userId);
    notifyListeners();
  }

  saveUserName(String userName){
    this.userName = userName;
    saveSHStringValue(SH_USER_NAME, userName);
    notifyListeners();
  }

  saveUserSurName(String userSurName) {
    this.userSurName = userSurName;
    saveSHStringValue(SH_USER_SURNAME, userSurName);
    notifyListeners();
  }

  saveUserRol(String userRol) {
    this.userRol = userRol;
    saveSHStringValue(SH_USER_ROL, userRol);
    notifyListeners();
  }

  saveUserTelefono(String userTel) {
    this.userTel = userTel;
    saveSHStringValue(SH_USER_ROL, userRol);
    notifyListeners();
  }
  saveUserPermiso(int idGrupo) {
    this.idGrupo = idGrupo;
    saveSHIntegerValue(SH_USER_ROL, idGrupo);
    notifyListeners();
  }
}