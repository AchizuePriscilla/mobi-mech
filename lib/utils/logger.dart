import 'dart:developer' as dev;

class AppLogger {
  AppLogger._();

  static bool _showLogs = false;

  static void showLogs(value) {
    _showLogs = value;
  }

  static void log(Object? e) {
    if (_showLogs) dev.log("$e");
  }
}
