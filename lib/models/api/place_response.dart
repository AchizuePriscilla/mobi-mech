import 'package:dartz/dartz.dart';
import 'package:mobi_mech/models/api/api_error_response.dart';
import 'package:mobi_mech/models/api/api_response.dart';
import 'package:mobi_mech/models/place_model.dart';

class PlaceResponse {
  final String? token;
  final bool success;
  final PlaceModel? placeModel;
  final ApiErrorResponse? error;

  const PlaceResponse({
    this.token,
    this.success = false,
    this.error,
    this.placeModel,
  });

  factory PlaceResponse.fromMap(Either<Failure, Success> json) {
    return json.fold(
      (failure) => PlaceResponse(error: failure.error),
      (success) => PlaceResponse(
        success: true,
        token: success.data["token"] ?? "",
        placeModel: PlaceModel.fromJson(success.data['result'])
      ),
    );
  }

}
