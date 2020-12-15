import 'package:ag/view/configuraciones/arbitros.dart';
import 'package:ag/view/configuraciones/asistentes.dart';
import 'package:ag/view/configuraciones/campeonatos.dart';
import 'package:ag/view/configuraciones/equipos.dart';
import 'package:ag/view/configuraciones/jugadores.dart';
import 'package:ag/view/configuraciones/ligas.dart';
import 'package:ag/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Configuration extends StatefulWidget {
  Configuration({Key key}) : super(key: key);

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Configuraciones"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget>[
          itemWindows(context, new ChoiceWindows(
            title: "Ligas",
            type: 1,
          )),
          itemWindows(context, const ChoiceWindows(
              title: "Equipos",
              type: T_EQUIPOS
          )),
          itemWindows(context, new ChoiceWindows(
              title: "Campeonatos",
              type: T_CAMPEONATOS
          )),
          itemWindows(context, new ChoiceWindows(
              title: "Arbitros",
              type: T_ARBITROS
          )),
          itemWindows(context, new ChoiceWindows(
              title: "Asistentes",
              type: T_ASISTENTES
          )),
          itemWindows(context, new ChoiceWindows(
              title: "Jugadores",
              type: T_JUGADORES
          ))
        ],
      ),
    );
  }

  Widget itemWindows(BuildContext context, final ChoiceWindows choice){
    return InkWell(
      onTap: () => {
        goWindows(context, choice)
    }, // handle your onTap here
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
          child: Text(choice.title),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
            top: Radius.circular(10),
          ),
          boxShadow: [
            // to make elevation
            BoxShadow(
              color: Colors.black45,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }

  goWindows(BuildContext context, final ChoiceWindows choice){
    Widget w;
    switch(choice.type){
      case T_LIGAS:
        w = LigasActivity();
        break;
      case T_EQUIPOS:
        w = EquiposActivity();
        break;
      case T_CAMPEONATOS:
        w = CampeonatosActivity();
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


const int T_LIGAS = 1;
const int T_EQUIPOS = 2;
const int T_CAMPEONATOS = 3;
const int T_ARBITROS = 4;
const int T_ASISTENTES = 5;
const int T_JUGADORES = 6;

class ChoiceWindows {
  const ChoiceWindows({this.title, this.type});

  final String title;
  final int type;
}