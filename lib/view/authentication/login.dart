

import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:ag/services/authenticationService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget{
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final email = TextEditingController();
  final clave = TextEditingController();
  final authenticationService = new AuthenticationServices();

  void authenticate(BuildContext ctx ) async{
      final UserDTO user = new UserDTO(
        idUser: email.text,
        password: clave.text
      );

      UserDTO resp = await authenticationService.login(user);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(resp.idUser == ""){
        await prefs.setBool(SH_IS_LOGGED, false);
        final message =  SnackBar(
          content: Text("Error"),
        );
        Scaffold.of(ctx).showSnackBar(message);
      } else {
        await prefs.setBool(SH_IS_LOGGED, true);
        await prefs.setString(SH_USER_ID, resp.idUser);
        await prefs.setString(SH_USER_NAME, resp.nombre + " " + resp.apellido );
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home()));
      }
  }

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      controller: email,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final passwordField = TextField(
      controller: clave,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          authenticate(context);
        },
        child: Text("Ingresar",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 120.0,
                  child: Text("De Primera", style: TextStyle(fontFamily: 'Montserrat', fontSize: 40.0),)
                ),
                SizedBox(height: 10.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}