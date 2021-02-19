import 'package:ag/network/model/dtos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardGame extends StatelessWidget{
  final String escudoImage = 'assets/images/escudo.png';

  CardGame({this.partidoId, this.partidosFromDateDTO, this.championName, this.date, this.localName, this.localGoal, this.visitName, this.visitGoal, this.showDate, this.edit});

  final int partidoId;
  final PartidosFromDateDTO partidosFromDateDTO;
  final String championName;
  final DateTime date;
  final String localName;
  final String localGoal;
  final String visitName;
  final String visitGoal;
  final bool showDate;
  final Function edit;

  @override
  Widget build(BuildContext context) {
    final String sFechaDate = this.showDate? new DateFormat("MM/dd").format(date).toString():"";
    final String sHoraDate = new DateFormat("HH:mm").format(date).toString();

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
                    title: Text(championName,  overflow: TextOverflow.ellipsis,),
                    trailing: InkWell(
                      child: Icon(Icons.more_vert),
                      onTap: () =>{
                        edit(context, this.partidosFromDateDTO)
                      },
                    ),
                ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  margin: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage(escudoImage),
                        width: 30,
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        child: Text(
                          localName,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    children: <Widget>[
                      Text(sFechaDate),
                      Text(sHoraDate + ' hs'),
                      Text(localGoal + ' - ' + visitGoal, style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  margin: EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        child: Text(
                          visitName,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image(
                        image: AssetImage(escudoImage),
                        width: 30,
                        height: 30,
                      ),
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