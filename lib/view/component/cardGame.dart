

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardGame extends StatelessWidget{
  CardGame({this.championName, this.date, this.localName, this.localGoal, this.visitName, this.visitGoal});

  final String championName;
  final DateTime date;
  final String localName;
  final String localGoal;
  final String visitName;
  final String visitGoal;

  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat("HH:mm");
    final String sDate = dateFormat.format(date).toString();

    return Center(
      child: Card(
        elevation: 5,

        margin: EdgeInsets.all(10.0),
        borderOnForeground: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container (
                decoration: new BoxDecoration (
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade200),
                    ),
                ),
                child: new ListTile (
                    title: Text(championName)
                )
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_downward),
                      SizedBox(width: 5),
                      Text(localName)
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(sDate + ' hs'),
                      Text(localGoal + ' - ' + visitGoal, style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.featured_play_list),
                      SizedBox(width: 5),
                      Text(visitName)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}