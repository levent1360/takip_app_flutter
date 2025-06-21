import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/urunler/urun_model.dart';

abstract class MarkaService {
  Future<List<UrunModel>> getProducts();
  Future<bool> getUrlProducts(String? url);
}

class MarkaServiceImpl implements MarkaService {
  final BaseApiService _apiService;

  MarkaServiceImpl(this._apiService);

  Future<List<UrunModel>> getProducts() async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    List<UrunModel> aaa = await _apiService.getList<UrunModel>(
      '/takip/urunler/$token',
      fromJsonT: (json) => UrunModel.fromJson(json),
    );

    print('Service $aaa');
    return aaa;
  }

  Future<bool> getUrlProducts(String? url) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();

    final result = await _apiService.get<bool>(
      'takip/link/$token?linktext=$url',
      fromJsonT: (json) => json as bool,
    );

    print('Service $result');
    return result;
  }
}
