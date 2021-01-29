import 'package:flutter/material.dart';

MaterialButton buildMaterialButton({text: String, onPresses}) {
  return MaterialButton(
    onPressed: onPresses,
    color: Colors.red,
    hoverColor: Colors.red[600],
    hoverElevation: 5,
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.red)),
    textColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: Text(text),
  );
}
