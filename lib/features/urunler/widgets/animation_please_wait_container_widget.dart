import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/lottie_files.dart';

class AnimationPleaseWaitContainerWidget extends StatefulWidget {
  final bool isLoading;
  final String? metin;
  const AnimationPleaseWaitContainerWidget({
    super.key,
    required this.isLoading,
    this.metin,
  });

  @override
  State<AnimationPleaseWaitContainerWidget> createState() =>
      _AnimationPleaseWaitContainerWidgetState();
}

class _AnimationPleaseWaitContainerWidgetState
    extends State<AnimationPleaseWaitContainerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: widget.isLoading
          ? AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1), // 1 saniyede kaybolur
              child: Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(83, 33, 149, 243),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8), // İç boşluk
                child: Row(
                  children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Lottie.asset(
                        LottieFiles.shopping_loading,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ), // Lottie ile text arasında boşluk
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.metin ?? '',
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 12, 71, 123),
                            fontSize: 18,
                          ),
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
