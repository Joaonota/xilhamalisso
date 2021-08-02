import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/models/contacto.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

class ContactView extends StatefulWidget {
  final Contacto contato;

  const ContactView({Key key, this.contato}) : super(key: key);

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _controle = StreamController<QuerySnapshot>.broadcast();

  String _idDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _idDoUsuario = fUser.uid;
    //_numeroDoUsuario = fUser.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controle.stream,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          Usuarios users = snapShot.data;
          return ViewLayout(
            contatos: users,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final Usuarios contatos;

  const ViewLayout({Key key, this.contatos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomTile(
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: contatos.foto,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: UniversalVariables.onlineDotColor,
                    border: Border.all(
                        color: UniversalVariables.blackColor, width: 2)),
              ),
            )
          ],
        ),
      ),
      mini: false,
      title: Text(
        contatos?.nome ?? "...",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: Text(
        "Ola bem-vindo A Xilhamalisso ",
        style: TextStyle(
          color: UniversalVariables.greyColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
