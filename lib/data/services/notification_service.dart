import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';

class NotificationService {
  static Future<void> initFCMToken() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();

      if (token != null) {
        final localDataSource = sl<LocalDataSource>();
        await localDataSource.setDeviceToken(token);
        print('Token kaydedildi: $token');
      }
    } else {
      print('Bildirim izni reddedildi.');
    }
  }
}
