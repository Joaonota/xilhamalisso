import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:xilhamalisso/Autenticacao/AuteticacaoUser/AutenticaUser.dart';
import 'package:xilhamalisso/DialogoBox/ErrorAlertDialog.dart';
import 'package:xilhamalisso/DialogoBox/LoadingAlertDialog.dart';
import 'package:xilhamalisso/Menu/Page_menu.dart';
import 'package:xilhamalisso/custimizado/textFielCustomizado.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditaUser extends StatefulWidget {
  @override
  _EditaUserState createState() => _EditaUserState();
}

String userUrl = "";
File imageFile;
bool isConnectd;
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
                              border: InputBorder.none,
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
                    onPressed: () async {
                      // uploadAndSaveImage();
                      final bool isConnectd =
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
                      );*/
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
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          content: Text("Por favor selecione uma imagem"),
        ),
      );
    } else {
      cEmail.text.isNotEmpty &&
              cNome.text.isNotEmpty &
                  cNasci.text.isNotEmpty &
                  cLocaliza.text.isEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                content: Text("Por favor preencha todo Formulario..."),
              ),
            )
          : uploadStorage();
      print("imagem $imageFile.toString()");
    }
  }

  Future uploadStorage() async {
    showDialog(
        context: context,
        builder: (builder) {
          return LoadingAlertDialog(
            menssagem: "Actualizando Seus Dados",
          );
        });

    //upload da imagem
    String nomeImage = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    firebase_storage.Reference pastaRaiz = storage.ref();
    firebase_storage.Reference arquivo =
        pastaRaiz.child("fotos").child(nomeImage);

    firebase_storage.UploadTask uploadTask = arquivo.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();
    print("url da imagem $url");

    registaUser(url);
  }

  //verficar se usuario esta logado

//
  //Registro Do Usuario
  Future registaUser(String url) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser;
    fUser = auth.currentUser;

    if (fUser != null) {
      FirebaseFirestore.instance
          .collection("usuarios")
          .doc(fUser.uid)
          .collection("meus_dados")
          .doc(fUser.phoneNumber)
          .set({
        "uid": fUser.uid,
        "numero": fUser.phoneNumber,
        "nome": cNome.text.trim(),
        "nascimento": cNasci.text.trim(),
        "email": cEmail.text.trim(),
        "localiza": cLocaliza.text.trim(),
        "foto": url
      });
      print("Usuario cadastrado");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => PageMenu()));
    } else {
      print("Nao Foi possivel Cadastar");
    }
    //chamada de firestore
  }

  Future verficauUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado;
    usuarioLogado = auth.currentUser;
    if (usuarioLogado == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AutenticaUser(),
        ),
      );
    } else {
      print("Voce esta");
    }
  }

  @override
  void initState() {
    super.initState();
    verficauUsuarioLogado();
  }
}
