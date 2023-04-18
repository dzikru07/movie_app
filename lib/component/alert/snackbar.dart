import 'package:flutter/material.dart';

class AlertApp {
  mainSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message.toString()),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.red,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
