import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComboView<T> extends StatelessWidget{
  ComboView({this.label, this.itemValue, this.itemList, this.onChange});

  final String label;
  final List<DropdownMenuItem<T>> itemList;
  final T itemValue;
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: new Text(label),
              ),
              Container(
                padding: new EdgeInsets.all(5.0),
              ),
              DropdownButton<T>(
                isExpanded: false,
                value: itemValue,
                items: itemList,
                onChanged: onChange,
              ),
            ],
          )
      ),
    );
  }
}