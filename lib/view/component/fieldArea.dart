

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldArea extends StatelessWidget{
  FieldArea({
    this.label,
    this.controller,
    this.rows
  });

  final String label;
  final TextEditingController controller;
  final int rows;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: rows,
      keyboardType: TextInputType.text,
      controller: this.controller,
      decoration: InputDecoration(
          labelText: "${this.label}"
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}