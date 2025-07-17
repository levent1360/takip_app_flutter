import 'package:takip/data/services/urun_service.dart';

class UrunKaydetController {
  final UrunService _urunService;

  UrunKaydetController(this._urunService);

  Future<String?> urunKaydet2(String? url) async {
    return await _urunService.urunKaydet2(url);
  }
}
