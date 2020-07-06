import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemList{
  int id;
  String title;
  String subtitle;

  ItemList({this.id, this.title, this.subtitle});

}
class FieldListView extends StatelessWidget{
  FieldListView({this.label, this.title, , this.controller});

  final String label;
  final String title;
  final List<ItemList> itemList;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: const Text('Liga',
            style: TextStyle(fontSize: 20)),
        onPressed: (){ openDialog(context);});
  }

  openDialog(final BuildContext context){
    SimpleDialog dialog = SimpleDialog(
      title: const Text("asdas"),
      children: <Widget>[
        setupAlertDialoadContainer()
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Gujarat, India'),
          );
        },
      ),
    );
  }
}