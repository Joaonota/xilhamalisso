import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xilhamalisso/Telas_Teste/AutenticaUser.dart';
import 'package:xilhamalisso/Menssagem/chat_list_screen.dart';
import 'package:xilhamalisso/custimizado/Customappbar.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

class DetalhesPro extends StatefulWidget {
  @override
  _DetalhesProState createState() => _DetalhesProState();
}

class _DetalhesProState extends State<DetalhesPro> {
  final _controle = StreamController<QuerySnapshot>.broadcast();
  String _idDoUsuario;

  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _idDoUsuario = fUser.uid;
    //_numeroDoUsuario = fUser.phoneNumber;
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
    var _carregarDados = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.blue,
          ),
          Text(
            "Carregando Seus Dados Aguarde",
            style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
    return Container(
      color: UniversalVariables.blackColor,
      margin: EdgeInsets.only(top: 24),
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
                    child: Column(
                      children: [
                        CustomAppBar(
                          actions: [
                            IconButton(
                              onPressed: () async {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                auth.signOut();
                                print("clicado");
                                await auth.signOut();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (builder) => AutenticaUser()));
                              },
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
                        //UserDetalhes()
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(usuarios.foto),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    usuarios.nome,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    usuarios.email,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
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

/*class UserDetalhes extends StatelessWidget {
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
}*/
/*Column(
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
      ),*/