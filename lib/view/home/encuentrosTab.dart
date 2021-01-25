

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/home/encuentros/editPartidos.dart';
import 'package:ag/view/home/tabCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EncuentrosTab extends StatefulWidget{

  @override
  State createState() => EncuentrosTabStatus();
}

class EncuentrosTabStatus extends State<EncuentrosTab> {
  int day;
  int initPosition = 1;
  final List<Tab> tabs = new List<Tab>();

  @override
  void initState() {
    super.initState();
    tabs.add(new Tab(text: "Ayer",));
    tabs.add(new Tab(text: "Hoy",));
    tabs.add(new Tab(text: "Mañana",));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: tabs.length,
        tabBuilder: (context, index) => tabs[index],
        pageBuilder: (context, index){
          return getScreenFromMode(index);
        },
        onPositionChange: (index){
          if(index != null){
            initPosition = index;
          }
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  Widget getScreenFromMode(int index) {
    Widget screen;
    switch(index){
      case 0:
        this.day = -1;
        screen = getListPartido();
        break;
      case 1:
        this.day = 0;
        screen = getListPartido();
        break;
      case 2:
        this.day = 1;
        screen = getListPartido();
        break;
    }
    return screen;
  }

  getListPartido(){
    String sCurrentDate = buildCurrentDate();
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
                      partidoId: partidos[index].idPartidos,
                      partidosFromDateDTO: partidos[index],
                      championName: partidos[index].campeonatoName,
                      date: DateTime.now(),
                      localName: partidos[index].eLocalName,
                      localGoal:  partidos[index].resultadoLocal.toString(),
                      visitName:  partidos[index].eVisitName,
                      visitGoal: partidos[index].resultadoVisitante.toString(),
                      edit: openEditPartidos,
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

  String buildCurrentDate(){
    DateTime now = new DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day  + day);
    return"${currentDate.year.toString()}-${currentDate.month.toString().padLeft(2,'0')}-${currentDate.day.toString().padLeft(2,'0')}";
  }

  openEditPartidos(BuildContext context, PartidosFromDateDTO partido) async{
    String sCurrentDate = buildCurrentDate();
    bool received = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditPartidos(partidosFromDateDTO: partido,)
    ));
    if(received){
      Provider.of<PartidosProvider>(context).getForDate(sCurrentDate);
    }
  }
}