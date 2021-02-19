

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/component/circularProgress.dart';
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
  int initPosition = 0;
  final List<Tab> tabs = new List<Tab>();
  final List<Encuentro> encuentros = new List<Encuentro>();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PartidosProvider>().callGetDates();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Consumer<PartidosProvider>(
        builder: (context, provider, child) {
          tabs.clear();
          List<Encuentro> encuentros = provider.encuentros;
          if(encuentros != null){
            if(encuentros.isNotEmpty){
              for(Encuentro e in encuentros){
                tabs.add(new Tab(text: e.day));
              }
              return SafeArea(
                child: CustomTabView(
                  initPosition: initPosition,
                  itemCount: tabs.length,
                  tabBuilder: (context, index) => tabs[index],
                  pageBuilder: (context, index){
                    return getListPartido(encuentros[index].partidos);
                  },
                  onPositionChange: (index){
                    if(index != null){
                      initPosition = index;
                    }
                  },
                  onScroll: (position) => print('$position'),
                ),
              );
            } else {
              return Center(
                child: Text("No se encontraron datos"),
              );
            }
          }
          return CircularProgress();
        });

    if(widget == null){
      return CircularProgress();
    }
    return widget;
  }

  Widget getScreenFromMode(int index) {
    Widget screen;
    /*
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
     */
    return screen;
  }

  getListPartido(List<PartidosFromDateDTO> partidos){
    if(partidos != null && partidos.isNotEmpty){
      return Center(
        child: ListView.builder
          (
            itemCount: partidos.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return CardGame(
                partidoId: partidos[index].idPartidos,
                partidosFromDateDTO: partidos[index],
                championName: partidos[index].campeonatoName,
                date: DateTime.parse(partidos[index].fechaEncuentro),
                localName: partidos[index].eLocalName,
                localGoal: partidos[index].resultadoLocal.toString(),
                visitName: partidos[index].eVisitName,
                visitGoal: partidos[index].resultadoVisitante.toString(),
                showDate: false,
                edit: openEditPartidos,
              );
            }
        ),
      );
    } else {
      return Center(
        child: Text("No se encontraron datos"),
      );
    }


    /*
    return Center(
      child: FutureBuilder<List<PartidosFromDateDTO>>(
          future: ,
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
     */
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