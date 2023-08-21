

import 'package:mobi_mech/utils/logger.dart';

class ParserUtil<T> {
  static DateTime parseJsonDate(String? dateString) {
    try {
      return DateTime.parse(dateString!);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String grabImageUrl(Map<String, dynamic> json) {
    try {
      return json.values.where((value) => value.contains('https')).first;
    } catch (e) {
      return '';
    }
  }

  static String parseJsonString(
    Object? json,
    String param, {
    String? defaultValue,
  }) {
    try {
      json = json as Map;
      Object? result = json[param];

      if (result == null) return defaultValue ?? '';

      String resultString = result.toString();
      final parsedString =
          resultString.isEmpty ? defaultValue ?? resultString : resultString;

      return parsedString;
    } catch (e) {
      AppLogger.log(e);

      return defaultValue ?? '';
    }
  }

  static bool parseJsonBoolean(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return false;
      return result as bool;
    } catch (e) {
      return false;
    }
  }

  List<T> parseJsonList({
    required List<dynamic>? json,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    try {
      final data = List<Map<String, dynamic>>.from(json!);

      return List<T>.from(
        data.map(
          (e) => fromJson(e),
        ),
      );
    } catch (e, trace) {
      AppLogger.log(e);
      AppLogger.log(trace);
      return [];
    }
  }

  static double parseJsonNum(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return 0;
      return result as double;
    } catch (e) {
      return 0;
    }
  }
}
