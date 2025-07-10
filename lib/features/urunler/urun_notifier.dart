import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/components/snackbar/success_snackbar_component.dart';
import 'package:takip/core/utils/normalizeTurkishCharacters.dart';
import 'package:takip/features/markalar/marka_notifier.dart';
import 'package:takip/features/urunler/urun_model.dart';
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

  Future<void> getProducts({String query = '', bool ismarka = false}) async {
    state = state.copyWith(isLoading: true);

    final urunController = ref.read(urunControllerProvider);
    final apiResponse = await urunController.getProducts();
    await urunController.urunGoruldu();

    final normalizedQuery = normalizeTurkishCharacters(query.toLowerCase());
    final selectedMarka = ref.read(markaNotifierProvider).selectedMarka;

    List<UrunModel> filtered = apiResponse.where((product) {
      final productName = normalizeTurkishCharacters(
        product.name?.toLowerCase() ?? '',
      );
      final matchesQuery = query.isEmpty
          ? true
          : productName.contains(normalizedQuery);
      final matchesMarka = !ismarka
          ? true
          : (selectedMarka == null
                ? true
                : product.siteMarka == selectedMarka.name);

      return matchesQuery && matchesMarka;
    }).toList();

    state = state.copyWith(
      data: apiResponse,
      filteredData: filtered,
      isLoading: false,
    );
  }

  // Future<void> getFilteredProducts() async {
  //   state = state.copyWith(isLoading: true);

  //   state = state.copyWith(
  //     data: state.data,
  //     filteredData: state.filteredData,
  //     isLoading: false,
  //   );
  // }

  // void filterProducts(String query) {
  //   state = state.copyWith(isLoading: true);
  //   final normalizedQuery = normalizeTurkishCharacters(query.toLowerCase());

  //   final filtered = state.data.where((q) {
  //     final normalizedName = normalizeTurkishCharacters(q.name!.toLowerCase());
  //     return normalizedName.contains(normalizedQuery);
  //   }).toList();

  //   state = state.copyWith(filteredData: filtered, isLoading: false);
  // }

  // Future<void> filterByMarkaProducts() async {
  //   state = state.copyWith(isLoading: true);

  //   // Marka state'ini almak için read kullanıyoruz
  //   final markaState = ref.read(markaNotifierProvider);

  //   List<UrunModel> filtered = [];

  //   // Eğer selectedMarka null ise, tüm verileri filteredData'ya ekliyoruz
  //   if (markaState.selectedMarka == null) {
  //     filtered = state.data.isEmpty ? [] : state.data;
  //   } else {
  //     // Eğer selectedMarka varsa, veri filtreleme işlemi yapıyoruz
  //     filtered = state.data
  //         .where((q) => q.siteMarka == markaState.selectedMarka?.name)
  //         .toList();
  //   }

  //   // filteredData'yı güncelliyoruz ve loading'i false yapıyoruz
  //   state = state.copyWith(filteredData: filtered, isLoading: false);
  // }

  // void resetFilter() {
  //   state = state.copyWith(filteredData: state.data);
  // }

  Future<void> urunSil(int id) async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref.read(urunControllerProvider).urunSil(id);
    if (apiResponse >= 200 && apiResponse < 300) {
      final updatedData = state.data.where((item) => item.id != id).toList();
      final updatedFilteredData = state.filteredData
          .where((item) => item.id != id)
          .toList();
      state = state.copyWith(
        isLoading: false,
        data: updatedData,
        filteredData: updatedFilteredData,
      );
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
      final updatedFilteredData = state.filteredData.map((item) {
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

      state = state.copyWith(
        isLoading: false,
        data: updatedData,
        filteredData: updatedFilteredData,
      );
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
      final updatedFilteredData = state.filteredData
          .where((item) => item.isIslendi != false && item.link != url)
          .toList();
      state = state.copyWith(
        isLoading: false,
        data: updatedData,
        filteredData: updatedFilteredData,
      );
    }
    state = state.copyWith(isLoading: false);
  }

  void urunEkle(UrunModel yeniUrun) {
    final yeniDataListesi = List<UrunModel>.from(state.data)
      ..insert(0, yeniUrun);
    final yeniFilteredDataListesi = List<UrunModel>.from(state.filteredData)
      ..insert(0, yeniUrun);

    state = state.copyWith(
      data: yeniDataListesi,
      filteredData: yeniFilteredDataListesi,
    );
  }
}
