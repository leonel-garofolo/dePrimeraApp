
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FixtureCampeonato extends StatelessWidget{
  FixtureCampeonato(this.campeonatoSelected);

  final int campeonatoSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<PartidosFromDateDTO>>(
          future: Provider.of<CampeonatosProvider>(context).getFixture(campeonatoSelected),
          builder: (BuildContext context, AsyncSnapshot<List<PartidosFromDateDTO>> snapshot){
            if(snapshot.hasData){
              List<PartidosFromDateDTO> partidos = snapshot.data;
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
            }
          }
      ),
    );
  }
}