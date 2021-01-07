import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/view/authentication/login.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/component/sidebar.dart';
import 'package:ag/view/configuration.dart';
import 'package:ag/view/notification.dart';
import 'package:ag/view/settings/profile.dart';
import 'package:ag/view/settings/setting.dart';
import 'package:ag/view/settings/yourOpinion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//EventBus eventBus = EventBus();
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey;

  int screenType;
  String title;
  List<String> tabsName;
  int campeonatoSelected;

  @override
  void initState() {
    super.initState();
    this._scaffoldKey = new GlobalKey<ScaffoldState>();
    this.screenType= 0;
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
    this.title = "Encuentros";
    tabsName = new List<String>();
    tabsName.add("Ayer");
    tabsName.add("Hoy");
    tabsName.add("Mañana");
    Provider.of<CampeonatosProvider>(context, listen: false).getAll();
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

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(this.title),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: DataSearch("equipo o torneo", listWords),
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
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: tabsName[0]),
                Tab(text: tabsName[1]),
                Tab(text: tabsName[2]),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              this.screenType == 0? showGames(-1): loadFixture(),
              this.screenType == 0? showGames(0): loadPosition(),
              this.screenType == 0? showGames(1): loadSanciones(),
            ],

          ),

          drawer: loadData(context, Provider.of<CampeonatosProvider>(context).getCampeonatos()) ,
          ),
        );
  }

  showGames(int day) {
    DateTime now = new DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day  + day);
    String sCurrentDate = "${currentDate.year.toString()}-${currentDate.month.toString().padLeft(2,'0')}-${currentDate.day.toString().padLeft(2,'0')}";
    print("day: " + day.toString() + ": date" + sCurrentDate);

    return Center(
      child: FutureBuilder<List<PartidosFromDateDTO>>(
          future: Provider.of<PartidosProvider>(context).getForDate(sCurrentDate),
          builder: (BuildContext context, AsyncSnapshot<List<PartidosFromDateDTO>>  snapshot){
            if(snapshot.hasData){
              List<PartidosFromDateDTO> partidos = snapshot.data;
              return new ListView.builder
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
              return Center(
                child: Text("No se encontraron datos"),
              );
            }
          }
      ),
    );
  }

  loadFixture(){
    return Center(
      child: FutureBuilder<List<PartidosFromDateDTO>>(
          future: Provider.of<CampeonatosProvider>(context).getFixture(campeonatoSelected),
          builder: (BuildContext context, AsyncSnapshot<List<PartidosFromDateDTO>> snapshot){
            if(snapshot.hasData){
              List<PartidosFromDateDTO> partidos = snapshot.data;
              return new ListView.builder
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
              return Center(
                child: Text("No se encontraron datos"),
              );
            }
          }
      ),
    );
  }

  loadPosition(){
    return Container(
      alignment: Alignment.topCenter,
      child: FutureBuilder<List<EquipoTablePosDTO>>(
          future: Provider.of<CampeonatosProvider>(context).getTablePosition(campeonatoSelected),
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

  loadSanciones(){
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
                        width: 50, //SET width
                        child: Text(sancion.apellidoNombre + " (" + sancion.eNombre + ")")
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

  Widget loadData(BuildContext context, List<CampeonatoDTO> campeonatosDTO)  {
    List<Widget> items = new List<Widget>();
    if(campeonatosDTO != null && campeonatosDTO.isEmpty){
      return NavDrawer(items);
    } else {
      List<Menu> menus = new List<Menu>();
      campeonatosDTO.forEach((camp) {
        menus.add(new Menu(
            nombre: camp.descripcion,
            isSubMenu: true,
            pathGo: "LIGA",
            campeonatoDTO:camp
        ));
      });

      items.add(Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'De Primera',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          )
      ));
      items.add(ListTile(
        leading: Icon(Icons.calendar_today_outlined),
        contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
        title: Align(
          child: new Text("Encuentros"),
          alignment: Alignment(-1.2, 0),
        ),
        onTap: () =>
        {
          openPath(context, "DAILY", null)
        },
      ));

      items.add(
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Column(
              children: [
                Text("Mis Torneos"),
              ],
            ),
          ));
      if (menus != null) {
        menus.add(new Menu(
            icon: Icon(Icons.settings),
            nombre: "Configuraciones",
            isSubMenu: false,
            pathGo: "CONFIG"
        ));
        menus.add(new Menu(
            icon: Icon(Icons.border_color),
            nombre: "Notificaciones",
            isSubMenu: false,
            pathGo: "NOTIFY"
        ));
        menus.add(new Menu(
            icon: Icon(Icons.exit_to_app),
            nombre: "Salir",
            isSubMenu: false,
            pathGo: "EXIT"
        ));

        menus.forEach((menu) {
          if (!menu.isSubMenu) {
            //items.add(Divider(color:Colors.black));
            items.add(ListTile(
              leading: menu.icon,
              contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              title: Align(
                child: new Text(menu.nombre),
                alignment: Alignment(-1.2, 0),
              ),
              onTap: () =>
              {
                openPath(context, menu.pathGo, null)
              },
            ));
          } else {
            items.add(
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: ListTile(
                    title: Text(menu.nombre),
                    onTap: () =>
                    {
                      openPath(context, menu.pathGo, menu.campeonatoDTO)
                    },
                  ),
                )
            );
          }
        });
      }

      return Drawer(
        child: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return items[index];
                  },
                  childCount: items.length,
            ))
          ],
        ),
      );
    }
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
          screenType= 1;
          _tabController.animateTo(0);
          tabsName.clear();
          tabsName.add("Fixture");
          tabsName.add("Posiciones");
          tabsName.add("Sanciones");
          title= campeonatoDTO.descripcion;
          campeonatoSelected = campeonatoDTO.idCampeonato;
        });
        break;

      case "DAILY":
        setState(() {
          screenType= 0;
          _tabController.animateTo(1);
          tabsName.clear();
          tabsName.add("Ayer");
          tabsName.add("Hoy");
          tabsName.add("Mañana");
          title= "Encuentros";
          campeonatoSelected = 0;
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
  final String hint;
  final List<ListWords> listWords;
  DataSearch(this.hint, this.listWords);

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
        ? listWords
        : listWords.where((p) => p.toString().startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: () {
        //showResults(context);
      },
      trailing: Icon(Icons.remove_red_eye),
      title: RichText(
        text: TextSpan(
            text: suggestionList[index].titlelist.substring(0, query.length),
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].titlelist.substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ]),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }
}

List<ListWords>  listWords = [
  ListWords('oneWord', 'OneWord definition'),
  ListWords('twoWord', 'TwoWord definition.'),
  ListWords('TreeWord', 'TreeWord definition'),
];

class ListWords {
  String titlelist;
  String definitionlist;

  ListWords(String titlelist, String definitionlist) {
    this.titlelist = titlelist;
    this.definitionlist = definitionlist;
  }
}