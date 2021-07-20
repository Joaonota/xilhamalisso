import 'package:flutter/material.dart';

class AutenticacaoAdmin extends StatefulWidget {
  @override
  _AutenticacaoAdminState createState() => _AutenticacaoAdminState();
}

class _AutenticacaoAdminState extends State<AutenticacaoAdmin> {
  String tCodigo;
  String tSenha;

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
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: TextField(
                  onChanged: (codigo) {
                    tCodigo = codigo;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    hintText: "Introduza Sua Credecial",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: TextField(
                  onChanged: (b) {
                    tSenha = b;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.https),
                    hintText: "Introduza Seu Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffaa9166),
                    borderRadius: BorderRadius.circular(15)),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Acessar",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
