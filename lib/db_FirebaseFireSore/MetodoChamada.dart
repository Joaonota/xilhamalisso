import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xilhamalisso/models/chamada.dart';

class MetodoChmada {
  final CollectionReference callColetionRef =
      FirebaseFirestore.instance.collection("chamada");
  //
  Stream<DocumentSnapshot> callStream({String uid}) =>
      callColetionRef.doc(uid).snapshots();
  //
  Future<bool> makeCall({Chamada chamada}) async {
    try {
      chamada.hasDisabled = true;
      Map<String, dynamic> hasDialledMap = chamada.toMap(chamada);

      chamada.hasDisabled = false;
      Map<String, dynamic> hasNotDialledMap = chamada.toMap(chamada);

      await callColetionRef.doc(chamada.chamadaID).set(hasDialledMap);
      await callColetionRef.doc(chamada.receiverID).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Chamada chamada}) async {
    try {
      await callColetionRef.doc(chamada.chamadaID).delete();
      await callColetionRef.doc(chamada.receiverID).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
