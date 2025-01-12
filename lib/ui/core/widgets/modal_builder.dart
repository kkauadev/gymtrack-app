import 'package:flutter/material.dart';

Future<void> dialogBuilder(
  BuildContext context, {
  required String title,
  required Widget content,
  TextStyle? titleStyle,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: titleStyle ?? Theme.of(context).textTheme.headlineMedium,
        ),
        content: content,
      );
    },
  );
}
