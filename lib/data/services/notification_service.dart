import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';

class NotificationService {
  static Future<void> initFCMToken() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Android 13+ için manuel izin kontrolü
    if (defaultTargetPlatform == TargetPlatform.android) {
      // Android 13+ ise izin istemen lazım, Flutter tarafında paket yoksa native'den kontrol etmelisin.
      // Burada paket kullanmadan Flutter tarafında izin kontrolü mümkün değil,
      // Bu yüzden Android 13+ için native kodda izin isteği yapmalısın.
      // Burada demo amaçlı izin varsayımı yapıyoruz.
      print(
        'Android cihaz: Bildirim izni varsayılan olarak veriliyor veya nativeden kontrol edilmeli.',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // iOS'ta izin iste
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print('Bildirim izni reddedildi.');
        return;
      }
    }

    // iOS için APNs token alma
    String? apnsToken;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        apnsToken = await messaging.getAPNSToken();
      } catch (e) {
        print("APNS token alınamadı: $e");
      }

      if (apnsToken == null) {
        print("APNS token henüz hazır değil.");
        return;
      }
    }

    // FCM token alma (hem Android hem iOS için)
    String? token = await messaging.getToken();

    if (token != null) {
      final localDataSource = sl<LocalDataSource>();
      await localDataSource.setDeviceToken(token);
      print('FCM Token kaydedildi: $token');
    } else {
      print("FCM token alınamadı");
    }
  }
}
