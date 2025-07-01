import 'package:takip/data/services/onboarding_service.dart';
import 'package:takip/features/onboarding/onboarding_page_model.dart';

class OnboardingController {
  final OnboardingService _onboardingService;

  OnboardingController(this._onboardingService);

  Future<List<OnboardingPageModel>> getOnboardingData() async {
    return await _onboardingService.getOnboardingData();
  }
}
