import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/Introducao/introducao.dart';
import 'package:xilhamalisso/Menu/Page_menu.dart';
import 'package:xilhamalisso/profissional/HomePro.dart';
import 'package:xilhamalisso/profissional/dasboardPro.dart';
import 'package:xilhamalisso/provider/UserProvider.dart';

import 'chamada_telas/Tela_Recebe_Chamada.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Xilhamalisso',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePro() //EditaProfissional(),, //ChatList()
          ),
    );
  }
}


/*initialRoute: "/",
      routes: {
        "/": (context) => AutenticaUser(),
        "menssagem": (context) => Menssagem(),
        "verifica": (context) => VerificaCodigo(),*/
