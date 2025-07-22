import 'package:takip/features/urunler/urun_model.dart';

class UrunState {
  final bool isLoading;
  final bool isNextLoading;
  final List<UrunModel> data;
  final List<UrunModel> filteredData;
  final UrunModel? selectedProduct;
  final int pageNumber;
  final int totalCount;

  UrunState({
    required this.data,
    required this.filteredData,
    required this.selectedProduct,
    required this.pageNumber,
    required this.totalCount,
    required this.isLoading,
    required this.isNextLoading,
  });

  factory UrunState.initial() => UrunState(
    data: [],
    filteredData: [],
    selectedProduct: null,
    pageNumber: 1,
    totalCount: 0,
    isLoading: false,
    isNextLoading: false,
  );

  UrunState copyWith({
    List<UrunModel>? data,
    List<UrunModel>? filteredData,
    UrunModel? selectedProduct,
    int? pageNumber,
    int? totalCount,
    bool? isLoading,
    bool? isNextLoading,
  }) {
    return UrunState(
      isLoading: isLoading ?? this.isLoading,
      isNextLoading: isNextLoading ?? this.isNextLoading,
      data: data ?? this.data,
      filteredData: filteredData ?? this.filteredData,
      pageNumber: pageNumber ?? this.pageNumber,
      totalCount: totalCount ?? this.totalCount,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}
