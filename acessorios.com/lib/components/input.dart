import 'package:flutter/material.dart';

class InputDecorationAcessorios{

  InputDecoration input(String texto){
    return InputDecoration(
        focusedBorder: UnderlineInputBorder( borderSide: BorderSide( color:  Colors.green)),
        hintText: texto,
        hintStyle: TextStyle(color: Colors.green),
        enabledBorder: UnderlineInputBorder(
            borderSide:
            (BorderSide(color: Colors.green))),
    );
  }
}