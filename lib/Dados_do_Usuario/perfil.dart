import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xilhamalisso/models/usuarios.dart';

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
              child: Card(
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                usuarios.nome,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffaa9166),
                                ),
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
