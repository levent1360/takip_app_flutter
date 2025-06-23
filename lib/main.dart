import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/success_snackbar_component.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/services/notification_service.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/urunler/shop_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorService().navigatorKey = GlobalKey<NavigatorState>();
  await setupLocator();
  await Firebase.initializeApp();

  await NotificationService.initFCMToken();
  runApp(ProviderScope(child: const SampleApp()));
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

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
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  static const platform = MethodChannel('app.channel.shared.data');
  String dataShared = 'No data';
  String? token;

  @override
  void initState() {
    super.initState();
    getSharedText();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    final localDataSource = sl<LocalDataSource>();
    token = await localDataSource.getDeviceToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ShopHomePage();
  }

  Future<void> getSharedText() async {
    var sharedData = await platform.invokeMethod('getSharedText');
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData as String;
        print(dataShared);
        final result = sl<UrunService>().getUrlProducts(dataShared);
        print(result);
      });
    }
  }
}
