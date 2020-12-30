import 'package:ag/providers/equiposProvider.dart';
import 'package:ag/providers/ligaProvider.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/view/component/fieldCheckBox.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquiposActivity extends StatefulWidget {
  EquiposActivity({Key key}) : super(key: key);

  @override
  EquiposActivityState createState() => EquiposActivityState();
}

class EquiposActivityState extends State<EquiposActivity> {
  List<EquipoDTO> equipos;
  List<LigaDTO> ligas;

  @override
  void initState() {
    super.initState();
  }

   loadEquipos() async{
     Provider.of<LigaProvider>(context).getAll().then((value) => ligas = value);
     List<EquipoDTO> tempEquipos;
     Provider.of<EquiposProvider>(context).getAll().then((value) => tempEquipos = value);
     for(EquipoDTO equipo in tempEquipos){
       for(LigaDTO liga in ligas){
         if(equipo.idLiga == liga.idLiga){
           equipo.ligaDTO = liga;
           break;
         }
       }
     }
     equipos = tempEquipos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadEquipos(),
        builder: (BuildContext context, AsyncSnapshot<void>  snapshot) {
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
        });
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
      MaterialPageRoute(builder: (context) => EquiposForm(ligasDTO: ligas)),
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
  final _formKey = GlobalKey<FormState>();

  final nombre = TextEditingController();
  LigaDTO ligaValue;
  bool habilitado = false;
  final foto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.equipoDTO != null){
      nombre.text = this.widget.equipoDTO.nombre;
      if(ligaValue == null)
        ligaValue = this.widget.equipoDTO.ligaDTO;
      habilitado = this.widget.equipoDTO.habilitado;
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
              FieldComboBox<LigaDTO>(
                label: "Liga",
                itemValue: ligaValue,
                itemList: widget.ligasDTO,
                onChange: onChangeLiga,
              ),
              FieldCheckbox(
                label: "Habilitado",
                value: habilitado,
                valueChanged: (newValue) {
                  setState(() {
                    habilitado = newValue;
                  });
                },
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
              ),
            ],
          ),
        ),),
    );
  }

  void onChangeLiga(LigaDTO newLiga){
    setState(() {
      ligaValue = newLiga;
    });
  }

  save() async{
    final EquipoDTO equipoDTO = new EquipoDTO();
    if(this.widget.equipoDTO != null){
      equipoDTO.idEquipo = this.widget.equipoDTO.idEquipo;
    }
    equipoDTO.nombre = nombre.text;
    equipoDTO.idLiga = ligaValue.idLiga;
    equipoDTO.habilitado = habilitado;

    Provider.of<EquiposProvider>(context).save(equipoDTO).then((value) => print(value));
    Navigator.pop(context);
  }
}