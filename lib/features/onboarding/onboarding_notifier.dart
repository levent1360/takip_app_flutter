import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/features/onboarding/onboarding_provider.dart';
import 'package:takip/features/onboarding/onboarding_state.dart';

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
      return OnboardingNotifier(ref);
    });

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final Ref ref;

  OnboardingNotifier(this.ref) : super(OnboardingState.initial()) {}

  Future<void> getOnboardingData() async {
    state = state.copyWith(isLoading: true);
    final apiResponse = await ref
        .read(onboardingControllerProvider)
        .getOnboardingData();
    state = state.copyWith(data: apiResponse, isLoading: false);
  }
}
