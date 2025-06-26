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

class _SplashScreenState extends ConsumerState<SplashScreen>
    with WidgetsBindingObserver {
  // static const platform = MethodChannel('app.channel.shared.data');

  String? sharedText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    checkSharedText();
    _listenForNewSharedText();
    platform.setMethodCallHandler((call) async {
      if (call.method == "getSharedText") {
        final sharedText = call.arguments as String?;
      }
    });
  }

  @override
  void dispose() {
    // Uygulama durdurulduğunda observer'ı kaldırıyoruz
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Uygulama foreground'a geçtiğinde bu fonksiyon tetiklenir
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print('didChangeAppLifecycleState : $state');
      // checkSharedText();
      // Uygulama foreground'a geldiğinde SplashScreen'i tekrar gösteriyoruz
      _navigateToSplashScreen();
    }
  }

  // Splash Screen'e yönlendiren fonksiyon
  void _navigateToSplashScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  void _listenForNewSharedText() {
    platform.setMethodCallHandler((call) async {
      if (call.method == "onNewSharedText") {
        final newData = call.arguments as String?;

        if (newData != null && newData.isNotEmpty) {
          // API isteği yap
          await ref
              .read(urunKaydetNotifierProvider.notifier)
              .getUrlProducts(newData);

          // Bekleme süresi (loading hissi için)
          await Future.delayed(const Duration(seconds: 2));

          if (!mounted) return;

          // Yönlendir
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ShopHomePage()),
          );
        }
      }
    });
  }

  Future<void> checkSharedTextAndNavigate() async {
    try {
      final sharedData = await platform.invokeMethod('getSharedText');

      if (sharedData != null && sharedData is String) {
        // Paylaşılan veri varsa: önce API çağrısı yap
        await ref
            .read(urunKaydetNotifierProvider.notifier)
            .getUrlProducts(sharedData);

        // 2 saniye loading gibi beklet (isteğe bağlı)
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ShopHomePage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ShopHomePage()),
        );
      }

      // Her iki durumda da yönlendir
      if (!context.mounted) return;
    } catch (e) {
      // Hata durumunda doğrudan ana sayfaya yönlendir
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ShopHomePage()),
        );
      }
    }
  }

  Future<void> checkSharedText() async {
    try {
      final result = await platform.invokeMethod("getSharedText");
      if (result != null && result is String) {
        setState(() {
          sharedText = result;
          ref
              .read(urunKaydetNotifierProvider.notifier)
              .getUrlProducts(sharedText);
        });

        /// Loading screen göster, sonra yönlendir
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (_) => ShopHomePage()));
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
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => ShopHomePage()));
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
