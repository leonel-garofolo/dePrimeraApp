import 'package:ag/network/model/dtos.dart';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/component/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer(this.idGrupo, this.campeonatosDTO, this.openPath);
  final int idGrupo;
  final List<CampeonatoDTO> campeonatosDTO;
  final Function openPath;

  final String profileUserImage = 'assets/images/profileUserImage.png';
  @override
  Widget build(BuildContext context) {


    List<Widget> items = new List<Widget>();
    if (campeonatosDTO != null && campeonatosDTO.isEmpty) {
      return NavDrawer(items);
    } else {
      List<Menu> menus = new List<Menu>();
      if (campeonatosDTO != null) {
        campeonatosDTO.forEach((camp) {
          menus.add(new Menu(
              nombre: camp.descripcion,
              isSubMenu: true,
              pathGo: "LIGA",
              campeonatoDTO: camp
          ));
        });
      }

      items.add(Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage(profileUserImage),
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              Provider.of<SharedPreferencesProvider>(
                                  context, listen: false).getUserName() + ' ' +
                                  Provider.of<SharedPreferencesProvider>(
                                      context, listen: false).getUserSurName(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              Provider.of<SharedPreferencesProvider>(
                                  context, listen: false).getUserGrupoName(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
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
        onTap: () =>{
          //openPath(context, "DAILY", null)
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
        if(idGrupo ==1) { //ONLY ADMINISTRATION PROFILE
          menus.add(new Menu(
              icon: Icon(Icons.settings),
              nombre: "Configuraciones",
              isSubMenu: false,
              pathGo: "CONFIG"
          ));
        }
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
            items.add(ListTile(
              leading: menu.icon,
              contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              title: Align(
                child: new Text(menu.nombre),
                alignment: Alignment(-1.2, 0),
              ),
              onTap: ()=> {

                openPath(context, menu.pathGo, null)
              },

              
            ));
          } else {
            items.add(
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: ListTile(
                    title: Text(menu.nombre),
                    onTap: ()=> {
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
}