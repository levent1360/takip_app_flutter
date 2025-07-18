import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/services/error_service.dart';

Future<bool?> showConfirmDialog({
  String? title,
  String? content,
  String? cancelText,
  String? confirmText,
}) {
  final context = ErrorService().navigatorKey.currentContext;
  return showDialog<bool>(
    context: context!,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Üst başlık ve kapatma ikonu
            Row(
              children: [
                Icon(Icons.info),
                Text(
                  title ?? LocalizationHelper.of(context).defaultOnay,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Placeholder metin simülasyonu (görseldeki gri çizgiler)
            Text(content ?? LocalizationHelper.of(context).defaultOnayMetin),
            const SizedBox(height: 30),

            /// Butonlar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      cancelText ?? LocalizationHelper.of(context).iptal,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// Log out button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      confirmText ?? LocalizationHelper.of(context).evet,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
