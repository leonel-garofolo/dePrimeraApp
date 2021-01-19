

import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/equiposProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquipoPlantel extends StatefulWidget{
  final int equipoSelected;
  EquipoPlantel(this.equipoSelected);

  @override
  EquipoPlantelState createState() => EquipoPlantelState();
}

class EquipoPlantelState extends State<EquipoPlantel> {

  @override
  void initState() {
    super.initState();
    Provider.of<EquiposProvider>(context, listen: false).getPlantel(this.widget.equipoSelected);
  }

  @override
  Widget build(BuildContext context) {
    final List<JugadorPlantelDTO> jugadores =Provider.of<EquiposProvider>(context, listen: false).getJugadores();
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

      return SingleChildScrollView(
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
      return Center(
        child: Text("No se encontraron datos"),
      );
    }
  }
}