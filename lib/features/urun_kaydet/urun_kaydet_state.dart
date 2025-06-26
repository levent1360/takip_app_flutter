class UrunKaydetState {
  final bool isLoading;
  final bool? result;
  UrunKaydetState({required this.isLoading, this.result});

  factory UrunKaydetState.initial() => UrunKaydetState(isLoading: false);

  UrunKaydetState copyWith({bool? isLoading, bool? result}) {
    return UrunKaydetState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}
