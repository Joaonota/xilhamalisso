import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xilhamalisso/models/usuarios.dart';

class DetalhesUser extends StatefulWidget {
  @override
  _DetalhesUserState createState() => _DetalhesUserState();
}

class _DetalhesUserState extends State<DetalhesUser> {
  final _controle = StreamController<QuerySnapshot>.broadcast();
  String _idDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = await auth.currentUser;
    _idDoUsuario = fUser.uid;
  }

  Future<Stream<QuerySnapshot>> dadosUsurio() async {
    await _verficaUsuario();
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("Usuarios")
        .where("id", isEqualTo: _idDoUsuario)
        .snapshots();
    stream.listen((dados) {
      _controle.add(dados);
    });
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
      body: Container(
        child: StreamBuilder(
          stream: _controle.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return _carregarDados;
                break;
              case ConnectionState.done:
                //exibe menssagem de Erro
                if (snapshot.hasError) {
                  return Text("Erro ao Carregar os dados");
                } else {
                  QuerySnapshot querySnapshot = snapshot.data;
                  return ListView.builder(
                      itemCount: querySnapshot.docs.length,
                      itemBuilder: (context, indice) {
                        List<DocumentSnapshot> usuariosx =
                            querySnapshot.docs.toList();
                        DocumentSnapshot docomentSnap = usuariosx[indice];
                        Usuarios usuarios =
                            Usuarios.fromDocumentSnap(docomentSnap);
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xffebedf9),
                          ),
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.userAlt,
                                        color: Color(0xffaa9166),
                                      ),
                                      SizedBox(
                                        width: 18.0,
                                      ),
                                      Text(
                                        "Meus Dados".toUpperCase(),
                                        style: TextStyle(
                                          color: Color(0xffaa9166),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //card com Detalhes
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 298,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      child: CircleAvatar(
                                                        maxRadius: 40,
                                                        minRadius: 40,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                usuarios.foto),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 60,
                                                    bottom: 5,
                                                    right: 4.0,
                                                    child: Stack(
                                                      children: [
                                                        Icon(
                                                          Icons.brightness_1,
                                                          color: Colors.green,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 3),
                                                  child: Text(
                                                    usuarios.nome,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xffaa9166)),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Icon(
                                                          Icons.phone,
                                                          color:
                                                              Color(0xffaa9166),
                                                        ),
                                                        Text(
                                                          usuarios.numeroTele,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Icon(
                                                          Icons.mail,
                                                          color:
                                                              Color(0xffaa9166),
                                                        ),
                                                        Text(
                                                          usuarios.email,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .location_history,
                                                          color: Color(
                                                              0xffaa9166)),
                                                      Text(
                                                        usuarios.localizacao,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 330,
                                                child: Divider(
                                                  color: Colors.brown,
                                                ),
                                              ),
                                              Container(
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffaa9166),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Actualizar",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
                break;
              default:
            }
            return Container();
          },
        ),
      ),
    );
  }
}
