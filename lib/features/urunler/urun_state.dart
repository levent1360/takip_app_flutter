import 'package:takip/features/urunler/urun_model.dart';

class UrunState {
  final bool isLoading;
  final List<UrunModel> data;
  final List<UrunModel> filteredData;

  UrunState({
    required this.data,
    required this.filteredData,
    required this.isLoading,
  });

  factory UrunState.initial() =>
      UrunState(data: [], filteredData: [], isLoading: false);

  UrunState copyWith({
    List<UrunModel>? data,
    List<UrunModel>? filteredData,
    bool? isLoading,
  }) {
    return UrunState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      filteredData: filteredData ?? this.filteredData,
    );
  }

  UrunState urunEkle(UrunState mevcutState, UrunModel yeniUrun) {
    final yeniDataListesi = List<UrunModel>.from(mevcutState.data)
      ..insert(0, yeniUrun);
    final yeniFilteredDataListesi = List<UrunModel>.from(
      mevcutState.filteredData,
    )..insert(0, yeniUrun);

    return mevcutState.copyWith(
      data: yeniDataListesi,
      filteredData: yeniFilteredDataListesi,
    );
  }
}
