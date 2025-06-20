import 'package:flutter/foundation.dart';

class Env {
  static const API_URL = kReleaseMode
      ? 'http://213.14.167.154:9595/'
      : 'http://213.14.167.154:9595/';
  static const API_URL2 = 'http://10.0.2.2:8080/api';
}
