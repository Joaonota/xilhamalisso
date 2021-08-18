import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xilhamalisso/Telas_Teste/AutenticaUser.dart';
import 'package:xilhamalisso/custimizado/CarregarDados.dart';

import 'introducao.dart';

class FirstRun extends StatefulWidget {
  @override
  _FirstRunState createState() => _FirstRunState();
}

class _FirstRunState extends State<FirstRun> with AfterLayoutMixin<FirstRun> {
  Future verficaPrimeiravez() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _ver = (preferences.getBool("ver") ?? false);
    if (_ver) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new AutenticaUser(),
      ));
    } else {
      await preferences.setBool("ver", true);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (context) => new Introducao(),
      ));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => verficaPrimeiravez();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CarregarDados(text: "Carregando", colors: Colors.green),
      ),
    );
  }
}
