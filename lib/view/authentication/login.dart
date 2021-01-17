

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/PersonasProvider.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/authentication/createUser.dart';
import 'package:ag/view/component/saveButton.dart';
import 'package:ag/view/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget{
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

    return Scaffold(
      key:_scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 100.0),
                          Text("De Primera", style: TextStyle(fontFamily: 'Montserrat', fontSize: 40.0)),
                          SizedBox(height: 40.0),
                          emailField,
                          SizedBox(height: 25.0),
                          passwordField,
                          SizedBox(
                            height: 10.0,
                          ),
                          InkWell(
                            onTap: () =>_forgot(),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("Olvidaste la contrasena?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic
                                ),),
                            )
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                          ButtonRequest(
                              text: "Ingresar",
                              onPressed: (){
                                authenticate(context);
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
              InkWell(
                onTap: () =>_createUser(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: Text("Crear cuenta",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      )
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
        Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserTelefono(resp.telefono);

        Provider.of<PersonasProvider>(context, listen: false).getPersonaForUser(resp.idUser).then((persona){
          Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserName(persona.nombre);
          Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserSurName(persona.apellido);

          Provider.of<AuthenticationProvider>(context, listen: false).getUserPermission(resp.idUser).then((appGrupo) {
            print(appGrupo.idAppGrupos);
            Provider.of<SharedPreferencesProvider>(context, listen: false).saveUserPermiso(appGrupo.idAppGrupos);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    Home(
                      idUser: resp.idUser,
                      idGrupo: appGrupo.idAppGrupos,
                    )
                )
            );
          });
        });
      }
    });
  }

  void _createUser() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreateUser()
    ));
  }

  _forgot() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Se ha enviado el mail para restablecer la contrasena'),
      ),
    );

  }
}
