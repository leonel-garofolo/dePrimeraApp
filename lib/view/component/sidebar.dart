import 'package:ag/network/model/dtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Menu {
  Icon icon;
  String nombre;
  bool isSubMenu;
  String pathGo;
  CampeonatoDTO campeonatoDTO;

  Menu({this.icon, this.nombre, this.isSubMenu, this.pathGo, this.campeonatoDTO});
}

class NavDrawer extends StatelessWidget {
  NavDrawer(this.items);
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    Column col = Column(
      mainAxisSize: MainAxisSize.max,
    );

    if(items != null){
      col = Column(
        mainAxisSize: MainAxisSize.max,
        children: items,
      );
    }
    return Drawer(child: col);
  }
}