import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class AutenticaUser extends StatefulWidget {
  @override
  _AutenticaUserState createState() => _AutenticaUserState();
}

class _AutenticaUserState extends State<AutenticaUser> {
  int start = 30;
  bool wait = false;
  bool isvible = true;
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
                                "Escolha seu Pais e Introduza seu Número",
                                style: GoogleFonts.ebGaramond(
                                  fontSize: 25,
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
                                      textStyle:
                                          GoogleFonts.ebGaramond(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 330,
                                child: ElevatedButton(
                                  onPressed: () {
                                    startTimer();
                                    phoneController.text = number.toString();
                                    regitarUserPhone(
                                        phoneController.text.trim(), context);
                                  },
                                  child: Text(
                                    "Continuar",
                                    style: TextStyle(fontSize: 19),
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

  Future regitarUserPhone(String telefone, BuildContext context) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: telefone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredencial) async {
          var resul = await _firebaseAuth.signInWithCredential(authCredencial);
          print("erro");
        },
        verificationFailed: (exception) {
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
                    content: OTPTextField(
                      onChanged: (cd) {
                        cd = codeController.text.toString().trim();
                      },
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.grey[200],
                        focusBorderColor: Colors.blue,
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
                              final code = codeController.text.trim();
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
                              } else {
                                print("erro");
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

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
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
