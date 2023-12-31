import 'package:flutter/material.dart';
import 'package:mobi_mech/data/local/local_cache.dart';
import 'package:mobi_mech/data/remote/google_map_apis/google_map_service.dart';
import 'package:mobi_mech/handlers/navigation_handler.dart';
import 'package:mobi_mech/utils/locator.dart';
import 'package:mobi_mech/utils/logger.dart';

class BaseViewModel extends ChangeNotifier {
  late NavigationHandler navigationHandler;
  late LocalCache localCache;
  late GoogleMapServices googleMapServices;
  BaseViewModel(
      {NavigationHandler? navigationHandler,
      LocalCache? localCache,
      GoogleMapServices? mapServices}) {
    this.navigationHandler = navigationHandler ?? locator();
    this.localCache = localCache ?? locator();
    this.googleMapServices = mapServices ?? locator();
  }
  bool _loading = false;
  bool get loading => _loading;

  bool _signedIn = false;
  bool get signedIn => _signedIn;

  void toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void toggleSignedIn(bool val) {
    _signedIn = val;
    notifyListeners();
  }

  void log(Object? e) {
    AppLogger.log(e);
  }
}
