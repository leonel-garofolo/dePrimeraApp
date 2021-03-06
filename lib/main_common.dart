import 'package:ag/enviroments/config.dart';
import 'package:ag/view/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DePrimeraApp extends StatelessWidget {
  DePrimeraApp(this.config);
  final Config config;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'De Primera',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',

      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}