import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String menssagem;

  const ErrorAlertDialog({Key key, this.menssagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.white,
          ),
          Text(
            menssagem,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}
