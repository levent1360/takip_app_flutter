import 'package:takip/data/services/marka_service.dart';
import 'package:takip/features/markalar/marka_model.dart';

class MarkaController {
  final MarkaService _markaService;

  MarkaController(this._markaService);

  Future<List<MarkaModel>> getMarkas() async {
    return await _markaService.getMarkas();
  }
}
