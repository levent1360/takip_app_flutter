class UrunKaydetState {
  final bool isLoading;
  final bool? result;
  final String? guidId;
  final String? metin;
  UrunKaydetState({
    required this.isLoading,
    this.metin,
    this.result,
    this.guidId,
  });

  factory UrunKaydetState.initial() => UrunKaydetState(isLoading: false);

  UrunKaydetState copyWith({
    bool? isLoading,
    bool? result,
    String? metin,
    String? guidId,
  }) {
    return UrunKaydetState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      guidId: guidId ?? this.guidId,
      metin: metin ?? this.metin,
    );
  }
}
