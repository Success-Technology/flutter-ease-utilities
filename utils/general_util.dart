import 'package:flutter/material.dart';

Color colorTokenizer(String hexa) {
  String replace = hexa.replaceFirst('#', '');
  String ready = 'ff' + replace;
  return Color(int.parse(ready, radix: 16));
}

dynamic hexaTokenizer(Color color,
    {bool hashMode = false}) {
  String noHash = color.value.toRadixString(16);

  return hashMode
      ? '#${noHash.substring(2, noHash.length)}'
      : int.parse(color.value.toRadixString(16),
          radix: 16);
}

MaterialColor customSwatch(Color color) {
  MaterialColor swatch = MaterialColor(
    hexaTokenizer(
        color), // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: color, //10%
      100: color, //20%
      200: color, //30%
      300: color, //40%
      400: color, //50%
      500: color, //60%
      600: color, //70%
      700: color, //80%
      800: color, //90%
      900: color, //100%
    },
  );
  return swatch;
}
