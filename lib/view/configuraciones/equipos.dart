import 'package:ag/services/equiposService.dart';
import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/view/component/fieldListView.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EquiposActivity extends StatefulWidget {
  EquiposActivity({Key key}) : super(key: key);

  @override
  EquiposActivityState createState() => EquiposActivityState();
}

class EquiposActivityState extends State<EquiposActivity> {
  final EquiposServices equiposServices= new EquiposServices();
  final LigasServices ligasServices= new LigasServices();
  List<EquipoDTO> equipos;
  List<LigaDTO> ligas;

  @override
  void initState() {
    super.initState();
    loadEquipos();
  }

   loadEquipos(){
     ligasServices.getAll().then((response){
       setState(() {
         ligas = response;
         equiposServices.getAll().then((responseEquipo){
           final List<EquipoDTO> tempEquipos = responseEquipo;
           for(EquipoDTO equipo in tempEquipos){
             for(LigaDTO liga in ligas){
               if(equipo.idLiga == liga.idLiga){
                 equipo.ligaDTO = liga;
                 break;
               }
             }
           }
           setState(() {
             equipos = tempEquipos;
           });
         });
       });
     });
  }

  @override
  Widget build(BuildContext context) {
    Widget list = Container(
      child: Text("cargando"),
    );

    if(equipos != null && equipos.isNotEmpty){
      list= ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: equipos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Center(child: Text('${equipos[index].nombre}')),
            subtitle: Center(child: Text('${equipos[index].ligaDTO.nombre}')),
            onTap: () => editEntity(context, equipos[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos'),
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
  }

  editEntity(final BuildContext context, EquipoDTO equipoDTO){
    print(equipoDTO.nombre);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EquiposForm(ligasDTO: ligas, equipoDTO: equipoDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EquiposForm()),
    );
  }
}

class EquiposForm extends StatefulWidget {
  EquiposForm({Key key, this.ligasDTO, this.equipoDTO}) : super(key: key);

  final List<LigaDTO> ligasDTO;
  final EquipoDTO equipoDTO;
  @override
  EquiposFormState createState() => EquiposFormState();
}

class EquiposFormState extends State<EquiposForm>{
  final EquiposServices equiposServices = new EquiposServices();
  final _formKey = GlobalKey<FormState>();

  final idLiga = TextEditingController();
  final nombre = TextEditingController();
  final habilitado = TextEditingController();
  final foto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.equipoDTO != null){
      nombre.text = this.widget.equipoDTO.nombre;
      idLiga.text = this.widget.equipoDTO.ligaDTO.idLiga.toString();
      //habilitado.text = this.widget.equipoDTO.habilitado;
      //foto.text = this.widget.equipoDTO.foto;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.equipoDTO != null? this.widget.equipoDTO.nombre : "Nuevo Equipo"}"),
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
              FieldListView(
                label: "Id Liga",
                title: "Selecciona una Liga",
                controller: idLiga,
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
    final EquipoDTO equipoDTO = new EquipoDTO();
    if(this.widget.equipoDTO != null){
      equipoDTO.idEquipo = this.widget.equipoDTO.idEquipo;
    }
    equipoDTO.nombre = nombre.text;
    print(await equiposServices.save(equipoDTO));
    Navigator.pop(context);
  }
}