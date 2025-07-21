import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/lottie_files.dart';
import 'dart:async';

import 'package:takip/features/urunler/shop_home_page_scroll.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // static const platform = MethodChannel('app.channel.shared.data');

  String? sharedText;

  @override
  void initState() {
    super.initState();

    checkSharedText();
  }

  @override
  void dispose() {
    // Uygulama durdurulduğunda observer'ı kaldırıyoruz
    super.dispose();
  }

  Future<void> checkSharedText() async {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ShopHomePageScroll()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 300,
                child: Lottie.asset(
                  LottieFiles.splash_loading,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
