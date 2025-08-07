import 'package:flutter/material.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/buttons/notification_status_icon.dart';

class UrunCardNotificationWidget extends StatelessWidget {
  const UrunCardNotificationWidget({
    super.key,
    required this.urun,
    required this.iconSize,
  });

  final UrunModel urun;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: NotificationStatusIcon(urunModel: urun, size: iconSize),
    );
  }
}
