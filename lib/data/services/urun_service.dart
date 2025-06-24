import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/urunler/urun_model.dart';

abstract class UrunService {
  Future<List<UrunModel>> getProducts();
  Future<bool> getUrlProducts(String? url);
}

class UrunServiceImpl implements UrunService {
  final BaseApiService _apiService;

  UrunServiceImpl(this._apiService);

  Future<List<UrunModel>> getProducts() async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    return await _apiService.getList<UrunModel>(
      '/takip/urunler/$token',
      fromJsonT: (json) => UrunModel.fromJson(json),
    );
  }

  Future<bool> getUrlProducts(String? url) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();

    final result = await _apiService.get<bool>(
      'takip/link/$token?linktext=$url',
      fromJsonT: (json) => json as bool,
    );
    print('Kayıt Sonucu:  $result');
    return result;
  }
}
