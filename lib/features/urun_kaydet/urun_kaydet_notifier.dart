import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_provider.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_state.dart';

final urunKaydetNotifierProvider =
    StateNotifierProvider<UrunKaydetNotifier, UrunKaydetState>((ref) {
      return UrunKaydetNotifier(ref);
    });

class UrunKaydetNotifier extends StateNotifier<UrunKaydetState> {
  final Ref ref;

  UrunKaydetNotifier(this.ref) : super(UrunKaydetState.initial()) {}

  Future<void> getUrlProducts(String? url) async {
    print("-----------------------------------");
    print("URL alındı: $url");
    print("-----------------------------------");
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref
        .read(urunKaydetControllerProvider)
        .getUrlProducts(url);

    await Future.delayed(Duration(seconds: 10));
    state = state.copyWith(isLoading: false, result: apiResponse);
  }
}
