import 'package:takip/features/markalar/marka_model.dart';

class MarkaState {
  final List<MarkaModel> data;
  final List<MarkaModel> filteredData;
  final bool isLoading;
  final MarkaModel? selectedMarka;

  MarkaState({
    required this.data,
    required this.filteredData,
    this.selectedMarka,
    required this.isLoading,
  });

  factory MarkaState.initial() => MarkaState(
    data: [],
    filteredData: [],
    selectedMarka: null,
    isLoading: false,
  );

  MarkaState copyWith({
    List<MarkaModel>? data,
    List<MarkaModel>? filteredData,
    MarkaModel? selectedMarka,
    bool? isLoading,
  }) {
    return MarkaState(
      data: data ?? this.data,
      filteredData: filteredData ?? this.filteredData,
      selectedMarka: selectedMarka,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
