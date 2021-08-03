import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:xilhamalisso/db_FirebaseFireSore/MetodosFireba.dart';

import 'package:xilhamalisso/provider/UserProvider.dart';
import 'package:xilhamalisso/utils/universal_variables.dart';

import 'dasboardPro.dart';

class HomePro extends StatefulWidget {
  @override
  _HomeProState createState() => _HomeProState();
}

class _HomeProState extends State<HomePro> {
  PageController pageController;
  int _page = 0;
  final MetodosFirebase metodoFirebase = MetodosFirebase();
  UsuarioProvider userProviders;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProviders = Provider.of<UsuarioProvider>(context, listen: false);
      await userProviders.refreshUser();
    });
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: PageView(
        children: [
          Container(
            child: DasBoardPro(),
          ),
          Center(
            child: Text(
              "Meus Contactos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              "Minhas Chamadas",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
            backgroundColor: UniversalVariables.blackColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.chat,
                    color: (_page == 0)
                        ? UniversalVariables.lightBlueColor
                        : UniversalVariables.greyColor),
                label: "Conversas",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_phone,
                    color: (_page == 1)
                        ? UniversalVariables.lightBlueColor
                        : UniversalVariables.greyColor),
                label: "Contactos",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call,
                    color: (_page == 2)
                        ? UniversalVariables.lightBlueColor
                        : UniversalVariables.greyColor),
                label: "Chamadas",
              ),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}
