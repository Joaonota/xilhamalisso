import 'package:cloud_firestore/cloud_firestore.dart';

class Usuarios {
  String id;
  String nome;
  String dataNas;
  String email;
  String numeroTele;
  String localizacao;
  String foto;
  Usuarios();
  Usuarios.fromDocumentSnap(DocumentSnapshot doc) {
    this.id = doc.id;
    this.nome = doc["nome"];
    this.dataNas = doc["Nascimento"];
    this.email = doc["emial"];
    this.numeroTele = doc["numero"];
    this.localizacao = doc["localiza"];
    this.foto = doc["foto"];
  }
}
