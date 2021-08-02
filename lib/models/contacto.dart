import 'package:cloud_firestore/cloud_firestore.dart';

class Contacto {
  String uid;
  Timestamp addedOn;

  Contacto({
    this.uid,
    this.addedOn,
  });

  Map toMap(Contacto contact) {
    var data = Map<String, dynamic>();
    data['contact_id'] = contact.uid;
    data['added_on'] = contact.addedOn;
    return data;
  }

  Contacto.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['contact_id'];
    this.addedOn = mapData["added_on"];
  }
}
