import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/notification/bildirim_controller.dart';

final urunServiceProvider = Provider<UrunService>((ref) {
  return sl<UrunService>();
});

final bildirimControllerProvider = Provider<BildirimController>(
  (ref) => BildirimController(ref.read(urunServiceProvider)),
);
