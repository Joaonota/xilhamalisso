import 'package:flutter/material.dart';

class DasboardAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252a48),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff252a48),
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.grey,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff252a48),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 140),
                child: Text(
                  "HELLO",
                  style: TextStyle(
                    color: Color(0xff747baa),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "MS. Jessica Benson",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
