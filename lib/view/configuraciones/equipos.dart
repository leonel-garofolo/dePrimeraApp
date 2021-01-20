import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/equiposProvider.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/component/fieldCheckBox.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/component/saveButton.dart';
import 'package:ag/view/component/withoutData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquiposActivity extends StatefulWidget {
  EquiposActivity({Key key}) : super(key: key);

  @override
  EquiposActivityState createState() => EquiposActivityState();
}

class EquiposActivityState extends State<EquiposActivity> {
  List<LigaDTO> ligas;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return
        Consumer<EquiposProvider>(builder: (context, value, child) {
          Widget widget;
          if(value.isLoading){
            widget = CircularProgress();
          } else {
            List<EquipoDTO> equipos = value.equipos;


            if(equipos != null){
              if(equipos.isNotEmpty){
                widget= ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: equipos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Center(child: Text('${equipos[index].nombre}')),
                      onTap: () => editEntity(context, equipos[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                );
              } else {
                widget = WithoutData();
              }
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Equipos'),
            ),
            body: widget,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                newEntity(context);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
      },);
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
  bool habilitado = false;
  final foto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.equipoDTO != null){
      nombre.text = this.widget.equipoDTO.nombre;
      habilitado = this.widget.equipoDTO.habilitado;
      //foto.text = this.widget.equipoDTO.foto;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.equipoDTO != null? this.widget.equipoDTO.nombre : "Nuevo Equipo"}"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<EquiposProvider>(context, listen: false).delete(widget.equipoDTO.idEquipo);
              Provider.of<EquiposProvider>(context, listen: false).getAll();
              Navigator.pop(context);
            },
          ),
        ],
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
              FieldCheckbox(
                label: "Habilitado",
                value: habilitado,
                valueChanged: (newValue) {
                  setState(() {
                    habilitado = newValue;
                  });
                },
              ),
              Container(height: 10,),
              ButtonRequest(
                  text: "Guardar",
                  onPressed: (){
                    save();
                  }
              ),
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
    equipoDTO.habilitado = habilitado;

    Provider.of<EquiposProvider>(context, listen: false).save(equipoDTO).then((value) {
      Provider.of<EquiposProvider>(context, listen: false).getAll();
      Navigator.pop(context);
    });

  }
}