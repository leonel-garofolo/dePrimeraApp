import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/PersonasProvider.dart';
import 'package:ag/providers/asistentesProvider.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/paisesProvider.dart';
import 'package:ag/providers/provinciasProvider.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldNumber.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/component/withoutData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AsistentesActivity extends StatefulWidget {
  AsistentesActivity({Key key}) : super(key: key);

  @override
  AsistentesActivityState createState() => AsistentesActivityState();
}

class AsistentesActivityState extends State<AsistentesActivity> {

  List<PaisDTO> paises;
  List<ProvinciaDTO> provincias;
  List<CampeonatoDTO> campeonatos;

  @override
  void initState() {
    super.initState();
    Provider.of<PaisesProvider>(context, listen: false).getAll();
    Provider.of<ProvinciasProvider>(context, listen: false).getAll();
    Provider.of<CampeonatosProvider>(context, listen: false).getAll();
    Provider.of<PersonasProvider>(context, listen: false).getAll();
    Provider.of<AsistentesProvider>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    paises = Provider.of<PaisesProvider>(context).getPaises();
    provincias = Provider.of<ProvinciasProvider>(context).getProvincias();
    campeonatos = Provider.of<CampeonatosProvider>(context).getCampeonatos();
    List<PersonaDTO> personas = Provider.of<PersonasProvider>(context).getPersonas();
    List<AsistenteDTO> asistentes = Provider.of<AsistentesProvider>(context).getAsistentes();

    Widget list = CircularProgress();
    if(asistentes != null){
      if(asistentes.isNotEmpty) {
        if(personas != null && personas.isNotEmpty) {
          for (AsistenteDTO asistente in asistentes) {
            for (PersonaDTO persona in personas) {
              if (asistente.idPersona == persona.idPersona) {
                asistente.personaDTO = persona;
                for(PaisDTO pais in paises){
                  if(asistente.personaDTO.idPais == pais.idPais){
                    asistente.personaDTO.paisDTO = pais;

                    for(ProvinciaDTO prov in provincias){
                      if(asistente.personaDTO.idPais == prov.idPais &&
                          asistente.personaDTO.idProvincia == prov.idProvincia){
                        asistente.personaDTO.provinciaDTO = prov;
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

          if(campeonatos != null && campeonatos.isNotEmpty) {
            for (AsistenteDTO asistente in asistentes) {
              for (CampeonatoDTO campeonato in campeonatos) {
                if (asistente.idCampeonato == campeonato.idCampeonato) {
                  asistente.campeonatoDTO = campeonato;
                  break;
                }
              }
            }
          }

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
      } else {
        list = WithoutData();
      }
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
  }

  editEntity(final BuildContext context, AsistenteDTO asistenteDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AsistentesForm(
        paises: paises,
        provincias: provincias,
        campeonatosDTO: campeonatos,
        asistenteDTO: asistenteDTO,
      )),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AsistentesForm(
          paises: paises,
          provincias: provincias,
          campeonatosDTO: campeonatos)),
    );
  }
}

class AsistentesForm extends StatefulWidget {
  AsistentesForm({Key key,
    this.paises,
    this.provincias,
    this.campeonatosDTO,
    this.asistenteDTO}) : super(key: key);

  final List<PaisDTO> paises;
  final List<ProvinciaDTO> provincias;
  final List<CampeonatoDTO> campeonatosDTO;
  final AsistenteDTO asistenteDTO;
  @override
  AsistentesFormState createState() => AsistentesFormState();
}

class AsistentesFormState extends State<AsistentesForm>{
  final _formKey = GlobalKey<FormState>();

  PaisDTO paisValue;
  ProvinciaDTO provinciaValue;
  CampeonatoDTO campeonatoValue;

  final apellidoNombre = TextEditingController();
  final domicilio = TextEditingController();
  final edad = TextEditingController();
  final idLiga = TextEditingController();
  final idLocalidad = TextEditingController();
  final idTipoDoc = TextEditingController();
  final nroDoc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.asistenteDTO != null){
      apellidoNombre.text = this.widget.asistenteDTO.personaDTO.apellidoNombre;
      domicilio.text = this.widget.asistenteDTO.personaDTO.domicilio;
      edad.text = this.widget.asistenteDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.asistenteDTO.personaDTO.localidad;
      if(paisValue == null)
        paisValue = this.widget.asistenteDTO.personaDTO.paisDTO;
      if(provinciaValue== null)
        provinciaValue = this.widget.asistenteDTO.personaDTO.provinciaDTO;

      idTipoDoc.text = this.widget.asistenteDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.asistenteDTO.personaDTO.nroDoc.toString();
      if(campeonatoValue == null)
        campeonatoValue = this.widget.asistenteDTO.campeonatoDTO;

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
              FieldComboBox<CampeonatoDTO>(
                label: "Campeonato",
                itemValue: campeonatoValue,
                itemList: widget.campeonatosDTO,
                onChange: onChangeCampeonato,
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

  void onChangeCampeonato(CampeonatoDTO newCampeonato){
    setState(() {
      campeonatoValue = newCampeonato;
    });
  }

  save() async{
    final AsistenteDTO asistenteDTO = new AsistenteDTO();
    final PersonaDTO personaDTO = new PersonaDTO(
        apellidoNombre: apellidoNombre.text,
        idTipoDoc: int.parse(idTipoDoc.text),
        nroDoc: int.parse(nroDoc.text),
        domicilio: domicilio.text,
        edad: int.parse(edad.text),
        idPais: paisValue.idPais,
        idProvincia: provinciaValue.idProvincia,
        localidad: idLocalidad.text
    );

    if(this.widget.asistenteDTO != null){
      if(this.widget.asistenteDTO.idPersona != null){
        personaDTO.idPersona = this.widget.asistenteDTO.idPersona;
      }
      if(this.widget.asistenteDTO.idAsistente != null){
        asistenteDTO.idAsistente = this.widget.asistenteDTO.idAsistente;
      }
    }

    Provider.of<PersonasProvider>(context, listen: false).save(personaDTO).then((value){
      asistenteDTO.idPersona = int.parse(value);
      asistenteDTO.idCampeonato = campeonatoValue.idCampeonato;
      Provider.of<AsistentesProvider>(context, listen: false).save(asistenteDTO).then((value) {
        print(value);
        Provider.of<AsistentesProvider>(context, listen: false).getAll();
        Navigator.pop(context);
      });

    });
  }
}