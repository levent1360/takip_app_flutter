import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';

class NotificationService {
  static Future<void> initFCMToken() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Android 13+ için izin iste ama reddedilse de devam et
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        final result = await Permission.notification.request();
        if (!result.isGranted) {
          print('Android: Bildirim izni reddedildi');
        }
      }
    }

    // iOS için izin iste ama reddedilse de devam et
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print('iOS: Bildirim izni reddedildi');
      } else {
        // APNs token (isteğe bağlı)
        try {
          String? apnsToken = await messaging.getAPNSToken();
          if (apnsToken != null) {
            print("APNs token: $apnsToken");
          }
        } catch (e) {
          print("APNs token alınamadı: $e");
        }
      }
    }

    // FCM token her durumda alınır
    try {
      String? token = await messaging.getToken();
      if (token != null) {
        final localDataSource = sl<LocalDataSource>();
        await localDataSource.setDeviceToken(token);
        print('FCM Token kaydedildi: $token');
      } else {
        print("FCM token alınamadı");
      }
    } catch (e) {
      print("FCM token alınırken hata oluştu: $e");
    }
  }

  Future<void> ensureNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
      print("Bildirim izni zaten verilmiş");
      return;
    }

    if (status.isDenied) {
      final result = await Permission.notification.request();
      if (result.isGranted) {
        print("Kullanıcı izin verdi");
      } else {
        print("Kullanıcı izin vermedi");
      }
    } else if (status.isPermanentlyDenied) {
      // Kullanıcı bildirim iznini tamamen engellemiş
      // Ayarlara yönlendirmek gerek
      print(
        "Bildirim izni kalıcı olarak reddedilmiş. Ayarlara yönlendiriliyor...",
      );
      await openAppSettings();
    }
  }

  Future<bool> checkNotificationPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      return status.isGranted;
    } else if (Platform.isIOS) {
      final settings = await FirebaseMessaging.instance
          .getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    } else {
      // Diğer platformlarda varsayılan olarak false
      return false;
    }
  }
}
