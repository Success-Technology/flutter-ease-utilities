import 'package:flutter/material.dart';

void showSnack(
    BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(5)),
          content: Text(message)));
}

void showBanner(
    BuildContext context, String message,
    [VoidCallback? onPressed]) {
  ScaffoldMessenger.of(context)
      .showMaterialBanner(MaterialBanner(
    content: Text(message),
    actions: [
      TextButton(
        child: const Text("Yeah"),
        onPressed: onPressed,
      )
    ],
  ));
}

void jump(BuildContext context, Widget next) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => next));
}
