import 'package:flutter/material.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({required this.imageUrl});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  double offsetY = 0;

  @override
  Widget build(BuildContext context) {
    // Arka plan opaklığını hesapla (1.0 tam siyah, 0.0 tamamen saydam)
    double backgroundOpacity = 1.0 - (offsetY.abs() / 100).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.transparent, // Önemli: transparan yap
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // boş alanlara tıklamayı yakalar
        onTap: () => Navigator.pop(context),
        onVerticalDragUpdate: (details) {
          setState(() {
            offsetY += details.delta.dy;
          });
        },
        onVerticalDragEnd: (details) {
          if (offsetY > 100) {
            Navigator.pop(context);
          } else {
            setState(() {
              offsetY = 0;
            });
          }
        },
        child: Stack(
          children: [
            // Dinamik arka plan rengi
            Container(color: Colors.black.withOpacity(backgroundOpacity)),
            // Kaydırılabilir görsel
            Transform.translate(
              offset: Offset(0, offsetY),
              child: Center(
                child: InteractiveViewer(child: Image.network(widget.imageUrl)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
