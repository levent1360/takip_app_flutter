import 'package:takip/features/notification/models/hatali_kayit_model.dart';

class BildirimState {
  final List<HataliKayitModel> data;

  final bool isLoading;
  BildirimState({required this.data, required this.isLoading});

  factory BildirimState.initial() => BildirimState(data: [], isLoading: false);

  BildirimState copyWith({List<HataliKayitModel>? data, bool? isLoading}) {
    return BildirimState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
