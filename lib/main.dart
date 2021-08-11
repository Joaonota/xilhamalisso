import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/Autenticacao/AuteticacaoUser/VerificaCodigo.dart';
import 'package:xilhamalisso/Dados_do_Usuario/EditaUser.dart';
import 'package:xilhamalisso/Menu/Page_menu.dart';
import 'package:xilhamalisso/profissional/HomePro.dart';
import 'package:xilhamalisso/provider/UserProvider.dart';
import 'package:xilhamalisso/provider/image_upload_provider.dart';

import 'Telas_Teste/TelaTestePhone.dart';

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
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Xilhamalisso',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePro(),
          '/novo': (context) => EditaUser(),
          '/homePro': (context) => HomePro(),
          '/Menu': (context) => PageMenu(),
        },
        //EditaProfissional(),, //ChatList()
      ),
    );
  }
}


/*initialRoute: "/",


initialRoute: '/',
        routes: {
          '/': (context) => FirstRun(),
          'homePro': (context) => HomePro(),
          'cliente': (context) => PageMenu(),
          "novo": (context) => EditaUser(),
        },
///
      routes: {
        "/": (context) => AutenticaUser(),
        "menssagem": (context) => Menssagem(),
        "verifica": (context) => VerificaCodigo(),*/
