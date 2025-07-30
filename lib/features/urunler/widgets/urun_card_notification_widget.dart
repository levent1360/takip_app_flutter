import 'package:flutter/material.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/widgets/notification_status_icon.dart';

class UrunCardNotificationWidget extends StatelessWidget {
  const UrunCardNotificationWidget({
    super.key,
    required this.bildirimAc,
    required this.urun,
    required this.iconSize,
  });

  final VoidCallback bildirimAc;
  final UrunModel urun;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: bildirimAc,
        child: NotificationStatusIcon(
          isBildirimAcik: urun.isBildirimAcik,
          size: iconSize,
        ),
      ),
    );
  }
}
