import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/Dados_do_Usuario/perfil.dart';
import 'package:xilhamalisso/models/usuarios.dart';

class DetalhesUser extends StatefulWidget {
  @override
  _DetalhesUserState createState() => _DetalhesUserState();
}

class _DetalhesUserState extends State<DetalhesUser> {
  final _controle = StreamController<QuerySnapshot>.broadcast();
  String _idDoUsuario;
  String _numeroDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = await auth.currentUser;
    _idDoUsuario = fUser.uid;
    _numeroDoUsuario = fUser.phoneNumber;
  }

  Future<Stream<QuerySnapshot>> dadosUsurio() async {
    try {
      await _verficaUsuario();

      FirebaseFirestore db = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream = db
          .collection("usuarios")
          .doc(_idDoUsuario)
          .collection("meus_dados")
          .where("numero", isEqualTo: _numeroDoUsuario)
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
    var _carregarDados = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.blue,
          ),
          Text(
            "Carregando Seus Dados Agurde",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder(
        stream: _controle.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _carregarDados;
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
                        Text("Erro ao Carregar os Dados"),
                      ],
                    );
                  } else {}
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
                    return Perfil(usuarios: usuarios);
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
