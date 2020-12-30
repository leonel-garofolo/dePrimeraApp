import 'package:ag/view/component/cardMenu.dart';
import 'package:ag/view/configuraciones/arbitros.dart';
import 'package:ag/view/configuraciones/asistentes.dart';
import 'package:ag/view/configuraciones/campeonatos.dart';
import 'package:ag/view/configuraciones/equipos.dart';
import 'package:ag/view/configuraciones/jugadores.dart';
import 'package:ag/view/configuraciones/ligas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int T_LIGAS = 1;
const int T_CAMPEONATOS = 2;
const int T_EQUIPOS = 3;
const int T_ARBITROS = 4;
const int T_ASISTENTES = 5;
const int T_JUGADORES = 6;

class Configuration extends StatefulWidget {
  Configuration({Key key}) : super(key: key);

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  List<String> configuracionNombre;
  @override
  void initState() {
    super.initState();
    configuracionNombre = new List<String>();
    configuracionNombre.add("Ligas");
    configuracionNombre.add("Campeonatos");
    configuracionNombre.add("Equipos");
    configuracionNombre.add("Arbitros");
    configuracionNombre.add("Asistentes");
    configuracionNombre.add("Jugadores");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Configuraciones"),
      ),
      body: new ListView.builder(
          itemCount: configuracionNombre.length,
          itemBuilder: (context, index) {
             return InkWell(
               onTap: () {
                 goWindows(context, index +1);
               },
               child: CardMenu(
                   title: configuracionNombre[index],
                   count: 2
               ),
             );
          },
      ),
    );
  }

  goWindows(BuildContext context, final int choice){
    Widget w;
    switch(choice){
      case T_LIGAS:
        w = LigasActivity();
        break;
      case T_CAMPEONATOS:
        w = CampeonatosActivity();
        break;
      case T_EQUIPOS:
        w = EquiposActivity();
        break;
      case T_ARBITROS:
        w = ArbitrosActivity();
        break;
      case T_ASISTENTES:
        w = AsistentesActivity();
        break;
      case T_JUGADORES:
        w = JugadoresActivity();
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => w),
    );
  }
}

