import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobi_mech/data/local/secure_storage.dart';
import 'package:mobi_mech/utils/constants.dart';
import 'package:mobi_mech/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalCache {
  ///Saves `value` to cache using `key`
  Future<void> saveToLocalCache({required String key, required dynamic value});

  ///Retrieves a cached value stored with `key`
  Object? getFromLocalCache(String key);

  ///Removes cached value stored with `key` from cache
  Future<void> removeFromLocalCache(String key);

  ///Retrieves access token for authorizing requests
  Future<String?> getToken();

  LatLng getCurrentLatLngFromSharedPrefs();

  String getCurrentAddressFromSharedPrefs();

  LatLng getTripLatLngFromSharedPrefs(String type);

  String getSourceAndDestinationPlaceText(String type);
}

class LocalCacheImpl implements LocalCache {
  late SecureStorage storage;
  late SharedPreferences sharedPreferences;
  static const token = 'userTokenId';
  LocalCacheImpl({
    required this.storage,
    required this.sharedPreferences,
  });

  @override
  Object? getFromLocalCache(String key) {
    try {
      return sharedPreferences.get(key);
    } catch (e) {
      AppLogger.log(e);
      return null;
    }
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    AppLogger.log('Data being saved: key: $key, value: $value');
    if (value is String) {
      await sharedPreferences.setString(key, value);
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
    }
    if (value is int) {
      await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    }
    if (value is Map) {
      await sharedPreferences.setString(key, json.encode(value));
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await storage.read(token);
    } catch (e) {
      AppLogger.log(e);
      return null;
    }
  }

  @override
  LatLng getCurrentLatLngFromSharedPrefs() {
    return LatLng(sharedPreferences.getDouble(kLatitude)!,
        sharedPreferences.getDouble(kLongitude)!);
  }

  @override
  String getCurrentAddressFromSharedPrefs() {
    return sharedPreferences.getString(kCurrentAddress)!;
  }

  @override
  LatLng getTripLatLngFromSharedPrefs(String type) {
    List sourceLocationList =
        json.decode(sharedPreferences.getString('source')!)['location'];
    List destinationLocationList =
        json.decode(sharedPreferences.getString('destination')!)['location'];
    LatLng source = LatLng(sourceLocationList[0], sourceLocationList[1]);
    LatLng destination =
        LatLng(destinationLocationList[0], destinationLocationList[1]);

    if (type == 'source') {
      return source;
    } else {
      return destination;
    }
  }

  @override
  String getSourceAndDestinationPlaceText(String type) {
    String sourceAddress =
        json.decode(sharedPreferences.getString('source')!)['name'];
    String destinationAddress =
        json.decode(sharedPreferences.getString('destination')!)['name'];

    if (type == 'source') {
      return sourceAddress;
    } else {
      return destinationAddress;
    }
  }
}
