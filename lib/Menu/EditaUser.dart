import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xilhamalisso/custimizado/textFielCustomizado.dart';

class EditaUser extends StatefulWidget {
  @override
  _EditaUserState createState() => _EditaUserState();
}

File imageFile;

class _EditaUserState extends State<EditaUser> {
  carregaFoto() async {
    final getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (getImage != null) {
        imageFile = File(getImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff291b12),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff291b12),
        title: Text("Perfil"),
        leading: Icon(Icons.arrow_back),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(),
              GestureDetector(
                onTap: () {
                  carregaFoto();
                },
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: FileImage(imageFile),
                      maxRadius: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey[100],
                          ),
                          Text(
                            "Adicionar",
                            style:
                                GoogleFonts.ebGaramond(color: Colors.grey[100]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldCustomizado(
                prefixIcon: Icon(Icons.person),
                hintText: "Nome",
              ),
              SizedBox(
                height: 14,
              ),
              TextFieldCustomizado(
                prefixIcon: Icon(Icons.calendar_today),
                hintText: "Data de Nascimento",
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(
                height: 14,
              ),
              TextFieldCustomizado(
                hintText: "E-mail",
                prefixIcon: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 14,
              ),
              TextFieldCustomizado(
                prefixIcon: Icon(Icons.phone),
                hintText: "Numero de Telefone",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 14,
              ),
              TextFieldCustomizado(
                hintText: "Localização",
                prefixIcon: Icon(Icons.location_history),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: TextButton(
                    onPressed: () {},
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
}
