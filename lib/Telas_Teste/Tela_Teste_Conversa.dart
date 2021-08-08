import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xilhamalisso/Telas_Teste/Tela_teste_ligar.dart';

class TelaConversa extends StatefulWidget {
  @override
  _TelaConversaState createState() => _TelaConversaState();
}

class _TelaConversaState extends State<TelaConversa> {
  bool mudo = false;
  String tempoFalr = "00:00:06";
  String displayTime = "00";

  var watchPhome = Stopwatch();
  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() {
    Timer(Duration(seconds: 1), iniciaCont);
    watchPhome.start();
  }

  iniciaCont() {
    if (watchPhome.isRunning) {
      startTimer();
    }
    setState(() {
      displayTime = watchPhome.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (watchPhome.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (watchPhome.elapsed.inSeconds % 60).toString().padLeft(2, "0");
      print(displayTime);

      if (displayTime == tempoFalr) {
        print("execedeu o Tempo");
        watchPhome.stop();
      }
    });
  }

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
                  "Em Conversa..",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Container(
                  child: CircleAvatar(
                    maxRadius: 79,
                    minRadius: 79,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                child: Center(
                  child: Text(
                    "Emidio Sitoe",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.record_voice_over,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        displayTime,
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 170,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100)),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                mudo = !mudo;
                              });
                            },
                            child: Icon(
                              mudo ? Icons.mic_off : Icons.mic,
                              color: mudo ? Colors.blue : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.speaker,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100)),
                            child: TextButton(
                              onPressed: () {
                                watchPhome.stop();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (builder) => TelaTesteLigar(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.call_end,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
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
