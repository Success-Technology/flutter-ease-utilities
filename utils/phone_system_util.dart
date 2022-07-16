import 'package:flutter/material.dart';
import 'package:notetask/main.dart';

void showSnack(
    BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(5)),
          content: Text(message).noteTask(context)));
}

void showBanner(
    BuildContext context, String message,
    [VoidCallback? onPressed]) {
  ScaffoldMessenger.of(context)
      .showMaterialBanner(MaterialBanner(
    content: Text(message),
    actions: [
      TextButton(
        child: const Text("Yeah").noteTask(context),
        onPressed: onPressed,
      )
    ],
  ));
}

void jump(BuildContext context, Widget next) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => next));
}
