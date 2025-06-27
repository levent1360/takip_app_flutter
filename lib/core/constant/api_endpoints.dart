class ApiEndpoints {
  // Endpointler
  static const String urunler = 'takip/urunler/';
  static const String goruldu = 'takip/goruldu/';
  static const String markalar = 'takip/markalar/';
  static const String hatali = 'takip/hatali/phonecode';

  static String takipLink(String token, String url) {
    return 'takip/link/$token?linktext=$url';
  }

  static String takipSil(String token, int id) {
    return 'takip/sil/$token/$id';
  }
}
