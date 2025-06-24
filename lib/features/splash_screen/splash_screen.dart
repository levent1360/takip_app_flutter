import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/lottie_files.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page.dart';
import 'dart:async';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  static const platform = MethodChannel('app.channel.shared.data');

  @override
  void initState() {
    super.initState();
    getSharedText();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ShopHomePage()),
      );
    });
  }

  Future<void> getSharedText() async {
    String? sharedData = await platform.invokeMethod('getSharedText');
    if (sharedData != null) {
      ref.read(urunKaydetNotifierProvider.notifier).getUrlProducts(sharedData);
    }
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
