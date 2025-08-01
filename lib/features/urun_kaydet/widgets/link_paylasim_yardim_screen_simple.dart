import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';

class LinkPaylasimYardimScreenSimple extends StatelessWidget {
  const LinkPaylasimYardimScreenSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationHelper.l10n.yardimtext1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          const SizedBox(height: 16),
          // 1. Adım
          Text(
            LocalizationHelper.l10n.yardimtext2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(LocalizationHelper.l10n.yardimtext3),
          const SizedBox(height: 50),

          // 2. Adım
          Text(
            LocalizationHelper.l10n.yardimtext4,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 8),

          Text(LocalizationHelper.l10n.yardimtext5),
          const SizedBox(height: 24),

          Text(
            LocalizationHelper.l10n.yardimtext6,
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
