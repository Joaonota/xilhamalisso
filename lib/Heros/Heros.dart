import 'package:flutter/material.dart';

class Heros extends StatefulWidget {
  @override
  _HerosState createState() => _HerosState();
}

class _HerosState extends State<Heros> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nome;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Nome"),
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Prencha o nome";
                        }
                      },
                      onSaved: (String valeu) {
                        nome = valeu;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        print(nome);
                      },
                      child: Text("Validar"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
