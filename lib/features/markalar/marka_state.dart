import 'package:takip/features/markalar/marka_model.dart';

class MarkaState {
  final List<MarkaModel> data;

  final bool isLoading;
  MarkaState({required this.data, required this.isLoading});

  factory MarkaState.initial() => MarkaState(data: [], isLoading: false);

  MarkaState copyWith({List<MarkaModel>? data, bool? isLoading}) {
    return MarkaState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
