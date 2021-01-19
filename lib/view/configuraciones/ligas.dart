import 'package:ag/providers/ligaProvider.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:ag/view/component/saveButton.dart';
import 'package:ag/view/component/withoutData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LigasActivity extends StatefulWidget {
  LigasActivity({Key key}) : super(key: key);

  @override
  LigasActivityState createState() => LigasActivityState();
}

bool _deleteMode;
class LigasActivityState extends State<LigasActivity> {
  List<LigaDTO> ligas;

  @override
  void initState() {
    super.initState();
    _deleteMode = false;
    Provider.of<LigaProvider>(context, listen: false).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LigaProvider>(
      builder: (context, liga, child) {
        Widget list;
        if(liga.isLoading){
          list =  CircularProgress();
        } else {
          ligas= liga.ligas;
          Widget deleteModeWidget = Container();

          if(ligas != null){
            if(ligas.isNotEmpty){
              list= ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: ligas.length,
                itemBuilder: (BuildContext context, int index) {
                  if(_deleteMode){
                    deleteModeWidget =Checkbox(
                        value: ligas[index].deleteSelected,
                        onChanged: (newValue){
                          setState(() {
                            ligas[index].deleteSelected = newValue;
                            print(ligas[index].deleteSelected);
                          });
                        });
                  } else {
                    deleteModeWidget = Container();
                  }

                  return InkWell(
                    onTap: () => editEntity(context, ligas[index]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(margin: EdgeInsets.only(left: 10, top: 5), child: Text('${ligas[index].nombre}', style: TextStyle(fontSize: 20),)),
                            Container(child: Text('${ligas[index].cuit}', style: TextStyle(fontSize: 12),))
                          ],
                        ),
                        deleteModeWidget

                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
            } else {
              list = WithoutData();
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Ligas'),
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
      },
    );

  }

  editEntity(final BuildContext context, LigaDTO ligaDTO){
    print(ligaDTO.nombre);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LigasForm(ligaDTO: ligaDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LigasForm()),
    );
  }
}

class LigasForm extends StatefulWidget {
  LigasForm({Key key, this.ligaDTO}) : super(key: key);

  final LigaDTO ligaDTO;
  @override
  LigasFormState createState() => LigasFormState();
}

class LigasFormState extends State<LigasForm>{
  final _formKey = GlobalKey<FormState>();

  final nombre = TextEditingController();
  final cuit = TextEditingController();
  final domicilio = TextEditingController();
  final nombreContacto = TextEditingController();
  final telefonoContacto = TextEditingController();
  final telefono = TextEditingController();
  final mailContacto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.ligaDTO != null){
      nombre.text = this.widget.ligaDTO.nombre;
      cuit.text = this.widget.ligaDTO.cuit;
      domicilio.text = this.widget.ligaDTO.domicilio;
      nombreContacto.text = this.widget.ligaDTO.nombreContacto;
      telefonoContacto.text = this.widget.ligaDTO.telefonoContacto;
      telefono.text = this.widget.ligaDTO.telefono;
      mailContacto.text = this.widget.ligaDTO.mailContacto;
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${this.widget.ligaDTO != null? this.widget.ligaDTO.nombre : "Nueva Liga"}"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<LigaProvider>(context, listen: false).delete(widget.ligaDTO.idLiga);
              Provider.of<LigaProvider>(context, listen: false).getAll();
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
            FieldText(
              label: "Cuit",
              controller: cuit,
            ),
            FieldText(
              label: "Domicilio",
              controller: domicilio,
            ),
            FieldText(
              label: "Nombre Contacto",
              controller: nombreContacto,
            ),
            FieldText(
              label: "Mail Contacto",
              controller: mailContacto,
            ),
            FieldText(
              label: "Telefono",
              controller: telefono,
            ),
            FieldText(
              label: "Telefono Contacto",
              controller: telefonoContacto,
            ),
            Container(height: 10,),
            ButtonRequest(
                text: "Guardar",
                onPressed: () {
                  save();
                }
            )
          ],
        ),
      ),),
    );
  }

  save() {
    final LigaDTO ligaDTO = new LigaDTO();
    if(this.widget.ligaDTO != null){
      ligaDTO.idLiga = this.widget.ligaDTO.idLiga;
    }
    ligaDTO.nombre = nombre.text;
    ligaDTO.cuit = cuit.text;
    ligaDTO.domicilio = domicilio.text;
    ligaDTO.nombreContacto = nombreContacto.text;
    ligaDTO.mailContacto = mailContacto.text;
    ligaDTO.telefono = telefono.text;
    ligaDTO.telefonoContacto = telefonoContacto.text;
    Provider.of<LigaProvider>(context, listen: false).save(ligaDTO).then((value) {
      Provider.of<LigaProvider>(context, listen: false).getAll();
      Navigator.pop(context);
    });

  }
}