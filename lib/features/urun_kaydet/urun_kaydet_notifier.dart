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
    await urunNotifier.getProducts();
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
    print("-----------------------------------");
    print("state.isLoading: ${state.isLoading}");
    print("-----------------------------------");
    state = state.copyWith(
      isLoading: true,
      result: apiResponse,
      metin: 'Ürünleriniz Kaydediliyor... ',
    );

    // Ürünler filtrelenip listeye eklenecek
    int retries = 0;
    const maxRetries = 20;
    const delayBetweenTries = Duration(milliseconds: 2000);

    while (retries < maxRetries) {
      await urunNotifier.getProducts();
      final currentLength = ref.read(urunNotifierProvider).data.length;

      print("-----------------------------------");
      print("beforeLength: ${beforeLength}");
      print("currentLength: ${currentLength}");
      print("-----------------------------------");

      if (currentLength > beforeLength) {
        break;
      }

      await Future.delayed(delayBetweenTries);
      retries++;
    }
    print("-----------------------------------");
    print("state.isLoading: ${state.isLoading}");
    print("retries: $retries");
    print("-----------------------------------");
    await Future.delayed(Duration(milliseconds: 1000));
    state = state.copyWith(
      isLoading: false,
      result: apiResponse,
      metin: 'Bitti',
    );
    print("-----------------------------------");
    print("state.isLoading: ${state.isLoading}");
    print("-----------------------------------");
  }

  Future<void> urunKaydet2(String? url) async {
    print("-----------------------------------");
    print("URL alındı: $url");
    print("-----------------------------------");
    state = state.copyWith(
      isLoading: true,
      metin: 'Kontrol Ediliyor... Bekleyiniz',
    );

    // Önceki ürün listesinin uzunluğunu al
    final urunNotifier = ref.read(urunNotifierProvider.notifier);
    await urunNotifier.getProducts();
    final beforeLength = ref.read(urunNotifierProvider).data.length;

    // API çağrısını yap
    final apiResponse = await ref
        .read(urunKaydetControllerProvider)
        .urunKaydet2(url);

    print("-----------------------------------");
    print("apiResponse: ${apiResponse}");
    print("-----------------------------------");

    if (apiResponse == null) {
      showErrorSnackBar(message: 'Geçerli bir ürün linki gönderiniz.');
      state = state.copyWith(
        isLoading: false,
        result: false,
        metin: 'Geçerli bir ürün linki gönderiniz.',
      );
      return;
    }
    print("-----------------------------------");
    print("state.isLoading: ${state.isLoading}");
    print("-----------------------------------");
    state = state.copyWith(
      isLoading: true,
      result: true,
      guidId: apiResponse,
      metin: 'Ürünleriniz Kaydediliyor... ',
    );

    // Ürünler filtrelenip listeye eklenecek
    int retries = 0;
    const maxRetries = 20;
    const delayBetweenTries = Duration(milliseconds: 2000);

    while (retries < maxRetries) {
      await urunNotifier.getProducts();
      final currentLength = ref.read(urunNotifierProvider).data.length;

      print("-----------------------------------");
      print("beforeLength: ${beforeLength}");
      print("currentLength: ${currentLength}");
      print("-----------------------------------");

      if (currentLength > beforeLength) {
        break;
      }

      await Future.delayed(delayBetweenTries);
      retries++;
    }
    print("-----------------------------------");
    print("state.isLoading: ${state.isLoading}");
    print("retries: $retries");
    print("-----------------------------------");
    await Future.delayed(Duration(milliseconds: 1000));
    state = state.copyWith(
      isLoading: false,
      result: true,
      guidId: apiResponse,
      metin: 'Bitti',
    );
    print("-----------------------------------");
    print("state.isLoading: ${state.isLoading}");
    print("-----------------------------------");
  }
}
