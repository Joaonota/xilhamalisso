import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/Menu/DetalhesPros.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';
import 'package:xilhamalisso/widget/Online_DotIndicator.dart';

class MeusContatos extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<MeusContatos> {
  final _controle = StreamController<QuerySnapshot>.broadcast();
  String _idDoUsuario;
  // String _numeroDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _idDoUsuario = fUser.uid;
    //_numeroDoUsuario = fUser.phoneNumber;
  }

  //
  // ignore: missing_return
  Future<Stream<QuerySnapshot>> listaUsuarios() async {
    try {
      _verficaUsuario();
      FirebaseFirestore db = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream = db
          .collection("usuarios")
          .where(
            "painel",
            isEqualTo: "pro",
          )
          .snapshots();
      //
      stream.listen((dados) {
        _controle.add(dados);
      });
    } catch (e) {}

    print(_idDoUsuario);
  }

  @override
  void initState() {
    super.initState();
    listaUsuarios();
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
      body: Container(
        decoration: BoxDecoration(
          color: UniversalVariables.blackColor,
        ),
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
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Clicado");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalhesPros(
                                      usuarios: usuarios,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13.0)),
                                    color: Colors.grey[900],
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
                                                                content:
                                                                    InteractiveViewer(
                                                                  child:
                                                                      Container(
                                                                          child:
                                                                              Image.network(
                                                                    usuarios
                                                                        .foto,
                                                                  )),
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
                                                    OnlineDotIndicator(
                                                        uid: usuarios.uid)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 8),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      usuarios.nome,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      usuarios.atuacao
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
              }
              return Container();
            }),
      ),
    );
  }
}
