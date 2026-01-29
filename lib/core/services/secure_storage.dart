import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late FlutterSecureStorage secureStorage;

  SecureStorage(FlutterSecureStorage preferences) {
    secureStorage = preferences;
  }

  Future<bool> hasData(String key) async {

    return await secureStorage.containsKey(key: key);
  }

  void setData(String key, String value) {
    secureStorage.write(key: key, value: value);
  }

  Future<String?> getData(String key) async {
    if (await secureStorage.containsKey(key: key)) {
      return await secureStorage.read(key: key);
    } else {
      return "";
    }
  }

  void clearData(String key) {
    secureStorage.delete(key: key);
  }
}