import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      child: Center(
        child:  CircularProgressIndicator(),
      ),
    );
  }
}