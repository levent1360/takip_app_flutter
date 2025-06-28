import 'package:takip/data/services/urun_service.dart';
import 'package:takip/features/notification/models/hatali_kayit_model.dart';

class BildirimController {
  final UrunService _urunService;

  BildirimController(this._urunService);

  Future<List<HataliKayitModel>> hataliKayitlar() async {
    return await _urunService.hataliKayitlar();
  }
}
