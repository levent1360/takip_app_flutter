import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/data/services/notification_service.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_notifier.dart';
import 'package:takip/features/urunler/shop_home_page.dart';
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
const platform = MethodChannel("app.channel.shared.data");

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
    // _initSharedText();
  }

  // Future<void> _initSharedText() async {
  //   try {
  //     final String? sharedText = await platform.invokeMethod('getSharedText');
  //     if (sharedText != null) {
  //       setState(() {
  //         _sharedText = sharedText;
  //       });
  //       final String uri = Uri.encodeComponent(_sharedText!);
  //       print('------------------------------------');
  //       print('getSharedText     : $_sharedText');
  //       print('getSharedText  uri   : $uri');
  //       print('------------------------------------');

  //       // await ref
  //       //     .read(urunKaydetNotifierProvider.notifier)
  //       //     .getUrlProducts(_sharedText);

  //       await Future.delayed(Duration(seconds: 2));
  //       setState(() {
  //         _sharedText = null;
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     print("Hata: ${e.message}");
  //   }
  // }

  void _setupIntentListener() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onNewSharedText') {
        setState(() {
          _sharedText = call.arguments;
        });

        final String uri = Uri.encodeComponent(_sharedText!);

        print('------------------------------------');
        print('onNewSharedText     : $_sharedText');
        print('onNewSharedText   uri  : $uri');
        print('------------------------------------');

        // Önce ProductScreen'e dön (gerekirse tüm stack'i temizle)
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ShopHomePage()),
          (route) => false,
        );

        await ref
            .read(urunKaydetNotifierProvider.notifier)
            .urunKaydet2(context, _sharedText);

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
    ref.read(urunNotifierProvider.notifier).getProducts();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setupIntentListener(); // Uygulama arka plandan döndüğünde kontrol et
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
      home: ShopHomePage(),
    );
  }
}
