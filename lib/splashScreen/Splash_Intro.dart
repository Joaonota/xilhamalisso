import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xilhamalisso/Menu/Page_menu.dart';

class SplashIntro extends StatefulWidget {
  @override
  _SplashIntroState createState() => _SplashIntroState();
}

class _SplashIntroState extends State<SplashIntro> {
  bannerTime() async {
    Timer(Duration(seconds: 5), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PageMenu(),
        ),
      );
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
