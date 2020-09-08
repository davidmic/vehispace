import 'package:flutter/material.dart';
import 'dart:async';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  starttime () async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, navpage);
  }
  void navpage (){
    Navigator.pushReplacementNamed(context, '/usermgt');
  }
  @override

  void initState () {
    super.initState();
    starttime();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo/splashlogo.png'),
      ),
    );
  }
}
