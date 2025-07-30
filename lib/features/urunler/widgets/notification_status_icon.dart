import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/notification/notification_permission_provider.dart';

class NotificationStatusIcon extends ConsumerWidget {
  final bool isBildirimAcik;
  final double? size;
  const NotificationStatusIcon({
    super.key,
    required this.isBildirimAcik,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(notificationPermissionProvider);

    return permissionState.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => const Icon(Icons.error),
      data: (allowed) => Icon(
        allowed
            ? isBildirimAcik
                  ? Icons.notifications_active
                  : Icons.notifications_none
            : Icons.notification_important,
        color: allowed ? Colors.teal : Colors.redAccent,
        size: size,
      ),
    );
  }
}
