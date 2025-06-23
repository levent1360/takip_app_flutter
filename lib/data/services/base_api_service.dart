import 'package:dio/dio.dart';

class BaseApiService {
  final Dio _dio;

  BaseApiService(this._dio);

  // Eğer GET de eklersen:
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) fromJsonT,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return fromJsonT(response.data);
    } on DioException {
      rethrow; // Interceptor işini yapar
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'İşlenmeyen bir hata oluştu: $e',
        type: DioExceptionType.unknown,
      );
    }
  }

  Future<List<T>> getList<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) fromJsonT,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final data = response.data;
        if (data is List) {
          return data.map((item) => fromJsonT(item)).toList();
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            error:
                'API, liste yerine başka bir format döndü: ${data.runtimeType}',
            type: DioExceptionType.badResponse,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Sunucu hatası: ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      // diğer hatalar da aynı şekilde DioException olarak sarılabilir
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'İşlenmeyen bir hata oluştu: $e',
        type: DioExceptionType.unknown,
      );
    }
  }
}
