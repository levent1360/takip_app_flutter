import 'package:takip/features/urunler/urun_model.dart';

class UrunState {
  final List<UrunModel> data;

  final bool isLoading;
  UrunState({required this.data, required this.isLoading});

  factory UrunState.initial() => UrunState(data: [], isLoading: false);

  UrunState copyWith({List<UrunModel>? data, bool? isLoading}) {
    return UrunState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
