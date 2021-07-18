import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class AutenticaUser extends StatefulWidget {
  @override
  _AutenticaUserState createState() => _AutenticaUserState();
}

class _AutenticaUserState extends State<AutenticaUser> {
  String phone;
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
                        "Escolha seu Pais e Introduza seu Numero",
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
            Container(
              child: InternationalPhoneInput(
                decoration: InputDecoration(
                  hintText: "Introduza seu numero",
                  border: OutlineInputBorder(),
                ),
                initialPhoneNumber: phone,
                initialSelection: "MZ",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
