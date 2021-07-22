import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xilhamalisso/custimizado/textFielCustomizado.dart';

class EditaUser extends StatefulWidget {
  @override
  _EditaUserState createState() => _EditaUserState();
}

File imageFile;
TextEditingController cEmail = TextEditingController();
TextEditingController cLocaliza = TextEditingController();
TextEditingController cNome = TextEditingController();
TextEditingController cNasci = TextEditingController();
GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                    children: [
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
                        hintText: "Localização",
                        prefixIcon: Icon(Icons.location_history),
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      uploadAndSaveImage();
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

  /// Upload de Foto do usuario
  uploadAndSaveImage() {
    if (imageFile == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Seleciona Uma Image"),
        ),
      );
    } else {
      print(imageFile.toString());
    }
  }

//
  //Registro Do Usuario
  Future registaUser(User fUser) async {
    //chamada de firestore
    FirebaseFirestore.instance.collection("Usuarios").doc(fUser.uid).set({
      "uid": fUser.uid,
      "numero": fUser.phoneNumber,
      "nome": cNome.text.trim(),
      "Nascimento": cNasci.text.trim(),
      "emial": cEmail.text.trim(),
      "localiza": cLocaliza.text.trim(),
    });
  }
}
