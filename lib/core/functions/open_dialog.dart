import 'package:flutter/material.dart';

Future<void> openDialog(
  BuildContext context, {
  required Widget widget,
  bool barrierDismissible = true,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => widget,
  );
}
