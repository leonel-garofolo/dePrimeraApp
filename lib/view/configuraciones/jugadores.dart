import 'package:ag/services/jugadoresService.dart';
import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/services/personasService.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class JugadoresActivity extends StatefulWidget {
  JugadoresActivity({Key key}) : super(key: key);

  @override
  JugadoresActivityState createState() => JugadoresActivityState();
}

class JugadoresActivityState extends State<JugadoresActivity> {
  final JugadoresServices jugadoresServices= new JugadoresServices();
  final PersonasServices personasServices= new PersonasServices();
  final LigasServices ligasServices= new LigasServices();
  List<LigaDTO> ligas;
  List<JugadorDTO> jugadores;
  List<PersonaDTO> personas;

  @override
  void initState() {
    super.initState();
  }

  loadJugadores() async{
    ligas = await ligasServices.getAll();
    personas = await personasServices.getAll();
    final List<JugadorDTO> tempJugadores = await jugadoresServices.getAll();
    for(JugadorDTO jugadore in tempJugadores){
      for(PersonaDTO persona in personas){
        if(jugadore.idPersona == persona.idPersona){
          jugadore.personaDTO = persona;
          break;
        }
      }

      for(LigaDTO liga in ligas){
        if(jugadore.personaDTO != null && jugadore.personaDTO.idLiga == liga.idLiga){
          jugadore.personaDTO.idLiga = liga.idLiga;
          jugadore.personaDTO.liga = liga;
          break;
        }
      }
    }
    jugadores = tempJugadores;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadJugadores(),
        builder: (BuildContext context, AsyncSnapshot<void>  snapshot) {
          Widget list = Container(
            child: Text("cargando"),
          );

          if(jugadores != null && jugadores.isNotEmpty){
            list= ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: jugadores.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('${jugadores[index].personaDTO.apellidoNombre}')),
                  subtitle: Center(child: Text('${jugadores[index].personaDTO.idTipoDoc.toString() + " - " +  jugadores[index].personaDTO.nroDoc.toString()}')),
                  onTap: () => editEntity(context, jugadores[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Jugadores'),
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

  editEntity(final BuildContext context, JugadorDTO jugadoreDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JugadoresForm(ligasDTO: ligas, jugadoreDTO: jugadoreDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JugadoresForm(ligasDTO: ligas)),
    );
  }
}

class JugadoresForm extends StatefulWidget {
  JugadoresForm({Key key, this.ligasDTO, this.jugadoreDTO}) : super(key: key);

  final List<LigaDTO> ligasDTO;
  final JugadorDTO jugadoreDTO;
  @override
  JugadoresFormState createState() => JugadoresFormState();
}

class JugadoresFormState extends State<JugadoresForm>{
  final JugadoresServices jugadoresServices = new JugadoresServices();
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
    if(this.widget.jugadoreDTO != null){
      apellidoNombre.text = this.widget.jugadoreDTO.personaDTO.apellidoNombre;
      domicilio.text = this.widget.jugadoreDTO.personaDTO.domicilio;
      edad.text = this.widget.jugadoreDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.jugadoreDTO.personaDTO.idLocalidad.toString();
      idPais.text = this.widget.jugadoreDTO.personaDTO.idPais.toString();
      idProvincia.text = this.widget.jugadoreDTO.personaDTO.idProvincia.toString();
      idTipoDoc.text = this.widget.jugadoreDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.jugadoreDTO.personaDTO.nroDoc.toString();

      if(ligaValue == null)
        ligaValue = this.widget.jugadoreDTO.personaDTO.liga;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.jugadoreDTO != null? this.widget.jugadoreDTO.personaDTO.apellidoNombre : "Nuevo Arbitro"}"),
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
    final JugadorDTO jugadorDTO = new JugadorDTO();
    final PersonaDTO personaDTO = new PersonaDTO(
      apellidoNombre: apellidoNombre.text,
      idLiga: ligaValue.idLiga,
      idTipoDoc: int.parse(idTipoDoc.text),
      nroDoc: int.parse(nroDoc.text),
      domicilio: domicilio.text,
      edad: int.parse(edad.text),
    );

    if(this.widget.jugadoreDTO != null){
      personaDTO.idPersona = this.widget.jugadoreDTO.idPersona;
      jugadorDTO.idJugador = this.widget.jugadoreDTO.idJugador;
    }

    final String id = await personasServices.save(personaDTO);
    jugadorDTO.idPersona = int.parse(id);
    print(id);
    print(await jugadoresServices.save(jugadorDTO));
    Navigator.pop(context);
  }
}