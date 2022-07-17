

import 'package:flutter/material.dart';


// Using Key Text
Future<String> loadHtml(
    BuildContext context) async {
  String data =
      await DefaultAssetBundle.of(context)
          .loadString("assets/using_key.html");
  return data;
}

// Printing Debug String Output
debugConsole(String message)
{
  print("debug : $message");
}


class Stage
{
  static int count = 0;
  void call(String message)
  {
      count++;
      print('Stage $count : $message');
  }
}