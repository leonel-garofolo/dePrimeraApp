

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/component/fieldPassword.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUser extends StatefulWidget{
  CreateUser({Key key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final email = TextEditingController();
  final clave = TextEditingController();
  final claveRepetir = TextEditingController();
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final telefono = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final createUserButon = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.lightBlueAccent,
          child: MaterialButton(
            minWidth: 120,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Volver",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue,
          child: MaterialButton(
            minWidth: 120,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              if(clave.text == claveRepetir.text){
                _createUser(context);
              } else {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('La contrasena ingresada no coincide'),
                  ),
                );
              }
            },
            child: Text("Crear",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top:20.0, bottom: 300, left: 20, right: 20),
          child: Form(
            child: Column(
              children: <Widget>[
                Text("Crear Usuario", style: TextStyle(fontSize: 28),),
                FieldText(
                  label: "Email",
                  controller: email,
                ),
                FieldPasswordText(
                  label: "Contrasena",
                  controller: clave,
                ),
                FieldPasswordText(
                  label: "Repetir Contrasena",
                  controller: claveRepetir,
                ),
                FieldText(
                  label: "Nombre",
                  controller: nombre,
                ),
                FieldText(
                  label: "Apellido",
                  controller: apellido,
                ),
                FieldText(
                  label: "Telefono",
                  controller: telefono,
                ),
                Container(height: 20,),
                createUserButon,
              ],
            ),
          ),
        )
      )
    );
  }

  _createUser(BuildContext ctx){
    final UserDTO user = new UserDTO(
        idUser: email.text,
        password: clave.text,
        telefono: telefono.text,
        habilitado: false
    );

    Provider.of<AuthenticationProvider>(context, listen: false).createAccount(user).then((value) {
      print(value);
      Navigator.pop(context);
    });
  }
}