import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xilhamalisso/Menu/Detalhes.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffebedf9),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              //parte de Cima
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.gavel,
                        color: Color(0xffaa9166),
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Text(
                        "Advogados Disponiveis".toUpperCase(),
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
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detalhes(),
                    ),
                  );
                },
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
                                    CircleAvatar(
                                      maxRadius: 30,
                                      minRadius: 30,
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
                                      "Emidio Sitoe",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("ADVOGADO")
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
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
                                  CircleAvatar(
                                    maxRadius: 30,
                                    minRadius: 30,
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
                                      color: Color(0xffeb302f),
                                      size: 19,
                                    ),
                                  ],
                                ))
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
                                    "João Manuel Nota",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Informatico".toUpperCase())
                                ],
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
