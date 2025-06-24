import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/services/notification_service.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/splash_screen/splash_screen.dart';
import 'package:takip/features/urunler/shop_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorService().navigatorKey = GlobalKey<NavigatorState>();
  await setupLocator();
  await Firebase.initializeApp();

  await NotificationService.initFCMToken();
  runApp(ProviderScope(child: const TakipApp()));
}

class TakipApp extends StatelessWidget {
  const TakipApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiyat Takip',
      debugShowCheckedModeBanner: false,
      navigatorKey: ErrorService().navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}

class TakipAppPage extends StatefulWidget {
  const TakipAppPage({super.key});

  @override
  State<TakipAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<TakipAppPage> {
  static const platform = MethodChannel('app.channel.shared.data');

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return ShopHomePage();
  }

  Future<void> getSharedText() async {
    String? sharedData = await platform.invokeMethod('getSharedText');
    if (sharedData != null) {
      setState(() {
        sl<UrunService>().getUrlProducts(sharedData);
      });
    }
  }
}
