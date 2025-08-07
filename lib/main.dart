import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/data/services/notification_service.dart';
import 'package:takip/features/notification/notification_permission_provider.dart';
import 'package:takip/features/onboarding/onboarding_screen.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page_scroll.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorService().navigatorKey = GlobalKey<NavigatorState>();
  await setupLocator();
  await Firebase.initializeApp();

  await NotificationService.initFCMToken();
  runApp(ProviderScope(child: const TakipApp()));
}

final navigatorKey = ErrorService().navigatorKey;
// const platform = MethodChannel("app.channel.shared.data");

class TakipApp extends ConsumerStatefulWidget {
  const TakipApp({super.key});

  @override
  ConsumerState<TakipApp> createState() => _TakipAppState();
}

class _TakipAppState extends ConsumerState<TakipApp>
    with WidgetsBindingObserver {
  static const platform = MethodChannel('app.channel.shared.data');
  String? _sharedText;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupInteractedMessage();
    _setupIntentListener();
  }

  void _setupIntentListener() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onNewSharedText') {
        setState(() {
          _sharedText = call.arguments;
        });

        // Önce ProductScreen'e dön (gerekirse tüm stack'i temizle)
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ShopHomePageScroll()),
          (route) => false,
        );

        await ref
            .read(urunKaydetNotifierProvider.notifier)
            .urunKaydet(
              _sharedText,
              checkingText: LocalizationHelper.l10n.urunkontrol,
              gecerliGonderText: LocalizationHelper.l10n.gecerligonder,
              urunkaydediliyorText: LocalizationHelper.l10n.urunkaydediliyor,
              bittiText: LocalizationHelper.l10n.bitti,
              hataText: LocalizationHelper.l10n.hata,
            );
        await bildirimIzinAc();

        await Future.delayed(Duration(seconds: 2));
        setState(() {
          _sharedText = null;
        });
      }
    });
  }

  Future<void> _setupInteractedMessage() async {
    // Uygulama kapalıyken veya arka plandayken açılan bildirim
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Uygulama arka planda veya öndeyken gelen bildirim
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // Bildirim tıklandığında API'ye istek at
    ref.read(urunNotifierProvider.notifier).initData();
  }

  Future<void> bildirimIzinAc() async {
    final permissionState = ref.watch(notificationPermissionProvider);

    if (permissionState.value == false) {
      final result = await showConfirmDialog(
        title: LocalizationHelper.l10n.bildirimizinbaslik,
        content: LocalizationHelper.l10n.bildirimizinmetin,
        confirmText: LocalizationHelper.l10n.bildirimizinayaragit,
        confirmColor: Colors.teal,
      );

      if (result == true) {
        NotificationService().ensureNotificationPermission();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setupIntentListener(); // Uygulama arka plandan döndüğünde kontrol et
      ref.read(notificationPermissionProvider.notifier).checkPermission();
    }
  }

  @override
  void dispose() {
    platform.setMethodCallHandler(null); // Handler'ı temizle
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fiyat Takip',
      debugShowCheckedModeBanner: false,
      navigatorKey: ErrorService().navigatorKey,
      supportedLocales: const [Locale('en'), Locale('tr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: OnboardingScreen(), //ShopHomePageScroll(), //ShopHomePage(),
    );
  }
}
