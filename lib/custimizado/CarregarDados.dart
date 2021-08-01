import 'package:flutter/material.dart';

class CarregarDados extends StatelessWidget {
  final String text;
  final Color colors;

  const CarregarDados({Key key, @required this.text, @required this.colors})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: this.colors,
            backgroundColor: Colors.blue,
          ),
          Text(
            this.text,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ));
  }
}
