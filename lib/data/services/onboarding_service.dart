import 'package:takip/core/constant/api_endpoints.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/onboarding/onboarding_page_model.dart';

abstract class OnboardingService {
  Future<List<OnboardingPageModel>> getOnboardingData();
}

class OnboardingServiceImpl implements OnboardingService {
  final BaseApiService _apiService;

  OnboardingServiceImpl(this._apiService);

  Future<List<OnboardingPageModel>> getOnboardingData() async {
    final locale = LocalizationHelper.currentLanguageCode;
    List<OnboardingPageModel> aaa = await _apiService
        .getList<OnboardingPageModel>(
          ApiEndpoints.sunum(locale == 'en'),
          fromJsonT: (json) => OnboardingPageModel.fromJson(json),
        );

    return aaa;
  }
}
