import 'package:takip/core/constant/api_endpoints.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/notification/models/hatali_kayit_model.dart';
import 'package:takip/features/urunler/urun_model.dart';

abstract class UrunService {
  Future<List<UrunModel>> getProducts();
  Future<bool> getUrlProducts(String? url);
  Future urunGoruldu();
  Future<int> urunSil(int id);
  Future<int> hataliSil(String link);
  Future<List<HataliKayitModel>> hataliKayitlar();
  Future<int> bildirimAc(int id, bool deger);
}

class UrunServiceImpl implements UrunService {
  final BaseApiService _apiService;

  UrunServiceImpl(this._apiService);

  Future<List<UrunModel>> getProducts() async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    return await _apiService.getList<UrunModel>(
      '${ApiEndpoints.urunler}/$token',
      fromJsonT: (json) => UrunModel.fromJson(json),
    );
  }

  Future urunGoruldu() async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    await await _apiService.getBasic('${ApiEndpoints.goruldu}/$token');
  }

  Future<int> urunSil(int id) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    final result = await _apiService.getBasic(
      ApiEndpoints.takipSil(token!, id),
    );
    return result.statusCode as int;
  }

  Future<int> hataliSil(String link) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    final result = await _apiService.getBasic(
      ApiEndpoints.hataliSil(token!, link),
    );
    return result.statusCode as int;
  }

  Future<int> bildirimAc(int id, bool deger) async {
    final result = await _apiService.getBasic(
      ApiEndpoints.bildirimAc(id, !deger),
    );
    return result.statusCode as int;
  }

  Future<bool> getUrlProducts(String? url) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();

    final String uri = Uri.encodeComponent(url!);

    final result = await _apiService.get<bool>(
      ApiEndpoints.takipLink(token!, uri),
      fromJsonT: (json) => json as bool,
    );
    return result;
  }

  Future<List<HataliKayitModel>> hataliKayitlar() async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    return await _apiService.getList<HataliKayitModel>(
      'takip/hatali/$token',
      fromJsonT: (json) => HataliKayitModel.fromJson(json),
    );
  }
}
