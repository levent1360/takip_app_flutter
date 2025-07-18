import 'package:flutter/foundation.dart';

class Env {
  static const API_URL = kReleaseMode
      ? 'https://takip.truyazilim.com/'
      : 'https://takip.truyazilim.com/';
}
