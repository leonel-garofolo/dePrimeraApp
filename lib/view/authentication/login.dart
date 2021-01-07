

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget{
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final email = TextEditingController();
  final clave = TextEditingController();
  
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

  authenticate(BuildContext ctx){
    final UserDTO user = new UserDTO(
        idUser: email.text,
        password: clave.text
    );

    Provider.of<AuthenticationProvider>(context, listen: false).login(user).then((value) {
      final UserDTO resp = value;
      if(resp.idUser == ""){
        Provider.of<SharedPreferencesProvider>(context).saveLogged(false);
        final message =  SnackBar(
          content: Text("Error"),
        );
        Scaffold.of(ctx).showSnackBar(message);
      } else {
        Provider.of<SharedPreferencesProvider>(context, listen: false).saveLogged(true);
        Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserId(resp.idUser);
        Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserName(resp.nombre);
        Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserSurName(resp.apellido);
        Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserTelefono(resp.telefono);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }
}