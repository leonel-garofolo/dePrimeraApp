

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ListPartidos extends StatelessWidget{
  ListPartidos(this.day);
  final int day;

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day  + day);
    String sCurrentDate = "${currentDate.year.toString()}-${currentDate.month.toString().padLeft(2,'0')}-${currentDate.day.toString().padLeft(2,'0')}";
    print("day: " + day.toString() + ": date" + sCurrentDate);

    return Center(
      child: FutureBuilder<List<PartidosFromDateDTO>>(
          future: Provider.of<PartidosProvider>(context).getForDate(sCurrentDate),
          builder: (BuildContext context, AsyncSnapshot<List<PartidosFromDateDTO>>  snapshot){
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