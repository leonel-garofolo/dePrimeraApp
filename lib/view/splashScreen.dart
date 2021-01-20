import 'dart:async';
import 'package:ag/providers/sharedPreferenceProvider.dart';
import 'package:ag/view/authentication/login.dart';
import 'package:ag/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool status;
  @override
  void initState() {
    super.initState();
    Provider.of<SharedPreferencesProvider>(context, listen: false).getSharedPreference();
    _mockCheckForSession();
  }

 _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      status = Provider.of<SharedPreferencesProvider>(context, listen: false).isLogged();
      if(status != null){
        if (status) {
          _navigateToHome();
        } else {
          _navigateToLogin();
        }
      }
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>
            Home(
              idUser: Provider.of<SharedPreferencesProvider>(context, listen: false).getUserId(),
              idGrupo: Provider.of<SharedPreferencesProvider>(context, listen: false).getUserGrupo(),

            )));
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
