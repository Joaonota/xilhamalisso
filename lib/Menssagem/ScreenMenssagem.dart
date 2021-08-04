import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/custimizado/CarregarDados.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodosFireba.dart';
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
  ScrollController _listScrollController = ScrollController();
  //
  final MetodosFirebase metodoFirebase = MetodosFirebase();

  bool iswrite = false;
  Usuarios sender;
  String _currentUserID;
  Radius messageRadius = Radius.circular(10);

  //

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

      stream.listen((dados) {
        _controle.add(dados);
      });
      //print(receives);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    //mostraMenssagem();
    _verficaUsuario();
    /*  metodoFirebase.getCurrentUser().then((users) {
      _currentUserID = users.uid;
      setState(() {
        sender =Usuarios()
      });
    });*/
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebedf9),
      //este appBar sera custimisado
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[100],
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("menssagem")
          .doc(_currentUserID)
          .collection(widget.receiver.uid)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        // SchedulerBinding.instance.addPostFrameCallback((_) {
        //   _listScrollController.animateTo(
        //     _listScrollController.position.minScrollExtent,
        //     duration: Duration(milliseconds: 250),
        //     curve: Curves.easeInOut,
        //   );
        // });

        return ListView.builder(
          padding: EdgeInsets.all(10),
          controller: _listScrollController,
          reverse: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            // mention the arrow syntax if you get the time
            return chatMessageItem(snapshot.data.docs[index]);
          },
        );
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    ModelMenssagem _message = ModelMenssagem.fromMap(snapshot.data());

    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Container(
        alignment: _message.senderID == _currentUserID
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderID == _currentUserID
            ? senderLayout(_message)
            : receiverLayout(_message),
      ),
    );
  }

  Widget senderLayout(ModelMenssagem message) {
    // Radius messageRadius = Radius.circular(10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Bubble(
            child: getMessagesend(message),
            color: Colors.green,
            padding: const BubbleEdges.all(10.0),
            margin: BubbleEdges.only(top: 4),
            nip: BubbleNip.rightTop,
            elevation: 8,
          ),
        ),
      ],
    );
  }
/*bbb
    Widget senderLayout(ModelMenssagem message) {
    Radius messageRadius = Radius.circular(10);

    return Bubble(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: UniversalVariables.senderColor,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }*/

  getMessagesend(ModelMenssagem message) {
    return Text(
      message.menssagem,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  getMessagereceive(ModelMenssagem message) {
    return Text(
      message.menssagem,
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget receiverLayout(ModelMenssagem message) {
    //Radius messageRadius = Radius.circular(10);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Bubble(
            child: getMessagereceive(message),
            color: Colors.white,
            padding: const BubbleEdges.all(10.0),
            margin: BubbleEdges.only(top: 4),
            nip: BubbleNip.leftTop,
            elevation: 8,
          ),
        ),
      ],
    );
  }

/*Widget receiverLayout(ModelMenssagem message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: UniversalVariables.receiverColor,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }*/
  /* adicinatodb(String text) async {
    /* var db = FirebaseFirestore.instance
        .collection("menssagem")
        .doc(_currentUserID)
        .collection(widget.receiver.uid)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        db,
        {
          'senderID': _currentUserID,
          'menssagem': text,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'receiverID': widget.receiver.uid,
          'tipo': "texto"
        },
      );
    });*/
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("menssagem")
        .doc(_currentUserID)
        .collection(widget.receiver.uid)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "senderID": _currentUserID,
      "menssagem": text,
      "tipo": "texto",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "receiverID": widget.receiver.uid,
    });
    adicionaContato(senderID: _currentUserID, receiverID: widget.receiver.uid);
    return await db
        .collection("menssagem")
        .doc(widget.receiver.uid)
        .collection(_currentUserID)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "senderID": _currentUserID,
      "menssagem": text,
      "tipo": "texto",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "receiverID": widget.receiver.uid,
    });
  }
*/
  mandarMennsagem() async {
    var texto = textEditingController.text;

    setState(() {
      iswrite = false;
    });
    textEditingController.clear();

    ModelMenssagem _modelMenssagem = ModelMenssagem(
        receiverID: widget.receiver.uid,
        senderID: _currentUserID,
        menssagem: texto,
        timestamp: Timestamp.now(),
        tipo: "texto");

    //
    metodoFirebase.adicinatodb(_modelMenssagem, sender, widget.receiver);
    //
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
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.all(5),
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
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
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
                      hintText: "Menssagem",
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
