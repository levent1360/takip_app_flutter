import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // Endpointler
  static const String urunler = 'takip/urunler/';
  static const String goruldu = 'takip/goruldu/';
  static const String markalar = 'takip/markalar/';
  static const String hatali = 'takip/hatali';
  static const String hatalisil = 'takip/hatalisil';
  static const String onboarding = 'takip/sunum';

  static String getUrunsPage(String token, int pageNumber) {
    return 'takip/urunlerpage/$token?pageNumber=$pageNumber';
  }

  static String urunKaydet2(String token, String url) {
    final isTest = kDebugMode ? true : false;
    return 'takip/link2/$token?linktext=$url&isTestData=$isTest';
  }

  static String urunSil(String token, String guidId) {
    return 'takip/UrunSil/$token/$guidId';
  }

  static String getUrun(String token, String id) {
    return 'takip/urun/$token/$id';
  }

  static String bildirimAc(int id, bool deger) {
    return 'takip/bildirimAc/$id/$deger';
  }
}
