import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/urunler/model/urun_model.dart';

abstract class UrunService {
  Future<List<UrunModel>> getProducts();
}

class UrunServiceImpl implements UrunService {
  final BaseApiService _apiService;

  UrunServiceImpl(this._apiService);

  Future<List<UrunModel>> getProducts() async {
    List<UrunModel> aaa = await _apiService.getList<UrunModel>(
      '/takip/urunler/asdasd',
      fromJsonT: (json) => UrunModel.fromJson(json),
    );

    print('Service $aaa');
    return aaa;
  }
}
