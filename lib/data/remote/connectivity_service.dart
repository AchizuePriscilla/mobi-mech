import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Future<bool> hasInternet();
}

class ConnectivityServiceImpl implements ConnectivityService {
  //this checks if user has active internet connection before attempting network call
  @override
  Future<bool> hasInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    return connectivityResult == ConnectivityResult.mobile
        ? true
        : connectivityResult == ConnectivityResult.wifi
            ? true
            : connectivityResult == ConnectivityResult.other
                ? true
                : false;
  }
}
