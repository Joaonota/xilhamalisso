import 'package:flutter/material.dart';
import 'package:xilhamalisso/chamada_telas/Telaligar.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodoChamada.dart';
import 'package:xilhamalisso/models/chamada.dart';

class TelaRecebeChamada extends StatelessWidget {
  final Chamada chamada;
  final MetodoChmada metodoChamada = MetodoChmada();
  TelaRecebeChamada({@required this.chamada});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff0f1921),
                Color(0xff2f0015),
              ]),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  "A Receber uma Chamada...",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Container(
                  child: CircleAvatar(
                    maxRadius: 80,
                    minRadius: 80,
                    backgroundImage: NetworkImage(chamada.chamadaPic),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                child: Center(
                  child: Text(
                    chamada.chamadaNome,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Text(
                    "+258845982017",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),*/
            SizedBox(
              height: 200,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaLigar(chamada: chamada),
                          ),
                        ),
                        child: Icon(Icons.call),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            )),
                        onPressed: () async {
                          print("Desligou");

                          await metodoChamada.endCall(chamada: chamada);
                        },
                        child: Icon(Icons.call_end),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
