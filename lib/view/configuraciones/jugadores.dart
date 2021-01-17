import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/PersonasProvider.dart';
import 'package:ag/providers/equiposProvider.dart';
import 'package:ag/providers/jugadoresProvider.dart';
import 'package:ag/providers/paisesProvider.dart';
import 'package:ag/providers/provinciasProvider.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldNumber.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/component/saveButton.dart';
import 'package:ag/view/component/withoutData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class JugadoresActivity extends StatefulWidget {
  JugadoresActivity({Key key}) : super(key: key);

  @override
  JugadoresActivityState createState() => JugadoresActivityState();
}

bool _deleteMode;
class JugadoresActivityState extends State<JugadoresActivity> {
  List<PaisDTO> paises;
  List<ProvinciaDTO> provincias;
  List<EquipoDTO> equipos;

  @override
  void initState() {
    super.initState();
    _deleteMode = false;
    Provider.of<PaisesProvider>(context, listen: false).getAll();
    Provider.of<ProvinciasProvider>(context, listen: false).getAll();
    Provider.of<EquiposProvider>(context, listen: false).getAll();
    Provider.of<PersonasProvider>(context, listen: false).getAll();
    Provider.of<JugadoresProvider>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    paises = Provider.of<PaisesProvider>(context).getPaises();
    provincias = Provider.of<ProvinciasProvider>(context).getProvincias();
    equipos = Provider.of<EquiposProvider>(context).getEquipos();
    List<PersonaDTO> personas = Provider.of<PersonasProvider>(context).getPersonas();
    List<JugadorDTO> jugadores = Provider.of<JugadoresProvider>(context).getJugadores();
    Widget list = CircularProgress();
    if(jugadores != null){
      if(jugadores.isNotEmpty) {
        if(personas != null && personas.isNotEmpty) {
          for (JugadorDTO jugador in jugadores) {
            for (PersonaDTO persona in personas) {
              if (jugador.idPersona == persona.idPersona) {
                jugador.personaDTO = persona;
                for(PaisDTO pais in paises){
                  if(jugador.personaDTO.idPais == pais.idPais){
                    jugador.personaDTO.paisDTO = pais;

                    for(ProvinciaDTO prov in provincias){
                      if(jugador.personaDTO.idPais == prov.idPais &&
                          jugador.personaDTO.idProvincia == prov.idProvincia){
                        jugador.personaDTO.provinciaDTO = prov;
                        break;
                      }
                    }

                    break;
                  }
                }
                break;
              }
            }
          }

          if(equipos != null && equipos.isNotEmpty) {
            for (JugadorDTO jugador in jugadores) {
              for (EquipoDTO equipo in equipos) {
                if (jugador.idEquipo == equipo.idEquipo) {
                  jugador.equipoDTO = equipo;
                  break;
                }
              }
            }
          }

          Widget deleteModeWidget = Container();

          list= ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: jugadores.length,
            itemBuilder: (BuildContext context, int index) {
              if(_deleteMode){
                deleteModeWidget =Checkbox(
                    value: jugadores[index].deleteSelected,
                    onChanged: (newValue){
                      setState(() {
                        jugadores[index].deleteSelected = newValue;
                        print(jugadores[index].deleteSelected);
                      });
                    });
              } else {
                deleteModeWidget = Container();
              }

              return InkWell(
                onLongPress: (){
                  setState(() {
                    _deleteMode = true;
                  });
                },
                onTap: () => editEntity(context, jugadores[index]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(margin: EdgeInsets.only(left: 10, top: 5), child: Text('${jugadores[index].personaDTO.nombre}', style: TextStyle(fontSize: 20),)),
                        Container(child: Text('${jugadores[index].personaDTO.idTipoDoc} ${jugadores[index].personaDTO.nroDoc}', style: TextStyle(fontSize: 12),))
                      ],
                    ),
                    deleteModeWidget

                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        }
      } else {
        list = WithoutData();
      }
    }

    List<IconButton> icons = new List<IconButton>();
    if(_deleteMode) {
      icons.add(IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          setState(() {
            _deleteMode = false;
            for (JugadorDTO jugador in jugadores) {
              jugador.deleteSelected = false;
            }
          });
        },
      ));

      icons.add(IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          for (JugadorDTO jugador in jugadores) {
            print(jugador.idJugador.toString() + "| " +
                jugador.deleteSelected.toString());
          }
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugadores'),
        actions: icons,
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

  editEntity(final BuildContext context, JugadorDTO jugadorDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JugadoresForm(
        paises: paises,
        provincias: provincias,
        equiposDTO: equipos,
        jugadorDTO: jugadorDTO,
      )),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JugadoresForm(
          paises: paises,
          provincias: provincias,
          equiposDTO: equipos)),
    );
  }
}

