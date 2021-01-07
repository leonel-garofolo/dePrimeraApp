

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldNumber extends StatelessWidget{
  FieldNumber({this.label, this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: this.controller,
      decoration: InputDecoration(
          labelText: "${this.label}"
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some number';
        }
        return null;
      },
    );
  }
}