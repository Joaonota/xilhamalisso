import 'package:flutter/material.dart';

class AutenticaUser extends StatefulWidget {
  @override
  _AutenticaUserState createState() => _AutenticaUserState();
}

class _AutenticaUserState extends State<AutenticaUser> {
  String numero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff291b12),
      body: Container(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Xilhamalisso",
                        style: TextStyle(
                          fontSize: 55.0,
                          color: Colors.white,
                          fontFamily: "Signatra",
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
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Escolha seu Pais e Introduza seu Numero",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontFamily: "Signatra",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (c) {
                    numero = c;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("verifica");
                  },
                  child: Text(
                    "Continuar",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
