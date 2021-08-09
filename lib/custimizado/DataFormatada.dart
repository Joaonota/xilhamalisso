import 'package:flutter/material.dart';

class DataFormatada extends StatelessWidget {
  final dia = DateTime.now().day;
  final mes = DateTime.now().month;
  final ano = DateTime.now().year;
  final hora = DateTime.now().hour;
  final minuto = DateTime.now().minute;
  final segudos = DateTime.now().second;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "$hora:$minuto:$segudos",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
