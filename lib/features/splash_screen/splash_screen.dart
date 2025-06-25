import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:takip/core/constant/lottie_files.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page.dart';
import 'dart:async';
import 'package:takip/main.dart';


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

  Future<void> checkSharedText() async {
    try {
      final result = await platform.invokeMethod("getSharedText");
      if (result != null && result is String) {
        setState(() {
          sharedText = result;
          ref.read(urunKaydetNotifierProvider.notifier).getUrlProducts(sharedText);
        });

        /// Loading screen göster, sonra yönlendir
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ShopHomePage(),
            ),
          );
        });
      } else {
        /// Normal açılış: doğrudan ProductScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ShopHomePage(), // veri yoksa
          ),
        );
      }
    } catch (e) {
      print("Paylaşım kontrol hatası: $e");
      // Hata varsa yine normal açılışa yönlendir
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ShopHomePage(),
        ),
      );
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
