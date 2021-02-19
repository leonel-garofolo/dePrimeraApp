
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/home/encuentros/editPartidos.dart';
import 'package:ag/view/home/tabCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampeonatoTab extends StatefulWidget{
  CampeonatoTab({Key key, this.campeonatoSelected}) : super(key: key);
  final int campeonatoSelected;

  @override
  State<StatefulWidget> createState()  => CampeonatoTabState();
}

class CampeonatoTabState extends State<CampeonatoTab>{
  int initPosition = 0;
  final List<Tab> tabs = new List<Tab>();
  @override
  void initState() {
    super.initState();
    tabs.add(new Tab(text: "Fixture",));
    tabs.add(new Tab(text: "Posiciones",));
    tabs.add(new Tab(text: "Sanciones",));
    tabs.add(new Tab(text: "Goleadores",));
    initLoad();
  }

  initLoad(){
    Future.microtask(() {
      CampeonatosProvider provider =context.read<CampeonatosProvider>();
      provider.getFixture(this.widget.campeonatoSelected);
      provider.getTablePosition(this.widget.campeonatoSelected);
      provider.getTableSanciones(this.widget.campeonatoSelected);
      provider.getTableGoleadores(this.widget.campeonatoSelected);
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
              print('current position: $index');
              initPosition = index;
            }
          },
          onScroll: (position) => print('$position'),
    ));
  }

  Widget getScreenFromMode(int index) {
    Widget widget;
    switch(index){
      case 0:
        final List<PartidosFromDateDTO> partidos = Provider.of<CampeonatosProvider>(context, listen: false).getPartidos();
        if(partidos != null && partidos.isNotEmpty){
          widget = new ListView.builder
            (
              itemCount: partidos.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return CardGame(
                  partidoId: partidos[index].idPartidos,
                  partidosFromDateDTO: partidos[index],
                  championName: partidos[index].campeonatoName,
                  date: DateTime.parse(partidos[index].fechaEncuentro),
                  localName: partidos[index].eLocalName,
                  localGoal:  partidos[index].resultadoLocal.toString(),
                  visitName:  partidos[index].eVisitName,
                  visitGoal: partidos[index].resultadoVisitante.toString(),
                  showDate: true,
                  edit: openEditPartidos,
                );
              }
          );
        } else {
          widget = Center(
            child: Text("No se encontraron datos"),
          );
        }
        break;
      case 1:
        final List<EquipoTablePosDTO> equipos = Provider.of<CampeonatosProvider>(context, listen: false).getEquipos();
        if(equipos != null && equipos.isNotEmpty){

          List<DataRow> dataRows = new List<DataRow>();
          equipos.forEach((equipo) {
            List<DataCell> dataCells = new List<DataCell>();
            dataCells.add(new DataCell(
                Container(
                    width: 150, //SET width
                    child: Text(equipo.nombre)
                )
            )
            );

            dataCells.add(new DataCell(Text(equipo.puntos.toString())));
            dataCells.add(new DataCell(Text(equipo.partidosGanados.toString())));
            dataCells.add(new DataCell(Text(equipo.partidosEmpatados.toString())));
            dataCells.add(new DataCell(Text(equipo.partidosPerdidos.toString())));

            dataRows.add(new DataRow(cells: dataCells));
          });

          widget= SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
                columnSpacing: 30.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Equipo',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'Pts',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'PG',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'PE',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'PP',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: dataRows
            ),
          );
        } else {
          widget= Center(
            child: Text("No se encontraron datos"),
          );
        }
        break;
      case 2:
        final List<SancionesJugadoresFromCampeonatoDTO> sancionesJugadores = Provider.of<CampeonatosProvider>(context, listen: false).getSancionesJugadores();
        if(sancionesJugadores != null && sancionesJugadores.isNotEmpty){
          List<DataRow> dataRows = new List<DataRow>();
          sancionesJugadores.forEach((sancion) {
            List<DataCell> dataCells = new List<DataCell>();
            dataCells.add(new DataCell(
                Container(
                    width: 130, //SET width
                    child: Text(sancion.apellido + " " + sancion.nombre)
                )
            )
            );

            dataCells.add(new DataCell(
                Container(
                    width: 130, //SET width
                    child: Text(sancion.eNombre)
                )
            )
            );

            dataCells.add(new DataCell(
                Container(//SET width
                    child: Text(sancion.cRojas.toString())
                )

            )
            );
            dataCells.add(new DataCell(Text(sancion.cAmarillas.toString())));
            dataCells.add(new DataCell(Text(sancion.cAzules.toString())));

            dataRows.add(new DataRow(cells: dataCells));
          });

          widget= SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columnSpacing: 5.0,
                columns: const <DataColumn>[
                  DataColumn(
                    numeric: false,
                    label: Text(
                      'Nombre',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: false,
                    label: Text(
                      'Equipo',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'R',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'Ama',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'Azu',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: dataRows
            ),
          );
        } else {
          widget= Center(
            child: Text("No se encontraron datos"),
          );
        }
        break;
      case 3:
        final List<CampeonatosGoleadoresDTO> goleadores = Provider.of<CampeonatosProvider>(context, listen: false).getGoleadores();
        if(goleadores != null && goleadores.isNotEmpty){
          List<DataRow> dataRows = new List<DataRow>();
          goleadores.forEach((goleador) {
            List<DataCell> dataCells = new List<DataCell>();
            dataCells.add(new DataCell(
                Container(
                    width: 130, //SET width
                    child: Text(goleador.apellido + " " + goleador.nombre)
                )
            )
            );

            dataCells.add(new DataCell(
                Container(
                    width: 130, //SET width
                    child: Text(goleador.equipo)
                )
            )
            );

            dataCells.add(new DataCell(
                Container(//SET width
                    child: Text(goleador.goles.toString())
                )

            )
            );

            dataRows.add(new DataRow(cells: dataCells));
          });

          widget= SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columnSpacing: 5.0,
                columns: const <DataColumn>[
                  DataColumn(
                    numeric: false,
                    label: Text(
                      'Nombre',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: false,
                    label: Text(
                      'Equipo',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'Goles',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: dataRows
            ),
          );
        } else {
          widget= Center(
            child: Text("No se encontraron datos"),
          );
        }
        break;
    }
    return widget;
  }

  openEditPartidos(BuildContext context, PartidosFromDateDTO partidosFromDateDTO) async{
    bool received = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditPartidos(partidosFromDateDTO: partidosFromDateDTO,)
    ));
    if(received!= null && received){
      initLoad();
    }
  }
}