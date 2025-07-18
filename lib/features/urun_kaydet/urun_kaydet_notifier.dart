import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_provider.dart';
import 'package:takip/features/urun_kaydet/urun_kaydet_state.dart';
import 'package:takip/features/urunler/urun_model.dart';
import 'package:takip/features/urunler/urun_notifier.dart';
import 'package:takip/features/urunler/urun_provider.dart';

final urunKaydetNotifierProvider =
    StateNotifierProvider<UrunKaydetNotifier, UrunKaydetState>((ref) {
      return UrunKaydetNotifier(ref);
    });

class UrunKaydetNotifier extends StateNotifier<UrunKaydetState> {
  final Ref ref;

  UrunKaydetNotifier(this.ref) : super(UrunKaydetState.initial()) {}

  Future<void> urunKaydet2(BuildContext context, String? url) async {
    state = state.copyWith(
      isLoading: true,
      metin: LocalizationHelper.of(context).urunkontrol,
    );

    try {
      // API çağrısını yap
      final apiResponse = await ref
          .read(urunKaydetControllerProvider)
          .urunKaydet2(url);

      if (apiResponse == null) {
        showErrorSnackBar(
          message: LocalizationHelper.of(context).gecerligonder,
        );
        state = state.copyWith(
          isLoading: false,
          result: false,
          metin: LocalizationHelper.of(context).gecerligonder,
        );
        return;
      }

      state = state.copyWith(
        isLoading: true,
        result: true,
        guidId: apiResponse,
        metin: LocalizationHelper.of(context).urunkaydediliyor,
      );

      // Ürünler filtrelenip listeye eklenecek
      int retries = 0;
      const maxRetries = 20;
      const delayBetweenTries = Duration(milliseconds: 2000);

      UrunModel? urunModel;

      while (retries < maxRetries) {
        urunModel = await ref
            .read(urunControllerProvider)
            .getUrunByGuidId(apiResponse);

        if (urunModel != null) {
          ref.read(urunNotifierProvider.notifier).urunEkle(urunModel);
          break;
        }

        await Future.delayed(delayBetweenTries);
        retries++;
      }

      await Future.delayed(Duration(milliseconds: 1000));
      state = state.copyWith(
        isLoading: false,
        result: true,
        guidId: apiResponse,
        metin: LocalizationHelper.of(context).bitti,
      );
    } on DioException {
      // final errorMessage = ErrorService().parseDioError(e);
      // showErrorSnackBar(message: errorMessage);

      state = state.copyWith(
        isLoading: false,
        result: false,
        metin: LocalizationHelper.of(context).hata,
      );
    }
  }
}
