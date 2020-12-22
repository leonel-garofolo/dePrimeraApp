import 'package:ag/services/asistentesService.dart';
import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/services/personasService.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AsistentesActivity extends StatefulWidget {
  AsistentesActivity({Key key}) : super(key: key);

  @override
  AsistentesActivityState createState() => AsistentesActivityState();
}

class AsistentesActivityState extends State<AsistentesActivity> {
  final AsistentesServices asistentesServices= new AsistentesServices();
  final PersonasServices personasServices= new PersonasServices();
  final LigasServices ligasServices= new LigasServices();
  List<LigaDTO> ligas;
  List<AsistenteDTO> asistentes;
  List<PersonaDTO> personas;

  @override
  void initState() {
    super.initState();
  }

  loadAsistentes() async{
    ligas = await ligasServices.getAll();
    personas = await personasServices.getAll();
    final List<AsistenteDTO> tempAsistentes = await asistentesServices.getAll();
    for(AsistenteDTO asistente in tempAsistentes){
      for(PersonaDTO persona in personas){
        if(asistente.idPersona == persona.idPersona){
          asistente.personaDTO = persona;
          break;
        }
      }

      for(LigaDTO liga in ligas){
        if(asistente.personaDTO != null && asistente.personaDTO.idLiga == liga.idLiga){
          asistente.personaDTO.idLiga = liga.idLiga;
          asistente.personaDTO.liga = liga;
          break;
        }
      }
    }
    asistentes = tempAsistentes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadAsistentes(),
        builder: (BuildContext context, AsyncSnapshot<void>  snapshot) {
          Widget list = Container(
            child: Text("cargando"),
          );

          if(asistentes != null && asistentes.isNotEmpty){
            list= ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: asistentes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('${asistentes[index].personaDTO.apellidoNombre}')),
                  subtitle: Center(child: Text('${asistentes[index].personaDTO.idTipoDoc.toString() + " - " +  asistentes[index].personaDTO.nroDoc.toString()}')),
                  onTap: () => editEntity(context, asistentes[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Asistentes'),
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

  editEntity(final BuildContext context, AsistenteDTO asistenteDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AsistentesForm(ligasDTO: ligas, asistenteDTO: asistenteDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AsistentesForm(ligasDTO: ligas)),
    );
  }
}

class AsistentesForm extends StatefulWidget {
  AsistentesForm({Key key, this.ligasDTO, this.asistenteDTO}) : super(key: key);

  final List<LigaDTO> ligasDTO;
  final AsistenteDTO asistenteDTO;
  @override
  AsistentesFormState createState() => AsistentesFormState();
}

class AsistentesFormState extends State<AsistentesForm>{
  final AsistentesServices asistentesServices = new AsistentesServices();
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
    if(this.widget.asistenteDTO != null){
      apellidoNombre.text = this.widget.asistenteDTO.personaDTO.apellidoNombre;
      domicilio.text = this.widget.asistenteDTO.personaDTO.domicilio;
      edad.text = this.widget.asistenteDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.asistenteDTO.personaDTO.idLocalidad.toString();
      idPais.text = this.widget.asistenteDTO.personaDTO.idPais.toString();
      idProvincia.text = this.widget.asistenteDTO.personaDTO.idProvincia.toString();
      idTipoDoc.text = this.widget.asistenteDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.asistenteDTO.personaDTO.nroDoc.toString();

      if(ligaValue == null)
        ligaValue = this.widget.asistenteDTO.personaDTO.liga;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.asistenteDTO != null? this.widget.asistenteDTO.personaDTO.apellidoNombre : "Nuevo Arbitro"}"),
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
    final AsistenteDTO asistenteDTO = new AsistenteDTO();
    final PersonaDTO personaDTO = new PersonaDTO(
      apellidoNombre: apellidoNombre.text,
      idLiga: ligaValue.idLiga,
      idTipoDoc: int.parse(idTipoDoc.text),
      nroDoc: int.parse(nroDoc.text),
      domicilio: domicilio.text,
      edad: int.parse(edad.text),
    );

    if(this.widget.asistenteDTO != null){
      personaDTO.idPersona = this.widget.asistenteDTO.idPersona;
      asistenteDTO.idAsistente = this.widget.asistenteDTO.idAsistente;
    }

    final String id = await personasServices.save(personaDTO);
    asistenteDTO.idPersona = int.parse(id);
    print(id);
    print(await asistentesServices.save(asistenteDTO));
    Navigator.pop(context);
  }
}