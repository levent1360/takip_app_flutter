import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_controller.dart';

final urunKaydetServiceProvider = Provider<UrunService>((ref) {
  return sl<UrunService>();
});

final urunKaydetControllerProvider = Provider<UrunKaydetController>(
  (ref) => UrunKaydetController(ref.read(urunKaydetServiceProvider)),
);
