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
    for(JugadorDTO jugador in tempJugadores){
      for(PersonaDTO persona in personas){
        if(jugador.idPersona == persona.idPersona){
          jugador.personaDTO = persona;
          break;
        }
      }

      for(LigaDTO liga in ligas){
        if(jugador.personaDTO != null && jugador.personaDTO.idLiga == liga.idLiga){
          jugador.personaDTO.idLiga = liga.idLiga;
          jugador.personaDTO.liga = liga;
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
            child: Text("Cargando"),
          );

          if(jugadores != null && jugadores.isNotEmpty){
            if(jugadores.isNotEmpty){
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
            } else {
              list = Container(
                child: Text("No se encontraron Datos"),
              );
            }
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
      MaterialPageRoute(builder: (context) => JugadoresForm(ligasDTO: ligas, jugadorDTO: jugadoreDTO,)),
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
  JugadoresForm({Key key, this.ligasDTO, this.jugadorDTO}) : super(key: key);

  final List<LigaDTO> ligasDTO;
  final JugadorDTO jugadorDTO;
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
    if(this.widget.jugadorDTO != null){
      apellidoNombre.text = this.widget.jugadorDTO.personaDTO.apellidoNombre;
      domicilio.text = this.widget.jugadorDTO.personaDTO.domicilio;
      edad.text = this.widget.jugadorDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.jugadorDTO.personaDTO.idLocalidad.toString();
      idPais.text = this.widget.jugadorDTO.personaDTO.idPais.toString();
      idProvincia.text = this.widget.jugadorDTO.personaDTO.idProvincia.toString();
      idTipoDoc.text = this.widget.jugadorDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.jugadorDTO.personaDTO.nroDoc.toString();

      if(ligaValue == null)
        ligaValue = this.widget.jugadorDTO.personaDTO.liga;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.jugadorDTO != null? this.widget.jugadorDTO.personaDTO.apellidoNombre : "Nuevo Jugador"}"),
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

    if(this.widget.jugadorDTO != null){
      personaDTO.idPersona = this.widget.jugadorDTO.idPersona;
      jugadorDTO.idJugador = this.widget.jugadorDTO.idJugador;
    }

    final String id = await personasServices.save(personaDTO);
    jugadorDTO.idPersona = int.parse(id);
    print(id);
    print(await jugadoresServices.save(jugadorDTO));
    Navigator.pop(context);
  }
}