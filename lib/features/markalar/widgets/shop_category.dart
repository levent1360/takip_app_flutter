import 'package:flutter/material.dart';
import 'package:takip/components/image/network_image_with_loader.dart';
import 'package:takip/components/skeleton/custom_skeleton.dart';

class MarkaWidget extends StatelessWidget {
  final String title;
  final String image;
  final bool isLoading;
  const MarkaWidget({
    super.key,
    required this.title,
    required this.image,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: isLoading
          ? Column(
              children: [
                CustomSkeleton(width: 56, height: 56, shape: CircleBorder()),
                SizedBox(height: 5),
                CustomSkeleton(width: 50, height: 12),
              ],
            )
          : Column(
              children: [
                CircleAvatar(radius: 28, child: NetworkImageWithLoader(image)),
                const SizedBox(height: 5),
                Text(title, style: const TextStyle(fontSize: 12)),
              ],
            ),
    );
  }
}
