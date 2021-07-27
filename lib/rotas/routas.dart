import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/Autenticacao/AuteticacaoUser/AutenticaUser.dart';
import 'package:xilhamalisso/Dados_do_Usuario/DetalhesUser.dart';
import 'package:xilhamalisso/Dados_do_Usuario/EditaUser.dart';
import 'package:xilhamalisso/Menu/Page_menu.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings definicoes) {
    final args = definicoes.arguments;
    switch (definicoes.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => PageMenu(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (context) => AutenticaUser(),
        );
      case "/meus_dados":
        return MaterialPageRoute(
          builder: (context) => DetalhesUser(),
        );
      case "/editar":
        return MaterialPageRoute(
          builder: (context) => EditaUser(),
        );
      default:
        erooRouta();
    }
  }

  static Route<dynamic> erooRouta() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela Não Encontrada"),
        ),
        body: Center(
          child: Text("Tela Não Encontrada"),
        ),
      );
    });
  }
}
