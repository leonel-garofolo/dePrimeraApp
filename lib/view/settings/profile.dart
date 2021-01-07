import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final email = TextEditingController();
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final telefono = TextEditingController();
  final rol = TextEditingController();
  double puntaje = 3;

  @override
  void initState() {
    super.initState();
    Provider.of<SharedPreferencesProvider>(context, listen: false).getSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    email.text= Provider.of<SharedPreferencesProvider>(context, listen: false).getUserId();
    nombre.text= Provider.of<SharedPreferencesProvider>(context, listen: false).getUserName();
    apellido.text= Provider.of<SharedPreferencesProvider>(context, listen: false).getUserSurName();
    telefono.text= Provider.of<SharedPreferencesProvider>(context, listen: false).getUserTelefono();
    rol.text= Provider.of<SharedPreferencesProvider>(context, listen: false).getUserRol();
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            FieldText(
              controller: email,
              label: "Email",
            ),
            FieldText(
              controller: nombre,
              label: "Nombre",
            ),
            FieldText(
              controller: apellido,
              label: "Apellido",
            ),
            FieldText(
              controller: telefono,
              label: "Telefono",
            ),
            FieldText(
              controller: rol,
              label: "Rol",
            ),
            SizedBox(height: 30,),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width - 20,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  send(context);
                },
                child: Text("Guardar",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18).copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  send(BuildContext context){
    UserDTO dto = new UserDTO(
      idUser: email.text,
      nombre: nombre.text,
      apellido: apellido.text,
      telefono: telefono.text
    );
    print(dto);
    /*
    ComentariosDTO dto = new ComentariosDTO(
        mail: email.text,
        puntaje: this.puntaje,
        comentario: opinion.text
    );
    Provider.of<ComentariosProvider>(context, listen: false).save(dto).then((value) {
      print(value);
      Navigator.pop(context);
    });

     */
  }
}