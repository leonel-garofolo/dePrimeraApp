
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FixtureCampeonato extends StatefulWidget{
  FixtureCampeonato(this.campeonatoSelected);
  final int campeonatoSelected;

  @override
  State<StatefulWidget> createState() => FixtureCampeonatoState();
}

class FixtureCampeonatoState extends State<FixtureCampeonato>{

  @override
  void initState() {
    super.initState();
    Provider.of<CampeonatosProvider>(context, listen: false).getFixture(this.widget.campeonatoSelected);
  }

  @override
  Widget build(BuildContext context) {
    final List<PartidosFromDateDTO> partidos = Provider.of<CampeonatosProvider>(context, listen: false).getPartidos();
    if(partidos != null && partidos.isNotEmpty){
      return new ListView.builder
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
      );
    } else {
      return Center(
        child: Text("No se encontraron datos"),
      );
    };
  }
}