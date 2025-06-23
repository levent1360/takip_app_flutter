import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/markalar/marka_provider.dart';
import 'package:takip/features/markalar/marka_state.dart';

final markaNotifierProvider = StateNotifierProvider<MarkaNotifier, MarkaState>((
  ref,
) {
  return MarkaNotifier(ref);
});

class MarkaNotifier extends StateNotifier<MarkaState> {
  final Ref ref;

  MarkaNotifier(this.ref) : super(MarkaState.initial()) {}

  Future<void> getMarkas() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 3));
    final apiResponse = await ref.read(markaControllerProvider).getMarkas();

    state = state.copyWith(data: apiResponse, isLoading: false);
  }
}
