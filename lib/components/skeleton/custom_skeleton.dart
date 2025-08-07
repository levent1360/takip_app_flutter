import 'package:flutter/material.dart';

class CustomSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final ShapeBorder shape;

  const CustomSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
    ),
  });

  @override
  State<CustomSkeleton> createState() => _CustomSkeletonState();
}

class _CustomSkeletonState extends State<CustomSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            shape: widget.shape,
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(1.0 + 2.0 * _controller.value, 0),
              colors: [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
            ),
          ),
        );
      },
    );
  }
}
