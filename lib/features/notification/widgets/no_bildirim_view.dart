import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
        const Text(
          'Bildirim Bulunamadı',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Bildirimlerinizi burada görüntüleyebilirsiniz',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
