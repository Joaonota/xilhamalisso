import 'package:flutter/material.dart';
import 'package:xilhamalisso/Menssagem/Chat_List.dart';
import 'package:xilhamalisso/Telas_Teste/AutenticaUser.dart';
import 'package:xilhamalisso/Dados_do_Usuario/DetalhesUser.dart';
import 'package:xilhamalisso/Dados_do_Usuario/EditaUser.dart';

import 'package:xilhamalisso/Menssagem/ScreenMenssagem.dart';
import 'package:xilhamalisso/Menu/Page_menu.dart';

class RouteGenerator {
  // ignore: missing_return
  static Future<Route> generateRoute(RouteSettings definicoes) async {
    // ignore: unused_local_variable
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
      case "/menssagem":
        return MaterialPageRoute(
          builder: (context) => ScreenMenssagem(),
        );
      case "/editar":
        return MaterialPageRoute(
          builder: (context) => EditaUser(),
        );
      case "listachat":
        return MaterialPageRoute(
          builder: (context) => ChatLists(),
        );
        /*case "detalhes":
        return MaterialPageRoute(
          builder: (_) => DetalhesPro()(args),
        );*/
        break;
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
