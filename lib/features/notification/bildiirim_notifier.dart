import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/notification/bildirim_provider.dart';
import 'package:takip/features/notification/bildirim_state.dart';

final bildirimNotifierProvider =
    StateNotifierProvider<BildiirimNotifier, BildirimState>((ref) {
      return BildiirimNotifier(ref);
    });

class BildiirimNotifier extends StateNotifier<BildirimState> {
  final Ref ref;

  BildiirimNotifier(this.ref) : super(BildirimState.initial()) {}

  Future<void> hataliKayitlar() async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref
        .read(bildirimControllerProvider)
        .hataliKayitlar();
    state = state.copyWith(data: apiResponse, isLoading: false);
  }
}
