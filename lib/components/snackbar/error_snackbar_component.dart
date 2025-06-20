import 'package:flutter/material.dart';
import 'package:takip/core/services/error_service.dart';

Future<void> showErrorSnackBar({
  required String message,
  Color backgroundColor = const Color(0xFFEA5B5B),
}) async {
  final context = ErrorService().navigatorKey.currentContext;

  if (context == null) return;

  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
