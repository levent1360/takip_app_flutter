import 'package:flutter/material.dart';
import 'dart:async';

class BlinkingCard extends StatefulWidget {
  final Widget widget;

  const BlinkingCard({super.key, required this.widget});
  @override
  _BlinkingCardState createState() => _BlinkingCardState();
}

class _BlinkingCardState extends State<BlinkingCard> {
  double _opacity = 1.0;
  Timer? _blinkTimer;
  Timer? _stopTimer;

  @override
  void initState() {
    super.initState();

    // Yanıp sönmeyi başlat
    _blinkTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _opacity = _opacity == 1.0 ? 0.0 : 1.0;
      });
    });

    // 10 saniye sonra animasyonu durdur
    _stopTimer = Timer(Duration(seconds: 5), () {
      _blinkTimer?.cancel();
      setState(() {
        _opacity = 1.0; // İsteğe göre son hali sabit kalabilir
      });
    });
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _stopTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 500),
        child: widget.widget,
      ),
    );
  }
}
