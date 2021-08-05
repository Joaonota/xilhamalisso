import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xilhamalisso/models/chamada.dart';

class MetodoChmada {
  final CollectionReference callColetionRef =
      FirebaseFirestore.instance.collection("chamada");

  Future<bool> makeCall({Chamada chamada}) async {
    try {
      chamada.hasDialled = true;
      Map<String, dynamic> hasDialledMap = chamada.toMap(chamada);

      chamada.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = chamada.toMap(chamada);

      await callColetionRef.doc(chamada.callerId).set(hasDialledMap);
      await callColetionRef.doc(chamada.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Chamada chamada}) async {
    try {
      await callColetionRef.doc(chamada.callerId).delete();
      await callColetionRef.doc(chamada.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
