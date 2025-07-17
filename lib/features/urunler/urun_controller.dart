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

  Future urunSil(String guidId) async {
    return await _urunService.urunSil(guidId);
  }

  Future bildirimAc(int id, bool deger) async {
    return await _urunService.bildirimAc(id, deger);
  }

  Future<UrunModel?> getUrunByGuidId(String? id) async {
    return await _urunService.getUrunByGuidId(id);
  }
}
