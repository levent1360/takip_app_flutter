import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/urunler/urun_model.dart';

class UrunController {
  final UrunService _urunService;

  UrunController(this._urunService);

  Future<List<UrunModel>> getProducts() async {
    return await _urunService.getProducts();
  }

  Future urunGoruldu() async {
    return await _urunService.urunGoruldu();
  }
}
