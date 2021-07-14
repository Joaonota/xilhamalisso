import 'package:flutter/material.dart';

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
              onPressed: () {},
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
              Icons.video_call,
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
      itemCount: 12,
      itemBuilder: (contex, index) {
        return chatMessageItem();
      },
    );
  }

//Item onde contem menssagem
  Widget chatMessageItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: senderLayout(),
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
        color: Colors.yellow,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Ola",
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
            topLeft: menssagemRadius,
            topRight: menssagemRadius),
        color: Color(0xffdde1ed),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Ola Mundo",
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
              child: Icon(
                Icons.attach_file_sharp,
                size: 25,
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
}
