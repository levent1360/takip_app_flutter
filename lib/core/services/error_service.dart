import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorService {
  // Singleton gibi kullanmak istersen
  static final ErrorService _instance = ErrorService._internal();
  factory ErrorService() => _instance;
  ErrorService._internal();

  late GlobalKey<NavigatorState> navigatorKey;

  String parseDioError(DioException e) {
    if (e.error is SocketException) {
      return "İnternet bağlantınızı kontrol edin.";
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return "Sunucu bakımda olabilir. Lütfen daha sonra tekrar deneyin.";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Sunucudan yanıt alınamadı.";
    } else if (e.type == DioExceptionType.badResponse) {
      return "Sunucu hatası: ${e.response?.statusCode}";
    } else if (e.type == DioExceptionType.cancel) {
      return "İstek iptal edildi.";
    } else {
      return "Bir hata oluştu. Lütfen tekrar deneyin.";
    }
  }
}
