import 'package:ag/view/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuraciones'),
            onTap: () => {
              openConfig(context)
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Notificaciones'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }

  openConfig(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Configuration()),
    );
  }
}