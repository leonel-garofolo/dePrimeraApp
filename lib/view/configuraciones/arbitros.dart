import 'package:ag/services/arbitrosService.dart';
import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/services/personasService.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ArbitrosActivity extends StatefulWidget {
  ArbitrosActivity({Key key}) : super(key: key);

  @override
  ArbitrosActivityState createState() => ArbitrosActivityState();
}

class ArbitrosActivityState extends State<ArbitrosActivity> {
  final ArbitrosServices arbitrosServices= new ArbitrosServices();
  final PersonasServices personasServices= new PersonasServices();
  final LigasServices ligasServices= new LigasServices();
  List<LigaDTO> ligas;
  List<ArbitroDTO> arbitros;
  List<PersonaDTO> personas;

  @override
  void initState() {
    super.initState();
  }

  loadArbitros() async{
    ligas = await ligasServices.getAll();
    personas = await personasServices.getAll();
    final List<ArbitroDTO> tempArbitros = await arbitrosServices.getAll();
    for(ArbitroDTO arbitro in tempArbitros){
      for(PersonaDTO persona in personas){
        if(arbitro.idPersona == persona.idPersona){
          arbitro.personaDTO = persona;
          break;
        }
      }

      for(LigaDTO liga in ligas){
        if(arbitro.personaDTO != null && arbitro.personaDTO.idLiga == liga.idLiga){
          arbitro.personaDTO.idLiga = liga.idLiga;
          arbitro.personaDTO.liga = liga;
          break;
        }
      }
    }
    arbitros = tempArbitros;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadArbitros(),
        builder: (BuildContext context, AsyncSnapshot<void>  snapshot) {
          Widget list = Container(
            child: Text("cargando"),
          );

          if(arbitros != null && arbitros.isNotEmpty){
            list= ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: arbitros.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('${arbitros[index].personaDTO.apellidoNombre}')),
                  subtitle: Center(child: Text('${arbitros[index].personaDTO.idTipoDoc.toString() + " - " +  arbitros[index].personaDTO.nroDoc.toString()}')),
                  onTap: () => editEntity(context, arbitros[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Arbitros'),
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

  editEntity(final BuildContext context, ArbitroDTO arbitroDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArbitrosForm(ligasDTO: ligas, arbitroDTO: arbitroDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArbitrosForm(ligasDTO: ligas)),
    );
  }
}

class ArbitrosForm extends StatefulWidget {
  ArbitrosForm({Key key, this.ligasDTO, this.arbitroDTO}) : super(key: key);

  final List<LigaDTO> ligasDTO;
  final ArbitroDTO arbitroDTO;
  @override
  ArbitrosFormState createState() => ArbitrosFormState();
}

class ArbitrosFormState extends State<ArbitrosForm>{
  final ArbitrosServices arbitrosServices = new ArbitrosServices();
  final PersonasServices personasServices = new PersonasServices();
  final _formKey = GlobalKey<FormState>();

  LigaDTO ligaValue;

  final apellidoNombre = TextEditingController();
  final domicilio = TextEditingController();
  final edad = TextEditingController();
  final idLiga = TextEditingController();
  final idLocalidad = TextEditingController();
  final idPais = TextEditingController();
  final idProvincia = TextEditingController();
  final idTipoDoc = TextEditingController();
  final nroDoc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if(this.widget.arbitroDTO != null){
      apellidoNombre.text = this.widget.arbitroDTO.personaDTO.apellidoNombre;
      domicilio.text = this.widget.arbitroDTO.personaDTO.domicilio;
      edad.text = this.widget.arbitroDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.arbitroDTO.personaDTO.idLocalidad.toString();
      idPais.text = this.widget.arbitroDTO.personaDTO.idPais.toString();
      idProvincia.text = this.widget.arbitroDTO.personaDTO.idProvincia.toString();
      idTipoDoc.text = this.widget.arbitroDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.arbitroDTO.personaDTO.nroDoc.toString();

      if(ligaValue == null)
        ligaValue = this.widget.arbitroDTO.personaDTO.liga;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.arbitroDTO != null? this.widget.arbitroDTO.personaDTO.apellidoNombre : "Nuevo Arbitro"}"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FieldText(
                label: "Apellido y Nombre",
                controller: apellidoNombre,
              ),
              FieldComboBox<LigaDTO>(
                label: "Liga",
                itemValue: ligaValue,
                itemList: widget.ligasDTO,
                onChange: onChangeLiga,
              ),
              FieldText(
                label: "Tipo Documento",
                controller: idTipoDoc,
              ),
              FieldText(
                label: "Nro Documento",
                controller: nroDoc,
              ),
              FieldText(
                label: "Edad",
                controller: edad,
              ),
              FieldText(
                label: "Domicilio",
                controller: domicilio,
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
    final ArbitroDTO arbitroDTO = new ArbitroDTO();
    final PersonaDTO personaDTO = new PersonaDTO(
      apellidoNombre: apellidoNombre.text,
      idLiga: ligaValue.idLiga,
      idTipoDoc: int.parse(idTipoDoc.text),
      nroDoc: int.parse(nroDoc.text),
      domicilio: domicilio.text,
      edad: int.parse(edad.text),
    );
    
    if(this.widget.arbitroDTO != null){
      personaDTO.idPersona = this.widget.arbitroDTO.idPersona;
      arbitroDTO.idArbitro = this.widget.arbitroDTO.idArbitro;
    }
    
    final String id = await personasServices.save(personaDTO);
    arbitroDTO.idPersona = int.parse(id);
    print(id);
    print(await arbitrosServices.save(arbitroDTO));
    Navigator.pop(context);
  }
}