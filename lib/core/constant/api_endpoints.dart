class ApiEndpoints {
  // Endpointler
  static const String urunler = 'takip/urunler/';
  static const String goruldu = 'takip/goruldu/';
  static const String markalar = 'takip/markalar/';
  static const String hatali = 'takip/hatali';
  static const String hatalisil = 'takip/hatalisil';
  static const String onboarding = 'takip/sunum';

  static String urunKaydet2(String token, String url) {
    return 'takip/link2/$token?linktext=$url';
  }

  static String takipSil(String token, int id) {
    return 'takip/sil/$token/$id';
  }

  static String getUrun(String token, String id) {
    return 'takip/urun/$token/$id';
  }

  static String hataliSil(String token, String link) {
    return 'takip/hatalisil/$token?link=$link';
  }

  static String bildirimAc(int id, bool deger) {
    return 'takip/bildirimAc/$id/$deger';
  }
}
