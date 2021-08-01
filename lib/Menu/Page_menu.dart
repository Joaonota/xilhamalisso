import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/custimizado/CarregarDados.dart';
import 'package:xilhamalisso/models/Usuarios.dart';

import 'DetalhesMenu.dart';

class PageMenu extends StatefulWidget {
  @override
  _PageMenuState createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  final _controle = StreamController<QuerySnapshot>.broadcast();
  String _idDoUsuario;
  //String _numeroDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _idDoUsuario = fUser.uid;
    // _numeroDoUsuario = fUser.phoneNumber;
  }

  // ignore: missing_return
  Future<Stream<QuerySnapshot>> dadosUsurio() async {
    try {
      await _verficaUsuario();

      FirebaseFirestore db = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream = db
          .collection("usuarios")
          .where("uid", isEqualTo: _idDoUsuario)
          .snapshots();

      ///
      stream.listen((dados) {
        _controle.add(dados);
      });
      print("id do usuario{$_idDoUsuario}");
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    dadosUsurio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000),
      body: StreamBuilder(
        stream: _controle.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CarregarDados(
                  text: "Carregando Seus Dados Agurde", colors: Colors.blue);
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              //exibe menssagem de Erro
              if (snapshot.hasError) {
                try {
                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                        Text("Erro ao Carregar os Dados :("),
                      ],
                    );
                  }
                } catch (e, s) {
                  print("erro{$s}");
                }
              }
              QuerySnapshot querySnapshot = snapshot.data;
              return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, indice) {
                    List<DocumentSnapshot> usuariosx =
                        querySnapshot.docs.toList();
                    DocumentSnapshot docomentSnap = usuariosx[indice];
                    Usuarios usuarios =
                        Usuarios.fromDocumentSnapshot(docomentSnap);
                    return DetalhesMenu(
                      usuarios: usuarios,
                    );
                  });
          }
          return Center(
            child: Container(
              child: Text("Sem dados"),
            ),
          );
        },
      ),
    );
  }
}
