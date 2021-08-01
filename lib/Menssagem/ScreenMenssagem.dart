import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/models/ModelMenssagem.dart.dart';

import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

import 'chat_list_screen.dart';

class ScreenMenssagem extends StatefulWidget {
  final Usuarios receiver;

  const ScreenMenssagem({this.receiver});
  @override
  _MenssagemState createState() => _MenssagemState();
}

class _MenssagemState extends State<ScreenMenssagem> {
  TextEditingController textEditingController = TextEditingController();

  final _controle = StreamController<QuerySnapshot>.broadcast();
  //

  bool iswrite = false;
  Usuarios sender;
  String _currentUserID;
  Radius messageRadius = Radius.circular(10);

  //
  String receives;

  ///
  Future _verficaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _currentUserID = fUser.uid;

    //_numeroDoUsuario = fUser.phoneNumber;
  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<Stream<QuerySnapshot>> mostraMenssagem() async {
    try {
      await _verficaUsuario();

      FirebaseFirestore db = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream = db
          .collection("menssagem")
          .doc(_currentUserID)
          .collection(widget.receiver.uid)
          .orderBy("timestamp", descending: true)
          .snapshots();

      ///
      ///db
      ///.collection("menssagem")
      // .doc(_currentUserID)
      //.collection(widget.receiver.uid)
      // .orderBy("field", descending: true)
      // .snapshots(),

      ///
      ///
      stream.listen((dados) {
        _controle.add(dados);
      });
      print(receives);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    mostraMenssagem();
    //_verficaUsuario();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebedf9),
      //este appBar sera custimisado
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffebedf9),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        centerTitle: false,
        title: Text(
          widget.receiver.nome,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.video_call_sharp,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.phone,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      //Aqui fecha AppBar
      body: Column(
        children: <Widget>[
          Flexible(
            child: listaMenssagem(),
          ),
          chatControl(),
        ],
      ),
    );
  }

//Lista de Menssagem
  Widget listaMenssagem() {
    var _carregarDados = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.blue,
          ),
          Text(
            "Carregando Sua Conversa",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
    return StreamBuilder(
      stream: _controle.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return _carregarDados;
            break;
          case ConnectionState.active:
          case ConnectionState.done:
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
                  List<DocumentSnapshot> mensagex = querySnapshot.docs.toList();
                  DocumentSnapshot docomentSnap = mensagex[indice];
                  ModelMenssagem usuarios =
                      ModelMenssagem.fromDocumentSnapshot(docomentSnap);
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      alignment: usuarios.senderID == _currentUserID
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        child: usuarios.senderID == _currentUserID
                            ? Container(
                                margin: EdgeInsets.only(top: 12),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.65,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffdde1ed),
                                  borderRadius: BorderRadius.only(
                                    topLeft: messageRadius,
                                    topRight: messageRadius,
                                    bottomLeft: messageRadius,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      usuarios.menssagem,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    )),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 12),
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.65),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: messageRadius,
                                    topRight: messageRadius,
                                    bottomLeft: messageRadius,
                                  ),
                                  color: Color(0xffffffff),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        usuarios.menssagem,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                      )),
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
    );
  }

//
  adicinatodb(String text) async {
    var db = FirebaseFirestore.instance
        .collection("menssagem")
        .doc(_currentUserID)
        .collection(widget.receiver.uid)
        .doc("menssagem");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        db,
        {
          'senderID': _currentUserID,
          'menssagem': text,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'receiverID': receives,
          'tipo': "texto"
        },
      );
    });

    /* await db
        .collection("menssagem")
        .doc(_currentUserID)
        .collection(widget.receiver.uid)
        .doc("menssagem")
        .set({
      "senderID": _currentUserID,
      "menssagem": text,
      "tipo": "texto",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "receiverID": receives,
    });

    return await db
        .collection("menssagem")
        .doc(widget.receiver.uid)
        .collection(_currentUserID)
        .doc("menssagem")
        .set({
      "senderID": _currentUserID,
      "menssagem": text,
      "tipo": "texto",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "receiverID": receives,
    });*/
  }

  mandarMennsagem() async {
    var texto = textEditingController.text;

    setState(() {
      iswrite = false;
    });
    textEditingController.clear();
    adicinatodb(texto);
  }

//Aqui e parte onde se escreve menssagem
  Widget chatControl() {
    setWritingTo(bool vall) {
      setState(() {
        iswrite = vall;
      });
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
              child: IconButton(
                onPressed: () {
                  addMediaModal(context);
                },
                icon: Icon(
                  Icons.attach_file_sharp,
                  size: 25,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (val) {
                  (val.length > 0 && val.trim() != "")
                      ? setWritingTo(true)
                      : setWritingTo(false);
                },
                decoration: InputDecoration(
                    hintText: "Escreva uma Menssagem",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white70,
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.face,
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            iswrite
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Icon(Icons.camera_alt),
                  ),
            iswrite
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white70),
                    margin: EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 19,
                      ),
                      onPressed: () => mandarMennsagem(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  addMediaModal(context) {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: UniversalVariables.blackColor,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      child: Icon(
                        Icons.close,
                      ),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Partilha",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    ModalTile(
                      title: "Galeria",
                      subtitle: "Partilha de Foto",
                      icon: Icons.image,
                    ),
                    ModalTile(
                        title: "Documento",
                        subtitle: "Partilha De Documento",
                        icon: Icons.file_copy_sharp),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ModalTile({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        mini: false,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: UniversalVariables.receiverColor,
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: UniversalVariables.greyColor,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: UniversalVariables.greyColor,
            fontSize: 14,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
