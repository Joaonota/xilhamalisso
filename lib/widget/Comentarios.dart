import 'dart:async';

import 'package:flutter/material.dart';

class Comentarios extends StatelessWidget {
  Future<List> dadoss() async {
    return [
      {"nome": "joao manuel nota"}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dadoss(),
        builder: (builder, snap) {
          return Column(
            children: List.generate(
                snap.data.length, (index) => Text(snap.data[index])),
          );
        });
  }
}
