import 'package:mobi_mech/models/api/api_error_response.dart';

abstract class ApiResponse {}

class Success extends ApiResponse {
  final Map<String, dynamic> data;

  Success(this.data);
}

class Failure extends ApiResponse {
  final ApiErrorResponse error;

  Failure(this.error);

  factory Failure.fromMap(Map<String, dynamic> json) {
    return Failure(
      ApiErrorResponse(
        message: getErrorMessage(json['status']),
      ),
    );
  }

  static String getErrorMessage(Object message) {
    if (message is List && message.isNotEmpty) {
      return message.first;
    }
    if (message is String) {
      print(message);
      return message;
    }
    return "Unknown error";
  }
}
