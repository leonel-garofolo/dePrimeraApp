import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/equiposProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/authentication/login.dart';
import 'package:ag/view/configuration.dart';
import 'package:ag/view/home/campeonato/fixture.dart';
import 'package:ag/view/home/campeonato/position.dart';
import 'package:ag/view/home/campeonato/sancionesCampeonato.dart';
import 'package:ag/view/home/encuentros/listPartidos.dart';
import 'package:ag/view/home/equipo/historial.dart';
import 'package:ag/view/home/equipo/plantel.dart';
import 'package:ag/view/home/menuDrawer.dart';
import 'package:ag/view/home/tabCustom.dart';
import 'package:ag/view/notification.dart';
import 'package:ag/view/settings/profile.dart';
import 'package:ag/view/settings/setting.dart';
import 'package:ag/view/settings/yourOpinion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key, this.idUser, this.idGrupo}) : super(key: key);
  final String idUser;
  final int idGrupo;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  GlobalKey<ScaffoldState> _scaffoldKey;

  /* Show Mode
   * 0 = Encuentros
   * 1 = Campeonatos
   * 2 = Equipos
   */
  int screenType;

  String title;
  List<Tab> tabs;
  int campeonatoSelected;
  int equipoSelected;
  int initPosition = 0;

  @override
  void initState() {
    super.initState();
    this._scaffoldKey = new GlobalKey<ScaffoldState>();
    this.screenType= 0;
    this.title = "Encuentros";
    tabs = new List<Tab>();
    tabs.add(new Tab(text: "Ayer",));
    tabs.add(new Tab(text: "Hoy",));
    tabs.add(new Tab(text: "Mañana",));
    Provider.of<SharedPreferencesProvider>(context, listen: false).getSharedPreference();
    Provider.of<EquiposProvider>(context, listen: false).getEquiposFromUser(this.widget.idUser, this.widget.idGrupo);
    Provider.of<CampeonatosProvider>(context, listen: false).getCampeonatoFromUser(this.widget.idUser, this.widget.idGrupo);
  }

  void _select(Choice choice) {
    switch(choice.id){
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => YourOpinion()), );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()), );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()), );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(tabs.length);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(this.title),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: DataSearch(
                          "equipo o torneo",
                          Provider.of<EquiposProvider>(context, listen: false).getEquipos(),
                          showEquiposDetail
                      ),
                    );
                  }),
              PopupMenuButton<Choice>(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return itemsMenuChoices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Row(
                        children: <Widget>[
                          Text(choice.title),
                          Icon(choice.icon),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
            ]
        ),
        body: SafeArea(
          child: CustomTabView(
            initPosition: initPosition,
            itemCount: tabs.length,
            tabBuilder: (context, index) => tabs[index],
            pageBuilder: (context, index){

              Widget screen = getScreenFromMode(-1, index);
              if(screen != null) {
                return getScreenFromMode(-1, index);
              }
              return Center(child: Text("Cargando"),);
            },
            onPositionChange: (index){
              if(index != null){
                print('current position: $index');
                initPosition = index;
              }
            },
            onScroll: (position) => print('$position'),
          ),
        ),

        drawer: new MenuDrawer(
            this.widget.idGrupo,
            Provider.of<CampeonatosProvider>(context).getCampeonatos(),
            openPath
        )
    );
  }

  showGames(int day) {
    return ListPartidos(day);
  }

  loadFixture(){
    return FixtureCampeonato(campeonatoSelected);
  }

  loadPosition(){
    return PosicionesCampeonatos(campeonatoSelected);
  }

  loadSanciones(){
    return SancionesCampeonatos(campeonatoSelected);
  }

  loadHistorial(){
    return EquipoHistorial(equipoSelected);
  }

  loadPlantel(){
    return EquipoPlantel(equipoSelected);
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
    }
  }

  openPath(BuildContext context, String path, CampeonatoDTO campeonatoDTO) async {
    toggleDrawer();
    switch (path) {
      case "LIGA":
        setState(() {
          this.screenType= 1;
          tabs.clear();
          tabs.add(new Tab(text: "Fixture",));
          tabs.add(new Tab(text: "Posiciones",));
          tabs.add(new Tab(text: "Sanciones",));

          title= campeonatoDTO.descripcion;
          campeonatoSelected = campeonatoDTO.idCampeonato;
          equipoSelected = 0;
        });
        break;

      case "DAILY":
        setState(() {
          this.screenType= 0;
          tabs.clear();
          tabs.add(new Tab(text: "Ayer",));
          tabs.add(new Tab(text: "Hoy",));
          tabs.add(new Tab(text: "Mañana",));
          title= "Encuentros";
          campeonatoSelected = 0;
          equipoSelected = 0;
        });

        break;
      case "CONFIG":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Configuration()),
        );
        break;
      case "NOTIFY":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationMessages()),
        );
        break;
      case "EXIT":
        final SharedPreferences sh = await SharedPreferences.getInstance();
        UserDTO dto = new UserDTO(
            idUser: sh.getString(SH_USER_ID),
            password: "123456"
        );

        Provider.of<AuthenticationProvider>(context, listen: false).logout(dto).then((value) {
           sh.setBool(SH_IS_LOGGED, false);
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
        break;
    }
  }

  showEquiposDetail(BuildContext context, int equipoSelected, String equipoNombre) {
    setState(() {
      this.screenType= 2;
      tabs.clear();
      tabs.add(new Tab(text: "Campana",));
      tabs.add(new Tab(text: "Plantel",));
      this.title= equipoNombre;
      this.campeonatoSelected = 0;
      this.equipoSelected = equipoSelected;
    });
  }

  Widget getScreenFromMode(int day, int index) {
    Widget screen;
    switch(this.screenType){
      case 0:
        screen = showGames(day);
        break;
      case 1:
        switch(index){
          case 0:
            screen = loadFixture();
            break;
          case 1:
            screen = loadPosition();
            break;
          case 2:
            screen = loadSanciones();
            break;
        }
        break;
      case 2:
        switch(index){
          case 0:
            screen = loadHistorial();
            break;
          case 1:
            screen = loadPlantel();
            break;
        }
        break;

    }
    return screen;
  }
}

class Choice {
  final int id;
  final String title;
  final IconData icon;
  const Choice({this.id, this.title, this.icon});
}

const List<Choice> itemsMenuChoices = const <Choice>[
  const Choice(id:0, title: 'Tu Opinion', icon: Icons.message),
  const Choice(id:1, title: 'Mi perfil', icon: Icons.face),
  const Choice(id:2, title: 'Preferencias', icon: Icons.settings),
];


class DataSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => hint;

  DataSearch(this.hint, this.listEquipos, this.showEquiposDetail);
  final String hint;
  final List<EquipoDTO> listEquipos;
  final Function showEquiposDetail;

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [

      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = '';
      })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Center(
      child: Text(query),

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? listEquipos
        : listEquipos.where((p) => p.toString().toLowerCase().startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: () {
        Navigator.pop(context);
        showEquiposDetail(context, suggestionList[index].idEquipo, suggestionList[index].nombre);
      },
      trailing: Icon(Icons.remove_red_eye),
      title: RichText(
        text: TextSpan(
            text: suggestionList[index].nombre,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
        ),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }
}




