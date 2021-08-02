import 'package:flutter/widgets.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/metodosFireba.dart';
import 'package:xilhamalisso/models/Usuarios.dart';

class UsuarioProvider with ChangeNotifier {
  Usuarios usuario;

  MetodosFirebase metodosFirebase = MetodosFirebase();
  Usuarios get getUSer => usuario;

  Future<void> refreshUser() async {
    Usuarios user = await metodosFirebase.detalheUsuario();
    usuario = user;
    notifyListeners();
  }
}
