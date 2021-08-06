import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/chamada_telas/Tela_Recebe_Chamada.dart';
import 'package:xilhamalisso/custimizado/CarregarDados.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodoChamada.dart';
import 'package:xilhamalisso/models/chamada.dart';
import 'package:xilhamalisso/provider/UserProvider.dart';

class PickoutLayout extends StatelessWidget {
  final Widget scaffold;
  final MetodoChmada metodoChmada = MetodoChmada();
  PickoutLayout({@required this.scaffold});
  //
  @override
  Widget build(BuildContext context) {
    final UsuarioProvider usuarioProvider =
        Provider.of<UsuarioProvider>(context);
    return (usuarioProvider != null && usuarioProvider.getUSer != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: metodoChmada.callStream(uid: usuarioProvider.getUSer.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.data() != null) {
                Chamada chamada = Chamada.fromMap(snapshot.data.data());

                if (!chamada.hasDisabled) {
                  return TelaRecebeChamada(chamada: chamada);
                }
              }
              return scaffold;
            },
          )
        : Scaffold(
            body: Center(
              child: CarregarDados(
                  text: "A Carregar", colors: Colors.deepOrangeAccent),
            ),
          );
  }
}
