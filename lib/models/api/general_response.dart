import 'package:dartz/dartz.dart';
import 'package:mobi_mech/utils/parser_util.dart';
import 'api_error_response.dart';
import 'api_response.dart';

class GeneralResponse<T> {
  final bool success;
  final String message;
  final ApiErrorResponse? error;
  final T? data;

  GeneralResponse({
    this.success = false,
    this.message = '',
    this.error,
    this.data,
  });

  factory GeneralResponse.fromMap(
    Either<Failure, Success> json, {
    T? Function(Map<String, dynamic>)? parseJson,
  }) {
    return json.fold(
      (failure) => GeneralResponse(error: failure.error),
      (success) => GeneralResponse(
        success: true,
        message: ParserUtil.parseJsonString(success.data, 'status'),
        data: parseJson != null ? parseJson(success.data) : null,
      ),
    );
  }

}
