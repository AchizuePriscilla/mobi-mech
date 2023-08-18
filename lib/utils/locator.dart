import 'package:get_it/get_it.dart';
import 'package:mobi_mech/data/local/local_cache.dart';
import 'package:mobi_mech/data/local/secure_storage.dart';
import 'package:mobi_mech/handlers/navigation_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

///Registers dependencies
Future<void> setupLocator() async {

  //Handlers
  locator
      .registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  //Local storage
  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorageImpl(),
  );

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(
      sharedPreferences: locator(),
      storage: locator(),
    ),
  );
}
