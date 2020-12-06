import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

showAlert(BuildContext c, String title, String content) {
  if (Platform.isIOS) {
    _showDialogCupertino(c, title, content);
  } else {
    _showDialogMaterial(c, title, content);
  }
}

_showDialogMaterial(BuildContext c, String title, String content) {
  showDialog(
      context: c,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              MaterialButton(
                  child: Text("Ok"),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => {Navigator.pop(c)})
            ],
          ));
}

_showDialogCupertino(BuildContext c, String title, String content) {
  showDialog(
      context: c,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                  child: Text("Ok"), isDefaultAction: true, onPressed: () => {Navigator.pop(c)})
            ],
          ));
}
