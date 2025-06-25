import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/lottie_files.dart';

class AnimationPleaseWaitContainerWidget extends StatefulWidget {
  const AnimationPleaseWaitContainerWidget({super.key});

  @override
  State<AnimationPleaseWaitContainerWidget> createState() =>
      _AnimationPleaseWaitContainerWidgetState();
}

class _AnimationPleaseWaitContainerWidgetState
    extends State<AnimationPleaseWaitContainerWidget>
    with TickerProviderStateMixin {
  double _opacity = 1.0;
  bool _visible = true;

  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
          _visible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    print('timer cancelled'); // Timer'ı iptal et
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: _visible
          ? AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1), // 1 saniyede kaybolur
              child: Container(
                width: double.infinity, // Ekran genişliği kadar olur
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(83, 33, 149, 243),
                  borderRadius: BorderRadius.circular(16), // Köşeleri yumuşatır
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(
                        LottieFiles.success,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Ürünleriniz Kaydediliyor...',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 12, 71, 123),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
