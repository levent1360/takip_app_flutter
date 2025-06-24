class UrunKaydetState {
  final bool isLoading;
  UrunKaydetState({required this.isLoading});

  factory UrunKaydetState.initial() => UrunKaydetState(isLoading: false);

  UrunKaydetState copyWith({bool? isLoading}) {
    return UrunKaydetState(isLoading: isLoading ?? this.isLoading);
  }
}
