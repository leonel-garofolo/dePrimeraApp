

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldDatePicker extends StatelessWidget{
  FieldDatePicker({this.label, this.value, this.valueChanged});
  DateTime _dateTime;
  final String label;
  final bool value;
  final ValueChanged<bool> valueChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
          RaisedButton(
            child: Text(label),
            onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
                ).then((date) {
                  print(date);
                });
              },
             )
        ],
      ),
    );
  }
}