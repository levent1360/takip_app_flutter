import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/success_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/utils/confirm_dialog.dart';
import 'package:takip/data/services/notification_service.dart';
import 'package:takip/features/notification/notification_permission_provider.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/urun_notifier.dart';

class NotificationStatusIcon extends ConsumerWidget {
  final UrunModel urunModel;
  final double? size;
  const NotificationStatusIcon({
    super.key,
    required this.urunModel,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(notificationPermissionProvider);

    Future<void> bildirimAc() async {
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
      } else {
        final result = await ref
            .read(urunNotifierProvider.notifier)
            .bildirimAc(urunModel.id, urunModel.isBildirimAcik);
        if (result == null) return;
        if (result) {
          showSuccessSnackBar(
            message: LocalizationHelper.l10n.bildirimkapatildi,
          );
        } else {
          showSuccessSnackBar(message: LocalizationHelper.l10n.bildirimacildi);
        }
      }
    }

    return permissionState.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => const Icon(Icons.error),
      data: (allowed) => GestureDetector(
        onTap: bildirimAc,
        child: Icon(
          allowed
              ? urunModel.isBildirimAcik
                    ? Icons.notifications_active
                    : Icons.notifications_off_outlined
              : Icons.notification_important,
          color: allowed
              ? urunModel.isBildirimAcik
                    ? Colors.teal
                    : Colors.grey
              : Colors.redAccent,
          size: size,
        ),
      ),
    );
  }
}
