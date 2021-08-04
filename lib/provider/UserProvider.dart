import 'package:flutter/widgets.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/metodosFireba.dart';
import 'package:xilhamalisso/models/Usuarios.dart';

class UsuarioProvider with ChangeNotifier {
  Usuarios _usuario;

  MetodosFirebase metodosFirebase = MetodosFirebase();
  Usuarios get getUSer => _usuario;

  Future<void> refreshUser() async {
    Usuarios user = await metodosFirebase.detalheUsuario();
    _usuario = user;
    notifyListeners();
  }
}
