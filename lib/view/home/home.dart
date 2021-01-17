import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/authenticationProvider.dart';
import 'package:ag/providers/campeonatosProvider.dart';
import 'package:ag/providers/partidosProvider.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/authentication/login.dart';
import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/configuration.dart';
import 'package:ag/view/home/campeonato/fixture.dart';
import 'package:ag/view/home/campeonato/position.dart';
import 'package:ag/view/home/campeonato/sancionesCampeonato.dart';
import 'package:ag/view/home/encuentros/listPartidos.dart';
import 'package:ag/view/home/menuDrawer.dart';
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
  Home({Key key, this.idUser, this.idGrupo}) : super(key: key);
  final String idUser;
  final int idGrupo;

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
    Provider.of<SharedPreferencesProvider>(context, listen: false).getSharedPreference();

    //TODO It is not getAll(), because depends of user are logged
    print(this.widget.idUser);
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
          body: SafeArea(
            child: TabBarView(
              controller: _tabController,
              children: [
                this.screenType == 0? showGames(-1): loadFixture(),
                this.screenType == 0? showGames(0): loadPosition(),
                this.screenType == 0? showGames(1): loadSanciones(),
              ],

            ),
          ),

          drawer: new MenuDrawer(
              this.widget.idGrupo,
              Provider.of<CampeonatosProvider>(context).getCampeonatos(),
              openPath
          )
          ),
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