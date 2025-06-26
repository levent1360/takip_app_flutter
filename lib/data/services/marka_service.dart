import 'package:takip/core/constant/api_endpoints.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/markalar/marka_model.dart';

abstract class MarkaService {
  Future<List<MarkaModel>> getMarkas();
}

class MarkaServiceImpl implements MarkaService {
  final BaseApiService _apiService;

  MarkaServiceImpl(this._apiService);

  Future<List<MarkaModel>> getMarkas() async {
    List<MarkaModel> aaa = await _apiService.getList<MarkaModel>(
      ApiEndpoints.markalar,
      fromJsonT: (json) => MarkaModel.fromJson(json),
    );

    return aaa;
  }
}
