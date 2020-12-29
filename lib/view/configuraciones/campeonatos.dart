import 'package:ag/services/campeonatosService.dart';
import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldDatePicker.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampeonatosActivity extends StatefulWidget {
  CampeonatosActivity({Key key}) : super(key: key);

  @override
  CampeonatosActivityState createState() => CampeonatosActivityState();
}

class CampeonatosActivityState extends State<CampeonatosActivity> {
  final CampeonatosServices campeonatosServices= new CampeonatosServices();
  final LigasServices ligasServices= new LigasServices();
  List<CampeonatoDTO> campeonatos;
  List<LigaDTO> ligas;

  @override
  void initState() {
    super.initState();
  }

  loadCampeonatos() async{
    ligas = await ligasServices.getAll();
    final List<CampeonatoDTO> tempCampeonatos = await campeonatosServices.getAll();
    for(CampeonatoDTO campeonato in tempCampeonatos){
      for(LigaDTO liga in ligas){
        if(campeonato.idLiga == liga.idLiga){
          campeonato.ligaDTO = liga;
          break;
        }
      }
    }
    campeonatos = tempCampeonatos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadCampeonatos(),
        builder: (BuildContext context, AsyncSnapshot<void>  snapshot) {
          Widget list = Container(
            child: Text("cargando"),
          );

          if(campeonatos != null && campeonatos.isNotEmpty){
            list= ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: campeonatos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('${campeonatos[index].descripcion}')),
                  subtitle: Center(child: Text('${campeonatos[index].ligaDTO.nombre}')),
                  onTap: () => editEntity(context, campeonatos[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Campeonatos'),
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

  editEntity(final BuildContext context, CampeonatoDTO campeonatoDTO){
    print(campeonatoDTO.descripcion);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CampeonatosForm(ligasDTO: ligas, campeonatoDTO: campeonatoDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CampeonatosForm(ligasDTO: ligas)),
    );
  }
}

class CampeonatosForm extends StatefulWidget {
  CampeonatosForm({Key key, this.ligasDTO, this.campeonatoDTO}) : super(key: key);

  final List<LigaDTO> ligasDTO;
  final CampeonatoDTO campeonatoDTO;
  @override
  CampeonatosFormState createState() => CampeonatosFormState();
}

class CampeonatosFormState extends State<CampeonatosForm>{
  final CampeonatosServices campeonatosServices = new CampeonatosServices();
  final _formKey = GlobalKey<FormState>();

  final descripcion = TextEditingController();
  LigaDTO ligaValue;
  DateTime fechaInicio;
  DateTime fechaFin;

  @override
  Widget build(BuildContext context) {
    if(this.widget.campeonatoDTO != null){
      descripcion.text = this.widget.campeonatoDTO.descripcion;
      if(ligaValue == null)
        ligaValue = this.widget.campeonatoDTO.ligaDTO;
      if(fechaInicio == null)
        fechaInicio = this.widget.campeonatoDTO.fechaInicio;
      if(fechaFin == null)
        fechaFin = this.widget.campeonatoDTO.fechaFin;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.campeonatoDTO != null? this.widget.campeonatoDTO.descripcion : "Nuevo Campeonato"}"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FieldText(
                label: "Descripcion",
                controller: descripcion,
              ),
              FieldComboBox<LigaDTO>(
                label: "Liga",
                itemValue: ligaValue,
                itemList: widget.ligasDTO,
                onChange: onChangeLiga,
              ),
              FieldDatePicker(
                label: "Fecha Desde",
                value: fechaInicio,
                valueChanged: (date){
                  setState(() {
                    fechaInicio = date;
                  });
                },
              ),
              FieldDatePicker(
                label: "Fecha Hasta",
                value: fechaFin,
                valueChanged: (date){
                  setState(() {
                    fechaFin = date;
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
    final CampeonatoDTO campeonatoDTO = new CampeonatoDTO();
    if(this.widget.campeonatoDTO != null){
      campeonatoDTO.idCampeonato = this.widget.campeonatoDTO.idCampeonato;
    }
    campeonatoDTO.descripcion = descripcion.text;
    campeonatoDTO.idLiga = ligaValue.idLiga;
    campeonatoDTO.fechaInicio = fechaInicio;
    campeonatoDTO.fechaFin = fechaFin;
    print(await campeonatosServices.save(campeonatoDTO));
    Navigator.pop(context);
  }
}