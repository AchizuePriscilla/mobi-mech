import 'package:get_it/get_it.dart';
import 'package:mobi_mech/data/local/local_cache.dart';
import 'package:mobi_mech/data/local/secure_storage.dart';
import 'package:mobi_mech/data/remote/connectivity_service.dart';
import 'package:mobi_mech/data/remote/google_map_apis/google_map_repo.dart';
import 'package:mobi_mech/data/remote/google_map_apis/google_map_service.dart';
import 'package:mobi_mech/handlers/navigation_handler.dart';
import 'package:mobi_mech/views/home/home_domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

///Registers dependencies
Future<void> setupLocator(
    {String baseApi = "maps.googleapis.com/maps/api/"}) async {
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

  //Services
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<GoogleMapServices>(
    () => GoogleMapServicesImpl(mapRepository: locator()),
  );

  //Repos
  locator.registerLazySingleton<GoogleMapRepository>(
    () => GoogleMapRepositoryImpl(baseApi),
  );

//Domains
  locator.registerLazySingleton<HomeDomain>(
    () => HomeDomain(
      mapServices: locator(),
    ),
  );
}
