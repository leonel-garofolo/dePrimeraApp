

import 'package:ag/view/home/encuentros/listPartidos.dart';
import 'package:ag/view/home/tabCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EncuentrosTab extends StatefulWidget{

  @override
  State createState() => EncuentrosTabStatus();
}

class EncuentrosTabStatus extends State<EncuentrosTab> {
  int initPosition = 1;
  final List<Tab> tabs = new List<Tab>();

  @override
  void initState() {
    super.initState();
    tabs.add(new Tab(text: "Ayer",));
    tabs.add(new Tab(text: "Hoy",));
    tabs.add(new Tab(text: "Mañana",));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: tabs.length,
        tabBuilder: (context, index) => tabs[index],
        pageBuilder: (context, index){
          return getScreenFromMode(index);
        },
        onPositionChange: (index){
          if(index != null){
            initPosition = index;
          }
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  Widget getScreenFromMode(int index) {
    Widget screen;
    switch(index){
      case 0:
        screen = ListPartidos(-1);
        break;
      case 1:
        screen = ListPartidos(0);
        break;
      case 2:
        screen = ListPartidos(1);
        break;
    }
    return screen;
  }
}