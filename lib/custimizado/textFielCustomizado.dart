import 'package:flutter/material.dart';

class TextFieldCustomizado extends StatelessWidget {
  final hintText;
  final controller;
  final keyboardType;
  final prefixIcon;
  final maxLength;
  const TextFieldCustomizado(
      {Key key,
      @required this.hintText,
      this.controller,
      this.maxLength,
      this.keyboardType,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: this.keyboardType,
            controller: this.controller,
            maxLength: this.maxLength,
            decoration: InputDecoration(
              prefixIcon: this.prefixIcon,
              hintText: this.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
