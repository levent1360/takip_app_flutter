import 'package:takip/features/markalar/marka_model.dart';

class MarkaState {
  final List<MarkaModel> data;
  final bool isLoading;
  final MarkaModel? selectedMarka;

  MarkaState({required this.data, this.selectedMarka, required this.isLoading});

  factory MarkaState.initial() =>
      MarkaState(data: [], selectedMarka: null, isLoading: false);

  MarkaState copyWith({
    List<MarkaModel>? data,
    MarkaModel? selectedMarka,
    bool? isLoading,
  }) {
    return MarkaState(
      data: data ?? this.data,
      selectedMarka: selectedMarka,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
