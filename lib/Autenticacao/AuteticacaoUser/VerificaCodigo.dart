import 'package:flutter/material.dart';

class VerificaCodigo extends StatefulWidget {
  @override
  _VerificaCodigoState createState() => _VerificaCodigoState();
}

class _VerificaCodigoState extends State<VerificaCodigo> {
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
                        "Introduza Codigo",
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Digite O Codigo Enviado",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
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
                  onPressed: () {},
                  child: Text(
                    "Verfificar",
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
