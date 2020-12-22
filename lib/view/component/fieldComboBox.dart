import 'package:ag/services/model/dtos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldComboBox<T extends ItemValue> extends StatelessWidget{
  FieldComboBox({this.label, this.itemValue, this.itemList, this.onChange});

  final String label;
  final List<T> itemList;
  final T itemValue;
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 16),),
          DropdownButton<T>(
            value: itemValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 16,
            onChanged: onChange,
            items: itemList
                .map<DropdownMenuItem<T>>((T itemValue) {
              return DropdownMenuItem<T>(
                value: itemValue,
                child: Text(itemValue.toString()),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}