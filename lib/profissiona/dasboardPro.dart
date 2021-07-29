import 'package:flutter/material.dart';
import 'package:xilhamalisso/custimizado/custom_tile.dart';
import 'package:xilhamalisso/profissiona/Detalhespro.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

class DasBoardPro extends StatelessWidget {
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

class ChatListContainer extends StatefulWidget {
  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (itemBuilder, index) {
        return CustomTile(
          leading: Container(
            constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 13,
                    width: 13,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.onlineDotColor,
                        border: Border.all(
                            color: UniversalVariables.blackColor, width: 2)),
                  ),
                )
              ],
            ),
          ),
          mini: false,
          title: Text(
            "Joao Nota",
            style: TextStyle(
                color: Colors.white, fontFamily: "Arial", fontSize: 19),
          ),
          subtitle: Text(
            "Ola bem-vindo A Xilhamalisso ",
            style: TextStyle(
              color: UniversalVariables.greyColor,
              fontSize: 14,
            ),
          ),
        );
      }),
    );
  }
}

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Clicado");
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (builder) => DetalhesPro());
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: UniversalVariables.separatorColor,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "JN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UniversalVariables.lightBlueColor,
                  fontSize: 13,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: UniversalVariables.blackColor, width: 2),
                    color: UniversalVariables.onlineDotColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
