

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldCheckbox extends StatelessWidget{
  FieldCheckbox({this.label, this.value, this.valueChanged});

  final String label;
  final bool value;
  final ValueChanged<bool> valueChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label),
        Checkbox(
          value: value,
          onChanged: valueChanged,
        )
      ],
    );
  }
}