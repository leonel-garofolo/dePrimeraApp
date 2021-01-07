
import 'package:ag/view/component/fieldCheckBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool modoOscuro = false;
  bool notificarPartido = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            FieldCheckbox(
              label: "Modo Oscuro",
              value: modoOscuro,
              valueChanged: (newValue){
                setState(() {
                  modoOscuro = newValue;
                });
              },
            ),
            FieldCheckbox(
              label: "Notificar Insidencias del partido",
              value: notificarPartido,
              valueChanged: (newValue){
                setState(() {
                  notificarPartido = newValue;
                });
              },
            ),
            SizedBox(height: 50,),
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