import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificaCodigo extends StatefulWidget {
  final String verificationId;

  const VerificaCodigo({Key key, this.verificationId}) : super(key: key);
  @override
  _VerificaCodigoState createState() => _VerificaCodigoState();
}

class _VerificaCodigoState extends State<VerificaCodigo> {
  TextEditingController codeController = TextEditingController();
  int start = 60;

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/fotos/foto1.png",
                        height: 250,
                      ),
                      Text(
                        "Introduza o Codigo Enviado",
                        style: GoogleFonts.ebGaramond(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tempo Restante:",
                                    style: GoogleFonts.ebGaramond(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    " $start",
                                    style: GoogleFonts.ebGaramond(
                                      fontSize: 19.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10, left: 30),
                                child: Container(
                                  width: 330,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    autocorrect: false,
                                    autofocus: false,
                                    controller: codeController,
                                    decoration: InputDecoration(
                                      hintText: '••••',
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 21,
                                ),
                                child: Container(
                                  width: 335,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                    onPressed: () async {
                                      var code = codeController.text.trim();
                                      print("smsCode:$code");
                                      AuthCredential gredecial =
                                          PhoneAuthProvider.credential(
                                        verificationId: widget.verificationId,
                                        smsCode: codeController.text,
                                      );
                                      var result = await auth
                                          .signInWithCredential(gredecial);
                                      User user = result.user;
                                      if (user != null) {
                                        print("Verficado");

                                        final QuerySnapshot resulta =
                                            await FirebaseFirestore.instance
                                                .collection("usuarios")
                                                .where("uid",
                                                    isEqualTo: user.uid)
                                                .get();

                                        final List<DocumentSnapshot> documents =
                                            resulta.docs;
                                        if (documents.length == 0) {
                                          print("novo usuario");
                                          /*Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => EditaUser(),
                                    ),
                                  );*/
                                          Navigator.of(context)
                                              .pushReplacementNamed("/novo");
                                        } else {
                                          print("Usuario existete");
                                          //
                                          await FirebaseFirestore.instance
                                              .collection("usuarios")
                                              .where("uid", isEqualTo: user.uid)
                                              .get()
                                              .then((docs) async {
                                            if (docs.docs[0].exists) {
                                              if (docs.docs[0]
                                                      .data()["painel"] ==
                                                  "pro") {
                                                /* Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => HomePro(),
                                          ),
                                        );*/
                                                //

                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        "/homePro");
                                              }
                                            }
                                            if (documents.length == 1) {
                                              await FirebaseFirestore.instance
                                                  .collection("usuarios")
                                                  .where("uid",
                                                      isEqualTo: user.uid)
                                                  .get()
                                                  .then((docs) {
                                                if (docs.docs[0].exists) {
                                                  if (docs.docs[0]
                                                          .data()["painel"] ==
                                                      "cliente") {
                                                    /* Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PageMenu(),
                                              ),
                                            );*/
                                                    //
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            "/Menu");
                                                  }
                                                }
                                              });
                                            }
                                          });
                                        }

                                        ////
                                        /*Navigator.pop(context);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => PageMenu(),
                                    ),
                                  );*/
                                      }
                                    },
                                    child: Text(
                                      "Continuar",
                                      style: TextStyle(fontSize: 23),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
