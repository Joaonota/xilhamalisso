import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xilhamalisso/Autenticacao/AuteticacaoUser/AutenticaUser.dart';
import 'package:xilhamalisso/Dados_do_Usuario/DetalhesUser.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/sobre/sobre.dart';

import 'Chat_List.dart';

class DetalhesMenu extends StatefulWidget {
  final Usuarios usuarios;
  //

  const DetalhesMenu({Key key, this.usuarios}) : super(key: key);

  @override
  _DetalhesMenuState createState() => _DetalhesMenuState();
}

class _DetalhesMenuState extends State<DetalhesMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffaa9166),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "",
                                    style: GoogleFonts.ebGaramond(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "",
                                    style: GoogleFonts.ebGaramond(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      deslogar();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.powerOff,
                                    ),
                                  ),
                                  PopupMenuButton(
                                    onSelected: itemSelecionado,
                                    itemBuilder: (contex) {
                                      return itemLista.map((String item) {
                                        return PopupMenuItem(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }).toList();
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            "Xilhamalisso",
                            style: GoogleFonts.ebGaramond(
                                fontSize: 50,
                                color: Color(0xff121518),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Melhor Serviço Online",
                            style: GoogleFonts.ebGaramond(
                                fontSize: 25, color: Color(0xff121518)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              /// Aqui Comeca o grid
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatList(),
                    ),
                  );
                  print("Clicado o primeiro Grid");
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Primeiro e segundo Grid
                        Container(
                          child: Row(
                            children: [
                              //Priemiro Grid
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xff121518),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Icon(
                                            FontAwesomeIcons.balanceScale,
                                            size: 85,
                                            color: Color(0xffaa9166),
                                          ),
                                        ),
                                        Divider(),
                                        Text(
                                          "Consultas Jurídicas",
                                          style: GoogleFonts.ebGaramond(
                                              fontSize: 18.0,
                                              color: Color(0xffaa9166),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 29,
                              ),
                              //Segundo grid
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xff121518),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Icon(
                                            FontAwesomeIcons.users,
                                            size: 85,
                                            color: Color(0xffaa9166),
                                          ),
                                        ),
                                        Divider(),
                                        Text(
                                          "Assistencia Psicológica",
                                          style: GoogleFonts.ebGaramond(
                                              fontSize: 15.0,
                                              color: Color(0xffaa9166),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //termeina o grid de cima
              Divider(),
              //aqui comeca a segunda linha
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Primeiro e segundo Grid
                      Container(
                        child: Row(
                          children: [
                            //Priemiro Grid
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color(0xff121518),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Icon(
                                          FontAwesomeIcons.handHoldingHeart,
                                          size: 85,
                                          color: Color(0xffaa9166),
                                        ),
                                      ),
                                      Divider(),
                                      Text(
                                        "Consulta Nutricionista",
                                        style: GoogleFonts.ebGaramond(
                                            fontSize: 15.0,
                                            color: Color(0xffaa9166),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            //Segundo grid
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalhesUser(),
                                  ),
                                );
                                print("Clicado o Utimo  Grid");
                              },
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xff121518),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Icon(
                                            FontAwesomeIcons.userAlt,
                                            size: 85,
                                            color: Color(0xffaa9166),
                                          ),
                                        ),
                                        Divider(),
                                        Text(
                                          "Minha Conta",
                                          style: GoogleFonts.ebGaramond(
                                              fontSize: 18.0,
                                              color: Color(0xffaa9166),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> itemLista = ["Sobre"];

  itemSelecionado(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Sobre":
        print(itemEscolhido);
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => Sobre()));
        break;
      default:
    }
  }

  Future deslogar() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => AutenticaUser()));
  }
}
