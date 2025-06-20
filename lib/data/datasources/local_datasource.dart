import 'package:shared_preferences/shared_preferences.dart';
import 'package:takip/core/constant/shared_preferences_keys.dart';

abstract class LocalDataSource {
  Future<bool> setDeviceToken(String token);
  Future<String?> getDeviceToken();
  Future<void> deleteAll();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences prefs;
  LocalDataSourceImpl({required this.prefs});

  @override
  Future<bool> setDeviceToken(String token) async {
    return prefs.setString(SharedPreferencesKeys.deviceToken, token);
  }

  @override
  Future<String?> getDeviceToken() async {
    return prefs.getString(SharedPreferencesKeys.deviceToken);
  }

  @override
  Future<void> deleteAll() async {
    await prefs.clear();
  }
}
