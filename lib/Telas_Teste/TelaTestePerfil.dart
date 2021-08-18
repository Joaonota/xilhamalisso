import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

import 'package:xilhamalisso/widget/cached_image.dart';
import 'package:xilhamalisso/widget/style.dart';

class TelaTestePerfil extends StatefulWidget {
  @override
  _TelaTestePerfilState createState() => _TelaTestePerfilState();
}

int numero = 0;
bool likes = false;
bool status = false;

class _TelaTestePerfilState extends State<TelaTestePerfil> {
  likesss() {
    if (likes == false) {
      setState(() {
        likes = true;
        status = true;
      });
      numero++;
    } else {
      if (likes == true) {
        setState(() {
          likes = false;
          status = false;
        });
        numero--;
      }
    }
    print(likes);
  }

  @override
  void dispose() {
    super.dispose();

    alertComentario();
  }

  alertComentario() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text("Escreva Seu Comentario"),
      content: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          hintText: "Comentario",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
      actions: [ElevatedButton(onPressed: () {}, child: Text("Enviar"))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Comentario",
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return alertComentario();
              });
        },
        backgroundColor: Colors.brown,
        child: Icon(Icons.comment),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              likesss();
                            },
                            icon: Icon(
                              likes == false
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: Colors.pink,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedImage(
                            "",
                            height: 100,
                            width: 100,
                            radius: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text(
                            "Joao Manuel Nota",
                            style: style(
                              size: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Informatico",
                            style: style(
                              isBold: true,
                              cor: Colors.orange,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.brown,
                              ),
                              Text("Joaonota23@gmail.com"),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 120),
                  child: Row(
                    children: [
                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.brown)),
                          onPressed: () {},
                          child: Text("Menssagem"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.brown)),
                          onPressed: () {},
                          child: Icon(Icons.phone),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Card(
                      elevation: 3,
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Likes",
                                    style: style(isBold: true, size: 18),
                                  ),
                                  Text(
                                    "Status",
                                    style: style(isBold: true, size: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(numero.toString()),
                                  status == true
                                      ? Text(
                                          "Online",
                                          style: style(
                                              isBold: true,
                                              cor: UniversalVariables
                                                  .onlineDotColor),
                                        )
                                      : Text(
                                          "Offline",
                                          style: style(
                                              isBold: true, cor: Colors.red),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 3,
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 290.0, top: 10),
                          child: Container(
                            child: Text(
                              "Sobre",
                              style: style(isBold: true, size: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "legislações videos etc.De igual forma tera que constar do website um canto para sugerir ao visitante que baixe o aplicativo.	O aplicativo ou App deve conter:",
                                  style: style(isBold: true),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone_android,
                                            color: Colors.brown,
                                          ),
                                          Text("845982017",
                                              style: style(isBold: true))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_history,
                                            color: Colors.brown,
                                          ),
                                          Text(
                                            "Av.jdhfjdhfjhdjhdjfhdjfh",
                                            style: style(isBold: true),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Card(
                    elevation: 6,
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  " Ultimo Comentario",
                                  style: style(size: 18, isBold: true),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  DateFormat('dd MMM kk:mm')
                                      .format(DateTime.now()),
                                  style: style(
                                      size: 15, cor: Colors.grey, isBold: true),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Ver Mais",
                                  style: style(cor: Colors.orangeAccent),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTile(
                          leading: Container(
                            constraints:
                                BoxConstraints(maxHeight: 60, maxWidth: 60),
                            child: Stack(
                              children: <Widget>[
                                CachedImage(
                                  "",
                                  height: 130,
                                  width: 130,
                                  radius: 10,
                                ),
                              ],
                            ),
                          ),
                          title: Text(
                            "Joao Manuel Nota",
                            style: style(
                                cor: Colors.black, size: 19, isBold: true),
                          ),
                          subtitle:
                              Text("wkwlwlklwkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
                //comentarios
              ],
            ),
          ),
        ],
      ),
    );
  }
}
