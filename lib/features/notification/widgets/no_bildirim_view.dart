import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/constant/lottie_files.dart';

class NoBildirimView extends StatelessWidget {
  const NoBildirimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Sonsuzluk hatasını engeller
      children: [
        Container(
          height: 200,
          width: 300,
          child: Lottie.asset(LottieFiles.no_notification, fit: BoxFit.contain),
        ),
        const SizedBox(height: 32),
        Text(
          LocalizationHelper.l10n.bildirimbulunamadi,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          LocalizationHelper.l10n.bildirimbulunamadimetin,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
