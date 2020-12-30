import 'package:ag/providers/ligaProvider.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LigasActivity extends StatefulWidget {
  LigasActivity({Key key}) : super(key: key);

  @override
  LigasActivityState createState() => LigasActivityState();
}

class LigasActivityState extends State<LigasActivity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LigaDTO>>(
       future:  Provider.of<LigaProvider>(context).getAll(),
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
      } else if(snapshot.data == null || (snapshot.data != null && snapshot.data.isEmpty)){
        list = Container(
          child: Text("Sin Datos"),
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
    if(this.widget.ligaDTO != null){
      nombre.text = this.widget.ligaDTO.nombre;
      cuit.text = this.widget.ligaDTO.cuit;
      domicilio.text = this.widget.ligaDTO.domicilio;
      nombreContacto.text = this.widget.ligaDTO.nombreContacto;
      telefonoContacto.text = this.widget.ligaDTO.telefonoContacto;
      telefono.text = this.widget.ligaDTO.telefono;
      mailContacto.text = this.widget.ligaDTO.mailContacto;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.ligaDTO != null? this.widget.ligaDTO.nombre : "Nueva Liga"}"),
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child:Form(
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
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  save();
                },
                child: const Text('Guardar',
                    style: TextStyle(fontSize: 20)),
              ),
            )

          ],
        ),
      ),),
    );
  }

  save() async{
    final LigaDTO ligaDTO = new LigaDTO();
    if(this.widget.ligaDTO != null){
      ligaDTO.idLiga = this.widget.ligaDTO.idLiga;
    }
    ligaDTO.nombre = nombre.text;
    ligaDTO.cuit = cuit.text;
    ligaDTO.domicilio = domicilio.text;
    ligaDTO.nombreContacto = nombreContacto.text;
    ligaDTO.mailContacto = mailContacto.text;
    ligaDTO.telefono = telefono.text;
    ligaDTO.telefonoContacto = telefonoContacto.text;
    print(Provider.of<LigaProvider>(context).save(ligaDTO));
    Navigator.pop(context);
  }
}