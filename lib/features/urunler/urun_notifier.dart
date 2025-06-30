import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/success_snackbar_component.dart';
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

  Future<void> bildirimAc(int id, bool deger) async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref
        .read(urunControllerProvider)
        .bildirimAc(id, deger);
    if (apiResponse >= 200 && apiResponse < 300) {
      final updatedData = state.data.map((item) {
        if (item.id == id) {
          return item.copyWith(isBildirimAcik: !deger);
        }
        return item;
      }).toList();

      if (deger) {
        showSuccessSnackBar(message: 'Bu ürün için bildirimler kapatıldı');
      } else {
        showSuccessSnackBar(message: 'Bu ürün için bildirimler açıldı');
      }

      state = state.copyWith(isLoading: false, data: updatedData);
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> hataliSil(String url) async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref.read(urunControllerProvider).hataliSil(url);
    if (apiResponse >= 200 && apiResponse < 300) {
      final updatedData = state.data
          .where((item) => item.isIslendi != false && item.link != url)
          .toList();
      state = state.copyWith(isLoading: false, data: updatedData);
    }
    state = state.copyWith(isLoading: false);
  }
}
