import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodoChamada.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/models/chamada.dart';

class ChamadaUtils {
  static final MetodoChmada callMethods = MetodoChmada();

  static dial({Usuarios from, Usuarios to, context}) async {
    Chamada chamada = Chamada(
      callerId: from.uid,
      callerName: from.nome,
      callerPic: from.foto,
      receiverId: to.uid,
      receiverName: to.nome,
      receiverPic: to.foto,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(chamada: chamada);

    chamada.hasDialled = true;

    if (callMade) {
      /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );*/
    }
  }
}
