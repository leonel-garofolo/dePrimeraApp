import 'package:ag/view/configuration.dart';
import 'package:ag/view/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                Padding(
                        padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'De Primera',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                ),
              ],
            )
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Fixtures'),
            onTap: () => {},
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
            onTap: () => {
              openNotification(context)
            },
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

  openNotification(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationMessages()),
    );
  }
}