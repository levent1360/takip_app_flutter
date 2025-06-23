import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/services/marka_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/markalar/marka_controller.dart';

final markaServiceProvider = Provider<MarkaService>((ref) {
  return sl<MarkaService>();
});

final markaControllerProvider = Provider<MarkaController>(
  (ref) => MarkaController(ref.read(markaServiceProvider)),
);
