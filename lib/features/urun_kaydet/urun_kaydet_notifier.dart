import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_provider.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_state.dart';
import 'package:takip/features/urunler/urun_notifier.dart';

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
    state = state.copyWith(
      isLoading: true,
      metin: 'Kontrol Ediliyor... Bekleyiniz',
    );

    // Önceki ürün listesinin uzunluğunu al
    final urunNotifier = ref.read(urunNotifierProvider.notifier);
    final beforeLength = ref.read(urunNotifierProvider).data.length;

    // API çağrısını yap
    final apiResponse = await ref
        .read(urunKaydetControllerProvider)
        .getUrlProducts(url);

    if (!apiResponse) {
      showErrorSnackBar(message: 'Geçerli bir ürün linki gönderiniz.');
      state = state.copyWith(
        isLoading: false,
        metin: 'Geçerli bir ürün linki gönderiniz.',
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      result: apiResponse,
      metin: 'Ürünleriniz Kaydediliyor... ',
    );

    // Ürünler filtrelenip listeye eklenecek
    int retries = 0;
    const maxRetries = 10;
    const delayBetweenTries = Duration(milliseconds: 3000);

    while (retries < maxRetries) {
      await urunNotifier.getProducts();

      final currentLength = ref.read(urunNotifierProvider).data.length;
      if (currentLength > beforeLength) {
        break;
      }

      await Future.delayed(delayBetweenTries);
      retries++;
    }

    await Future.delayed(Duration(milliseconds: 1000));
    state = state.copyWith(
      isLoading: false,
      result: apiResponse,
      metin: 'Bitti',
    );
  }
}
