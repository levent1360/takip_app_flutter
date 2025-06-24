import 'package:takip/data/services/urun_service.dart';

class UrunKaydetController {
  final UrunService _urunService;

  UrunKaydetController(this._urunService);

  Future<bool> getUrlProducts(String? url) async {
    return await _urunService.getUrlProducts(url);
  }
}
