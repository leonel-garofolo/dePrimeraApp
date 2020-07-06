import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/view/component/field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LigasActivity extends StatefulWidget {
  LigasActivity({Key key}) : super(key: key);

  @override
  _LigasActivityState createState() => _LigasActivityState();
}

class _LigasActivityState extends State<LigasActivity> {
  final LigasServices ligasServices= new LigasServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LigaDTO>>(
       future: ligasServices.getAll(),
       builder: (BuildContext context, AsyncSnapshot<List<LigaDTO>>  snapshot) {

      Widget list = Container(
        child: Text("cargando"),
      );

      if(snapshot.data != null && snapshot.data.isNotEmpty){
        list= ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Center(child: Text('${snapshot.data[index].nombre}')),
              subtitle: Center(child: Text('${snapshot.data[index].cuit}')),
              onTap: () => editEntity(context, snapshot.data[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Ligas'),
        ),
        body: list,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newEntity(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    });
  }

  editEntity(final BuildContext context, LigaDTO ligaDTO){
    print(ligaDTO.nombre);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LigasForm(ligaDTO: ligaDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LigasForm()),
    );
  }
}

class LigasForm extends StatefulWidget {
  LigasForm({Key key, this.ligaDTO}) : super(key: key);

  final LigaDTO ligaDTO;
  @override
  LigasFormState createState() => LigasFormState();
}

class LigasFormState extends State<LigasForm>{
  final _formKey = GlobalKey<FormState>();

  final nombre = TextEditingController();
  final cuit = TextEditingController();
  final domicilio = TextEditingController();
  final nombreContacto = TextEditingController();
  final telefonoContacto = TextEditingController();
  final telefono = TextEditingController();
  final mailContacto = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${this.widget.ligaDTO != null? this.widget.ligaDTO.nombre : "Nueva Liga"}"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FieldText(
              label: "Nombre",
              controller: nombre,
            ),
            FieldText(
              label: "Cuit",
              controller: cuit,
            ),
            FieldText(
              label: "Domicilio",
              controller: domicilio,
            ),
            FieldText(
              label: "Nombre Contacto",
              controller: nombreContacto,
            ),
            FieldText(
              label: "Mail Contacto",
              controller: mailContacto,
            ),
            FieldText(
              label: "Telefono",
              controller: telefono,
            ),
            FieldText(
              label: "Telefono Contacto",
              controller: telefonoContacto,
            ),
            RaisedButton(
              onPressed: () {
                print(nombre.value.text);
              },
              child: const Text('Enabled Button', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

}