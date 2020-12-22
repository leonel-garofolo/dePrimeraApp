

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldText extends StatelessWidget{
  FieldText({this.label, this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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