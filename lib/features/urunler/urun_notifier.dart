import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> getProducts({
    String query = '',
    bool ismarka = false,
    bool forceRefresh = false,
  }) async {
    state = state.copyWith(isLoading: true);

    // final urunController = ref.read(urunControllerProvider);
    // await urunController.urunGoruldu();
    if (forceRefresh) {
      state = state.copyWith(isLoading: true);

      final urunController = ref.read(urunControllerProvider);
      final apiResponse = await urunController.getProducts();
      await urunController.urunGoruldu();

      state = state.copyWith(data: apiResponse, isLoading: false);
    }

    final normalizedQuery = normalizeTurkishCharacters(query.toLowerCase());
    final selectedMarka = ref.read(markaNotifierProvider).selectedMarka;

    List<UrunModel> filtered = state.data.where((product) {
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
      data: state.data,
      filteredData: filtered,
      isLoading: false,
    );
  }

  Future<void> initData({bool isClearAll = false}) async {
    state = state.copyWith(isLoading: true);

    final urunController = ref.read(urunControllerProvider);
    final apiResponse = await urunController.getProductsPage(1);
    await urunController.urunGoruldu();

    state = state.copyWith(
      data: apiResponse.data,
      filteredData: apiResponse.data,
      pageNumber: apiResponse.pageNumber,
      isLoading: false,
      totalCount: apiResponse.totalCount,
    );
    if (isClearAll) {
      await filterData(isClearAll: true);
      return;
    }
    filterData(); // filtreleme işlemi yapılır
  }

  Future<void> nextData({bool isClearAll = false}) async {
    // Son sayfaya gelindiyse tekrar yükleme yapılmasın
    final alreadyFetchedCount = state.data.length;
    if (state.isNextLoading || alreadyFetchedCount >= state.totalCount) return;

    state = state.copyWith(isLoading: true, isNextLoading: true);

    final urunController = ref.read(urunControllerProvider);
    final nextPage = state.pageNumber + 1;
    final apiResponse = await urunController.getProductsPage(nextPage);
    await urunController.urunGoruldu();

    final updatedData = [...state.data, ...apiResponse.data];

    state = state.copyWith(
      data: updatedData,
      filteredData: updatedData,
      pageNumber: nextPage,
      isLoading: false,
      isNextLoading: false,
      totalCount: apiResponse.totalCount, // <- önemli
    );

    if (isClearAll) {
      await filterData(isClearAll: true);
      return;
    }
    if (state.queryText == null) {
      filterData();
    } else {
      filterData(isQuery: true, query: state.queryText!);
    }
  }

  Future<void> filterDataEski({
    bool isQuery = false,
    String query = '',
    bool ismarka = false,
    bool isClearAll = false,
  }) async {
    if (isClearAll) {
      await clearAllfilter();
      return;
    }

    final normalizedQuery = normalizeTurkishCharacters(query.toLowerCase());
    final selectedMarka = ref.read(markaNotifierProvider).selectedMarka;

    if (isQuery) {
      setQueryText(query);
    }
    if (!ismarka) {
      ref.read(markaNotifierProvider.notifier).clearSelectedMarka();
    }

    final _query = state.queryText;

    List<UrunModel> filtered = state.data.where((product) {
      final productName = normalizeTurkishCharacters(
        product.filterMarkaNameBirlesik.toLowerCase(),
      );
      final matchesQuery = _query == null
          ? true
          : productName.contains(normalizedQuery);
      final matchesMarka = !ismarka
          ? true
          : (selectedMarka == null
                ? true
                : product.siteMarka == selectedMarka.name);

      return matchesQuery && matchesMarka;
    }).toList();

    final uniqueMarkalar = filtered.map((e) => e.siteMarka).toSet().toList();
    if (isQuery) {
      await ref
          .read(markaNotifierProvider.notifier)
          .setFilterMarkas(uniqueMarkalar);
    }

    state = state.copyWith(filteredData: filtered);
  }

  Future<void> filterData({
    bool isQuery = false,
    String? query,
    bool isClearAll = false,
  }) async {
    // 1. Filtreleri sıfırlamak istenirse
    if (isClearAll) {
      await clearAllfilter();
      return;
    }

    // 3. Eğer query varsa, setQueryText çalışsın ve marka temizlensin
    if (isQuery) {
      setQueryText(query ?? '');
      ref.read(markaNotifierProvider.notifier).clearSelectedMarka();
    }

    // 4. En güncel filtre bilgilerini oku
    final selectedMarka = ref.read(markaNotifierProvider).selectedMarka;
    final currentQuery = state.queryText?.toLowerCase() ?? '';

    // 5. Filtreyi uygula
    final filtered = state.data.where((product) {
      final productName = normalizeTurkishCharacters(
        product.filterMarkaNameBirlesik.toLowerCase(),
      );

      final matchesQuery = currentQuery.isEmpty
          ? true
          : productName.contains(currentQuery);

      final matchesMarka = selectedMarka == null
          ? true
          : product.siteMarka == selectedMarka.name;

      return matchesQuery && matchesMarka;
    }).toList();

    // 6. Eğer arama varsa, filtre markaları güncelle
    if (isQuery) {
      final uniqueMarkalar = filtered.map((e) => e.siteMarka).toSet().toList();
      await ref
          .read(markaNotifierProvider.notifier)
          .setFilterMarkas(uniqueMarkalar);
    }

    // 7. State güncelle
    state = state.copyWith(filteredData: filtered);
  }

  void setSelectedProduct(int id) {
    final product = state.data.firstWhere((e) => e.id == id);
    state = state.copyWith(selectedProduct: product);
  }

  void setQueryText(String? text) {
    state = state.copyWith(queryText: text);
  }

  void clearQueryText() {
    state = state.copyWith(queryText: null);
  }

  Future<void> clearAllfilter() async {
    state = state.copyWith(filteredData: state.data, queryText: null);
    await ref.read(markaNotifierProvider.notifier).clearFilterMarkas();
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
  //   ref.read(markaNotifierProvider.notifier).clearSelectedMarka();
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
  //     filtered = state.filteredData
  //         .where((q) => q.siteMarka == markaState.selectedMarka?.name)
  //         .toList();
  //   }

  //   // filteredData'yı güncelliyoruz ve loading'i false yapıyoruz
  //   state = state.copyWith(filteredData: filtered, isLoading: false);
  // }

  // void resetFilter() {
  //   state = state.copyWith(filteredData: state.data);
  // }

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
