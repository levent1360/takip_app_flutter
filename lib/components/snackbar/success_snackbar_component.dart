import 'package:flutter/material.dart';
import 'package:takip/core/services/error_service.dart';

void showSuccessSnackBar({
  required String message,
  Color backgroundColor = const Color(0xFF329494),
}) {
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
