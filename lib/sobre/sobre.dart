import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  /*var nomes = {
    "nome": "joao",
    "apelido": "nota",
  };*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (itemBuilder, indec) {
          return Column(
            children: [],
          );
        }),
      ),
    );
  }
}
