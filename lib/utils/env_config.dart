import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'logger.dart';

Future<void> loadEnvFile({String path = ".env"}) async {
  try {
    await dotenv.load(fileName: path);
  } catch (e) {
    AppLogger.log(e);
  }
}
