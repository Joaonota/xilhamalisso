import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xilhamalisso/Dados_do_Usuario/EditaUser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xilhamalisso',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditaUser(),
    );
  }
}
/*initialRoute: "/",
      routes: {
        "/": (context) => AutenticaUser(),
        "menssagem": (context) => Menssagem(),
        "verifica": (context) => VerificaCodigo(),*/