import 'package:flutter/material.dart';

class DropButom extends StatelessWidget {
  var hint;
  var itens;
  var onChanged;
  var onSaved;
  var estilo;
  var value;
  var valida;
  DropButom(
      {@required this.itens,
      @required this.onChanged,
      this.estilo,
      this.value,
      this.valida,
      this.hint,
      this.onSaved});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: DropdownButtonFormField(
        hint: Text(this.hint),
        value: this.value,
        validator: this.valida,
        onSaved: this.onSaved,
        items: this.itens,
        onChanged: this.onChanged,
        style: this.estilo,
      ),
    );
  }
}
