import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodosFireba.dart';
import 'package:xilhamalisso/enum/status_usuario.dart';
import 'package:xilhamalisso/models/Usuarios.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';
import 'package:xilhamalisso/utils/utilitarios.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  final MetodosFirebase _authMethods = MetodosFirebase();

  OnlineDotIndicator({
    @required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utilitarios.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return UniversalVariables.onlineDotColor;
        default:
          return Colors.orange;
      }
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: StreamBuilder<DocumentSnapshot>(
        stream: _authMethods.getUserStrem(
          uid: uid,
        ),
        builder: (context, snapshot) {
          Usuarios user;

          if (snapshot.hasData && snapshot.data.data != null) {
            user = Usuarios.fromMap(snapshot.data.data());
          }

          return Container(
            height: 12,
            width: 12,
            margin: EdgeInsets.only(right: 5, top: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(user?.status),
            ),
          );
        },
      ),
    );
  }
}
