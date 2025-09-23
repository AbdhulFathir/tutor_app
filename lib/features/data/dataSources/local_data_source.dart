import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String username_key = 'ref_020';


class LocalDataSource {
  FlutterSecureStorage? secureStorage;
  SharedPreferences? prefs;

  LocalDataSource(
      {FlutterSecureStorage? securePreferences,
        SharedPreferences? sharedPreferences}) {
    secureStorage = securePreferences;
    prefs = sharedPreferences;
  }


  void setUserName(String username) {
    secureStorage!.write(key: username_key, value: username);
  }

  Future<bool> hasUsername() async {
    final contain = await secureStorage!.containsKey(key: username_key);
    return contain;
  }

  Future<String> getUsername() async {
    final usernameValue = await secureStorage!.read(key: username_key);
    return usernameValue!;
  }



}