class JugadoresForm extends StatefulWidget {
  JugadoresForm({Key key,
    this.paises,
    this.provincias,
    this.equiposDTO,
    this.jugadorDTO}) : super(key: key);

  final List<PaisDTO> paises;
  final List<ProvinciaDTO> provincias;
  final List<EquipoDTO> equiposDTO;
  final JugadorDTO jugadorDTO;
  @override
  JugadoresFormState createState() => JugadoresFormState();
}

class JugadoresFormState extends State<JugadoresForm>{
  final _formKey = GlobalKey<FormState>();

  PaisDTO paisValue;
  ProvinciaDTO provinciaValue;
  EquipoDTO equipoValue;

  final apellidoNombre = TextEditingController();
  final domicilio = TextEditingController();
  final edad = TextEditingController();
  final idLiga = TextEditingController();
  final idLocalidad = TextEditingController();
  final idTipoDoc = TextEditingController();
  final nroDoc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.jugadorDTO != null){
      apellidoNombre.text = this.widget.jugadorDTO.personaDTO.nombre;
      domicilio.text = this.widget.jugadorDTO.personaDTO.domicilio;
      edad.text = this.widget.jugadorDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.jugadorDTO.personaDTO.localidad;
      if(paisValue == null)
        paisValue = this.widget.jugadorDTO.personaDTO.paisDTO;
      if(provinciaValue== null)
        provinciaValue = this.widget.jugadorDTO.personaDTO.provinciaDTO;

      idTipoDoc.text = this.widget.jugadorDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.jugadorDTO.personaDTO.nroDoc.toString();
      if(equipoValue == null)
        equipoValue = this.widget.jugadorDTO.equipoDTO;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.jugadorDTO != null? this.widget.jugadorDTO.personaDTO.nombre : "Nuevo Arbitro"}"),
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
              FieldComboBox<PaisDTO>(
                label: "Pais",
                itemValue: paisValue,
                itemList: widget.paises,
                onChange: onChangePais,
              ),
              FieldComboBox<ProvinciaDTO>(
                label: "Provincia",
                itemValue: provinciaValue,
                itemList: widget.provincias,
                onChange: onChangeProvincia,
              ),
              FieldText(
                label: "Localidad",
                controller: idLocalidad,
              ),
              FieldText(
                label: "Tipo Documento",
                controller: idTipoDoc,
              ),
              FieldNumber(
                label: "Nro Documento",
                controller: nroDoc,
              ),
              FieldNumber(
                label: "Edad",
                controller: edad,
              ),
              FieldText(
                label: "Domicilio",
                controller: domicilio,
              ),
              FieldComboBox<EquipoDTO>(
                label: "Equipo",
                itemValue: equipoValue,
                itemList: widget.equiposDTO,
                onChange: onChangeEquipo,
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

  void onChangePais(PaisDTO newPais){
    setState(() {
      paisValue = newPais;
    });
  }

  void onChangeProvincia(ProvinciaDTO newProvincia){
    setState(() {
      provinciaValue = newProvincia;
    });
  }

  void onChangeEquipo(EquipoDTO newEquipo){
    setState(() {
      equipoValue = newEquipo;
    });
  }

  save() async{
    final JugadorDTO jugadorDTO = new JugadorDTO();
    final PersonaDTO personaDTO = new PersonaDTO(
        nombre: apellidoNombre.text,
        idTipoDoc: int.parse(idTipoDoc.text),
        nroDoc: int.parse(nroDoc.text),
        domicilio: domicilio.text,
        edad: int.parse(edad.text),
        idPais: paisValue.idPais,
        idProvincia: provinciaValue.idProvincia,
        localidad: idLocalidad.text
    );

    if(this.widget.jugadorDTO != null){
      if(this.widget.jugadorDTO.idPersona != null){
        personaDTO.idPersona = this.widget.jugadorDTO.idPersona;
      }
      if(this.widget.jugadorDTO.idJugador != null){
        jugadorDTO.idJugador = this.widget.jugadorDTO.idJugador;
      }
    }

    Provider.of<PersonasProvider>(context, listen: false).save(personaDTO).then((value){
      jugadorDTO.idPersona = int.parse(value);
      jugadorDTO.idEquipo = equipoValue.idEquipo;
      Provider.of<JugadoresProvider>(context, listen: false).save(jugadorDTO).then((value) {
        print(value);
        Provider.of<JugadoresProvider>(context, listen: false).getAll();
        Navigator.pop(context);
      });

    });
  }
}