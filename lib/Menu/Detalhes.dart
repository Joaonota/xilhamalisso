import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Detalhes extends StatelessWidget {
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
              //Parte De Cima
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
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
                        "detalhes".toUpperCase(),
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
              //card com Detalhes
              SizedBox(
                height: 20,
              ),
              Container(
                height: 298,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    color: Colors.white,
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
                                padding: EdgeInsets.only(left: 3),
                                child: Column(
                                  children: [
                                    Text(
                                      "João Manuel Nota",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffaa9166)),
                                    ),
                                    Text(
                                      "Informatico".toUpperCase(),
                                      style: TextStyle(
                                        color: Color(0xffaa9166),
                                      ),
                                    )
                                  ],
                                ),
                              ))
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Color(0xffaa9166),
                                  ),
                                  Text(
                                    "(+258)8459-82017",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.mail,
                                    color: Color(0xffaa9166),
                                  ),
                                  Text(
                                    "joaoteste@gmail.com",
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
                                Text(
                                  "Av. Julius Nherere",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
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
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            "INFO",
                                          )
                                        ],
                                      ),
                                      content:
                                          Text("Deseja Efectuar o Pagamento?"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            CircularProgressIndicator();
                                          },
                                          child: Text("Sim"),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Não",
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "Menssagem",
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
              ),

              Container(
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Sobre",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xffaa9166),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Clicado");

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          title: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.warning,
                                                  color: Colors.red,
                                                ),
                                                Center(
                                                  child: Text("Atenção"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          content: Text(
                                            "Mediante o pagamento de uma taxa de 50mt. Tera que  Acesso a pagina de Conversa .",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("OK"),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "Aviso",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Um campo de chat que so será accionado mediante o pagamento de uma taxa de 50mt. Tera que ter opções de pagamento Mpsa ou mesmo por conta bancária. Para alem do chat devera ter a opcao de chamada para que o interessado poça se comunicar com os nossos profissionais.Um campo de chat que so será accionado mediante o pagamento de uma taxa de 50mt. Tera que ter opções de pagamento Mpsa ou mesmo por conta bancária. Para alem do chat devera ter a opcao de chamada para que o interessado poça se comunicar com os nossos profissionais.",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}
