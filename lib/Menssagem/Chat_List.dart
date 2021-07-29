import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/models/usuarios.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _controle = StreamController<QuerySnapshot>.broadcast();
  String _idDoUsuario;
  // String _numeroDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _idDoUsuario = fUser.uid;
    // _numeroDoUsuario = fUser.phoneNumber;
  }

  // ignore: missing_return
  Future<Stream<QuerySnapshot>> listaDados() async {
    await _verficaUsuario();
    FirebaseFirestore db = FirebaseFirestore.instance;

    Stream<QuerySnapshot> stream = db
        .collection("usuarios")
        .doc(_idDoUsuario)
        .collection("meus_dados")
        .where("painel", isEqualTo: "cliente")
        .snapshots();
    stream.listen((dados) {
      _controle.add(dados);
    });
    print("db $stream");
  }

  @override
  void initState() {
    super.initState();
    listaDados();
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
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffebedf9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: StreamBuilder(
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
                          return Container(
                            child: Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0)),
                                color: Color(0xffeabf4e),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: <Widget>[
                                      Stack(
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (builder) {
                                                          return AlertDialog(
                                                            content: Container(
                                                              child:
                                                                  Image.network(
                                                                      usuarios
                                                                          .foto),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: CircleAvatar(
                                                    maxRadius: 30,
                                                    minRadius: 30,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            usuarios.foto),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 40,
                                            bottom: 4,
                                            right: 1.0,
                                            child: Stack(
                                              children: [
                                                Icon(
                                                  Icons.brightness_1,
                                                  color: Color(0xff30dc76),
                                                  size: 19,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 8),
                                            child: Column(
                                              children: [
                                                Text(
                                                  usuarios.nome,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text("ADVOGADO")
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                }
                return Container(
                  child: Text("Sem Dados"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
