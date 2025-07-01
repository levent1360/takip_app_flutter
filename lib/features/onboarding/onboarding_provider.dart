import 'package:takip/core/di/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takip/data/services/onboarding_service.dart';
import 'package:takip/features/onboarding/onboarding_controller.dart';

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return sl<OnboardingService>();
});

final onboardingControllerProvider = Provider<OnboardingController>(
  (ref) => OnboardingController(ref.read(onboardingServiceProvider)),
);
