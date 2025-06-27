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

  Future<void> urunSil(int id) async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref.read(urunControllerProvider).urunSil(id);
    if (apiResponse >= 200 && apiResponse < 300) {
      final updatedData = state.data.where((item) => item.id != id).toList();
      state = state.copyWith(isLoading: false, data: updatedData);
    }
    state = state.copyWith(isLoading: false);
  }
}
