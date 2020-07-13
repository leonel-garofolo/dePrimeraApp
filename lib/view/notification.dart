import 'package:ag/services/notificacionesService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:ag/view/component/fieldView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationMessages extends StatefulWidget {
  NotificationMessages({Key key}) : super(key: key);

  @override
  NotificationMessagesState createState() => NotificationMessagesState();
}

class NotificationMessagesState extends State<NotificationMessages> {
  final notificacionesServices = new NotificacionesServices();
  List<NotificacionDTO> notificaciones;
  @override
  void initState() {
    super.initState();
  }

  loadNotificaciones() async{
    notificaciones = await notificacionesServices.getAll();
    print(notificaciones);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadNotificaciones(),
        builder: (BuildContext context, AsyncSnapshot<void>  snapshot) {
          Widget list = Container(
            child: Text("Cargando"),
          );

          if(notificaciones != null && notificaciones.isNotEmpty){
            if(notificaciones.isNotEmpty){
              list= ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: notificaciones.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Center(child: Text('${notificaciones[index].titulo}')),
                    subtitle: Center(child: Text('${notificaciones[index].texto}')),
                    onTap: () => editEntity(context, notificaciones[index]),
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
              title: const Text('Notificaciones'),
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

  editEntity(final BuildContext context, NotificacionDTO notificacionDTO){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificacionesForm(notificationDTO: notificacionDTO,)),
    );
  }

  newEntity(final BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificacionesForm()),
    );
  }
}


class NotificacionesForm extends StatefulWidget {
  NotificacionesForm({Key key, this.notificationDTO}) : super(key: key);

  final NotificacionDTO notificationDTO;
  @override
  NotificacionesFormState createState() => NotificacionesFormState();
}

class NotificacionesFormState extends State<NotificacionesForm>{
  final _formKey = GlobalKey<FormState>();
  final NotificacionesServices notificacionesServices = new NotificacionesServices();

  final titulo = TextEditingController();
  final texto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(this.widget.notificationDTO != null){
      titulo.text = this.widget.notificationDTO.titulo;
      texto.text = this.widget.notificationDTO.texto;

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

  void enviar() async{
    final NotificacionDTO notificacionDTO = new NotificacionDTO();
    if(this.widget.notificationDTO != null){
      notificacionDTO.idNotificacion = this.widget.notificationDTO.idNotificacion;
    }
    notificacionDTO.titulo = titulo.text;
    notificacionDTO.texto = texto.text;
    notificacionDTO.idGrupo = 1;
    await notificacionesServices.save(notificacionDTO);
    Navigator.pop(context);
  }
}
