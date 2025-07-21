import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';

class LinkPaylasimYardimIcerik extends StatelessWidget {
  const LinkPaylasimYardimIcerik({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationHelper.l10n.yardimtext1,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 1. Adım
          Text(
            LocalizationHelper.l10n.yardimtext2,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(LocalizationHelper.l10n.yardimtext3),
          const SizedBox(height: 8),
          Image.asset('assets/images/paylas_buton1.jpg', fit: BoxFit.contain),
          const SizedBox(height: 8),
          const Center(child: Icon(Icons.arrow_downward, size: 45)),
          const SizedBox(height: 8),
          Image.asset('assets/images/paylas_buton2.jpg', fit: BoxFit.contain),
          const SizedBox(height: 8),
          const Center(child: Icon(Icons.arrow_downward, size: 45)),
          const SizedBox(height: 8),
          Image.asset('assets/images/paylas_buton.jpg', fit: BoxFit.contain),

          const SizedBox(height: 50),

          // 2. Adım
          Text(
            LocalizationHelper.l10n.yardimtext4,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Text(LocalizationHelper.l10n.yardimtext5),
          const SizedBox(height: 8),
          Image.asset(
            'assets/images/kopyala_yapistir.jpg',
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 24),

          Text(
            LocalizationHelper.l10n.yardimtext6,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
