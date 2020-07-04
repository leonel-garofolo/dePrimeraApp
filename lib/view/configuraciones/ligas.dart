import 'package:ag/services/ligasService.dart';
import 'package:ag/services/model/dtos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LigasForm extends StatefulWidget {
  LigasForm({Key key}) : super(key: key);

  @override
  _LigasFormState createState() => _LigasFormState();
}

final List<String> entries = <String>['A', 'B', 'C'];

class _LigasFormState extends State<LigasForm> {

  @override
  void initState() {
    super.initState();
  }

  Future<List<LigaDTO>> getLigas() async{
    final LigasServices ligasServices= new LigasServices();
    List<LigaDTO> ligas = await ligasServices.getAll();
    return ligas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LigaDTO>>(
       future: getLigas(),
       builder: (context, snapshot) {

      Widget list = Container(
        child: Text("cargando"),
      );

      if(snapshot.data != null && snapshot.data.isNotEmpty){
        list= ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(child: Text('Entry ${snapshot.data[index].nombre}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Ligas'),
        ),
        body: list,
      );
    });
  }
}