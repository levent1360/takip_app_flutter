import 'package:takip/features/onboarding/onboarding_page_model.dart';

class OnboardingState {
  final List<OnboardingPageModel> data;

  final bool isLoading;
  OnboardingState({required this.data, required this.isLoading});

  factory OnboardingState.initial() =>
      OnboardingState(data: [], isLoading: false);

  OnboardingState copyWith({List<OnboardingPageModel>? data, bool? isLoading}) {
    return OnboardingState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
