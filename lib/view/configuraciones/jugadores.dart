import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JugadoresForm extends StatefulWidget {
  JugadoresForm({Key key}) : super(key: key);

  @override
  _JugadoresFormState createState() => _JugadoresFormState();
}

class _JugadoresFormState extends State<JugadoresForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugadores'),
      ),
      body: Center(

      ),
    );
  }
}