
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:xilhamalisso/custimizado/Customappbar.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

import 'dasboardPro.dart';

class DetalhesPro extends StatefulWidget {
  @override
  _DetalhesProState createState() => _DetalhesProState();
}

class _DetalhesProState extends State<DetalhesPro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UniversalVariables.blackColor,
      margin: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          CustomAppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.powerOff),
              )
            ],
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
            centerTitle: true,
            title: UserCircle(),
          ),
          UserDetalhes()
        ],
      ),
    );
  }
}

class UserDetalhes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Joao Manuel Nota",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Joaonota23@gmail.com",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
