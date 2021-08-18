import 'package:flutter/cupertino.dart';

TextStyle style({
  FontWeight fontWeight,
  double size,
  Color cor,
  bool isBold = false,
}) {
  return TextStyle(
    fontWeight: isBold == false ? fontWeight : FontWeight.bold,
    fontSize: size,
    color: cor,
  );
}
