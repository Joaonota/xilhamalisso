import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xilhamalisso/custimizado/textFielCustomizado.dart';
import 'package:xilhamalisso/models/AreaActuacao.dart';

class EditaProfissional extends StatefulWidget {
  @override
  _EditaProfissionalState createState() => _EditaProfissionalState();
}

String userUrl = "";
File imageFile;
bool isConnectd;
String painel = "cliente";
TextEditingController cEmail = TextEditingController();
TextEditingController cLocaliza = TextEditingController();
TextEditingController cNome = TextEditingController();
TextEditingController cNasci = TextEditingController();
GlobalKey<FormState> _formkey = GlobalKey<FormState>();
List<DropdownMenuItem<String>> _listaDropArea = [];
String _itemSelecionadoArea;

class _EditaProfissionalState extends State<EditaProfissional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff291b12),
        title: Text("Perfil"),
        leading: Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(),
              GestureDetector(
                onTap: () {
                  // carregaFoto();
                },
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          imageFile == null ? null : FileImage(imageFile),
                      maxRadius: 60,
                      child: imageFile == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey[100],
                                ),
                                Text(
                                  "Adicionar",
                                  style: GoogleFonts.ebGaramond(
                                      color: Colors.grey[100]),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFieldCustomizado(
                      controller: cNome,
                      prefixIcon: Icon(Icons.person),
                      hintText: "Nome",
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DateTimePicker(
                          dateMask: 'd MMM, yyyy',
                          controller: cNasci,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.event),
                            hintText: "Data de Nascimento",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          type: DateTimePickerType.date,
                          firstDate: DateTime(197),
                          lastDate: DateTime(2100),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextFieldCustomizado(
                      hintText: "E-mail",
                      controller: cEmail,
                      prefixIcon: Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextFieldCustomizado(
                      hintText: "Localização",
                      controller: cLocaliza,
                      prefixIcon: Icon(Icons.location_history),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          hint: Text("Area De Actuacao"),
                          value: _itemSelecionadoArea,
                          items: _listaDropArea,
                          onChanged: (valor) {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      // uploadAndSaveImage();
                      /*final bool isConnectd =
                          await InternetConnectionChecker().hasConnection;
                      print(isConnectd);

                      isConnectd == false
                          ? showDialog(
                              context: context,
                              builder: (builder) {
                                return ErrorAlertDialog(
                                  menssagem:
                                      "Conecte a Internet Para Continuar",
                                );
                              })
                          : uploadAndSaveImage();
                      /* Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => PageMenu(),
                        ),
                      );*/ */
                    },
                    child: Text(
                      "Gravar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    carregarDropDowArea();
  }

  carregarDropDowArea() {
    for (var areaActu in AreaActacao.areaActuas) {
      _listaDropArea.add(DropdownMenuItem(
        child: Text(areaActu),
        value: areaActu,
      ));
    }
  }
}
