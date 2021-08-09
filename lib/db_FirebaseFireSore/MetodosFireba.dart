import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/enum/status_usuario.dart';
import 'package:xilhamalisso/models/ModelMenssagem.dart.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/models/contacto.dart';
import 'package:xilhamalisso/utils/utilitarios.dart';

class MetodosFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  //
  static final CollectionReference _userCollection = db.collection("usuarios");
  final CollectionReference _messageCollection = db.collection("menssagem");
  //
  Future<Usuarios> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot = await _userCollection.doc(id).get();
      return Usuarios.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

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
  Future<void> adicinatodb(
      ModelMenssagem menssagem, Usuarios sender, Usuarios receive) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var map = menssagem.toMap();
    await db
        .collection("menssagem")
        .doc(menssagem.senderID)
        .collection(menssagem.receiverID)
        .add(map);

    adicionaContato(
        senderID: menssagem.senderID, receiverID: menssagem.receiverID);

    return await db
        .collection("menssagem")
        .doc(menssagem.receiverID)
        .collection(menssagem.senderID)
        .add(map);
  }

  //
  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<Usuarios> detalheUsuario() async {
    //
    User currentUser = await getCurrentUser();
    //
    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();
    return Usuarios.fromMap(documentSnapshot.data());
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
        uid: receiveId,
        addedOn: currentTime,
      );
      var senderMap = senderContato.toMap(senderContato);
      await getDocomentRef(of: senderId, forContact: receiveId).set(senderMap);
    }
  }

  //adiciona
  Future<void> adicionaReceiveContato(
      String senderId, String receiveId, currentTime) async {
    DocumentSnapshot documentSnapshotReceive =
        await getDocomentRef(of: receiveId, forContact: senderId).get();

    //
    if (!documentSnapshotReceive.exists) {
      //
      Contacto receiverContato = Contacto(
        uid: senderId,
        addedOn: currentTime,
      );
      var receiverMap = receiverContato.toMap(receiverContato);
      await getDocomentRef(of: receiveId, forContact: senderId)
          .set(receiverMap);
    }
  }

  ///actualiza satus do usuario
  void setUserState({@required String userID, @required UserState userState}) {
    int stateNum = Utilitarios.stateToNum(userState);

    _userCollection.doc(userID).update({"status": stateNum});
  }

  Stream<DocumentSnapshot> getUserStrem({@required String uid}) =>
      _userCollection.doc(uid).snapshots();

  //metodo para enviar Imagem
  void setImageMsg(String url, String receiverId, String senderId) async {
    ModelMenssagem message;

    message = ModelMenssagem.imagemMessagem(
        menssagem: "IMAGEM",
        receiverID: receiverId,
        senderID: senderId,
        fotoUrl: url,
        timestamp: Timestamp.now(),
        tipo: 'imagem');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await _messageCollection
        .doc(message.senderID)
        .collection(message.receiverID)
        .add(map);

    _messageCollection
        .doc(message.receiverID)
        .collection(message.senderID)
        .add(map);
  }
}
