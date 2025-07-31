import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/markalar/marka_model.dart';
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
    final apiResponse = await ref.read(markaControllerProvider).getMarkas();
    state = state.copyWith(
      data: apiResponse,
      filteredData: apiResponse,
      isLoading: false,
    );
  }

  Future<void> selectedMarka(MarkaModel model) async {
    var _selectedBefore = state.selectedMarka;

    if (_selectedBefore == null) {
      _selectedBefore = model;
    } else if (_selectedBefore.name == model.name) {
      _selectedBefore = null;
    } else {
      _selectedBefore = model;
    }

    state = state.copyWith(selectedMarka: _selectedBefore, isLoading: false);
  }

  void clearSelectedMarka() {
    state = state.copyWith(selectedMarka: null, isLoading: false);
  }

  String getMarkaName(String name) {
    final data = state.data;
    if (data == null) return 'Bilinmiyor';

    try {
      final brand = data.firstWhere((x) => x.name == name);
      return brand.orjName;
    } catch (e) {
      return 'Bilinmiyor';
    }
  }
}
