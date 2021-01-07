

import 'package:flutter/cupertino.dart';

class WithoutData extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Center(
        child: Text("No se encontraron Datos"),
      ),
    );
  }
}