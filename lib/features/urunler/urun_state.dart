import 'package:takip/features/urunler/urun_model.dart';

class UrunState {
  final bool isLoading;
  final List<UrunModel> data;
  final List<UrunModel> filteredData;
  final UrunModel? selectedProduct;

  UrunState({
    required this.data,
    required this.filteredData,
    required this.selectedProduct,
    required this.isLoading,
  });

  factory UrunState.initial() => UrunState(
    data: [],
    filteredData: [],
    selectedProduct: null,
    isLoading: false,
  );

  UrunState copyWith({
    List<UrunModel>? data,
    List<UrunModel>? filteredData,
    UrunModel? selectedProduct,
    bool? isLoading,
  }) {
    return UrunState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      filteredData: filteredData ?? this.filteredData,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}
