import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';

class NotificationService {
  static Future<void> initFCMToken() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1️⃣ Kullanıcıdan izin iste
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2️⃣ İzin verildiyse devam et
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 3️⃣ APNs token hazır mı kontrol et (iOS için)
      String? apnsToken;
      try {
        apnsToken = await messaging.getAPNSToken();
      } catch (e) {
        print("APNS token alınamadı: $e");
      }

      if (apnsToken != null) {
        // 4️⃣ FCM token al
        String? token = await messaging.getToken();

        if (token != null) {
          final localDataSource = sl<LocalDataSource>();
          await localDataSource.setDeviceToken(token);
          print('FCM Token kaydedildi: $token');
        } else {
          print("FCM token alınamadı");
        }
      } else {
        print("APNS token henüz hazır değil.");
      }
    } else {
      print('Bildirim izni reddedildi.');
    }
  }
}
