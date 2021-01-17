

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SancionesCampeonatos extends StatelessWidget{
  SancionesCampeonatos(this.campeonatoSelected);
  final int campeonatoSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<SancionesJugadoresFromCampeonatoDTO>>(
          future: Provider.of<CampeonatosProvider>(context).getTableSanciones(campeonatoSelected),
          builder: (BuildContext context, AsyncSnapshot<List<SancionesJugadoresFromCampeonatoDTO>> snapshot){
            if(snapshot.hasData){
              List<SancionesJugadoresFromCampeonatoDTO> sanciones = snapshot.data;
              List<DataRow> dataRows = new List<DataRow>();
              sanciones.forEach((sancion) {
                List<DataCell> dataCells = new List<DataCell>();
                dataCells.add(new DataCell(
                    Container(
                        width: 60, //SET width
                        child: Text(sancion.apellido + " " + sancion.nombre)
                    )
                )
                );

                dataCells.add(new DataCell(
                    Container(
                        width: 60, //SET width
                        child: Text(sancion.eNombre)
                    )
                )
                );

                dataCells.add(new DataCell(
                    Container(
                        width: 10, //SET width
                        child: Text(sancion.cRojas.toString())
                    )

                )
                );
                dataCells.add(new DataCell(Text(sancion.cAmarillas.toString())));
                dataCells.add(new DataCell(Text(sancion.cAzules.toString())));

                dataRows.add(new DataRow(cells: dataCells));
              });

              return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Nombre',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Equipo',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        'Rojas',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        'Amarillas',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        'Azules',
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