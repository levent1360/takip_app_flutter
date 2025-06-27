import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/lottie_files.dart';

class NoItemsView extends StatelessWidget {
  const NoItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Sonsuzluk hatasını engeller
      children: [
        Container(
          height: 200,
          width: 300,
          child: Lottie.asset(LottieFiles.noitem, fit: BoxFit.contain),
        ),
        const SizedBox(height: 32),
        const Text(
          'Ürün Bulunamadı',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Takip edilmesini istediğiniz ürünün bağlantı adresini paylaşın.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
