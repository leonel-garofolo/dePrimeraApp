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
  LigasServices ligasServices;
  List<LigaDTO> ligas;

  @override
  void initState() {
    super.initState();
    ligasServices = new LigasServices();
  }

  @override
  Widget build(BuildContext context) {


    Widget list = ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ligas'),
      ),
      body: list,
    );
  }
}