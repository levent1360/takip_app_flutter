import 'package:flutter/foundation.dart';

class Env {
  static const API_URL = kReleaseMode
      ? 'https://takip.truyazilim.com/'
      : 'https://takip.truyazilim.com/';
  static const API_URL2 = 'http://10.0.2.2:8080/api';

  static const silBaslik = 'Silme Onayı';
  static const silMetin = 'Bu ürünü silmek istediğinize emin misiniz?';
}
