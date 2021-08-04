import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/widget/Online_DotIndicator.dart';

class Perfil extends StatelessWidget {
  final Usuarios usuarios;

  const Perfil({Key key, @required this.usuarios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
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
            SizedBox(
              height: 20,
            ),
            Container(
              height: 298,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0)),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: CircleAvatar(
                                      maxRadius: 40,
                                      minRadius: 40,
                                      backgroundImage:
                                          NetworkImage(usuarios.foto),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  bottom: 10,
                                  right: 15.0,
                                  child: Stack(
                                    children: [
                                      OnlineDotIndicator(uid: usuarios.uid)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      usuarios.nome.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffaa9166),
                                      ),
                                    ),
                                    Text(
                                      usuarios.dataNas,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffaa9166),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Color(0xffaa9166),
                                ),
                                Text(
                                  usuarios.numero,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Color(0xffaa9166),
                                ),
                                Text(
                                  usuarios.email,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_history,
                                  color: Color(0xffaa9166)),
                              Row(
                                children: [
                                  Text("AV."),
                                  Text(
                                    usuarios.localizacao,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Editar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
