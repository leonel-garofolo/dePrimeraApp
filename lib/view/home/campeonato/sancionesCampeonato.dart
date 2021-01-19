

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SancionesCampeonatos extends StatefulWidget{
  final int campeonatoSelected;
  SancionesCampeonatos(this.campeonatoSelected);

  @override
  State<StatefulWidget> createState() => SancionesCampeonatosState();
}

class SancionesCampeonatosState extends State<SancionesCampeonatos>{

  @override
  void initState() {
    super.initState();
    Provider.of<CampeonatosProvider>(context, listen: false).getTableSanciones(this.widget.campeonatoSelected);
  }

  @override
  Widget build(BuildContext context) {
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

      return SingleChildScrollView(
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
      return Center(
        child: Text("No se encontraron datos"),
      );
    };
  }
}