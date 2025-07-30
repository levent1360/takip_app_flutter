import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

final notificationPermissionProvider =
    StateNotifierProvider<NotificationPermissionNotifier, AsyncValue<bool>>(
      (ref) => NotificationPermissionNotifier()..checkPermission(),
    );

class NotificationPermissionNotifier extends StateNotifier<AsyncValue<bool>> {
  NotificationPermissionNotifier() : super(const AsyncLoading());

  Future<void> checkPermission() async {
    try {
      bool isGranted;

      if (Platform.isAndroid) {
        final status = await Permission.notification.status;
        isGranted = status.isGranted;
      } else if (Platform.isIOS) {
        final settings = await FirebaseMessaging.instance
            .getNotificationSettings();
        isGranted =
            settings.authorizationStatus == AuthorizationStatus.authorized;
      } else {
        isGranted = false;
      }

      state = AsyncData(isGranted);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
