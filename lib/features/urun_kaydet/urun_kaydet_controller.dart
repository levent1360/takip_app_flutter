import 'package:takip/data/services/urun_service.dart';

class UrunKaydetController {
  final UrunService _urunService;

  UrunKaydetController(this._urunService);

  Future<String?> urunKaydet(String? url) async {
    return await _urunService.urunKaydet3(url);
  }
}
