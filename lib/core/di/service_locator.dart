import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takip/core/constant/env.dart';
import 'package:takip/core/interceptors/app_interceptor.dart';
import 'package:takip/data/datasources/local_datasource.dart';
import 'package:takip/data/services/base_api_service.dart';
import 'package:takip/data/services/marka_service.dart';
import 'package:takip/data/services/urun_service.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(prefs: prefs),
  );

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.API_URL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AppInterceptor(sl<LocalDataSource>()));

    return dio;
  });

  sl.registerLazySingleton<BaseApiService>(() => BaseApiService(sl<Dio>()));

  sl.registerLazySingleton<UrunService>(
    () => UrunServiceImpl(sl<BaseApiService>()),
  );
  sl.registerLazySingleton<MarkaService>(
    () => MarkaServiceImpl(sl<BaseApiService>()),
  );
}
