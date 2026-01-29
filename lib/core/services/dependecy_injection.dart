import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/core/services/secure_storage.dart';
import '../../features/data/dataSources/local_data_source.dart';

final injection = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  const flutterSecureStorage = FlutterSecureStorage();
  var secureStorage = SecureStorage(flutterSecureStorage);


  injection.registerLazySingleton(() => sharedPreferences);
  injection.registerLazySingleton(() => flutterSecureStorage);
  injection.registerLazySingleton(() => secureStorage);
  injection.registerLazySingleton(() => packageInfo);

  injection.registerSingleton(LocalDataSource(
    securePreferences: injection(),
    sharedPreferences: injection(),
  ));


}

