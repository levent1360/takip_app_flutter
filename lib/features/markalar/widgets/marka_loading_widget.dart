import 'package:flutter/material.dart';
import 'package:takip/components/skeleton/custom_skeleton.dart';

class MarkaLoadingWidget extends StatelessWidget {
  const MarkaLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CustomSkeleton(width: 56, height: 56, shape: CircleBorder()),
          SizedBox(height: 5),
          CustomSkeleton(width: 50, height: 12),
        ],
      ),
    );
  }
}
