import 'package:flutter/material.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String menssagem;

  const LoadingAlertDialog({Key key, this.menssagem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.green,
          ),
          SizedBox(
            height: 10,
          ),
          Text(menssagem)
        ],
      ),
    );
  }
}
