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
  /* String get senderID => this._senderID;

  set senderID(String value) => this._senderID = value;

  get receiverID => this._receiverID;

  set receiverID(value) => this._receiverID = value;

  get tipo => this._tipo;

  set tipo(value) => this._tipo = value;

  get menssagem => this._menssagem;

  set menssagem(value) => this._menssagem = value;

  get timestamp => this._timestamp;

  set timestamp(value) => this._timestamp = value;

  get fotoUrl => this._fotoUrl;

  set fotoUrl(value) => this._fotoUrl = value;

  get audioUrl => this._audioUrl;

  set audioUrl(value) => this._audioUrl = value;

  ModelMenssagem();
  ModelMenssagem.fromDocumentSnapshot(dynamic documentSnapshot) {
    this.senderID = documentSnapshot.data()['senderID'];
    this.menssagem = documentSnapshot.data()['menssagem'];
    this.tipo = documentSnapshot.data()['tipo'];
    this.timestamp = documentSnapshot.data()['timestamp'];
    this.receiverID = documentSnapshot.data()['receiverID'];
    //this.foto = documentSnapshot.data()['foto'];
    //this.atuacao = documentSnapshot.data()["atuacao"];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      "senderID": this.senderID,
      "menssagem": this.menssagem,
      "tipo": this.tipo,
      "timestamp": this.timestamp,
      "receiverID": this.receiverID,
      //"atuacao": this.atuacao,
      //"foto": this.foto,
    };
    return mapa;
  }*/

  //
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
