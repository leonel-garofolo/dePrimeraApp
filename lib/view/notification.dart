import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/notificacionesProvider.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/component/fieldComboBox.dart';
import 'package:ag/view/component/fieldText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationMessages extends StatefulWidget {
  NotificationMessages({Key key}) : super(key: key);

  @override
  NotificationMessagesState createState() => NotificationMessagesState();
}

class NotificationMessagesState extends State<NotificationMessages> {

  List<AppGruposDTO> appGrupos;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NotificacionesProvider>().getAll());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificacionesProvider>(builder: (context, value, child) {
      Widget list;
      if(value.isLoading){
        list =  CircularProgress();
      } else {
        List<NotificacionDTO> notificaciones = value.notificaciones;
        if (notificaciones != null && notificaciones.isNotEmpty) {
          if (notificaciones.isNotEmpty) {
            list = ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: notificaciones.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Center(child: Text('${notificaciones[index].titulo}')),
                  subtitle: Center(
                      child: Text('${notificaciones[index].texto}')),
                  //onTap: () => editEntity(context, notificaciones[index]),
                );
              },
              separatorBuilder: (BuildContext context,
                  int index) => const Divider(),
            );
          } else {
            list = Container(
              child: Text("No se encontraron Datos"),
            );
          }
        }
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Notificaciones'),
        ),
        body: list,
        /*
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newEntity(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlueAccent,
        ),
         */
      );
    },);
  }

  editEntity(final BuildContext context, NotificacionDTO notificacionDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificacionesForm(notificationDTO: notificacionDTO, appGrupos: appGrupos,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificacionesForm(appGrupos: appGrupos)),
    );
  }
}


class NotificacionesForm extends StatefulWidget {
  NotificacionesForm({Key key, this.notificationDTO, this.appGrupos}) : super(key: key);

  final NotificacionDTO notificationDTO;
  final List<AppGruposDTO> appGrupos;
  @override
  NotificacionesFormState createState() => NotificacionesFormState();
}

class NotificacionesFormState extends State<NotificacionesForm>{
  final _formKey = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final texto = TextEditingController();
  AppGruposDTO appGrupoValue;

  @override
  Widget build(BuildContext context) {
    if(this.widget.notificationDTO != null){
      titulo.text = this.widget.notificationDTO.titulo;
      texto.text = this.widget.notificationDTO.texto;
      if(appGrupoValue == null)
        appGrupoValue = this.widget.notificationDTO.appGruposDTO;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Notificaciones"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FieldText(
                label: "Titulo",
                controller: titulo,
              ),
              FieldText(
                label: "Texto",
                controller: texto,
              ),
              FieldComboBox<AppGruposDTO>(
                label: "Grupo",
                itemValue: appGrupoValue,
                itemList: widget.appGrupos,
                onChange: onChangeAppGrupo,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    enviar();
                  },
                  child: const Text('Enviar',
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),),
    );
  }

  void onChangeAppGrupo(AppGruposDTO appGruposDTO) {
    setState(() {
      appGrupoValue = appGruposDTO;
    });
  }

  void enviar() async{
    final NotificacionDTO notificacionDTO = new NotificacionDTO();
    if(this.widget.notificationDTO != null){
      notificacionDTO.idNotificacion = this.widget.notificationDTO.idNotificacion;
    }
    notificacionDTO.titulo = titulo.text;
    notificacionDTO.texto = texto.text;
    notificacionDTO.idGrupo = appGrupoValue.idAppGrupos;
    Provider.of<NotificacionesProvider>(context).save(notificacionDTO).then((value) => print(value));
    Navigator.pop(context);
  }
}
