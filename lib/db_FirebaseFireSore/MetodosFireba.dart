import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/models/contacto.dart';

class MetodosFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  //
  static final CollectionReference _userCollection = db.collection("usuarios");
  final CollectionReference _messageCollection = db.collection("menssagem");
  //
  Stream<QuerySnapshot> fetchContact({String userId}) =>
      _userCollection.doc(userId).collection("contato").snapshots();

  DocumentReference getDocomentRef({String of, String forContact}) =>
      _userCollection.doc(of).collection("contato").doc(forContact);

  adicionaContato({String senderID, String receiverID}) async {
    Timestamp currentTime = Timestamp.now();
    await adicionaReceiveContato(senderID, receiverID, currentTime);
    await adicionaReceiveContato(senderID, receiverID, currentTime);
  }

  Stream<QuerySnapshot> fetchLastMens(
          {@required String senderId, @required String receiveID}) =>
      _messageCollection
          .doc(senderId)
          .collection(receiveID)
          .orderBy("timestamp")
          .snapshots();

//metodo para adicionar contacto

  //medotod para adicionar Menssagem no Firestore
  Future<void> adicinatodb(String text, _currentUserID, receiver) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("menssagem")
        .doc(_currentUserID)
        .collection(receiver)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "senderID": _currentUserID,
      "menssagem": text,
      "tipo": "texto",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "receiverID": receiver,
    });
    adicionaContato(senderID: _currentUserID, receiverID: receiver);

    return await db
        .collection("menssagem")
        .doc(receiver)
        .collection(_currentUserID)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      "senderID": _currentUserID,
      "menssagem": text,
      "tipo": "texto",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      "receiverID": receiver,
    });
  }

  String _idDoUsuario;
  //
  Future<User> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User fUser = auth.currentUser;
    _idDoUsuario = fUser.uid;

    return fUser;
  }

  Future<Usuarios> detalheUsuario() async {
    await getCurrentUser();

    //

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(_idDoUsuario).get();
    return Usuarios.fromDocumentSnapshot(documentSnapshot);
  }

  ///
  Future<void> adicionaSenderContato(
      String senderId, String receiveId, currentTime) async {
    DocumentSnapshot documentSnapshotSender =
        await getDocomentRef(of: senderId, forContact: receiveId).get();

    //
    if (!documentSnapshotSender.exists) {
      //
      Contacto senderContato = Contacto(
        uid: senderId,
        addedOn: currentTime,
      );
      var senderMap = senderContato.toMap(senderContato);
      await getDocomentRef(of: senderId, forContact: receiveId).set(senderMap);
    }
  }

  //adiciona
  Future<void> adicionaReceiveContato(
    String senderId,
    String receiveId,
    currentTime,
  ) async {
    DocumentSnapshot documentSnapshotReceive =
        await getDocomentRef(of: receiveId, forContact: senderId).get();

    //
    if (!documentSnapshotReceive.exists) {
      //
      Contacto receiverContato = Contacto(
        uid: receiveId,
        addedOn: currentTime,
      );
      var receiverMap = receiverContato.toMap(receiverContato);
      await getDocomentRef(of: receiveId, forContact: senderId)
          .set(receiverMap);
    }
  }
}
