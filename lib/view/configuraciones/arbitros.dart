import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/PersonasProvider.dart';
import 'package:ag/providers/arbitrosProvider.dart';
import 'package:ag/providers/campeonatosProvider.dart';
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


class ArbitrosActivity extends StatefulWidget {
  ArbitrosActivity({Key key}) : super(key: key);

  @override
  ArbitrosActivityState createState() => ArbitrosActivityState();
}

class ArbitrosActivityState extends State<ArbitrosActivity> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArbitrosProvider>(builder: (context, value, child) {
      Widget widget;
      if(value.isLoading){
        widget = CircularProgress();
      } else {
        paises = Provider.of<PaisesProvider>(context).getPaises();
        provincias = Provider.of<ProvinciasProvider>(context).getProvincias();
        campeonatos = Provider.of<CampeonatosProvider>(context).getCampeonatos();
        List<PersonaDTO> personas = Provider.of<PersonasProvider>(context).getPersonas();
        List<ArbitroDTO> arbitros = value.arbitros;

        if(arbitros != null && arbitros.isNotEmpty) {
          if(personas != null && personas.isNotEmpty) {
            for (ArbitroDTO arbitro in arbitros) {
              for (PersonaDTO persona in personas) {
                if (arbitro.idPersona == persona.idPersona) {
                  arbitro.personaDTO = persona;
                  for(PaisDTO pais in paises){
                    if(arbitro.personaDTO.idPais == pais.idPais){
                      arbitro.personaDTO.paisDTO = pais;

                      for(ProvinciaDTO prov in provincias){
                        if(arbitro.personaDTO.idPais == prov.idPais &&
                            arbitro.personaDTO.idProvincia == prov.idProvincia){
                          arbitro.personaDTO.provinciaDTO = prov;
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
              for (ArbitroDTO arbitro in arbitros) {
                for (CampeonatoDTO campeonato in campeonatos) {
                  if (arbitro.idCampeonato == campeonato.idCampeonato) {
                    arbitro.campeonatoDTO = campeonato;
                    break;
                  }
                }
              }
            }

            widget= ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: arbitros.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('${arbitros[index].personaDTO.nombre}')),
                  subtitle: Center(child: Text('${arbitros[index].personaDTO.idTipoDoc.toString() + " - " +  arbitros[index].personaDTO.nroDoc.toString()}')),
                  onTap: () => editEntity(context, arbitros[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }
        } else {
          widget = WithoutData();
        }
      }


      return Scaffold(
        appBar: AppBar(
          title: const Text('Arbitros'),
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

    } ,);


  }

  editEntity(final BuildContext context, ArbitroDTO arbitroDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArbitrosForm(
          paises: paises,
          provincias: provincias,
          campeonatosDTO: campeonatos,
        arbitroDTO: arbitroDTO,
      )),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArbitrosForm(
          paises: paises,
          provincias: provincias,
          campeonatosDTO: campeonatos)),
    );
  }
}

class ArbitrosForm extends StatefulWidget {
  ArbitrosForm({Key key,
    this.paises,
    this.provincias,
    this.campeonatosDTO,
    this.arbitroDTO}) : super(key: key);

  final List<PaisDTO> paises;
  final List<ProvinciaDTO> provincias;
  final List<CampeonatoDTO> campeonatosDTO;
  final ArbitroDTO arbitroDTO;
  @override
  ArbitrosFormState createState() => ArbitrosFormState();
}

class ArbitrosFormState extends State<ArbitrosForm>{
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
    if(this.widget.arbitroDTO != null){
      apellidoNombre.text = this.widget.arbitroDTO.personaDTO.nombre;
      domicilio.text = this.widget.arbitroDTO.personaDTO.domicilio;
      edad.text = this.widget.arbitroDTO.personaDTO.edad.toString();
      idLocalidad.text = this.widget.arbitroDTO.personaDTO.localidad;
      if(paisValue == null)
        paisValue = this.widget.arbitroDTO.personaDTO.paisDTO;
      if(provinciaValue== null)
        provinciaValue = this.widget.arbitroDTO.personaDTO.provinciaDTO;

      idTipoDoc.text = this.widget.arbitroDTO.personaDTO.idTipoDoc.toString();
      nroDoc.text = this.widget.arbitroDTO.personaDTO.nroDoc.toString();
      if(campeonatoValue == null)
        campeonatoValue = this.widget.arbitroDTO.campeonatoDTO;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.arbitroDTO != null? this.widget.arbitroDTO.personaDTO.nombre : "Nuevo Arbitro"}"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<ArbitrosProvider>(context, listen: false).delete(widget.arbitroDTO.idArbitro);
              Provider.of<ArbitrosProvider>(context, listen: false).getAll();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
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

  void onChangeCampeonato(CampeonatoDTO newCampeonato){
    setState(() {
      campeonatoValue = newCampeonato;
    });
  }

  save() async{
    final ArbitroDTO arbitroDTO = new ArbitroDTO();
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
    
    if(this.widget.arbitroDTO != null){
      if(this.widget.arbitroDTO.idPersona != null){
        personaDTO.idPersona = this.widget.arbitroDTO.idPersona;
      }
      if(this.widget.arbitroDTO.idArbitro != null){
        arbitroDTO.idArbitro = this.widget.arbitroDTO.idArbitro;
      }
    }
    
    Provider.of<PersonasProvider>(context, listen: false).save(personaDTO).then((value){
      arbitroDTO.idPersona = int.parse(value);
      arbitroDTO.idCampeonato = campeonatoValue.idCampeonato;
      Provider.of<ArbitrosProvider>(context, listen: false).save(arbitroDTO).then((value) {
        print(value);
        Provider.of<ArbitrosProvider>(context, listen: false).getAll();
        Navigator.pop(context);
      });

    });
  }
}