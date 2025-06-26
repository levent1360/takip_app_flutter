import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/urunler/urun_provider.dart';
import 'package:takip/features/urunler/urun_state.dart';

final urunNotifierProvider = StateNotifierProvider<UrunNotifier, UrunState>((
  ref,
) {
  return UrunNotifier(ref);
});

class UrunNotifier extends StateNotifier<UrunState> {
  final Ref ref;

  UrunNotifier(this.ref) : super(UrunState.initial()) {}

  Future<void> getProducts() async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref.read(urunControllerProvider).getProducts();
    await ref.read(urunControllerProvider).urunGoruldu();
    state = state.copyWith(data: apiResponse, isLoading: false);
  }
}
