import 'dart:async';

import 'package:ag/helper/sharedPreferencesHelper.dart';
import 'package:ag/view/home.dart';
import 'package:ag/view/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    bool status = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get(SH_IS_LOGGED) != null){
      status = prefs.getBool(SH_IS_LOGGED);
    }
    return status;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Home()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/sports.png'),
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: Color(0xffffffff),
              highlightColor: Color(0xff000000),
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "De Primera",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
