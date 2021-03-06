import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AutenticaUser extends StatefulWidget {
  @override
  _AutenticaUserState createState() => _AutenticaUserState();
}

class _AutenticaUserState extends State<AutenticaUser> {
  int start = 33;
  bool wait = false;
  bool isvible;
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  //
  PhoneNumber number = PhoneNumber(isoCode: 'MZ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Autenticação  Pelo Número",
                        style: GoogleFonts.ebGaramond(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Escolha seu País e Introduza seu Número",
                                style: GoogleFonts.ebGaramond(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10, left: 30),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InternationalPhoneNumberInput(
                                      selectorConfig: SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                      ),
                                      inputBorder: InputBorder.none,
                                      ignoreBlank: false,
                                      textFieldController: phoneController,
                                      maxLength: 13,
                                      onInputChanged: (PhoneNumber numero) {
                                        number = numero;

                                        print(number);
                                      },
                                      initialValue: number,
                                      hintText: "Introduza Seu Número",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              isvible == true
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Text("Aguarde o codigo"),
                                          CircularProgressIndicator.adaptive(),
                                        ],
                                      ),
                                    )
                                  : Container(),
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
                                    onPressed: () {
                                      // alertCircular();
                                      //startTimer();
                                      setState(() {
                                        isvible = true;
                                      });
                                      phoneController.text = number.toString();
                                      regitarUserPhone(
                                          phoneController.text.trim(), context);
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

  agurdeProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future regitarUserPhone(String telefone, BuildContext context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: telefone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredencial) async {
          var resul = await _firebaseAuth.signInWithCredential(authCredencial);
          print("erro $resul");
        },
        verificationFailed: (exception) {
          showDialog(
              context: context,
              builder: (builder) {
                return Container(
                  child: AlertDialog(
                    content: Container(
                      child: Text("$exception"),
                    ),
                  ),
                );
              });
          print("fallha{$exception}");
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              builder: (c) {
                return Container(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: Text(
                      "Introduza O Codigo Enviado",
                    ),
                    content: TextField(
                      maxLength: 6,
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Introduza o Codigo Enviado",
                      ),
                    ),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                            onPressed: () async {
                              var code = codeController.text.trim();
                              print("smsCode:$code");
                              AuthCredential gredecial =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: code,
                              );
                              var result = await _firebaseAuth
                                  .signInWithCredential(gredecial);
                              User user = result.user;
                              if (user != null) {
                                print("Verficado");

                                final QuerySnapshot resulta =
                                    await FirebaseFirestore.instance
                                        .collection("usuarios")
                                        .where("uid", isEqualTo: user.uid)
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
                                      if (docs.docs[0].data()["painel"] ==
                                          "pro") {
                                        /* Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => HomePro(),
                                          ),
                                        );*/
                                        //

                                        Navigator.of(context)
                                            .restorablePushReplacementNamed(
                                                "homePro");
                                      }
                                    }
                                    if (documents.length == 1) {
                                      await FirebaseFirestore.instance
                                          .collection("usuarios")
                                          .where("uid", isEqualTo: user.uid)
                                          .get()
                                          .then((docs) {
                                        if (docs.docs[0].exists) {
                                          if (docs.docs[0].data()["painel"] ==
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
                                                .pushReplacementNamed("/Menu");
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
                              "Verfificar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      )
                    ],
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  alertCircular() {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            content: Column(
              children: [CircularProgressIndicator(), Text("Agurde o Codigo")],
            ),
          );
        });
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
