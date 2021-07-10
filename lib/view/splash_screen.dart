import 'dart:async';

import 'package:employee_details/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initiateTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Employee Directory')),
    );
  }

  _initiateTimer() {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, _navigateToHome);
  }

  _navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Home()));
  }
}
