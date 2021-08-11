import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class TelaTestePhone extends StatefulWidget {
  @override
  _TelaTestePhoneState createState() => _TelaTestePhoneState();
}

class _TelaTestePhoneState extends State<TelaTestePhone> {
  bool isvible;
  TextEditingController phoneController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'MZ');
  String verificationId;

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
                                      phoneController.text = number.toString();
                                      registarNumero(
                                          phoneController.text.trim());
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

  Future registarNumero(String numero) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;

      Navigator.of(context)
          .pushNamed("codigoSms", arguments: this.verificationId);
    };
    //
    auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: numero,
        verificationCompleted: (AuthCredential authCredencial) async {
          var result = await auth.signInWithCredential(authCredencial);
          print(result);
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
        },
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
