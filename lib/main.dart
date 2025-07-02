import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/data/services/notification_service.dart';
import 'package:takip/features/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorService().navigatorKey = GlobalKey<NavigatorState>();
  await setupLocator();
  await Firebase.initializeApp();

  await NotificationService.initFCMToken();
  runApp(ProviderScope(child: const TakipApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();
const platform = MethodChannel("app.channel.shared.data");

class TakipApp extends ConsumerStatefulWidget {
  const TakipApp({super.key});

  @override
  ConsumerState<TakipApp> createState() => _TakipAppState();
}

class _TakipAppState extends ConsumerState<TakipApp>
    with WidgetsBindingObserver {
  StreamSubscription<Uri>? _linkSubscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initDeepLinks();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    platform.setMethodCallHandler(null); // Handler'ı temizle
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    final appLinks = AppLinks();

    // Uygulama kapalıyken açılırsa (cold start)
    final initialUri = await appLinks.getInitialLink();
    if (initialUri != null) {
      _handleDeepLink(initialUri);
    }

    // Uygulama açık/arkada çalışırken gelen linkler
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    // URL'yi Riverpod'a kaydet

    print(uri);
  }

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
      home: OnboardingScreen(),
    );
  }
}
