import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> initData({
    bool isNext = false,
    bool isMarkaFilter = false,
  }) async {
    // Eğer zaten veri yükleniyorsa ya da tüm veriler yüklendiyse işlemi durdur
    if (isNext &&
        (state.isNextLoading || state.data.length >= state.totalCount))
      return;

    // Sayfa numarasını belirle
    final nextPage = isNext ? state.pageNumber + 1 : 1;

    // Yükleme durumunu güncelle
    state = state.copyWith(
      isLoading: !isNext, // İlk yüklemede tam ekran loading
      isNextLoading: isNext, // Scroll ile yüklemede alt loading
    );

    try {
      final urunController = ref.read(urunControllerProvider);

      final selectedMarka = ref.read(markaNotifierProvider).selectedMarka;
      String? _marka;
      if (selectedMarka != null) {
        _marka = selectedMarka.name;
      }

      String? _searchText;
      if (state.queryText != null) {
        _searchText = state.queryText;
      } else {
        _searchText = null;
      }

      // API'den sayfalı veri al
      final apiResponse = await urunController.getUrunlerPageSearch(
        nextPage,
        _searchText,
        _marka,
      );

      // Ürün görüntülendi işlemi
      await urunController.urunGoruldu();

      // Yeni verileri ekle (isNext'e göre ya sıfırla ya da üstüne ekle)
      final newData = isNext
          ? [...state.data, ...apiResponse.data]
          : apiResponse.data;

      if (!isMarkaFilter && apiResponse.markalar != null) {
        await ref
            .read(markaNotifierProvider.notifier)
            .setFilterMarkas(apiResponse.markalar!);
      }
      // State güncelle
      state = state.copyWith(
        data: newData,
        filteredData:
            newData, // Eğer dışarıdan farklı filtreleme varsa buna göre ayır
        pageNumber: nextPage,
        totalCount: apiResponse.totalCount,
        isLoading: false,
        isNextLoading: false,
      );
    } catch (e) {
      // Hata durumunda loading false yapılmalı
      state = state.copyWith(isLoading: false, isNextLoading: false);
    }
  }

  void setSelectedProduct(int id) {
    final product = state.data.firstWhere((e) => e.id == id);
    state = state.copyWith(selectedProduct: product);
  }

  Future<void> setQueryText(String? text) async {
    state = state.copyWith(queryText: text);
  }

  void clearQueryText() {
    state = state.copyWith(queryText: null);
  }

  Future<void> clearAllfilter() async {
    state = state.copyWith(filteredData: state.data, queryText: null);
    await ref.read(markaNotifierProvider.notifier).clearFilterMarkas();
  }

  Future<void> refreshData() async {
    // State'i temizle
    state = state.copyWith(
      data: [],
      queryText: null,
      queryTextSetToNull: true,
      filteredData: [],
      pageNumber: 1,
    );

    await ref.read(markaNotifierProvider.notifier).clearFilterMarkas();
    // Yeni verileri getir (filtresiz, ilk sayfa)
    await initData(isNext: false);
  }

  Future<void> urunSil(String guidId) async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref.read(urunControllerProvider).urunSil(guidId);
    if (apiResponse >= 200 && apiResponse < 300) {
      final updatedData = state.data
          .where((item) => item.iden != guidId)
          .toList();
      final updatedFilteredData = state.filteredData
          .where((item) => item.iden != guidId)
          .toList();
      state = state.copyWith(
        isLoading: false,
        data: updatedData,
        filteredData: updatedFilteredData,
        selectedProduct: null,
      );
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool?> bildirimAc(int id, bool deger) async {
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

      // selectedProduct'ı da kontrol edip gerekirse güncelle
      final updatedSelectedProduct = (state.selectedProduct?.id == id)
          ? state.selectedProduct!.copyWith(isBildirimAcik: !deger)
          : state.selectedProduct;

      state = state.copyWith(
        isLoading: false,
        data: updatedData,
        filteredData: updatedFilteredData,
        selectedProduct: updatedSelectedProduct,
      );
      return deger;
    }
    state = state.copyWith(isLoading: false);
    return null;
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
