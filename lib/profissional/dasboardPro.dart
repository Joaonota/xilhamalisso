import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/Menssagem/chat_list_screen.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodosFireba.dart';
import 'package:xilhamalisso/models/contacto.dart';
import 'package:xilhamalisso/provider/UserProvider.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';
import 'package:xilhamalisso/widget/contacto_view.dart';
import 'package:xilhamalisso/widget/quite_Box.dart';

class DasBoardPro extends StatelessWidget {
/*  UsuarioProvider userProvider;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UsuarioProvider>(context, listen: false);
      await userProvider.refreshUser();
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: AppBar(
        backgroundColor: UniversalVariables.blackColor,
        centerTitle: true,
        title: UserCircle(),
      ),
      body: ChatListContainer(),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final MetodosFirebase metodoFirebase = MetodosFirebase();

  @override
  Widget build(BuildContext context) {
    final UsuarioProvider userProvider = Provider.of<UsuarioProvider>(context);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: metodoFirebase.fetchContact(
            userId: userProvider.getUSer.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.docs;

              if (docList.isEmpty) {
                return QuiteBox();
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contacto contact = Contacto.fromMap(docList[index].data());

                  return ContactView(contact);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
