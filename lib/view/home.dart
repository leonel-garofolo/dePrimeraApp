import 'package:ag/view/component/cardGame.dart';
import 'package:ag/view/component/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  Choice _selectedChoice = itemsMenuChoices[0]; // The app's "state".

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 10, vsync: this);
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
        appBar: AppBar(
          title: const Text('Encuentros'),
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
            //controller: tabController,
            tabs: [
              Tab(text: 'Ayer'),
              Tab(text: "Hoy",),
              Tab(text: "Mañana",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            showGames(-1),
            showGames(0),
            showGames(1),
          ],

        ),

        drawer: NavDrawer(),
        )
    );
  }

  showGames(day) {
    switch(day) {
      case -1:
        return new ListView.builder
          (
            itemCount: 2,
            itemBuilder: (BuildContext ctxt, int index) {
              return CardGame(
                championName: 'Copa - grupo A',
                date: DateTime.now(),
                localName: 'Central',
                localGoal: '1',
                visitName: 'River',
                visitGoal: '0',
              );
            }
        );
        break;
      case 0:
        return new ListView.builder
          (
            itemCount: 10,
            itemBuilder: (BuildContext ctxt, int index) {
              return CardGame(
                championName: 'Copa - grupo A',
                date: DateTime.now(),
                localName: 'Central',
                localGoal: '1',
                visitName: 'River',
                visitGoal: '0',
              );
            }
        );
        break;
      case 1:
        return CardGame(
          championName: 'Copa - grupo A',
          date: DateTime.now(),
          localName: 'Central',
          localGoal: '1',
          visitName: 'River',
          visitGoal: '0',
        );
        break;
    }
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> itemsMenuChoices = const <Choice>[
  const Choice(title: 'Tu Opinion', icon: Icons.message),
  const Choice(title: 'Mi perfil', icon: Icons.face),
  const Choice(title: 'Preferencias', icon: Icons.settings),
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