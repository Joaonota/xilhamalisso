import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AutenticaUser extends StatefulWidget {
  @override
  _AutenticaUserState createState() => _AutenticaUserState();
}

class _AutenticaUserState extends State<AutenticaUser> {
  String numeroT;
  PhoneNumber number = PhoneNumber(isoCode: 'MZ');
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
                      Text("Escolha seu Pais e Introduza seu Numero",
                          style: GoogleFonts.ebGaramond(
                              fontSize: 25, color: Colors.white)),
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
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InternationalPhoneNumberInput(
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        inputBorder: InputBorder.none,
                        ignoreBlank: true,
                        onInputChanged: (PhoneNumber numero) {
                          number = numero;
                          print(number);
                        },
                        initialValue: number,
                        maxLength: 11,
                        hintText: "Introduza Seu Número",
                        textStyle: GoogleFonts.ebGaramond(fontSize: 20)),
                  )),
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
                    verficaTelefone();
                    login();
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

  String verficaID;
  String smsCode;
  Future<void> verficaTelefone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetri = (String verID) {
      this.verficaID = verID;
    };
    final PhoneCodeSent smsCodeSent = (String verID, [int forceCodeSent]) {
      this.verficaID = verID;
    };
    final PhoneVerificationCompleted verficaSucessl =
        (AuthCredential authCredential) {
      print("Verficado");
    };
    final PhoneVerificationFailed verificationFaile =
        (FirebaseAuthException excpecao) {
      print("falha ${excpecao.message}");
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+258845982017',
        verificationCompleted: verficaSucessl,
        verificationFailed: verificationFaile,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetri,
        timeout: Duration(seconds: 5));
  }

  login() {
    var _credencial = PhoneAuthProvider.credential(
        verificationId: verficaID, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(_credencial).then((e) {
      print("Codigo");
    }).catchError((e) {
      print(e);
    });
  }
  //

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'MZ');

    setState(() {
      this.number = number;
      numeroT = phoneNumber;
    });
  }
}
/*Padding(
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
            ),*/