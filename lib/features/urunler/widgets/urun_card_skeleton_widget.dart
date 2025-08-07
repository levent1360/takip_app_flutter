import 'package:flutter/material.dart';
import 'package:takip/components/skeleton/custom_skeleton.dart';

class UrunCardSkeleton extends StatelessWidget {
  final double containerPadding;
  final bool isTablet;
  final double screenWidth;
  final double fontSizeSmall;
  final double fontSizeNormal;
  final double iconSize;

  const UrunCardSkeleton({
    super.key,
    this.containerPadding = 8.0,
    required this.isTablet,
    required this.screenWidth,
    this.fontSizeSmall = 12.0,
    this.fontSizeNormal = 14.0,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Görsel alanı
          CustomSkeleton(
            height: isTablet ? 200 * 7 / 16 : 200 * 9 / 15,
            width: double.infinity,
          ),

          SizedBox(height: containerPadding / 2),

          // Ürün adı
          CustomSkeleton(height: fontSizeNormal + 8, width: double.infinity),
          SizedBox(height: containerPadding / 2),

          // Fiyat ve tarih butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  CustomSkeleton(height: fontSizeNormal + 8, width: 80),
                ],
              ),
            ],
          ),
          SizedBox(height: containerPadding),

          // Marka iconu ve silme ikonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Marka
              CustomSkeleton(
                width: iconSize * 1.6,
                height: iconSize * 1.6,
                shape: CircleBorder(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
