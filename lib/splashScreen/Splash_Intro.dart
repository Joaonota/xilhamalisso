import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xilhamalisso/Login/LoginScreen.dart';

// ignore: camel_case_types
class Splash_Intro extends StatefulWidget {
  @override
  _Splash_IntroState createState() => _Splash_IntroState();
}

// ignore: camel_case_types
class _Splash_IntroState extends State<Splash_Intro> {
  bannerTime() async {
    Timer(Duration(seconds: 5), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff291b12),
            Color(0xff291b12),
          ]),
          image: DecorationImage(
            image: AssetImage("assets/imagem_Splash/capa.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bannerTime();
  }
}
