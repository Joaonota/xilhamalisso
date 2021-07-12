import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PageMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000), //Color(0xff101018),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffaa9166)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    //primeiro Grid
                    GestureDetector(
                      onTap: () {
                        print("Clicado o primeiro Grid");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff121518),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.landmark,
                                size: 85,
                                color: Color(0xffaa9166),
                              ),
                              Divider(),
                              Text(
                                "Consultas Jurídicas",
                                style: GoogleFonts.ebGaramond(
                                    fontSize: 18.0,
                                    color: Color(0xffaa9166),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //segundo grid
                    GestureDetector(
                      onTap: () {
                        print("Clicado o segudno Grid");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff121518),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.users,
                                size: 85,
                                color: Color(0xffaa9166),
                              ),
                              Divider(),
                              Text(
                                "Assistencia Psicológica",
                                style: GoogleFonts.ebGaramond(
                                    fontSize: 18.0,
                                    color: Color(0xffaa9166),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Terceiro grid
                    GestureDetector(
                      onTap: () {
                        print("Clicado o terceiro grid");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff121518),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.handHoldingHeart,
                                size: 85,
                                color: Color(0xffaa9166),
                              ),
                              Divider(),
                              Text(
                                "Consulta a Nutricionista",
                                style: GoogleFonts.ebGaramond(
                                    fontSize: 16.5,
                                    color: Color(0xffaa9166),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Quarto grid
                    GestureDetector(
                      onTap: () {
                        print("Clicado o quarto Grid");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff121518),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.userAlt,
                                size: 85,
                                color: Color(0xffaa9166),
                              ),
                              Divider(),
                              Text(
                                "Minha Conta",
                                style: GoogleFonts.ebGaramond(
                                    fontSize: 18.0,
                                    color: Color(0xffaa9166),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
