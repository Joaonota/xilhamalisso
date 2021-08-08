import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xilhamalisso/chamada_telas/TelaChamda.dart';
import 'package:xilhamalisso/chamada_telas/Telaligar.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodoChamada.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/models/chamada.dart';

class ChamadaUtils {
  static final MetodoChmada callMethods = MetodoChmada();

  static dial({
    Usuarios from,
    Usuarios to,
    context,
  }) async {
    Chamada chamada = Chamada(
      chamadaID: from.uid,
      chamadaNome: from.nome,
      chamadaPic: from.foto,
      receiverID: to.uid,
      receiverName: to.nome,
      receiverPic: to.foto,
      channelID: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(chamada: chamada);

    chamada.hasDisabled = true;

    if (callMade) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaLigar(chamada: chamada),
        ),
      );
    }
  }
}
