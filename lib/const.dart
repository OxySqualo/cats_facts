import 'package:flutter/material.dart';

const colorTuna = Color.fromARGB(60, 243, 172, 172);

const colorDarcTuna = Color.fromARGB(230, 199, 129, 129);

ElevatedButton myElevatedButton({function, text}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        foregroundColor: colorDarcTuna,
        textStyle: const TextStyle(fontSize: 20)),
    onPressed: function,
    child: Text(text),
  );
}

TextStyle myTextStyle() {
  return const TextStyle(
      fontSize: 24.0,
      fontStyle: FontStyle.normal,
      color: colorDarcTuna,
      fontWeight: FontWeight.w600);
}

TextStyle myTitleTextStyle() {
  return const TextStyle(
      color: colorTuna, fontSize: 50, fontWeight: FontWeight.w900);
}

OutlineInputBorder enabledBorderStyle() {
  return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.amberAccent, width: 3.0),
      borderRadius: BorderRadius.all(Radius.circular(9.0)));
}
