import 'package:flutter/material.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

class QuiteBox extends StatelessWidget {
  final Usuarios user;

  const QuiteBox({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: UniversalVariables.separatorColor,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Ola seja bem vindo é aqui onde estão listadas as suas conversas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Procure seus amigos e familiares para começar a ligar ou conversar com eles",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 25),
              /*-FlatButton(
                color: UniversalVariables.lightBlueColor,
                child: Text("INICIAR A PESQUISA"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
