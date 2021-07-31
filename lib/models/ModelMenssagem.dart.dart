import 'package:cloud_firestore/cloud_firestore.dart';

class ModelMenssagem {
  String senderID;
  String receiverID;
  String tipo;
  String menssagem;
  Timestamp timestamp;
  String fotoUrl;
  String audioUrl;

  ModelMenssagem({
    this.senderID,
    this.receiverID,
    this.timestamp,
    this.tipo,
    this.menssagem,
  });
  // este metodo vai ser chamado so quando quiser enviar uma imagem
  ModelMenssagem.imagemMessagem(
      {this.senderID,
      this.receiverID,
      this.timestamp,
      this.tipo,
      this.menssagem,
      this.fotoUrl});
  // este metodo vai ser chamado so quando quiser enviar um audio
  ModelMenssagem.audioMessagem(
      {this.senderID,
      this.receiverID,
      this.timestamp,
      this.tipo,
      this.menssagem,
      this.audioUrl});
  //
  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderID'] = this.senderID;
    map['receiverID'] = this.receiverID;
    map['timestamp'] = this.timestamp;
    map['tipo'] = this.tipo;
    map['menssagem'] = this.menssagem;
    return map;
  }

  ModelMenssagem.fromMap(Map<String, dynamic> map) {
    this.senderID = map['senderID'];
    this.receiverID = map['receiverID'];
    this.tipo = map['tipo'];
    this.menssagem = map['menssagem'];
    this.timestamp = map['timestamp'];
    this.fotoUrl = map['fotoUrl'];
  }
  Map toImageMap() {
    var map = Map<String, dynamic>();
    map['senderID'] = this.senderID;
    map['receiverID'] = this.receiverID;
    map['timestamp'] = this.timestamp;
    map['tipo'] = this.tipo;
    map['menssagem'] = this.menssagem;
    map['fotoUrl'] = this.fotoUrl;
    return map;
  }
}
