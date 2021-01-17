

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PosicionesCampeonatos extends StatelessWidget {
  PosicionesCampeonatos(this.campeonatoSelected);

  final int campeonatoSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<EquipoTablePosDTO>>(
          future: Provider.of<CampeonatosProvider>(context).getTablePosition(this.campeonatoSelected),
          builder: (BuildContext context, AsyncSnapshot<List<EquipoTablePosDTO>> snapshot){
            if(snapshot.hasData){
              List<EquipoTablePosDTO> equipos = snapshot.data;
              List<DataRow> dataRows = new List<DataRow>();
              equipos.forEach((equipo) {
                List<DataCell> dataCells = new List<DataCell>();
                dataCells.add(new DataCell(
                    Container(
                        width: 130, //SET width
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

              return DataTable(
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