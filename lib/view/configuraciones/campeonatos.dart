import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/ligaProvider.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldDatePicker.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/component/saveButton.dart';
import 'package:ag/view/component/withoutData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampeonatosActivity extends StatefulWidget {
  CampeonatosActivity({Key key}) : super(key: key);

  @override
  CampeonatosActivityState createState() => CampeonatosActivityState();
}

class CampeonatosActivityState extends State<CampeonatosActivity> {
  List<CampeonatoDTO> campeonatos;
  List<LigaDTO> ligas;

  @override
  void initState() {
    super.initState();
    Provider.of<LigaProvider>(context, listen: false).getAll();
    Provider.of<CampeonatosProvider>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    ligas = Provider.of<LigaProvider>(context).getLigas();
    List<CampeonatoDTO> tempCampeonatos= Provider.of<CampeonatosProvider>(context).getCampeonatos();
    for(CampeonatoDTO campeonato in tempCampeonatos){
      for(LigaDTO liga in ligas){
        if(campeonato.idLiga == liga.idLiga){
          campeonato.ligaDTO = liga;
          break;
        }
      }
    }
    campeonatos = tempCampeonatos;

    Widget list = CircularProgress();
    if(campeonatos != null){
      if(campeonatos.isNotEmpty){
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
      } else {
        list = WithoutData();
      }
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
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<CampeonatosProvider>(context, listen: false).delete(widget.campeonatoDTO.idCampeonato);
              Provider.of<CampeonatosProvider>(context, listen: false).getAll();
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

    Provider.of<CampeonatosProvider>(context, listen: false).save(campeonatoDTO).then((value) {
      Provider.of<CampeonatosProvider>(context, listen: false).getAll();
      Navigator.pop(context);
    });
  }
}