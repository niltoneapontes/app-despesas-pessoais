import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptativeButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20))
        : ElevatedButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
