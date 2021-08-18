import 'package:flutter/material.dart';
import 'package:xilhamalisso/widget/cached_image.dart';
import 'package:xilhamalisso/widget/style.dart';

class TelaTesteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advogados",
          style: style(cor: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[200],
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedImage(
                          "",
                          height: 100,
                          width: 100,
                          radius: 10,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              "Joao Manuel Nota",
                              style: style(
                                size: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Informatico",
                              style: style(
                                isBold: true,
                                cor: Colors.orange,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.location_history),
                                Text("AV. TEte ddjksdks"),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.api_rounded),
                                Text(
                                  "140",
                                  style: style(cor: Colors.blue, isBold: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                Text(
                                  " +258845982017",
                                  style: style(isBold: true),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
