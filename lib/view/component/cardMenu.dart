import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget{
  CardMenu({this.title, this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      child: Card(
          elevation: 5,
          margin: EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          borderOnForeground: true,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container (
                    width: 270,
                    height: 75,
                    alignment: Alignment.centerLeft,
                    child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 30,
                          width: 200,
                          alignment: Alignment.centerLeft,
                          child:  Text("Cargados", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),)
                      ),
                      Container (
                          height: 30,
                          alignment: Alignment.centerRight,
                          child:  Text(count.toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),)
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}