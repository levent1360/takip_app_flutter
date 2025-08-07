import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // Endpointler
  static const String goruldu = 'takip/goruldu/';
  static const String markalar = 'takip/markalar/';
  static const String hatali = 'takip/hatali';
  static const String hatalisil = 'takip/hatalisil';
  static const String onboarding = 'takip/sunum';

  //UrunlerPageSearch?searchtext=ZARA%20luxe&marka=zara
  static String getUrunlerPageSearch(
    String token,
    int pageNumber,
    String? searchtext,
    String? marka,
  ) {
    // Başlangıç URL'si
    String url = 'takip/urunlerpagesearch/$token?pageNumber=$pageNumber';

    // Opsiyonel parametreleri ekle
    if (searchtext != null && searchtext.isNotEmpty) {
      url += '&searchtext=$searchtext';
    }

    if (marka != null && marka.isNotEmpty) {
      url += '&marka=$marka';
    }

    return url;
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

  static String sunum(bool isEnglish) {
    return 'takip/sunum?isEnglish=$isEnglish';
  }
}
