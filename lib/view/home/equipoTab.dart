import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/equiposProvider.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/component/circularProgress.dart';
import 'package:ag/view/home/tabCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipoTab extends StatefulWidget{
  final int equipoSelected;
  EquipoTab({Key key, this.equipoSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => EquipoTabStatus();
}

class EquipoTabStatus extends State<EquipoTab>{
  int initPosition = 0;
  final List<Tab> tabs = new List<Tab>();

  @override
  void initState() {
    super.initState();
    tabs.add(new Tab(text: "Campana",));
    tabs.add(new Tab(text: "Plantel",));
    Future.microtask(() {
      context.read<PartidosProvider>().getPartidosFromEquipo(this.widget.equipoSelected);
      context.read<EquiposProvider>().getPlantel(this.widget.equipoSelected);
    });
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
        ));
  }

  Widget getScreenFromMode(int index) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Consumer<PartidosProvider>(
            builder: (context, provider, child) {
              final List<PartidosFromDateDTO> partidos = provider.partidosView;
              Widget widgetTab;
              if(provider.isLoading){
                widgetTab = CircularProgressIndicator();
              } else {
                if(partidos != null && partidos.isNotEmpty){
                  widgetTab = new ListView.builder
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
                  widgetTab = Text("No se encontraron datos");
                }
              }

              return Scaffold(
                body: Center(
                  child: widgetTab,
                ),
              );
            }
        );
        break;
      case 1:
        widget = Consumer<EquiposProvider>(
            builder: (context, provider, child) {
              final List<JugadorPlantelDTO> jugadores = provider.jugadores;
              Widget widgetTab;
              if(provider.isLoading){
                widgetTab = CircularProgress();
              } else {
                if(jugadores !=null && jugadores.isNotEmpty){
                  List<DataRow> dataRows = new List<DataRow>();
                  jugadores.forEach((jugador) {
                    List<DataCell> dataCells = new List<DataCell>();
                    dataCells.add(new DataCell(
                        Container(
                            width: 150, //SET width
                            child: Text(jugador.apellido + ' ' + jugador.nombre)
                        )
                    )
                    );

                    dataCells.add(new DataCell(Text(jugador.nroCamiseta.toString())));
                    dataRows.add(new DataRow(cells: dataCells));
                  });

                  widgetTab = SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columnSpacing: 30.0,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Jugador',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            numeric: true,
                            label: Text(
                              'Nro',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: dataRows
                    ),
                  );
                } else {
                  widgetTab = Center(
                    child: Text("No se encontraron datos"),
                  );
                }
              }
              return Scaffold(
                body: widgetTab,
              );
            });
        break;
    }
    return widget;
  }
}