import 'package:flutter/material.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

import 'chat_list_screen.dart';

class Menssagem extends StatefulWidget {
  @override
  _MenssagemState createState() => _MenssagemState();
}

class _MenssagemState extends State<Menssagem> {
  TextEditingController textEditingController = TextEditingController();
  bool iswrite = false;
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
          "Joao Nota",
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
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 1,
      itemBuilder: (contex, index) {
        return Column(
          children: [
            chatMessageItem(),
            chatMessageItem1(),
          ],
        );
      },
    );
  }

//Item onde contem menssagem
  Widget chatMessageItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: Alignment.centerRight,
        child: Column(
          children: [senderLayout()],
        ),
      ),
    );
  }

  Widget chatMessageItem1() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [receiveLayout()],
        ),
      ),
    );
  }

  Widget senderLayout() {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.65,
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
          "Um campo de chat que so será accionado mediante o pagamento de uma taxa de 50mt.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget receiveLayout() {
    Radius menssagemRadius = Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: menssagemRadius,
          topRight: menssagemRadius,
          bottomLeft: menssagemRadius,
        ),
        color: Color(0xffffffff),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "OK.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
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
                      onPressed: () {},
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
