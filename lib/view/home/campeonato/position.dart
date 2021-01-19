

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PosicionesCampeonatos extends StatefulWidget{
  PosicionesCampeonatos(this.campeonatoSelected);
  final int campeonatoSelected;

  @override
  State<StatefulWidget> createState() => PosicionesCampeonatosState();
}

class PosicionesCampeonatosState extends State<PosicionesCampeonatos>{

  @override
  void initState() {
    super.initState();
    Provider.of<CampeonatosProvider>(context, listen: false).getTablePosition(this.widget.campeonatoSelected);
  }

  @override
  Widget build(BuildContext context) {
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

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
      return Center(
        child: Text("No se encontraron datos"),
      );
    }
  }
}