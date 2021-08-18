import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xilhamalisso/Introducao/introducao.dart';

class GetStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown[500], //Color(0xffaa9166),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Xilhamalisso",
                      style: GoogleFonts.ebGaramond(
                          fontSize: 50,
                          color: Color(0xff121518),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Melhor Serviço Online",
                      style: GoogleFonts.ebGaramond(
                          fontSize: 25, color: Color(0xff121518)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Um campo de chat que so será accionado mediante o pagamento de uma taxa de 50mt.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ebGaramond(
                          fontSize: 30,
                          color: Color(0xff121518),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Introducao()));
                      },
                      child: Text(
                        "Comecar",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
