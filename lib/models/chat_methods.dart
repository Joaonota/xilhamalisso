import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xilhamalisso/models/user.dart';
import 'package:xilhamalisso/models/Usuarios.dart';

import 'ModelMenssagem.dart.dart';

class ChatMethods {
  Future<void> addMessageToDb(
      ModelMenssagem message, Usuarios sender, Usuarios receiver) async {
    var map = message.toMap();
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db
        .collection("menssagem")
        .doc(message.senderID)
        .collection(message.receiverID)
        .add(map);

    return await db
        .collection("menssagem")
        .doc(message.receiverID)
        .collection(message.senderID)
        .add(map);
  }
}
