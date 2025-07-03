class UrunKaydetState {
  final bool isLoading;
  final bool? result;
  final String? metin;
  UrunKaydetState({required this.isLoading, this.metin, this.result});

  factory UrunKaydetState.initial() => UrunKaydetState(isLoading: false);

  UrunKaydetState copyWith({bool? isLoading, bool? result, String? metin}) {
    return UrunKaydetState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      metin: metin ?? this.metin,
    );
  }
}
