import 'package:dio/dio.dart';
import 'package:takip/components/snackbar/error_snackbar_component.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/data/datasources/local_datasource.dart';

class AppInterceptor extends Interceptor {
  final LocalDataSource localDataSource;

  AppInterceptor(this.localDataSource);
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final token = await localDataSource.getToken();

    // if (token.isNotNullOrEmpty) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final message = ErrorService().parseDioError(err);
    showErrorSnackBar(message: message);
    print('Interceptor: $message');
    super.onError(err, handler);
    return;
  }
}
