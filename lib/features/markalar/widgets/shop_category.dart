import 'package:flutter/material.dart';

class MarkaWidget extends StatelessWidget {
  final String title;
  final String image;
  const MarkaWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(radius: 28, child: Image.network(image)),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
