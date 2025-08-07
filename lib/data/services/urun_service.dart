import 'dart:convert';

import 'package:takip/core/constant/api_endpoints.dart';
import 'package:takip/core/constant/localization_helper.dart';
import 'package:takip/core/di/service_locator.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/models/paginated_response_model.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/features/notification/models/hatali_kayit_model.dart';
import 'package:takip/features/urunler/urun_model.dart';

abstract class UrunService {
  Future<PaginatedResponseModel<UrunModel>> getUrunlerPageSearch(
    int pageNumber, [
    String? searchtext,
    String? marka,
  ]);
  Future<String?> urunKaydet2(String? url);
  Future<String?> urunKaydet3(String? url);
  Future urunGoruldu();
  Future<int> urunSil(String guidId);
  Future<List<HataliKayitModel>> hataliKayitlar();
  Future<int> bildirimAc(int id, bool deger);
  Future<UrunModel?> getUrunByGuidId(String? id);
}

class UrunServiceImpl implements UrunService {
  final BaseApiService _apiService;

  UrunServiceImpl(this._apiService);

  // Future<PaginatedResponseModel<UrunModel>> getProductsPage([
  //   int pageNumber = 1,
  // ]) async {
  //   final localDataSource = sl<LocalDataSource>();
  //   final token = await localDataSource.getDeviceToken();

  //   final result = await _apiService.get<PaginatedResponseModel<UrunModel>>(
  //     ApiEndpoints.getUrunsPage(token!, pageNumber),
  //     fromJsonT: (json) => PaginatedResponseModel<UrunModel>.fromJson(
  //       json as Map<String, dynamic>,
  //       (item) => UrunModel.fromJson(item),
  //     ),
  //   );

  //   return result!; // Burada null olmadığını garanti ediyorsun
  // }

  Future<PaginatedResponseModel<UrunModel>> getUrunlerPageSearch([
    int pageNumber = 1,
    String? searchtext,
    String? marka,
  ]) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();

    final result = await _apiService.get<PaginatedResponseModel<UrunModel>>(
      ApiEndpoints.getUrunlerPageSearch(token!, pageNumber, searchtext, marka),
      fromJsonT: (json) => PaginatedResponseModel<UrunModel>.fromJson(
        json as Map<String, dynamic>,
        (item) => UrunModel.fromJson(item),
      ),
    );

    return result!; // Burada null olmadığını garanti ediyorsun
  }

  Future urunGoruldu() async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    await await _apiService.getBasic('${ApiEndpoints.goruldu}/$token');
  }

  Future<int> urunSil(String guidId) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    final result = await _apiService.getBasic(
      ApiEndpoints.urunSil(token!, guidId),
    );
    return result.statusCode as int;
  }

  Future<int> bildirimAc(int id, bool deger) async {
    final result = await _apiService.getBasic(
      ApiEndpoints.bildirimAc(id, !deger),
    );
    return result.statusCode as int;
  }

  Future<String?> urunKaydet2(String? url) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();

    final String uri = Uri.encodeComponent(url!);

    final result = await _apiService.get<String?>(
      ApiEndpoints.urunKaydet2(token!, uri),
      fromJsonT: (json) => json as String?,
    );
    return result;
  }

  Future<String?> urunKaydet3(String? url) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();

    final String uri = Uri.encodeComponent(url!);
    final locale = LocalizationHelper.currentLanguageCode;

    final result = await _apiService.get<String?>(
      ApiEndpoints.urunKaydet3(token!, uri, locale == 'en'),
      fromJsonT: (json) => json as String?,
    );
    return result;
  }

  Future<UrunModel?> getUrunByGuidId2(String? id) async {
    final localDataSource = sl<LocalDataSource>();
    final token = await localDataSource.getDeviceToken();
    final aaa = await _apiService.get<UrunModel?>(
      ApiEndpoints.getUrun(token!, id!),
      fromJsonT: (json) => json == null ? null : UrunModel.fromJson(json),
    );

    print('aaa ----------------------------------------------------------');
    print(aaa);
    print('aaa ----------------------------------------------------------');
    return aaa;
  }

  Future<UrunModel?> getUrunByGuidId(String? id) async {
    final token = await sl<LocalDataSource>().getDeviceToken();

    final response = await _apiService.get<dynamic>(
      ApiEndpoints.getUrun(token!, id!),
      fromJsonT: (json) => json, // Ham veriyi direkt döndür
    );

    if (response == null) return null;

    // Gelen verinin tipine göre işle
    if (response is Map<String, dynamic>) {
      return UrunModel.fromJson(response);
    } else if (response is String) {
      // String geldiyse decode etmeyi dene
      try {
        return UrunModel.fromJson(jsonDecode(response));
      } catch (e) {
        throw FormatException("Geçersiz JSON: $response");
      }
    } else {
      throw FormatException("Bilinmeyen yanıt tipi: ${response.runtimeType}");
    }
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
