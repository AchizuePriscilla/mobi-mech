import 'dart:convert';
import 'package:mobi_mech/data/local/secure_storage.dart';
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

}
