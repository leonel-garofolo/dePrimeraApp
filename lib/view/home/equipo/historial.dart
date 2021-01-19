
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipoHistorial extends StatefulWidget{
  final int equipoSelected;
  EquipoHistorial(this.equipoSelected);

  @override
  EquipoHistorialState createState() => EquipoHistorialState();
  
}

class EquipoHistorialState extends State<EquipoHistorial>{
  @override
  void initState() {
    super.initState();
    Provider.of<PartidosProvider>(context, listen: false).getPartidosFromEquipo(this.widget.equipoSelected);
  }

  @override
  Widget build(BuildContext context) {
    final List<PartidosFromDateDTO> partidos = Provider.of<PartidosProvider>(context, listen: false).getPartidosView();
    if(partidos != null && partidos.isNotEmpty){
      return Center(
          child: new ListView.builder
        (
          itemCount: partidos.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return CardGame(
              championName: partidos[index].campeonatoName,
              date: DateTime.now(),
              localName: partidos[index].eLocalName,
              localGoal:  partidos[index].resultadoLocal.toString(),
              visitName:  partidos[index].eVisitName,
              visitGoal: partidos[index].resultadoVisitante.toString(),
            );
          }
      ));
    } else {
      return Center(
        child: Text("No se encontraron datos"),
      );
    }
  }
}