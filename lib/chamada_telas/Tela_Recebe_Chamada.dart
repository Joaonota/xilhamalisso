import 'package:flutter/material.dart';
import 'package:xilhamalisso/chamada_telas/TelaChamda.dart';
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
        color: Color(0xffaa9166),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Chamada Recebida...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            CircleAvatar(
              maxRadius: 80,
              minRadius: 80,
              backgroundImage: NetworkImage(chamada.chamadaPic),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                chamada.chamadaNome,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await metodoChamada.endCall(chamada: chamada);
                    },
                    child: Icon(Icons.call_end),
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaChamada(chamada: chamada),
                      ),
                    ),
                    child: Icon(Icons.call),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
