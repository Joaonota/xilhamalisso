import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/Menssagem/ScreenMenssagem.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodosFireba.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/models/contacto.dart';
import 'package:xilhamalisso/provider/UserProvider.dart';
import 'package:xilhamalisso/widget/Online_DotIndicator.dart';

import 'LastMenssagem.dart';

class ContactView extends StatelessWidget {
  final Contacto contato;

  final MetodosFirebase _metodosFirebase = MetodosFirebase();

  ContactView(this.contato);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuarios>(
      future: _metodosFirebase.getUserDetailsById(contato.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Usuarios user = snapshot.data;

          return ViewLayout(
            contatos: user,
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
  final MetodosFirebase _metodosFirebase = MetodosFirebase();
  ViewLayout({Key key, this.contatos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsuarioProvider userProvider = Provider.of<UsuarioProvider>(context);
    return CustomTile(
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(contatos.foto)),
            OnlineDotIndicator(uid: contatos.uid)
          ],
        ),
      ),
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenMenssagem(
              receiver: contatos,
            ),
          )),
      title: Text(
        (contatos != null ? contatos.nome : null) != null
            ? contatos.nome
            : "..",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _metodosFirebase.fetchLastMens(
            senderId: userProvider.getUSer.uid, receiveID: contatos.uid),
      ),
    );
  }
}
